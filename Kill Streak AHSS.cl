class Main
{
    Description = "Survive while earning AHSS through Titan kills";
    Titans = 15;
    _hasSpawned = false;
    
    # AHSS unlock system
    PointsForAHSS = 5;
    PlayerData = Dict(); # {playerName: {points: int, unlocked: bool}}
    _ahssUnlocker = null;
    _ahssUnlocked = false;
    _ahssConfirmationEnabled = true; # Toggle for confirmation prompt

    # Initialize player data
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

    # Game start logic
    function OnGameStart()
    {
        if (Network.IsMasterClient)
        {
            Game.SpawnTitans("Default", self.Titans);
            UI.SetLabelAll("TopCenter", "Titans Left: " + self.Titans);
        }
        self._ahssUnlocker = null;
        self._ahssUnlocked = false;
        self.PlayerData.Clear();
    }

    # Player join handling
    function OnPlayerJoin(player)
    {
        self.InitPlayerData(player.Name);
        if (self._ahssUnlocked && Network.IsMasterClient)
        {
            Network.SendMessage(player, "AHSS_LOCKED");
        }
    }

    # Titan kill reward system
    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim == null || killer == null) {return;}
        
        if (victim.Type == "Titan" && killer.Type == "Human")
        {
            playerName = killer.Name;
            currentData = self.InitPlayerData(playerName);
            
            # Block points if AHSS was already unlocked by someone else
            if (self._ahssUnlocked && playerName != self._ahssUnlocker)
            {
                if (killer.IsMine)
                {
                    Game.Print("AHSS already unlocked by " + self._ahssUnlocker);
                }
                return;
            }
            
            # Award point
            currentPoints = currentData.Get("points") + 1;
            currentData.Set("points", currentPoints);
            
            # Show progress to killer
            if (killer.IsMine)
            {
                Game.Print("Titan Kill! Points: " + currentPoints + "/" + self.PointsForAHSS);
            }
            
            # Check for unlock threshold
            if (!self._ahssUnlocked && 
                currentPoints >= self.PointsForAHSS && 
                !currentData.Get("unlocked"))
            {
                self._ahssUnlocked = true;
                self._ahssUnlocker = playerName;
                currentData.Set("unlocked", true);
                self.HandleAHSSUnlock(killer);
                
                # Sync with all clients
                if (Network.IsMasterClient)
                {
                    Network.SendMessageAll("AHSS_UNLOCK|" + playerName);
                }
            }
        }
    }

    # AHSS unlock handler (with optional confirmation)
    function HandleAHSSUnlock(character)
    {
        if (character == null || character.Type != "Human") {return;}
        if (character.Name != self._ahssUnlocker) {return;}

        if (self._ahssConfirmationEnabled && character.IsMine)
        {
            # Start confirmation coroutine
            self.AHSSConfirmation(character);
            return;
        }
        
        # Skip confirmation if disabled
        self.ActivateAHSS(character);
    }

    # Coroutine: Waits for player confirmation
    coroutine AHSSConfirmation(character)
    {
        # Show prompt
        UI.SetLabel("MiddleCenter", character.Name + 
            "<color=yellow>Press F to unlock AHSS</color>");

        # Wait for F key press
        while (!Input.GetKeyHold("Human/Reload"))
        {
            wait 0.1; # Check every 0.1 seconds
        }

        # Confirmed - unlock AHSS
        UI.ClearLabel(character.Player, "MiddleCenter");
        self.ActivateAHSS(character);
    }

    # Actual AHSS activation logic
    function ActivateAHSS(character)
    {
        character.SetWeapon("AHSS");
        character.CurrentAmmoRound = 30;
        character.CurrentAmmoLeft = 120;
        
        if (character.IsMine) {
            Game.Print("<color=#FFD700>AHSS unlocked!</color>");
            character.PlaySound("Checkpoint");
        }
        
        Game.PrintAll(character.Name + " has unlocked AHSS!");
    }

    # Network message handling
    function OnNetworkMessage(sender, message)
    {
        if (message == "AHSS_LOCKED")
        {
            self._ahssUnlocked = true;
            if (Network.MyPlayer != null)
            {
                self.InitPlayerData(Network.MyPlayer.Name).Set("unlocked", false);
            }
            return;
        }
        
        parts = String.Split(message, "|");
        if (parts.Count < 2) {return;}
        
        if (parts.Get(0) == "AHSS_UNLOCK")
        {
            playerName = parts.Get(1);
            if (!self._ahssUnlocked)
            {
                self._ahssUnlocked = true;
                self._ahssUnlocker = playerName;
                self.InitPlayerData(playerName).Set("unlocked", true);
                
                # Handle local player unlock
                if (Network.MyPlayer != null && Network.MyPlayer.Name == playerName)
                {
                    if (Network.MyPlayer.Character != null)
                    {
                        self.ActivateAHSS(Network.MyPlayer.Character);
                    }
                    else
                    {
                        Game.ForcedLoadout = "AHSS";
                    }
                }
            }
        }
    }

    # Game state checks
    function OnTick()
    {
        if (Network.IsMasterClient && !Game.IsEnding)
        {
            titans = Game.Titans.Count;
            humans = Game.Humans.Count;
            
            if (humans > 0) {self._hasSpawned = true;}
            
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