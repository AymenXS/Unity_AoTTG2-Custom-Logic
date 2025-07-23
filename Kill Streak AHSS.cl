class Main
{
    Description = "Survive while earning AHSS through Titan kills";
    Titans = 15;
    _hasSpawned = false;
    
    # Titan kill reward system
    PointsForAHSS = 5;
    PlayerData = Dict(); # {playerName: {points: int, unlocked: bool}}
    _ahssUnlocker = null;  # Name of first unlocker
    _ahssUnlocked = false; # Global unlock status

    function InitPlayerData(playerName)
    {
        if (!self.PlayerData.Contains(playerName))
        {
            playerData = Dict();
            playerData.Set("points", 0);
            playerData.Set("unlocked", false);
            self.PlayerData.Set(playerName, playerData);
        }
        return self.PlayerData.Get(playerName);
    }

    function OnGameStart()
    {
        if (Network.IsMasterClient)
        {
            Game.SpawnTitans("Default", self.Titans);
            UI.SetLabelAll("TopCenter", "Titans Left: " + self.Titans);
        }
        # Reset unlock state at game start
        self._ahssUnlocker = null;
        self._ahssUnlocked = false;
        self.PlayerData.Clear();
    }

    function OnPlayerJoin(player)
    {
        # Initialize new player's data
        self.InitPlayerData(player.Name);
        
        # If AHSS was already unlocked, sync this to new player
        if (self._ahssUnlocked && Network.IsMasterClient)
        {
            Network.SendMessage(player, "AHSS_LOCKED");
        }
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim == null || killer == null) {return;}
        
        if (victim.Type == "Titan" && killer.Type == "Human")
        {
            playerName = killer.Name;
            
            # Safely get player data with initialization
            currentData = self.InitPlayerData(playerName);
            
            # Don't allow points if AHSS was already unlocked by someone
            if (self._ahssUnlocked && playerName != self._ahssUnlocker)
            {
                if (killer.IsMine)
                {
                    Game.Print("AHSS already unlocked by " + self._ahssUnlocker);
                }
                return;
            }
            
            currentPoints = currentData.Get("points") + 1;
            currentData.Set("points", currentPoints);
            
            # Show progress only to the killer
            if (killer.IsMine)
            {
                Game.Print("Titan Kill! Points: " + currentPoints + "/" + self.PointsForAHSS);
            }
            
            # Check if AHSS should be unlocked
            if (!self._ahssUnlocked && 
                currentPoints >= self.PointsForAHSS && 
                !currentData.Get("unlocked"))
            {
                # Mark AHSS as unlocked
                self._ahssUnlocked = true;
                self._ahssUnlocker = playerName;
                currentData.Set("unlocked", true);
                self.HandleAHSSUnlock(killer);
                
                # Sync with all clients if master
                if (Network.IsMasterClient)
                {
                    Network.SendMessageAll("AHSS_UNLOCK|" + playerName);
                }
            }
        }
    }

    function OnNetworkMessage(sender, message)
    {
        if (message == "AHSS_LOCKED")
        {
            # New player received lock notification
            self._ahssUnlocked = true;
            if (Network.MyPlayer != null)
            {
                self.InitPlayerData(Network.MyPlayer.Name).Set("unlocked", false);
            }
            return;
        }
        
        parts = String.Split(message, "|");
        if (parts.Count < 2) {return;}
        
        messageType = parts.Get(0);
        playerName = parts.Get(1);
        
        if (messageType == "AHSS_UNLOCK")
        {
            # Only process if AHSS wasn't already unlocked
            if (!self._ahssUnlocked)
            {
                self._ahssUnlocked = true;
                self._ahssUnlocker = playerName;
                
                # Initialize and update player data
                self.InitPlayerData(playerName).Set("unlocked", true);
                
                if (Network.MyPlayer != null && Network.MyPlayer.Name == playerName)
                {
                    if (Network.MyPlayer.Character != null)
                    {
                        self.HandleAHSSUnlock(Network.MyPlayer.Character);
                    }
                    else
                    {
                        Game.ForcedLoadout = "AHSS";
                    }
                }
            }
        }
    }

    function HandleAHSSUnlock(character)
    {
        if (character == null || character.Type != "Human") {return;}
        
        # Only proceed if this is the designated unlocker
        if (character.Name != self._ahssUnlocker) {return;}
        
        # Give AHSS to the current character
        character.SetWeapon("AHSS");
        character.CurrentAmmoRound = 30;
        character.CurrentAmmoLeft = 120;
        
        # Force AHSS loadout for future spawns
        if (character.IsMine) {
            Game.Print("<color=#FFD700>AHSS unlocked!</color>");
            character.PlaySound("Checkpoint");
        }
        
        Game.PrintAll(character.Name + " has unlocked AHSS!");
    }

    function OnTick()
    {
        # Game state checks
        if (Network.IsMasterClient && !Game.IsEnding)
        {
            titans = Game.Titans.Count;
            humans = Game.Humans.Count;
            
            if (humans > 0)
            {
                self._hasSpawned = true;
            }
            
            if (titans == 0)
            {
                UI.SetLabelAll("MiddleCenter", "<color=#00FF00>Humanity wins!</color>");
                Game.End(10.0);
            }
            elif (humans == 0 && self._hasSpawned)
            {
                UI.SetLabelAll("MiddleCenter", "<color=#FF0000>Humanity failed!</color>");
                Game.End(10.0);
            }
            
            UI.SetLabelAll("TopCenter", "Titans Left: " + titans);
        }
    }
}