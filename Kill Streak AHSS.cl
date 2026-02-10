class Main
{
    Description = "Survive while earning AHSS through Titan kills";
    Titans = 15;
    _hasSpawned = false;
    
    # AHSS unlock system
    PointsForAHSS = 5;
    AITitanPointValue = 0.1;  # Points per AI Titan kill
    PlayerTitanPointValue = 1; # Points per Player Titan kill
    
    PlayerData = Dict(); # {playerName: {points: float, unlocked: bool}}
    _ahssUnlocker = null;
    _ahssUnlocked = false;
    _ahssConfirmationEnabled = true;

    # Initialize player data
    function InitPlayerData(playerName)
    {
        if (!self.PlayerData.Contains(playerName))
        {
            playerData = Dict();
            playerData.Set("points", 0.0); # Changed to float
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
            self.UpdateTitanCounter();
            UI.SetLabelAll("TopRight", ""); # Clear by setting empty string
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

    function OnPlayerSpawn(player, character)
{
    # Spawn effect (working)
    Game.SpawnEffect("ThunderspearExplode", character.Position, Vector3.Zero, 2.0, Color(255,255,255,255));
    
    # Correct projectile spawn (fixed)
    Game.SpawnProjectileWithOwner(
    "Rock1",                     # string projectile type
    character.Position + Vector3(0,1,0), # Vector3 position
    Vector3.Zero,                # Vector3 rotation
    character.Forward * 10,      # Vector3 velocity
    Vector3(0,-4.9,0),           # Vector3 gravity
    3.0,                         # float lifetime
    character,                   # Character owner
    0.5                          # float size (Rock1 specific)
);
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
                return;
            }
            
            # Award points based on Titan type
            if (victim.IsAI)
            {
                pointsToAdd = self.AITitanPointValue;
            }
            else
            {
                pointsToAdd = self.PlayerTitanPointValue;
            }
            
            currentPoints = currentData.Get("points") + pointsToAdd;
            currentData.Set("points", currentPoints);
            
            # Update counter for all players
            self.UpdateProgressCounter(playerName, currentPoints);
            
            # Check for unlock threshold
            if (!self._ahssUnlocked && 
                currentPoints >= self.PointsForAHSS && 
                !currentData.Get("unlocked"))
            {
                self._ahssUnlocked = true;
                self._ahssUnlocker = playerName;
                currentData.Set("unlocked", true);
                
                # Clear counters
                if (Network.IsMasterClient)
                {
                    UI.SetLabelAll("TopRight", "");
                    UI.SetLabelAll("TopCenter", "AHSS Unlocked!");
                }
                
                self.HandleAHSSUnlock(killer);
                if (Network.IsMasterClient)
                {
                    Network.SendMessageAll("AHSS_UNLOCK|" + playerName);
                }
            }
            elif (!self._ahssUnlocked)
            {
                self.UpdateProgressCounter(playerName, currentPoints);
            }
        }
    }

    # Update progress counter for all players
    function UpdateProgressCounter(playerName, currentPoints)
{
    if (self._ahssUnlocked) {return;}
    
    if (Network.IsMasterClient)
    {
        text = playerName + ": " + String.FormatFloat(currentPoints, 1) + "/" + self.PointsForAHSS;
        UI.SetLabelAll("TopRight", text);
    }
}

    # Update titan counter
    function UpdateTitanCounter()
    {
        UI.SetLabelAll("TopCenter", "Titans Left: " + Game.Titans.Count);
    }

    # AHSS unlock handler
    function HandleAHSSUnlock(character)
    {
        if (character == null || character.Type != "Human") {return;}
        if (character.Name != self._ahssUnlocker) {return;}

        if (self._ahssConfirmationEnabled && character.IsMine)
        {
            self.AHSSConfirmation(character);
            return;
        }
        
        self.ActivateAHSS(character);
    }

    # Coroutine: Waits for player confirmation
    coroutine AHSSConfirmation(character)
    {
        UI.SetLabelForTime("TopRight", "Hold <color=yellow>'Reload'</color> to unlock AHSS", 5);

        while (!Input.GetKeyHold("Human/Reload"))
        {
            wait 0.1;
        }

        self.ActivateAHSS(character);
    }

    # Actual AHSS activation logic
    function ActivateAHSS(character)
    {
        # Verify character is human (safety check)
        if (character.Type != "Human") {return;}

        # Set weapon to AHSS
        character.SetWeapon("AHSS");
        # FORCE 5 ROUND LIMIT (using confirmed Human class fields)
        # -------------------------------------------------------
        character.CurrentAmmoRound = 2;
        character.CurrentAmmoLeft = 3;
        character.MaxAmmoRound = 2;
        character.MaxAmmoTotal = 3;
         # -------------------------------------------------------

        if (character.IsMine)
        {
            character.PlaySound("AHSSGunShotDouble2");
        }
        
        # Single global notification
        if (Network.IsMasterClient)
        {
            Game.PrintAll(character.Name + " has unlocked AHSS!");
        }
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
            
            self.UpdateTitanCounter();
        }
    }
}