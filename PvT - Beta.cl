#======================================================================
# PvT GAME MODE CORE SCRIPT
# Credits to Jibs & Sonic
# Credits to Lavasuna for the BetterWaves CL
#
# Features:
# - Tutorial and Rules for beginners
# - Team-based respawn feature with dynamic timers
# - Velocity-based damage calculations
# - Win condition tracking (Humans vs Titans)
# - Special player abilities (rock throw)
# - Idle mode with automatic respawn
# - Admin commands for moderation
# - Custom UI popups for rules and debug info
# - Slow motion ending
# - Kill to Revive system
# - AHSS unlock system with point tracking
#======================================================================
class Main {    
    /*===== SYSTEM TOGGLES =====*/
    EnableIdleSystem = true;
    EnableRespawnSystem = true;
    EnableRockThrowSystem = true;
    EnableAHSSUnlockSystem = true;
    EnableKCRevivalSystem = true;
    EnableDamageSystem = true;
    EnableTeamSystem = true;
    EnableScoreSystem = true;
    EnableMovementSystem = true;
    EnableNetworkSystem = true;
    # EnableUISystem = true;
    # EnableCommandSystem = true;
    
    /*===== GAME CONFIGURATION =====*/
   # Team Settings
	ShowTeamScore = true;
    TeamOneName = "Humans";
	TeamTwoName = "Titans";
	_TeamOneScore = 0;           # Total human victories
    _TeamTwoScore = 0;           # Total titan victories
    FullClear = true;          # Victory mode
    FullClearTooltip = "When enabled, humans must eliminate ALL Titans (AIs + PTs) to win.";

    # Spawn Settings  
    Titans = 15;              
    TitansTooltip = "Initial number of AI Titans spawned at match start.";
    BaseRespawnTime = 60.0;     # Default respawn delay
    BaseRespawnTimeTooltip = "Default respawn delay in seconds.";
    MinRespawnTime = 30.0;
    MinRespawnTimeTooltip = "Minimum possible respawn delay (cannot go below this).";

    # Moderator Settings
    Moderator = 0;  # Player ID with moderator privileges
    _nopermission = "<color='#CC0000'>Error: You do not have permission!</color>";

    # Special Abilities
    AuthorizedRockThrower = "";
    AuthorizedRockThrowerTooltip = "Player IDs separated by hyphens (1-2-3) who can throw rocks as Titans.";

    # Movement Tracking
    lastMagnitudes = new Dict(); # Tracks each player's movement speed

    # Player States
    rockthrowers = new List(); # Parsed rock throwers

    # Respawn Variables Feature
    respawn_timer_keys = new List(); # Active timers
    RespawnHumanScale = 1.0;
    RespawnHumanScaleTooltip = "How much human respawn time reduces per missing teammate.";
    RespawnTitanScale = 4.0; 
    RespawnTitanScaleTooltip = "How much titan respawn time reduces per missing teammate.";
    
    # Admin overrides
    ManualHumanTimer = 0;          # Manual human respawn time
    ManualHumanTimerTooltip = "Override human dynamic respawn time in seconds.";
    ManualTitanTimer = 0;          # Manual titan respawn time
    ManualTitanTimerTooltip = "Override human dynamic respawn time in seconds.";

    # UI State
    _rulesPopupCreated = false;
    _debugPopupCreated = false;

    # Idle mode settings
    IdleKillTime = 60;
    IdleKillTimeTooltip = "Time in seconds before a player is considered Idle and is killed.";
    IdleRespawn = true;
    IdleRespawnTooltip = "Allow Idle users to respawn immediately by pressing W.";

    # Kill To Revive
    KillsToRevive = 7;

    # Slow Motion Ending
    _SlowMode = false;
    SlowModeTooltip = "If enabled, this will give a slow-motion ending when the last titan/player is killed.";

    /*===== INITIALIZATION =====*/
    function Init() {
        # Initialize systems only if they're enabled
        if (Main.EnableIdleSystem) {
            IdleSystem.AfkKillTime = self.IdleKillTime;
            IdleSystem.IdleRespawn = self.IdleRespawn;
        }
        
        if (Main.EnableRespawnSystem) {
            RespawnSystem.BaseRespawnTime = self.BaseRespawnTime;
            RespawnSystem.MinRespawnTime = self.MinRespawnTime;
            RespawnSystem.RespawnHumanScale = self.RespawnHumanScale;
            RespawnSystem.RespawnTitanScale = self.RespawnTitanScale;
            RespawnSystem.respawn_timers = new Dict();
            RespawnSystem.respawn_timer_keys = new List();
        }
        
        if (Main.EnableScoreSystem) {
            ScoreSystem._HumanScore = RoomData.GetProperty("human_wins", 0);
            ScoreSystem._TitanScore = RoomData.GetProperty("titan_wins", 0);
        }
        
        if (Main.EnableTeamSystem) {
            TeamSystem.FullClear = self.FullClear;
        }
        
        if (Main.EnableRockThrowSystem) {
            Input.SetKeyDefaultEnabled("Titan/AttackRockThrow", true);
            Input.GetKeyDown("Titan/AttackRockThrow", RockThrowSystem.OnRockThrow());
            self.rockthrowers = String.Split(self.AuthorizedRockThrower, "-");
            RockThrowSystem.Init();
        }
        
        if (Main.EnableAHSSUnlockSystem) {
            AHSSUnlockSystem.Initialize();
        }
        
        if (Main.EnableKCRevivalSystem) {
            KCRevival.Init();
        }
        
        # Always configure UI basics
        UI.SetLabel("MiddleCenter", "");
        Game.DefaultShowKillFeed = false;
        Game.DefaultShowKillScore = false;
        Game.DefaultAddKillScore = false;
        UI.SetScoreboardProperty("KDRA");
        UI.SetScoreboardHeader("Kills / Deaths / Max / Total");

        player = Network.MyPlayer;
        player.SetCustomProperty("KDRA", 
            player.Kills + " / " + player.Deaths + 
            " / " + player.HighestDamage + " / " + player.TotalDamage
        );

        
        
        if (!RoomData.GetProperty("tutorial_shown", false)) {
            Cutscene.Start("PvTQuickStart", true);
            RoomData.SetProperty("tutorial_shown", true);
        }
    }

    function OnGameStart() {
        Game.SpawnTitansAsync("Default", self.Titans);
    }

    /*===== EVENT HANDLERS =====*/

    function OnTick() {
        # Empty or custom tick logic
    }
    
    function OnFrame() {
        if (Main.EnableMovementSystem) {MovementSystem.TrackMovement();}
        if (Main.EnableIdleSystem) {IdleSystem.OnFrame();}
    }

    function OnSecond() {
        if (Main.EnableKCRevivalSystem) {KCRevival.OnSecond();}
        if (Main.EnableIdleSystem) {IdleSystem.OnSecond();}
        if (Main.EnableRespawnSystem) {RespawnSystem.OnSecond();}
        if (Main.EnableRockThrowSystem) {RockThrowSystem.OnSecond();}
    }

    function OnCharacterSpawn(character) {
        if (Main.EnableTeamSystem) {TeamSystem.UpdateTeamUI();}
        if (Main.EnableRockThrowSystem) {RockThrowSystem.HandleSpawn(character);}
    }

    function OnCharacterDamaged(victim, killer, killerName, damage) {   
        if (Main.EnableDamageSystem) {DamageSystem.HandleDamage(victim, killer, killerName, damage);}
        if (Main.EnableTeamSystem) {TeamSystem.CheckVictoryConditions();}
    }

    function OnCharacterDie(victim, killer, killerName) {
        if (Main.EnableAHSSUnlockSystem) {AHSSUnlockSystem.ProcessTitanKill(victim, killer, killerName);}
        if (Main.EnableDamageSystem) {DeathSystem.HandleDeath(victim, killer, killerName);}
    }   

    function OnNetworkMessage(sender, message) {
        if (Main.EnableNetworkSystem) {NetworkSystem.HandleMessage(sender, message);}
    }

    function OnChatInput(message) {
        return CommandSystem.HandleCommand(message);
    }

    function OnButtonClick(buttonName) {
        UISystem.HandleButtonClick(buttonName);
    }
}

#======================================================================
# EXTENSIONS
#======================================================================

extension MovementSystem {
    lastMagnitudes = new Dict();

    function TrackMovement() {
        if (!Main.EnableMovementSystem) {return;}

        for (human in Game.PlayerHumans) {
            if (human != null && human.Player != null) {
                mag = human.Velocity.Magnitude;
                if (mag > 1) {
                    self.lastMagnitudes.Set("mag-"+human.Player.ID, mag);
                }
            }
        }
    }
}

extension DamageSystem {
    function HandleDamage(victim, killer, killerName, damage) {
        if (!Main.EnableDamageSystem) {return;}

        # Basic validation
        if (victim == null || victim.Health > 0 || victim.Player == null) {
            return;
        }
        
        if (!victim.IsAI) {
            RespawnSystem.QueueRespawn(victim);
        }
            
        
        # Human killer case
        if (killerName != "Rock" && killer != null && killer.Type == "Human") {
            self.HandleHumanKiller(victim, killer, killerName, damage);
        }
        
        # Titan killer case
        if (killerName != "Rock" && killer != null && killer.Type == "Titan") {
            self.HandleTitanKiller(victim, killer, killerName, damage);
        }
        
        # Rock kill case
        if (killerName == "Rock") {
            self.HandleRockKill(victim, killer, killerName, damage);
        }
    }

    function HandleHumanKiller(victim, killer, killerName, damage) {
        Game.ShowKillFeed(
            TeamSystem.TeamHeader(killer),
            TeamSystem.TeamHeader(victim),
            damage,
            "Blade"
        );
        
        # Update killer's score if local player
        if (killer.Name == Network.MyPlayer.Name) {
            Game.ShowKillScore(damage);
            ScoreSystem.UpdateScore(killer.Player, true, damage, false);
        } 
        
        # Update victim's score if local player
        if (victim.Name == Network.MyPlayer.Name) {
            ScoreSystem.UpdateScore(victim.Player, false, 0, false);
        }
    }

    function HandleTitanKiller(victim, killer, killerName, damage) {
        if (victim.Name == Network.MyPlayer.Name) {
            # Calculate velocity-based damage
            damage = MovementSystem.lastMagnitudes.Get("mag-"+victim.Player.ID, 5.0) * 10.0 + 1;
            # damage = Network.MyPlayer.Character.Velocity.Magnitude * Main.DamageMultiplier;
            
            Game.ShowKillFeedAll(
                TeamSystem.TeamHeader(killer),
                TeamSystem.TeamHeader(victim),
                damage,
                "Titan"
            );
            ScoreSystem.UpdateScore(killer.Player, true, Convert.ToInt(damage), false);
            ScoreSystem.UpdateScore(victim.Player, false, 0, false);
        }
        
        # if (killer.Name == Network.MyPlayer.Name) {
        #     ScoreSystem.UpdateScore(killer.Player, true, damage, false);
        # }
    }

    function HandleRockKill(victim, killer, killerName, damage) {
        if (victim.Name == Network.MyPlayer.Name) {
            # Calculate velocity-based damage
            damage = MovementSystem.lastMagnitudes.Get("mag-"+victim.Player.ID, 5.0) * 10.0 + 1;
            
            Game.ShowKillFeedAll(
                "<b><color='#ff0000'>ROCK</color></b>",
                TeamSystem.TeamHeader(victim),
                damage,
                "Titan"
            );
            ScoreSystem.UpdateScore(victim.Player, false, 0, false);
        }
    }
}

extension DeathSystem {
    function HandleDeath(victim, killer, killerName) {
        if (victim.Type == "Human" && victim.IsMine && victim.IsMainCharacter) {
            KCRevival.OnDeath();
        }

         if (victim.Type == "Titan" && killer != null) {
            value = 1;
            if (killer.Type == "Human") {
                if (killer.Weapon != "Blade") {
                    value = 0.5;
                }
            }
            KCRevival.ProcessTitanKill(killerName, value);
        }
    }
}

extension NetworkSystem {
    function HandleMessage(sender, message) {
        if (!Main.EnableNetworkSystem) {return;}
        
        if (message == "AHSS_LOCKED") {
            AHSSUnlockSystem._ahssUnlocked = true;
        }
        elif (String.StartsWith(message, "AHSS_UNLOCK|")) {
            # Handle AHSS unlock sync
        }
        elif (String.StartsWith(message, "mod:")) {
            self.HandleModCommand(sender, message);
        } 
        elif (String.StartsWith(message, "WinSync:")) {
            ScoreSystem.HandleWinSync(message);
        }
        elif (String.StartsWith(message, "slowmo")) {
            self.HandleSlowMo(message);
        }
        elif (String.StartsWith(message, "clearchat")) {
            self.HandleClearChat(sender, message);
        }
    }

    function HandleModCommand(sender, message) {
        if (Network.IsMasterClient && sender.ID == Main.Moderator) {
            cmd = String.Substring(message, 4);
            if (cmd == "resetkdall" || cmd == "clearchat" || cmd == "reviveall") {
                Network.SendMessageAll(cmd);
                Game.Print("Moderator used command: #" + cmd);
            }
        }
    }

    function HandleSlowMo(message) {
        if (message == "slowmo_off") {
            Time.TimeScale = 1.0;
            Game.Print("Slow motion disabled");
        } else {
            Time.TimeScale = 0.33;
            Game.Print("Slow motion enabled");
        }
    }

    function HandleClearChat(sender, message) {
        if (sender == Network.MasterClient) {
            for (i in Range(0, 25, 1)) {
                Game.Print(String.Newline);
            }
            Game.Print("Chat has been cleared by admin.");
        }
    }
}

extension UISystem {
    
    _rulesPopupCreated = false;
    _debugPopupCreated = false;

    function HandleButtonClick(buttonName) {
        if (buttonName == "CloseRules") {
            UI.HidePopup("RulesPopup");
        }
        elif (buttonName == "CloseDebug") {
            UI.HidePopup("DebugPopup");
        }
    }

    function CreateRulesPopup() {
        if (self._rulesPopupCreated) {return;}
        
        # 1. Create popup container (same dimensions)
        UI.CreatePopup("RulesPopup", "Original Gamemode PvT - GUIDELINES", 900, 700);
        
        # 2. Header (identical to original)
        UI.AddPopupLabel("RulesPopup", 
            "<color=#AAAAAA>These guidelines help maintain balanced gameplay. " +
            String.Newline +
            "Host may adjust rules to ensure everyone is having fun!</color>" + 
            String.Newline + String.Newline +
            "<size=24><color=#FF5555>WEAPON RESTRICTIONS</color></size>");
        
        # 3. Weapon rules (original formatting)
        UI.AddPopupLabel("RulesPopup", 
            "<color=#FF9999>NO APG/AHSS/TS weapons allowed (OP Against PTs)</color>" + 
            String.Newline + 
            "  <size=16><i>(Will be enabled in future updates)</i></size>");
        
        # 4. Respawn rules (original colors)
        UI.AddPopupLabel("RulesPopup", 
            String.Newline + "<size=24><color=#55FF55>RESPAWN</color></size>" +
            String.Newline +
            "Base respawn: <color=#FFFF00>60 seconds</color>" +
            String.Newline +
            "Adjusted down to <color=#FFFF00>30s minimum</color> for disadvantaged teams");

        # 5. Titan abilities (original styling)
        UI.AddPopupLabel("RulesPopup", 
            String.Newline + "<size=24><color=#FFAA00>TITAN ABILITIES</color></size>" +
            String.Newline +
            "<color=#FFCC00>Rock throw limited to 2 PTs max</color>" +
            String.Newline +
            "Throwers chosen randomly each round" +
            String.Newline +
            "<size=16><i>(Host may occasionally allow 3PT)</i></size>");
        
        # 6. Close button (identical implementation)
        UI.AddPopupBottomButton("RulesPopup", "CloseRules", 
            UI.WrapStyleTag("UNDERSTOOD", "color", "#FFFFFF"));
        
        self._rulesPopupCreated = true;
    }

    function CreateDebugPopup() {
        if (self._debugPopupCreated) {return;}
        
        UI.CreatePopup("DebugPopup", "Original Gamemode PvT - GUIDELINES", 900, 700);
        UI.AddPopupLabel("DebugPopup", Game.Loadouts + " - Debug Mode");
        UI.AddPopupBottomButton("DebugPopup", "CloseDebug", 
            UI.WrapStyleTag("UNDERSTOOD", "color", "#FFFFFF"));
        
        self._debugPopupCreated = true;
    }

    function ShowRulesPopup() {
        if (!self._rulesPopupCreated) {
            self.CreateRulesPopup();
        }
        UI.ShowPopup("RulesPopup");
    }

    function ShowDebugPopup() {
        if (!self._debugPopupCreated) {
            self.CreateDebugPopup();
        }
        UI.ShowPopup("DebugPopup");
    }
}

extension RockThrowSystem {
    rockthrowers = new List();
    
    function Init() {
        self.rockthrowers = String.Split(Main.AuthorizedRockThrower, "-");
    }
    
    function OnSecond() {
        if (!Main.EnableRockThrowSystem) {return;}

        if (Network.MyPlayer != null && 
            Network.MyPlayer.Character != null && 
            Network.MyPlayer.Character.Type == "Titan" && 
            Network.MyPlayer.Status == "Alive" && 
            !self.rockthrowers.Contains(Convert.ToString(Network.MyPlayer.ID))) {
            
            Input.SetKeyDefaultEnabled("Titan/AttackRockThrow", false);
        }
    }
    
    function HandleSpawn(character) {
        if (!Main.EnableRockThrowSystem) {return;}

        if (character.Type == "Titan" && !character.IsAI) {
            playerID = Convert.ToString(character.Player.ID);
            
            # Red outline for rock throwers
            if (self.rockthrowers.Contains(playerID)) {
                character.AddOutline(Color("#FF0000"), "OutlineVisible");
            }
        }
    }

    function OnRockThrow() {
        if (Network.MyPlayer != null && 
            Network.MyPlayer.Character != null && 
            Network.MyPlayer.Character.Type == "Titan") {
            
            # Get current position and rotation
            pos = Network.MyPlayer.Character.Position;
            rot = Network.MyPlayer.Character.Rotation;
            
            # Calculate throw direction and velocity
            fwd = Vector3(0, 0, 1).Rotate(rot);
            vel = fwd * 50;
            
            # Spawn rock with owner reference
            rock = Game.SpawnProjectileWithOwner(
                "Rock1",
                pos + Vector3(0, 2, 0),
                rot,
                vel,
                Vector3(0, -9.81, 0),
                10.0,
                Network.MyPlayer.Character, # Owner reference
                1.0
            );
            
            # Store owner ID in two ways for reliability
            rock.SetCustomProperty("ThrowerID", Network.MyPlayer.ID);
            rock.Owner = Network.MyPlayer.Character; # Direct owner assignment
            
            Game.Print("[ROCK THROWN] By: " + Network.MyPlayer.Name + " (ID:" + Network.MyPlayer.ID + ")");
        }
    }
}

extension CommandSystem {
    function HandleCommand(message) {
        if (String.StartsWith(message, "#")) {
            message = String.ToLower(message);
            fullcmd = String.Substring(message, 1);
            listcmd = String.Split(fullcmd, " ");
            cmdword = listcmd.Get(0);
            listcmd.RemoveAt(0);

            # ADMIN or MODERATOR commands 	
			# ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

            # Reset all player stats
            if (cmdword == "resetkdall") {
				if (Network.IsMasterClient) {
					Network.SendMessageAll("resetkdall");
					Game.Print("All players' stats have been reset.");
				}
				elif (Network.MyPlayer.ID == Main.Moderator) {
					Network.SendMessage(Network.MasterClient,"mod:resetkdall");
				} else {
					Game.Print(_nopermission);
				}
				return false;
			}

            if (cmdword == "reviveall") {
				if (Network.IsMasterClient) {
					Network.SendMessageAll("reviveall");
					Game.Print("All players have been revived.");
				}
				elif (Network.MyPlayer.ID == Main.Moderator) {
					Network.SendMessage(Network.MasterClient,"mod:reviveall");
				} else {
					Game.Print(_nopermission);
				}
				return false;
			}

            # Revive all player titans
            if (cmdword == "reviveallpt") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: You are not the MasterClient!</color>");
                } else {
                    self.ReviveAllPTs();
                }
                return false;
            }

            # Revive all player titans
            if (cmdword == "reviveallhumans") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: You are not the MasterClient!</color>");
                } else {
                    self.ReviveAllHumans();
                }
                return false;
            }

            # Set Team Wins
            if (cmdword == "setwins") {
                if (!Network.IsMasterClient) {
                    Game.Print(Main._nopermission);
                } elif (listcmd.Count > 1) {
                    ScoreSystem._HumanScore = Convert.ToInt(listcmd.Get(0));
                    ScoreSystem._TitanScore = Convert.ToInt(listcmd.Get(1));
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                    Game.Print("Scores set: Humans " + ScoreSystem._HumanScore + " - " + ScoreSystem._TitanScore + " Titans");
                }
                return false;
            }

            # Toggle strict mode
            if (cmdword == "mode") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: Only MasterClient can change mode!</color>");
                    return false;
                }
                Main.FullClear = !Main.FullClear;
                
                # UI feedback for mode change
                if (Main.FullClear) {
                    Game.Print("<color='#FFA500'>Mode Changed:</color> <color='#00FF00'>Full AI Clear: ON</color>");
                    UI.SetLabelForTime("TopRight", "<color='#FF0000'>STRICT MODE</color>Kill ALL AIs", 5);
                } else {
                    Game.Print("<color='#FFA500'>Mode Changed:</color> <color='#00FF00'>Full AI Clear: OFF</color>");
                    UI.SetLabelForTime("TopRight", "<color='#00FF00'>NORMAL MODE</color> AIs can survive", 5);
                }
                return false;
            }

            # Slow motion toggle
            if (cmdword == "slowmo") {
                if (Network.IsMasterClient || Network.MyPlayer.ID == Main.Moderator) {
                    if (Time.TimeScale == 1.0) {
                        Time.TimeScale = 0.33;
                        Game.Print("Slow motion enabled");
                        if (Network.IsMasterClient) {
                            Network.SendMessageAll("slowmo");
                        }
                    } else {
                        Time.TimeScale = 1.0;
                        Game.Print("Slow motion disabled");
                        if (Network.IsMasterClient) {
                            Network.SendMessageAll("slowmo_off");
                        }
                    }
                } else {
                    Game.Print(Main._nopermission);
                }
                return false;
            }

            # Clear chat  
            if (cmdword == "clearchat") {
                if (Network.IsMasterClient) {
                    Network.SendMessageAll("clearchat");
                    Game.Print("Cleared chat for all players.");
                } elif (Network.MyPlayer.ID == Main.Moderator) {
                    Network.SendMessage(Network.MasterClient, "mod:clearchat");
                } else {
                    Game.Print(Main._nopermission);
                }
                return false;
            }

            # Show debug popup 
            if (!Network.IsMasterClient) {
                Game.Print("<color='#CC0000'>Error: You are not the MasterClient!</color>");
            } elif (cmdword == "debug") {
                UISystem.ShowDebugPopup();
                return false;
            }

            # Command for testing sync messages
            if (cmdword == "testsync") {
                if (!Network.IsMasterClient) {return false;}
                
                # Create a combined message string
                syncData = "human_wins=5;titan_wins=3";
                Network.SendMessageAll("WinSync:" + syncData);
                
                Game.Print("Sent test sync: " + syncData);
                return false;
            }

            # ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
			# ADMIN or MODERATOR commands

        
            # Tutorial replay command (for any player)
            if (cmdword == "tutorial") {
                Cutscene.Start("PvTQuickStart", true);
                Game.Print("Replaying tutorial...");
                return false;
            }

            # Show rule popup
            if (cmdword == "rules") {
                UISystem.ShowRulesPopup();  # ← Use this instead of direct UI.ShowPopup()
                return false;
            }

            # Reset personal stats
            if (cmdword == "resetkd") {
                ScoreSystem.ResetKD(Network.MyPlayer);
                Game.Print("Your stats have been reset.");
                return false;
            }
            return false;
        }
    }

    function ReviveAllPTs() {
        ptcount = 0;
        for (p in Network.Players) {
            if (p.CharacterType == "Titan") {
                ptcount = ptcount + 1;
                Game.SpawnPlayer(p, false);
            }
        }
        if (ptcount == 0) {
            # Game.Print("There are no player titans in this room.");
        } else {
            Game.Print("Revived all PTs.");
        }
    }

    function ReviveAllHumans() {
        humanCount = 0;
        for (h in Network.Players) {
            if (h.CharacterType == "Human") {
                humanCount = humanCount + 1;
                Game.SpawnPlayer(h, false);
            }
        }
        if (humanCount == 0) {
            # Game.Print("There are no humans in this room.");
        } else {
            Game.Print("Revived all Humans!");
        }
    }
}

extension AHSSUnlockSystem {
    # Configuration - adjust these values as needed
    PointsForAHSS = 15;
    AITitanPointValue = 1;
    PlayerTitanPointValue = 5;
    _ahssConfirmationEnabled = true;
    
    # State tracking
    PlayerData = Dict();
    _ahssUnlocker = null;
    _ahssUnlocked = false;
    
    # Initialization
    function Initialize()
    {
        self.PlayerData.Clear();
        self._ahssUnlocker = null;
        self._ahssUnlocked = false;
    }
    
    # Core functionality
    function ProcessTitanKill(victim, killer, killerName) {
        if (!Main.EnableAHSSUnlockSystem) {return false;}
        if (victim == null || killer == null || killer.Type != "Human") {return false;}
        
        playerName = killer.Name;
        currentData = self.GetPlayerData(playerName);
        
        # Block if already unlocked by someone else
        if (self._ahssUnlocked && playerName != self._ahssUnlocker) {return false;}
        
        # Calculate points
        if (victim.IsAI) {
            pointsToAdd = self.AITitanPointValue;
        }
        else {
             pointsToAdd = self.PlayerTitanPointValue;
        }
            newPoints = currentData.Get("points") + pointsToAdd;
            currentData.Set("points", newPoints);
        
        # Check for unlock
        if (!self._ahssUnlocked && newPoints >= self.PointsForAHSS && !currentData.Get("unlocked"))
        {
            currentData.Set("unlocked", true);
            return self.HandleUnlock(killer, playerName);
        }
        
        self.UpdatePlayerCounter(playerName, newPoints);
        return false;
    }
    
    # Helper functions
    function GetPlayerData(playerName)
    {
        if (!self.PlayerData.Contains(playerName))
        {
            data = Dict();
            data.Set("points", 0.0);
            data.Set("unlocked", false);
            self.PlayerData.Set(playerName, data);
        }
        return self.PlayerData.Get(playerName);
    }
    
    function UpdatePlayerCounter(playerName, points)
    {
        if (self._ahssUnlocked) {return;}
        
        formattedPoints = String.FormatFloat(points, 1);
        text = playerName + ": " + formattedPoints + "/" + self.PointsForAHSS;
        UI.SetLabelAll("TopRight", text);
    }
    
    function HandleUnlock(character, playerName)
    {
        self._ahssUnlocked = true;
        self._ahssUnlocker = playerName;
        
        UI.SetLabelAll("TopRight", "");
        UI.SetLabelAll("TopCenter", "AHSS Unlocked!");
        
        if (self._ahssConfirmationEnabled && character.IsMine)
        {
            self.StartConfirmation(character);
        }
        else
        {
            self.ActivateAHSS(character);
        }
        
        return true;
    }
    
    coroutine StartConfirmation(character)
    {
        UI.SetLabelForTime("TopRight", "Hold <color=yellow>'Reload'</color> to unlock AHSS", 5);
        
        while (!Input.GetKeyHold("Human/Reload"))
        {
            wait 0.1;
        }
        
        self.ActivateAHSS(character);
    }
    
    function ActivateAHSS(character)
    {
        if (character.Type != "Human") {return;}
        
        character.SetWeapon("AHSS");
        character.CurrentAmmoRound = 2;
        character.CurrentAmmoLeft = 3;
        character.MaxAmmoRound = 2;
        character.MaxAmmoTotal = 3;
        
        if (character.IsMine)
        {
            character.PlaySound("AHSSGunShotDouble2");
        }
        
        if (Network.IsMasterClient)
        {
            Game.PrintAll(character.Name + " has unlocked AHSS!");
        }
    }
}

extension IdleSystem {
    AfkKillTime = 60;
    IsAfk = false;
    IdleRespawn = false;
    IdleProp = "IsAfk";

    _AfkTimer = 60;
    _lastPosition = Vector3(0,0,0);

    function OnFrame() {
        if (!Main.EnableIdleSystem) {return;}

        if (self.IsAfk && Input.GetKeyDown("General/Forward"))
        {
            self.IsAfk = false;
            self._AfkTimer = self.AfkKillTime;
            self._lastPosition = Vector3(0,0,0);
            if (self.IdleRespawn) {
                Game.SpawnPlayer(Network.MyPlayer, false);
            }
            self.SyncProp();
        }
    }

    function SyncProp() {
        Network.MyPlayer.SetCustomProperty(self.IdleProp, self.IsAfk);
    }

    function OnSecond(){
        if (!Main.EnableIdleSystem) {return;}

        if (self.IsAfk && Network.MyPlayer.Status != "Spectate")
        {
            if (self.IdleRespawn)
            {
                UI.SetLabelForTime("MiddleCenter", "You are Idle" + String.Newline + "Press '<color=#ff0000>" + Input.GetKeyName("General/Forward") + "</color>' to respawn.", 1.1);
            }
            else
            {
                UI.SetLabelForTime("MiddleCenter", "You are Idle" + String.Newline + "Press '<color=#ff0000>" + Input.GetKeyName("General/Forward") + "</color>' to queue for respawn.", 1.1);
            }
        }

        if (Network.MyPlayer.Status == "Alive")
        {
            if (Vector3.Distance(Network.MyPlayer.Character.Position, self._lastPosition) < 0.1)
            {
                self._AfkTimer -= 1;
            }
            else
            {
                self._AfkTimer = self.AfkKillTime;
            }

            self._lastPosition = Network.MyPlayer.Character.Position;
            if (self._AfkTimer < 1)
            {
                Network.MyPlayer.Character.GetKilled("Idle");
                self.IsAfk = true;
                self._AfkTimer = self.AfkKillTime;
                self.SyncProp();
            }
        }
    }
}

extension KCRevival {
    _killCounter = 0;

    function Init() { }

    function ResetState() {
        self._killCounter = 0;
        UI.SetLabel("BottomCenter", String.Newline + String.Newline + String.Newline + 
                       String.Newline + String.Newline);
    }

    function OnSpawn() {
        if (!Main.EnableKCRevivalSystem) {return;}
        self.ResetState();
    }

    function OnDeath() {
        if (!Main.EnableKCRevivalSystem) {return;}
        self.ShowRevivalCount();
    }

    function ShowRevivalCount() {
        if (!Main.EnableKCRevivalSystem) {return;}
        if (Network.MyPlayer.Status != "Dead" || IdleSystem.IsAfk)
        {
            return;
        }
        totalKillsNeeded = Main.KillsToRevive - self._killCounter;
        message = "<size=24>You will be revived after <color=#FF3333><b>" + 
                    Convert.ToString(totalKillsNeeded) + "</b></color> kills</size>";
        message += String.Newline + String.Newline + String.Newline + String.Newline;
        UI.SetLabel("BottomCenter", message);
    }

    function OnSecond() {
        if (!Main.EnableKCRevivalSystem) {return;}
        if (Network.MyPlayer.Status == "Spectating")
        {
            UI.SetLabel("BottomCenter", String.Newline + String.Newline + String.Newline + 
                       String.Newline + String.Newline);
        }
        elif (Network.MyPlayer.Status == "Dead")
        {
            self.ShowRevivalCount();
        }
        
    }

    function ProcessTitanKill(killerName, value)
    {
        if (!Main.EnableKCRevivalSystem) {return;}
        if (Network.MyPlayer.Status != "Dead" || IdleSystem.IsAfk)
        {
            return;
        }

        self._killCounter += value;
        if (self._killCounter >= Main.KillsToRevive)
        {
            self.ResetState();
            Game.SpawnPlayer(Network.MyPlayer, false);

            UI.SetLabelForTime("MiddleCenter", 
                "<size=30><color=#33FF33>You have been revived by " + 
                "<b>" + killerName + "</b></color></size>", 5.0);
        }
        else {
            self.ShowRevivalCount();
        }
    }
}

extension RespawnSystem {
    BaseRespawnTime = 60.0;
    MinRespawnTime = 30.0;
    RespawnHumanScale = 2.0;
    RespawnTitanScale = 4.0;
    ManualHumanTimer = 0;
    ManualTitanTimer = 0;
    
    respawn_timers = new Dict();
    respawn_timer_keys = new List();

    function OnSecond() {
        if (!Main.EnableRespawnSystem) {return;}

        # Initialize/reset if needed
        if (self.respawn_timers == null) {
            self.respawn_timers = new Dict();
            self.respawn_timer_keys = new List();
        }

        if (self.respawn_timer_keys == null || self.respawn_timer_keys.Count == 0) {
            return;
        }

        keys_to_remove = new List();
        
        for (key in self.respawn_timer_keys) {
            if (key == null) {continue;}
            
            # Get raw time value
            rawTime = self.respawn_timers.Get(key);
            if (rawTime == null) {continue;}
            
            # Simple countdown
            timeLeft = Convert.ToFloat(rawTime) - 1.0;
            self.respawn_timers.Set(key, timeLeft);
            
            if (timeLeft <= 0) {
                # Extract player ID (remove H-/T- prefix)
                playerID = String.Replace(key, "H-", "");
                playerID = String.Replace(playerID, "T-", "");
                
                # Find dead player
                targetPlayer = null;
                for (player in Network.Players) {
                    if (Convert.ToString(player.ID) == playerID && player.Status == "Dead") {
                        targetPlayer = player;
                        break;
                    }
                }
                
                if (targetPlayer != null) {
                    Game.SpawnPlayer(targetPlayer, false);
                    # Game.Print("Respawned " + targetPlayer.Name); FOR DEBUGGING
                }
                keys_to_remove.Add(key);
            }
        }
    
        # Cleanup Timers
        for (key in keys_to_remove) {
            self.respawn_timer_keys.Remove(key);
            self.respawn_timers.Remove(key);
        }
    }

    function GetHumanRespawnDelay() {
        # Admin override takes priority
        if (Main.ManualHumanTimer != null && Convert.ToFloat(Main.ManualHumanTimer) > 0) {
            return Convert.ToFloat(Main.ManualHumanTimer);
        }
        
        # Fallback if team data missing
        if (Game.PlayerTitans == null || Game.PlayerHumans == null) {
            Game.Print("[WARN] Missing team data, using default delay");
            return self.BaseRespawnTime;
        }
        
        # Dynamic calculation
        imbalance = Game.PlayerTitans.Count - Game.PlayerHumans.Count;
        calculated = self.BaseRespawnTime - (imbalance * self.RespawnHumanScale);
        
        return Math.Max(calculated, self.MinRespawnTime);
    }

    function GetTitanRespawnDelay() {
        # Check for admin override first
        if (Main.ManualTitanTimer != null && Convert.ToFloat(Main.ManualTitanTimer) > 0) {
            return Convert.ToFloat(Main.ManualTitanTimer);
        }
        
        # Fallback if team data missing
        if (Game.PlayerHumans == null || Game.PlayerTitans == null) {
            Game.Print("[WARN] Missing team data, using default delay");
            return self.BaseRespawnTime;
        }
        
        # Calculate dynamic delay based on team imbalance
        imbalance = Game.PlayerHumans.Count - Game.PlayerTitans.Count;
        calculated = self.BaseRespawnTime - (imbalance * self.RespawnTitanScale);
        
        # Ensure delay doesn't go below minimum
        return Math.Max(calculated, self.MinRespawnTime);
    }

    function QueueRespawn(victim) {
        if (!Main.EnableRespawnSystem) {return;}

        # Determine team prefix (H- for human, T- for titan)
        teamPrefix = "T-";
        if (victim.Type == "Human") {
            teamPrefix = "H-";
        }
        
        # Create respawn timer key
        playerIDstr = Convert.ToString(victim.Player.ID);
        if (String.Length(playerIDstr) == 0) {
            Game.Print("[ERROR] Invalid player ID");
            return;
        }
        storeKey = teamPrefix + playerIDstr;
        
        # Calculate respawn delay based on team
        delay = self.GetTitanRespawnDelay();
        if (victim.Type == "Human") {
            delay = self.GetHumanRespawnDelay();
        }
        
        # Queue respawn if valid
        if (delay != null && storeKey != null) {
            self.respawn_timers.Set(storeKey, delay);
            if (self.respawn_timer_keys == null) {
                self.respawn_timer_keys = new List();
            }
            if (!self.respawn_timer_keys.Contains(storeKey)) {
                self.respawn_timer_keys.Add(storeKey);
            }
        }
    }
}

extension ScoreSystem {
    _HumanScore = 0;
    _TitanScore = 0;
    
    function UpdateScore(x, iskiller, damage, restarting) {
        if (!Main.EnableScoreSystem) {return;}
        # Only update stats if not during game restart
        if (restarting == false) {
            if (iskiller) {
                x.Kills = x.Kills + 1;
                x.TotalDamage = x.TotalDamage + damage;
                if (x.HighestDamage < damage) { x.HighestDamage = damage; }
            } else {
                x.Deaths = x.Deaths + 1;
            }
        }

        # Calculate performance ratios
        kdr = self.f(x.Kills) / self.f(x.Deaths);
        dmg = self.f(x.TotalDamage) / self.f(x.Kills);
        
        # Format for display (handle division by zero cases)
        if (x.Kills > 0 && x.Deaths > 0) { 
            kdr = String.FormatFloat(kdr, 2); 
        } else { 
            kdr = "-"; 
        }
        if (x.TotalDamage == 0) { 
            dmg = "-"; 
        } else { 
            dmg = String.FormatFloat(dmg, 2); 
        }
        
        # Update scoreboard
        x.SetCustomProperty("KDRA", 
            x.Kills + " / " + x.Deaths + 
            " / " + x.HighestDamage + " / " + x.TotalDamage
        );
        
        # Save stats to persistent storage
        RoomData.SetProperty("kills", x.Kills);
        RoomData.SetProperty("deaths", x.Deaths);
        RoomData.SetProperty("highdmg", x.HighestDamage);
        RoomData.SetProperty("totdmg", x.TotalDamage);
    }
    
    function ResetKD(x) {
        x.Kills = 0;
        x.Deaths = 0;
        x.HighestDamage = 0;
        x.TotalDamage = 0;
        
        # Update scoreboard display
        x.SetCustomProperty("KDRA", "0 / 0 / 0 / 0");
        
        # Clear persistent storage
        RoomData.SetProperty("kills", 0);
        RoomData.SetProperty("deaths", 0);
        RoomData.SetProperty("highdmg", 0);
        RoomData.SetProperty("totdmg", 0);
    }
    
    function HandleWinSync(message) {
        if (String.StartsWith(message, "WinSync:")) {
            # Extract the data part after "WinSync:"
            dataStr = String.Substring(message, 8);
            
            # Split into key-value pairs
            pairs = String.Split(dataStr, ";");
            
            # Initialize default values
            human = 1;
            titan = 1;
            
            # Parse each pair
            for (pair in pairs) {
                if (String.Contains(pair, "human_wins=")) {
                    human = Convert.ToInt(String.Substring(pair, 11));
                }
                elif (String.Contains(pair, "titan_wins=")) {
                    titan = Convert.ToInt(String.Substring(pair, 11));
                }
            }
            
            # Update values
            self._HumanScore = human;
            self._TitanScore = titan;
            RoomData.SetProperty("human_wins", self._HumanScore);
            RoomData.SetProperty("titan_wins", self._TitanScore);
            TeamSystem.UpdateTeamUI();
        }
    }
    
    # Safe float conversion with null checking
    function f(inp) {
        return Convert.ToFloat(inp);
    }
}

extension TeamSystem {
    function UpdateTeamUI() {
        if (!Main.EnableTeamSystem) {return;}
        TeamScore = "";
        if (Main.ShowTeamScore) {
            TeamScore = String.Newline + "<size=20><color='#5F8DE7'>" + Main.TeamOneName + ": " + ScoreSystem._HumanScore + "</color> | " + "<color='#FFE14C'>" + Main.TeamTwoName + ": " + ScoreSystem._TitanScore + "</color></size>";
        }

        UI.SetLabel("TopCenter",
            "<color='#00ccff'><b>»</b> <color='white'>Player vs Titan</color> <b>«</b></color>"
            + String.Newline
            + "<b><color='#5F8DE7'>H</color></b> " + Game.PlayerHumans.Count
            + " | <b><color='#AAAAAA'>AI</color></b> " + Game.AITitans.Count
            + " | <b><color='#FFE14C'>T</color></b> " + Game.PlayerTitans.Count
            + TeamScore
        );
    }
    
    function TeamHeader(player) {
        prefix = "";
        aiColour = "#AAAAAA";
        tColour = "#FFE14C";
        hColour = "#5F8DE7";
        
        if (player.Type == "Titan") {
            if (player.IsAI) {
                prefix = "<b><color='" + aiColour + "'>(AI)</color></b> ";
            } else {
                prefix = "<b><color='" + tColour + "'>(T)</color></b> ";
            }
        } else {
            prefix = "<b><color='" + hColour + "'>(H)</color></b> ";
        }
        return prefix + player.Name;
    }
    
    function CheckVictoryConditions() {
        if (!Main.EnableTeamSystem) {return;}
        # Case 1: All humans dead - Titans win
        if (Game.PlayerHumans.Count == 0) {
            # Titans win condition
            ScoreSystem._TitanScore += 1;
            Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
            UI.SetLabelForTime("MiddleCenter",
                "<color='#FFE14C'>TITANS WIN!</color>" + String.Newline + "(All Humans eliminated)", 
                5
            );
            
            if (Main._SlowMode) {
                Time.TimeScale = 0.33; # slowmo ending
                Game.End(3.33);
            } else {
                Game.End(10);
            }
        # Case 2: All player titans dead - check AI conditions
        } elif (Game.PlayerTitans.Count == 0) {
            # Full Clear mode requires eliminating all AI titans
            if (Main.FullClear) {
                if (Game.AITitans.Count == 0) {
                    ScoreSystem._HumanScore += 1;
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                    UI.SetLabelForTime("MiddleCenter",
                        "<color='#00FF00'>HUMANS WIN!</color>" + String.Newline + "(All Titans eliminated)", 
                        5
                    );
                    
                    if (Main._SlowMode) {
                        Time.TimeScale = 0.33;
                        Game.End(3.33);
                    } else {
                        Game.End(10);
                    }
                } else {
                    UI.SetLabelAll("TopRight", "<color='#FF0000'>AIs left to win: </color>" + Game.AITitans.Count);
                }
            } else {
                if (Game.AITitans.Count < 5) {
                    ScoreSystem._HumanScore += 1;
                    UI.SetLabelForTime("MiddleCenter", 
                        "<color='#FFFF00'>AUTO-RESTARTING...</color>", 
                        3
                    );
                    
                    if (Main._SlowMode) {
                        Time.TimeScale = 0.33;
                        Game.End(3.33);
                    } else {
                        Game.End(5);
                    }
                } elif (Network.IsMasterClient) {
                    ScoreSystem._HumanScore += 1;
                    CommandSystem.ReviveAllHumans();
                    CommandSystem.ReviveAllPTs();
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                }
            }
        }
    }
}


#======================================================================
# TUTORIAL CUTSCENE
# Plays animated introduction sequence
#======================================================================

cutscene PvTQuickStart {
    coroutine Start() {
        # Camera Settings
        spawn = Map.FindMapObjectByName("TutorialSpawn");
        startPosition = Vector3(0, 450, -500);
        startRotation = Vector3(40, 0, 0);
        Camera.SetPosition(startPosition);
        Camera.SetRotation(startRotation);

        # 1. Mode Title
        Cutscene.ShowDialogue("Fenglee1", "PvT", "HUMANS vs TITANS - Original Mode");
        wait 5.0;

        # 2. Human Goal
        Cutscene.ShowDialogue("Armin1", "HUMANS GOAL", "Kill ALL Titans (players + AI) to win!");
        wait 5.0;

        # 3. Titan Goal
        Cutscene.ShowDialogue("Annie2", "TITANS GOAL", "Wipe out ALL Humans before they kill you!");
        wait 5.0;

        # 4. Rules
        Cutscene.ShowDialogue("Erwin1", "RULES COMMAND", "Type in chat: #rules for all Rules");
        wait 5.0;

        # 5. Tips
        Cutscene.ShowDialogue("Historia2", "HUMAN TIP", "Stick together, focus ONE PT at once!... ONE BY ONE");
        wait 5.0;

        Cutscene.ShowDialogue("Zeke1", "TITAN TIP", "Push as a TEAM, don't fight ALONE!");
        wait 5.0;

        # Explain why AHSS and APG are disabled; and they will soon be enabled

        # 9. Countdown
        Cutscene.ShowDialogue("Levi1", "READY?", "Are you Ready for Battle? #RURfB");
        wait 4.0;
        Cutscene.ShowDialogue("Levi1", "FIGHT!", "LET'S GO!");
    }
}