#======================================================================
# PvT GAME MODE CORE SCRIPT
# Credits to Jibs & Sonic
# 
# Features:
# - Team-based respawn feature with dynamic timers
# - Velocity-based damage calculations
# - Win condition tracking (Humans vs Titans)
# - Special player abilities (rock throw)
# - Advanced scoreboard statistics
#======================================================================
class Main {    
    /*===== GAME CONFIGURATION =====*/
    # Team Settings
    _HumanScore = 0;           # Total human victories  
    _TitanScore = 0;           # Total titan victories
    FullClear = true;          # Victory mode
    FullClearTooltip = "When enabled, humans must eliminate ALL Titans (AIs + PTs) to win.";

    # Spawn Settings  
    Titans = 15;              
    TitansTooltip = "Initial number of AI Titans spawned at match start.";
    BaseRespawnTime = 60.0;     # Default respawn delay
    BaseRespawnTimeTooltip = "Default respawn delay in seconds.";
    MinRespawnTime = 30.0;
    MinRespawnTimeTooltip = "Minimum possible respawn delay (cannot go below this).";

    # Special Abilities
    AuthorizedRockThrower = "";
    AuthorizedRockThrowerTooltip = "Player IDs separated by hyphens (1-2-3) who can throw rocks as Titans.";

    /*===== GAME FEATURES =====*/
    # Movement Tracking
    lastMagnitudes = new Dict(); # Tracks each player's movement speed

    # Player States
    rockthrowers = new List(); # Parsed rock throwers

    # Respawn Variables Feature
    respawn_timer_keys = new List(); # Active timers
    RespawnHumanScale = 2.0;
    RespawnHumanScaleTooltip = "How much human respawn time reduces per missing teammate.";
    RespawnTitanScale = 4.0; 
    RespawnTitanScaleTooltip = "How much titan respawn time reduces per missing teammate.";
    
    # Admin overrides
    human_override = null;          # Manual human respawn time
    titan_override = null;          # Manual titan respawn time

    # Greeting Feature
    _GreetingsFontSize = 20;  # Font size for special player greeting messages.

    # UNNAMED Section
    _rulesPopupCreated = false;

    /*===== INITIALIZATION =====*/
    # Initializes game state when match starts
    function OnGameStart() {
        # Initialize respawn timers
        self.respawn_timers = new Dict();

        self.createRulesPopup();

        # Configure UI defaults
        UI.SetLabel("MiddleCenter", "");
        Game.DefaultShowKillFeed = false;
        Game.DefaultShowKillScore = false;
        Game.DefaultAddKillScore = false;
        
        # Load persistent win counts
        self._HumanScore = RoomData.GetProperty("human_wins", 0);
        self._TitanScore = RoomData.GetProperty("titan_wins", 0);

        if (Network.IsMasterClient) {
            Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
        }
        
        # Configure scoreboard
        UI.SetScoreboardProperty("KDRA");
        UI.SetScoreboardHeader("Kills / Deaths / Max / Total");

        # Load player stats
        Network.MyPlayer.Kills = RoomData.GetProperty("kills", 0);
        Network.MyPlayer.Deaths = RoomData.GetProperty("deaths", 0);
        Network.MyPlayer.HighestDamage = RoomData.GetProperty("highdmg", 0);
        Network.MyPlayer.TotalDamage = RoomData.GetProperty("totdmg", 0);
        
        # Initialize game state
        self.updateScore(Network.MyPlayer, false, 0, true);
        Game.SpawnTitansAsync("Default", self.Titans);
        self.updateTeamUI();
        
        # Parse special ability IDs
        self.rockthrowers = String.Split(self.AuthorizedRockThrower, "-");

        # Cutscene for game start
        
            # 1. Load tutorial state
         self.tutorialShown = RoomData.GetProperty("tutorial_shown", false);

            # 2. Show tutorial if needed
        if (!self.tutorialShown) {
            Cutscene.Start("PvTQuickStart", true);
            self.tutorialShown = true;
            RoomData.SetProperty("tutorial_shown", true); # Documented persistence
        }
    }

    # Special greetings for notable players
    function OnPlayerSpawn(player, character) {
        hasGreetedProperty = player.GetCustomProperty("greeted");
        if (hasGreetedProperty == null) {
            hasGreeted = false;
        }
        else{
            hasGreeted = true;
        }
        # Game.Print("DEBUG: Player " + player.Name + " has 'greeted' property: " + hasGreeted); # FOR DEBUGGING

        if (!hasGreeted) {
             if (player.Name == "Ariana") {
                self.ShowPlayerGreeting(player.Name, "The LegendAry is HERE!");
            }
            if (player.Name == "Assyrian") {
                Game.Print("Ashurbanipal the legend of Assyria is back. Also known as Barney");
            }
            if (player.Name == "Doopad") {
                Game.Print("The 'Nom' Master has Arrived");
            }
            if (player.Name == "Cookies18") {
                Game.Print("Master of Voodoo SHIT is here, who will be the sacrifice today?");
            }
            if (player.Name == "Tornado76") {
                Game.Print("BRACE YOURSELF, THE TORNADO IS HERE!");
            }
            if (player.Name == "Auvre") {
                Game.Print("HELP ME TAKE PICTURES of THE MATCHES AAAAAAAAA!");
            }
            if (player.Name == "Nietoperek") {
                Game.Print("One DAY he will greet us first... :)");
            }
            if (player.Name == "Kamgo") {
                Game.Print("K-k-k-AMGO is HERE???!");
            }
            if (player.Name == "Beef3691") {
                Game.Print("J...JAMIE, You are playing again??!!");
            }
            if (player.Name == "ShiniGami") {
                Game.Print("...Is that even possible? he has risen from the grave?!!");
            }
            if (player.Name == "anunaki") {
                Game.Print(":O | Anunuka has actually joined the game?!!");
            }
            if (player.Name == "Hanji") {
                Game.Print("*Assyrian Distant Sounds* PLAAAYYYBOOOOYYY!");
            }
            if (player.Name == "Kaze") {
                Game.Print("The LEGEND says that Kaze is still digging up his ancestry tree to get a new record...");
            }
            if (player.Name == "Craggs") {
                Game.Print("'Life is SOLID 5/10' - Craggs 2023");
            }
            if (player.Name == "Symetha") {
                Game.Print("Sy-mi-mo-METHA is IN THE GAME!!");
            }
            if (player.Name == "Lavasuna") {
                Game.Print("Brace yourselves PTs. Lavasuna is on the hunt...");
            }
            if (player.Name == "Alpha") {
                Game.Print("Best <b><s>~Gambler~</s></b> DMG dealer is here");
            }
            if (player.Name == "Dr.Eisenlocke" || player.Name == "Brise" || player.Name == "Chaos") {
                Game.Print("Final Art is here!");
            }
            

            # Mark the player as greeted
            player.SetCustomProperty("greeted", true);
            # Game.Print("DEBUG: Player " + player.Name + " 'greeted' property set to true."); # FOR DEBUGGING
        } 
        # else {
        #     Game.Print("DEBUG: Player " + player.Name + " already has 'greeted' property."); # FOR DEBUGGING
        # }

        # Sync win counts if MasterClient
        if (Network.IsMasterClient) {
            Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
        }
    }

    # Add this new function in your Main class
    function ShowPlayerGreeting(playerName, message) {
        color = "#FFFFFF";  # Default white color
        size = self._GreetingsFontSize;
        
        # Special formatting for certain players
        # if (playerName == "Ariana") {
        #     color = "#FFD700";  # Gold color for Ariana
        #     size = 24;  # Slightly larger for emphasis
        # }
        Game.Print("<size=" + size + "><color='" + color + "'>" + message + "</color></size>");
    }


    /*===== CORE GAME LOOP =====*/
    # Runs every game tick (high frequency)
    function OnTick() {
        # 1. Track human movement velocities
        # 2. Process active respawn timers
        for (human in Game.PlayerHumans) {
            if (human != null && human.Player != null) {
                mag = human.Velocity.Magnitude;
                if (mag > 1) {
                    self.lastMagnitudes.Set("mag-"+human.Player.ID, mag);
                }
            }
        }

       
    }

    # Runs every second (low frequency)
    function OnSecond() {
        # Disable rock throw for non-authorized titans
        if (Network.MyPlayer != null && 
            Network.MyPlayer.Character != null && 
            Network.MyPlayer.Character.Type == "Titan" && 
            Network.MyPlayer.Status == "Alive" && 
            !self.rockthrowers.Contains(Convert.ToString(Network.MyPlayer.ID))) {
            
            Input.SetKeyDefaultEnabled("Titan/AttackRockThrow", false);
        }

         # Initialize/reset if null
        if (self.respawn_timers == null) {
            self.respawn_timers = new Dict();
            self.respawn_timer_keys = new List();
            return;
        }

        if (self.respawn_timer_keys == null || self.respawn_timer_keys.Count == 0) {
            return;
        }

        keys_to_remove = new List();
        
        for (key in self.respawn_timer_keys) {
            if (key == null || !self.respawn_timers.Contains(key)) {
                keys_to_remove.Add(key);
                continue;
            }
            
            rawTime = self.respawn_timers.Get(key);
            if (rawTime == null) {
                keys_to_remove.Add(key);
                continue;
            }
            
            timeLeft = Convert.ToFloat(rawTime) - Time.TickTime;
            
            if (timeLeft <= 0) {
                playerIDstr = String.Substring(key, 2);
                isNumber = true;
                for (i in Range(0, String.Length(playerIDstr), 1)) {
                    char = String.SubstringWithLength(playerIDstr, i, 1);
                    if (!String.Contains("0123456789", char)) {
                        isNumber = false;
                        break;
                    }
                }
                
                if (isNumber) {
                    playerID = Convert.ToInt(playerIDstr);
                    targetPlayer = null;
                    for (player in Network.Players) {
                        if (player.ID == playerID && player.Status == "Dead") {
                            targetPlayer = player;
                            break;
                        }
                    }
                    
                    if (targetPlayer != null) {
                        Game.SpawnPlayer(targetPlayer, false);
                        self.respawn_timers.Remove(key);
                        keys_to_remove.Add(key);
                    }
                }
            } else {
                self.respawn_timers.Set(key, timeLeft);
            }
        }
        
        for (key in keys_to_remove) {
            self.respawn_timer_keys.Remove(key);
        }
    }

    /*===== GAME EVENTS =====*/
    # Handles character spawn events
    function OnCharacterSpawn(character) {
        self.updateTeamUI();
        
        # Add special outlines for titans
        if (character.Type == "Titan" && !character.IsAI) {
            playerID = Convert.ToString(character.Player.ID);
            
            # Red outline for rock throwers
            if (self.rockthrowers.Contains(playerID)) {
                character.AddOutline(Color("#FF0000"), "OutlineVisible");
            }
        }
    }

    # Handles all damage events and victory conditions
    function OnCharacterDamaged(victim, killer, killerName, damage) {   
        # Basic validation
        if (victim == null || victim.Health > 0 || victim.Player == null) {
            return;
        }
        
        # Player-only respawn (excludes AI)
        if (!victim.IsAI) {
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
        delay = self.getTitanRespawnDelay();
        if (victim.Type == "Human") {
            delay = self.getHumanRespawnDelay();
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
            # Game.Print("[QUEUED] " + storeKey + ": " + delay + "s"); For Debugging
            }
        }
            
        # Process kill feed and scoring
        weapon = "Blade";
        
        # Human killer case
        if (killerName != "Rock" && killer != null && killer.Type == "Human") {
            weapon = killer.Weapon;
            damage = damage;
            
            Game.ShowKillFeed(
                self.TeamHeader(killer),
                self.TeamHeader(victim),
                damage,
                weapon
            );
            
            # Update killer's score if local player
            if (killer.Name == Network.MyPlayer.Name) {
                Game.ShowKillScore(damage);
                self.updateScore(killer.Player, true, damage, false);
            } 
            
            # Update victim's score if local player
            if (victim.Name == Network.MyPlayer.Name) {
                self.updateScore(victim.Player, false, 0, false);
            }
        }
        
        # Titan killer case
        if (killerName != "Rock" && killer != null && killer.Type == "Titan") {
            if (victim.Name == Network.MyPlayer.Name) {
                # Calculate velocity-based damage
                damage = self.lastMagnitudes.Get("mag-"+victim.Player.ID, 5.0) * 10.0 + 1;
                
                Game.ShowKillFeedAll(
                    self.TeamHeader(killer),
                    self.TeamHeader(victim),
                    damage,
                    weapon
                );
                self.updateScore(victim.Player, false, 0, false);
            }
            
            if (killer.Name == Network.MyPlayer.Name) {
                self.updateScore(killer.Player, true, 0, false);
            }
        }
        
        # Rock kill case
        if (killerName == "Rock") {
            if (victim.Name == Network.MyPlayer.Name) {
                # Calculate velocity-based damage
                damage = self.lastMagnitudes.Get("mag-"+victim.Player.ID, 5.0) * 10.0 + 1;
                
                Game.ShowKillFeedAll(
                    "<b><color='#ff0000'>ROCK</color></b>",
                    self.TeamHeader(victim),
                    damage,
                    weapon
                );
                self.updateScore(victim.Player, true, 0, false);
            }
        }

        # Update team UI
        self.updateTeamUI();

        # Check victory conditions
        if (Game.PlayerHumans.Count == 0) {
        # Titans win condition
        self._TitanScore += 1;
        Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
        UI.SetLabelForTime("MiddleCenter",
            "<color='#FFE14C'>TITANS WIN!</color>" + String.Newline + "(All Humans eliminated)", 
            5
        );
        Game.End(10);
        } elif (Game.PlayerTitans.Count == 0) {
            if (self.FullClear) {
                # Strict mode - must eliminate all AIs to win
                if (Game.AITitans.Count == 0) {
                    self._HumanScore += 1;
                    Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
                    UI.SetLabelForTime("MiddleCenter",
                        "<color='#00FF00'>HUMANS WIN!</color>" + String.Newline + "(All Titans eliminated)", 
                        5
                    );
                    Game.End(10);
                } else {
                    # Show remaining AI count
                    UI.SetLabelAll("TopRight", "<color='#FF0000'>AIs left to win: </color>" + Game.AITitans.Count);
                }
            } else {
                # Normal mode - original behavior with revives
                if (Game.AITitans.Count < 5) {
                    self._HumanScore += 1;
                    # self.reviveAllHumans();
                    # self.reviveAllPTs();
                    Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
                    UI.SetLabelForTime("MiddleCenter", 
                        "<color='#FFFF00'>AUTO-RESTARTING...</color>", 
                        3
                    );
                    
                    Game.End(5);
                } elif (Network.IsMasterClient) {
                    self._HumanScore += 1;
                    self.reviveAllHumans();
                    self.reviveAllPTs();
                    Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
                    
                }
            }
        }

        self.updateTeamUI();
    }

    # Processes win synchronization messages between clients
    # Message format: "WinSync:human_wins=X;titan_wins=Y"
    function OnNetworkMessage(sender, message) {
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
            self.updateTeamUI();
        }
    }

    /*===== INTERFACE FEATURES =====*/
    # Updates the team status display
    # Format:
    # » Player vs Titan «
    # H [count] | AI [count] | T [count]
    # Humans: [wins] | Titans: [wins]
    function updateTeamUI() {
        UI.SetLabel("TopCenter",
            "<color='#00ccff'><b>»</b> <color='white'>Player vs Titan</color> <b>«</b></color>"
            + String.Newline
            + "<b><color='#5F8DE7'>H</color></b> " + Game.PlayerHumans.Count
            + " | "
            + "<b><color='#AAAAAA'>AI</color></b> " + Game.AITitans.Count
            + " | "
            + "<b><color='#FFE14C'>T</color></b> " + Game.PlayerTitans.Count
            + String.Newline
            + "<size=20><color='#5F8DE7'>Humans: " + self._HumanScore + "</color>"
            + " | "
            + "<color='#FFE14C'>Titans: " + self._TitanScore + "</color></size>"
        );
    }

    # Updates player statistics and scoreboard
    # Parameters:
    # - x: Player reference
    # - iskiller: true=scoring kill | false=recording death
    # - damage: Damage dealt (for highest/total damage tracking)
    # - restarting: true=skip stat updates during game reset
    function updateScore(x, iskiller, damage, restarting) {
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

    # Formats player names with team prefixes
    # Returns strings like "(H) PlayerName" with team colors
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

    /*===== ADMIN COMMANDS =====*/
    # Handles admin commands and player actions
    # Command format: "#command [args]"
    function OnChatInput(message) {
        if (String.StartsWith(message, "#")) {
            message = String.ToLower(message);
            fullcmd = String.Substring(message, 1);
            listcmd = String.Split(fullcmd, " ");
            cmdword = listcmd.Get(0);
            listcmd.RemoveAt(0);
            
            # Reset personal stats
            if (cmdword == "resetkd") {
                self.resetKD(Network.MyPlayer);
                Game.Print("Your stats have been reset.");
                return true;
            }
            
            # Reset all player stats (admin only)
            if (cmdword == "resetkdall") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: You are not the MasterClient!</color>");
                } else {
                    for (p in Network.Players) {
                        self.resetKD(p);
                    }
                    Game.Print("All players' stats have been reset.");
                }
                return true;
            }
            
            # Revive all player titans (admin only)
            if (cmdword == "reviveallpt") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: You are not the MasterClient!</color>");
                } else {
                    ptcount = 0;
                    for (p in Network.Players) {
                        if (p.CharacterType == "Titan") {
                            ptcount = ptcount + 1;
                            Game.SpawnPlayer(p, false);
                        }
                    }
                    if (ptcount == 0) {
                        Game.Print("There are no player titans in this room.");
                    } else {
                        Game.Print("Revived all PTs.");
                    }
                }
                return true;
            }

            # Revive all player titans (admin only)
            if (cmdword == "reviveallhumans") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: You are not the MasterClient!</color>");
                } else {
                    humanCount = 0;
                    for (p in Network.Players) {
                        if (p.CharacterType == "Human") {
                            humanCount = humanCount + 1;
                            Game.SpawnPlayer(p, false);
                        }
                    }
                    if (humanCount == 0) {
                        Game.Print("There are no humans in this room.");
                    } else {
                        Game.Print("Revived all Humans!");
                    }
                }
                return true;
            }

            # Set human win count (admin only)
            if (cmdword == "sethumanwins") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: Only MasterClient can modify scores!</color>");
                    return true;
                }
                if (listcmd.Count > 0) {
                    newValue = Convert.ToInt(listcmd.Get(0));
                    self._HumanScore = newValue;
                    Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
                    self.updateTeamUI();
                    Game.Print("Set Human wins to: " + self._HumanScore);
                }
                return true;
            }       

            # Set titan win count (admin only)
            if (cmdword == "settitanwins") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: Only MasterClient can modify scores!</color>");
                    return true;
                }
                if (listcmd.Count > 0) {
                    newValue = Convert.ToInt(listcmd.Get(0));
                    self._TitanScore = newValue;
                    Network.SendMessageAll("WinSync:human_wins=" + self._HumanScore + ";titan_wins=" + self._TitanScore);
                    self.updateTeamUI();
                    Game.Print("Set Titan wins to: " + self._TitanScore);
                }
                return true;
            }

            # Toggle strict mode (admin only)
            if (cmdword == "mode") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color='#CC0000'>Error: Only MasterClient can change mode!</color>");
                    return true;
                }
                self.FullClear = !self.FullClear;
                
                # UI feedback for mode change
                if (self.FullClear) {
                    Game.Print("<color='#FFA500'>Mode Changed:</color> <color='#00FF00'>Full AI Clear: ON</color>");
                    UI.SetLabelForTime("TopRight", "<color='#FF0000'>STRICT MODE</color>Kill ALL AIs", 5);
                } else {
                    Game.Print("<color='#FFA500'>Mode Changed:</color> <color='#00FF00'>Full AI Clear: OFF</color>");
                    UI.SetLabelForTime("TopRight", "<color='#00FF00'>NORMAL MODE</color> AIs can survive", 5);
                }
                return true;
            }

            # Tutorial replay command (for any player)
            if (cmdword == "tutorial") {
                Cutscene.Start("PvTQuickStart", true);
                Game.Print("Replaying tutorial...");
                return true;
            }

            if (cmdword == "rules") {
                UI.ShowPopup("RulesPopup");
                return true; # Block the chat message
            }

            # Command for testing sync messages (admin only)
            if (cmdword == "testsync") {
                if (!Network.IsMasterClient) {return true;}
                
                # Create a combined message string
                syncData = "human_wins=5;titan_wins=3";
                Network.SendMessageAll("WinSync:" + syncData);
                
                Game.Print("Sent test sync: " + syncData);
                return true;
            }

            return false;
        }
    }

    # Resets all statistics for a player
    function resetKD(x) {
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

    # Revives all player-controlled titans
    # Usage: Called during game reset or via admin command
    function reviveAllPTs() {
        ptcount = 0;
        for (p in Network.Players) {
            if (p.CharacterType == "Titan") {
                ptcount = ptcount + 1;
                Game.SpawnPlayer(p, false);
            }
        }
        if (ptcount > 0) {
            Game.Print("Revived all Player Titans");
        }
    }

    function reviveAllHumans() {
        humanCount = 0;
        for (h in Network.Players) {
            if (h.CharacterType == "Human") {
                humanCount = humanCount + 1;
                Game.SpawnPlayer(h, false);
            }
        }
        if (humanCount > 0) {
            Game.Print("Revived all Humans");
        }
    }

    /*===== CALCULATION HELPERS =====*/
    # Safe float conversion with null checking
    function f(inp) {
        return Convert.ToFloat(inp);
    }
    
    # Calculates human/titan respawn delay based on:
    # - Team imbalance
    # - Admin overrides
    # - Minimum time constraints
    function getHumanRespawnDelay() {
        # Admin override takes priority
        if (self.human_override != null) {
            return Math.Max(Convert.ToFloat(self.human_override), self.MinRespawnTime);
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

    function getTitanRespawnDelay() {
        # Check for admin override first
        if (self.titan_override != null && Convert.ToSingle(self.titan_override) > 0) {
            return Math.Max(Convert.ToSingle(self.titan_override), self.MinRespawnTime);
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


    # NEW ADDED FEATURE + UNNAMED SECTION
    function createRulesPopup() {
        if (self._rulesPopupCreated) {return;}
        
        # Create popup
        UI.CreatePopup("RulesPopup", "Original Gamemode PvT - GUIDELINES", 900, 700);
        
        # Header 
        UI.AddPopupLabel("RulesPopup", 
            "<color=#AAAAAA>These guidelines help maintain balanced gameplay. " +
            String.Newline +
            "Host may adjust rules to ensure everyone is having fun!</color>" + 
            String.Newline + String.Newline +
            "<size=24><color=#FF5555>WEAPON RESTRICTIONS</color></size>");
        
        # Weapon rules
        UI.AddPopupLabel("RulesPopup", 
            "<color=#FF9999>NO APG/AHSS/TS weapons allowed (OP Against PTs)</color>" + 
            String.Newline + 
            "  <size=16><i>(Will be enabled in future updates)</i></size>");
        
        # Respawn rules
        UI.AddPopupLabel("RulesPopup", 
            String.Newline + "<size=24><color=#55FF55>RESPAWN</color></size>" +
            String.Newline +
            "Base respawn: <color=#FFFF00>60 seconds</color>" +
            String.Newline +
            "Adjusted down to <color=#FFFF00>30s minimum</color> for disadvantaged teams");

        # Titan abilities
        UI.AddPopupLabel("RulesPopup", 
            String.Newline + "<size=24><color=#FFAA00>TITAN ABILITIES</color></size>" +
            String.Newline +
            "<color=#FFCC00>Rock throw limited to 2 PTs max</color>" +
            String.Newline +
            "Throwers chosen randomly each round" +
            String.Newline +
            "<size=16><i>(Host may occasionally allow 3PT)</i></size>");
        
        # Close button 
        UI.AddPopupBottomButton("RulesPopup", "CloseRules", 
            UI.WrapStyleTag("UNDERSTOOD", "color", "#FFFFFF"));
        
        self._rulesPopupCreated = true;
    }

    function OnButtonClick(buttonName) {
        if (buttonName == "CloseRules") {
            UI.HidePopup("RulesPopup");
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