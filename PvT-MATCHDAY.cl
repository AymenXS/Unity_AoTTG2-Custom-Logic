#======================================================================
# PvT MATCHDAY - COMPETITIVE CORE
# Credits to Jibs & Sonic
# Credits to Lavasuna for the BetterWaves CL
#
# Stripped-down version for competitive matches.
# Removed: Kill-to-Revive, Idle/AFK, Slow-motion, Respawn, AHSS Unlock, Final 1v1
#
# Features:
# - Tutorial and rules popup
# - Team system with win conditions and UI counters
# - Velocity-based damage and custom kill feed
# - Rock throw restrictions for PTs
# - Admin commands (reset scores, mode toggle)
# - Network sync (wins, damage credit)
# - Titan jump cooldown
# - Configurable player titan stats
#======================================================================
class Main {    
    /*===== GAME CONFIGURATION =====*/
# Team System
    _EnableTeamSystem = true;

    _ShowTeamScore = true;

    TeamOneName = "Humans";
    TeamTwoName = "Titans";

    _TeamOneScore = 0;           # Total human victories
    _TeamTwoScore = 0;           # Total titan victories

    FullClear = true;          # Victory mode
    FullClearTooltip = "When enabled, humans must eliminate ALL Titans (AIs + PTs) to win.";

# Spawn
    Titans = 15;
    TitansTooltip = "Initial number of AI Titans spawned at match start.";

# Rock Throw System
    _EnableRockThrowSystem = true;

    AuthorizedRockThrower = "1";
    AuthorizedRockThrowerTooltip = "Player IDs separated by hyphens (1-2-3) who can throw rocks as Titans.";

# Titan Jump Cooldown
    _EnableTitanJumpCooldown = true;

    _JumpCoolDown = 3.0;  # Cooldown in seconds

# Titan Stats
    _TitanAttackSpeed = 1;
    _TitanMaxStamina = 3; 
    _TitanStamina = 3; 
    _TitanAttackPause = 0.1;

# System Toggles (no per-setting fields)
    _EnableDamageSystem = true;
    _EnableScoreSystem = true;
    _EnableMovementSystem = true;
    _EnableNetworkSystem = true;

# Permission Messages
    _nopermission = "<color=#CC0000>Error: You do not have permission!</color>";

# Debug
    _DebugMode = false;
    _DebugLogToFile = false;
    _DebugLogFileName = "pvt";
    _DebugLogFlushSeconds = 600; # 10 minutes
    _DebugLogMaxBuffer = 8000;   # chars
    _DebugLogWindowSeconds = 300; # keep last 5 minutes
    _SuperDebugMode = false;
    _SuperDebugLogToFile = false;
    _SuperDebugLogFileName = "pvtsuper";
    _SuperDebugLogFlushSeconds = 300; # 5 minutes
    _SuperDebugLogMaxBuffer = 20000; # chars
    _SuperDebugLogWindowFrames = 600; # keep last ~10s at 60fps
    _SuperDebugConsoleEnabled = false;
    _SuperDebugSampleEveryFrames = 10;
    _DebugStartOnLaunch = false;


 /*===== INITIALIZATION =====*/
    function Init() {
        if (!Main._DebugStartOnLaunch) {
            Main._DebugMode = false;
            Main._DebugLogToFile = false;
            Main._SuperDebugMode = false;
            Main._SuperDebugLogToFile = false;
        }
        # Initialize systems only if they're enabled
        if (Main._EnableScoreSystem) {
            ScoreSystem._HumanScore = RoomData.GetProperty("human_wins", 0);
            ScoreSystem._TitanScore = RoomData.GetProperty("titan_wins", 0);
        }
        
        if (Main._EnableTeamSystem) {
            TeamSystem.FullClear = self.FullClear;
        }
        
        if (Main._EnableRockThrowSystem) {
            RockThrowSystem.Init();
        }

        if (Main._EnableTitanJumpCooldown) {
            TitanJumpCooldown.Init();
        }

        if (Main._DebugLogToFile) {
            Main._DebugLogFileName = "pvt";
            DebugSystem.EnsureFileLoaded();
        }

        # Always configure UI basics
        UI.SetLabel("MiddleCenter", "");
        Game.DefaultShowKillFeed = false;
        Game.DefaultHideKillScore = false;
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
        # Spawn initial AI titans
        Game.SpawnTitansAsync("Default", self.Titans);
    }

    /*===== EVENT HANDLERS =====*/
    function OnFrame() {
        # Per-frame updates for enabled systems
        if (Main._EnableMovementSystem) {MovementSystem.TrackMovement(); DebugSystem.Inc("MovementFrame");}
        if (Main._EnableTitanJumpCooldown) {
            TitanJumpCooldown.OnFrame();
            DebugSystem.Inc("TitanJumpFrame");
        }
        DebugSystem.FrameSnapshot();
    }

    function OnSecond() {
        # Per-second updates for enabled systems
        if (Main._EnableRockThrowSystem) {RockThrowSystem.OnSecond(); DebugSystem.Inc("RockThrowSecond");}

        DebugSystem.ReportAndReset();
    }

    function OnCharacterSpawn(character) {
        # Update UI and apply spawn-related systems
        if (Main._EnableTeamSystem) {TeamSystem.UpdateTeamUI(); DebugSystem.Inc("TeamSpawn");}
        if (Main._EnableRockThrowSystem) {RockThrowSystem.HandleSpawn(character); DebugSystem.Inc("RockThrowSpawn");}
        PlayerTitanStats.OnCharacterSpawn(character);
    }

    function OnCharacterDamaged(victim, killer, killerName, damage) {
        # Damage processing and win checks
        if (Main._EnableDamageSystem) {DamageSystem.HandleDamage(victim, killer, killerName, damage); DebugSystem.Inc("Damage");}
        if (Main._EnableTeamSystem) {
            # Check wins on any death (Human, Player Titan, or AI Titan in Full Clear)
            if (victim != null && victim.Health <= 0) {
                TeamSystem.CheckVictoryConditions();
            }
            TeamSystem.UpdateTeamUI();
            DebugSystem.Inc("TeamDamage");
        }
    }

    function OnCharacterDie(victim, killer, killerName) {
        # Death handling for stats
        if (Main._EnableTeamSystem) {TeamSystem.UpdateTeamUI(); DebugSystem.Inc("TeamDeath");}
    }   

    function OnNetworkMessage(sender, message) {
        # Route network events to system handlers
        if (Main._EnableNetworkSystem) {NetworkSystem.HandleMessage(sender, message); DebugSystem.Inc("NetworkMsg");}
    }

    function OnChatInput(message) {
        # Parse and handle chat commands
        return CommandSystem.HandleCommand(message);
    }

    function OnButtonClick(buttonName) {
        # UI button routing
        UISystem.HandleButtonClick(buttonName);
    }
}

#======================================================================
# EXTENSIONS
#======================================================================

extension DebugSystem {
    _counts = new Dict();
    _logBuffer = "";
    _logSeconds = 0;
    _flushCounter = 0;
    _fileLoaded = false;
    _fileLog = "";
    _fileValid = false;
    _fileNameChecked = false;
    _frameCount = 0;
    _recentLines = List();
    _superLogBuffer = "";
    _superFlushCounter = 0;
    _superFileLoaded = false;
    _superFileValid = false;
    _superFileNameChecked = false;
    _superRecentLines = List();

    function Inc(key) {
        if (!Main._DebugMode) {return;}
        if (self._counts == null) { self._counts = new Dict(); }
        current = self._counts.Get(key, 0);
        self._counts.Set(key, current + 1);
    }

    function Get(key) {
        if (self._counts == null) { return 0; }
        return self._counts.Get(key, 0);
    }

    function ReportAndReset() {
        if (!Main._DebugMode) {return;}

        msg = "[DEBUG]" + String.Newline +
            "  Frame: Mv=" + self.Get("MovementFrame") +
            " Idle=" + self.Get("IdleFrame") +
            " AHSS=" + self.Get("AHSSFrame") +
            " Jmp=" + self.Get("TitanJumpFrame") + String.Newline +
            "  Second: Idle=" + self.Get("IdleSecond") +
            " Resp=" + self.Get("RespawnSecond") +
            " Rock=" + self.Get("RockThrowSecond") +
            " AHSS=" + self.Get("AHSSSecond") +
            " Jmp=" + self.Get("TitanJumpSecond") +
            " Team=" + self.Get("TeamSecond") + String.Newline +
            "  Events: Dmg=" + self.Get("Damage") +
            " Death=" + self.Get("Death") +
            " TeamDmg=" + self.Get("TeamDamage") +
            " TeamDeath=" + self.Get("TeamDeath") +
            " TeamSpawn=" + self.Get("TeamSpawn") +
            " KTRSpawn=" + self.Get("KTRSpawn") +
            " RockSpawn=" + self.Get("RockThrowSpawn") +
            " AHSSKill=" + self.Get("AHSSKill") +
            " Net=" + self.Get("NetworkMsg");

        Game.Debug(msg);

        if (Main._DebugLogToFile) {
            self.AppendLog(msg);
        }

        self._counts = new Dict();
    }

    function FrameSnapshot() {
        if (!Main._SuperDebugMode) {return;}
        self._frameCount += 1;

        if (Main._SuperDebugSampleEveryFrames > 1) {
            if ((self._frameCount % Main._SuperDebugSampleEveryFrames) != 0) {
                return;
            }
        }

        vel = "n/a";
        if (Network.MyPlayer != null && Network.MyPlayer.Character != null) {
            char = Network.MyPlayer.Character;
            if (char.Type == "Human") {
                velValue = MovementSystem.lastMagnitudes.Get("mag-"+char.Player.ID, 0.0);
                vel = String.FormatFloat(velValue, 2);
            }
        }
        msg = "[SDEBUG f" + Convert.ToString(self._frameCount) + "] Vel=" + vel;
        if (Main._SuperDebugConsoleEnabled) {
            Game.Debug(msg);
        }
        if (Main._SuperDebugLogToFile) {
            self.AppendSuperLog(msg);
        }
    }

    function AppendSuperLog(line) {
        self._superFlushCounter += 1;

        entry = line;
        self._superRecentLines.Add(entry);
        if (self._superRecentLines.Count > Main._SuperDebugLogWindowFrames) {
            self._superRecentLines.RemoveAt(0);
        }

        self._superLogBuffer += entry + String.Newline;

        if (String.Length(self._superLogBuffer) >= Main._SuperDebugLogMaxBuffer ||
            self._superFlushCounter >= Main._SuperDebugLogFlushSeconds) {
            self.FlushSuperLog();
        }
    }

    function EnsureSuperFileLoaded() {
        if (self._superFileLoaded) {return;}
        if (!self._superFileNameChecked) {
            ok = PersistentData.IsValidFileName(Main._SuperDebugLogFileName);
            Game.Debug("[DEBUG] Super log file name '" + Main._SuperDebugLogFileName + "' valid=" + Convert.ToString(ok));
            self._superFileNameChecked = true;
        }

        if (!PersistentData.IsValidFileName(Main._SuperDebugLogFileName)) {
            Game.Debug("[DEBUG] Invalid super log file name. Falling back to 'pvtsuper'.");
            Main._SuperDebugLogFileName = "pvtsuper";
            self._superFileLoaded = true;
            self._superFileValid = false;
            return;
        }
        self._superFileValid = true;

        if (PersistentData.FileExists(Main._SuperDebugLogFileName)) {
            PersistentData.LoadFromFile(Main._SuperDebugLogFileName, false);
        }
        self._superFileLoaded = true;
    }

    function FlushSuperLog() {
        if (!Main._SuperDebugLogToFile) {return;}
        if (String.Length(self._superLogBuffer) == 0) {return;}

        self.EnsureSuperFileLoaded();
        if (!self._superFileLoaded || !self._superFileValid) {return;}

        joined = "";
        for (line in self._superRecentLines) {
            joined = joined + line + String.Newline;
        }
        PersistentData.SetProperty("pvt_super_debug_log", joined);
        PersistentData.SaveToFile(Main._SuperDebugLogFileName, false);

        self._superLogBuffer = "";
        self._superFlushCounter = 0;
    }

    function ClearSuperLog() {
        if (!PersistentData.IsValidFileName(Main._SuperDebugLogFileName)) {return;}
        PersistentData.Clear();
        PersistentData.SetProperty("pvt_super_debug_log", "");
        PersistentData.SaveToFile(Main._SuperDebugLogFileName, false);
        self._superLogBuffer = "";
        self._superFlushCounter = 0;
        self._superFileLoaded = false;
        self._superFileValid = false;
        self._superRecentLines = List();
    }

    function AppendLog(line) {
        self._logSeconds += 1;
        self._flushCounter += 1;

        entry = Convert.ToString(self._logSeconds) + "s | " + line;
        self._recentLines.Add(entry);
        if (self._recentLines.Count > Main._DebugLogWindowSeconds) {
            self._recentLines.RemoveAt(0);
        }

        self._logBuffer += entry + String.Newline;

        if (String.Length(self._logBuffer) >= Main._DebugLogMaxBuffer ||
            self._flushCounter >= Main._DebugLogFlushSeconds) {
            self.FlushLog();
        }
    }

    function EnsureFileLoaded() {
        if (self._fileLoaded) {return;}
        if (!self._fileNameChecked) {
            ok = PersistentData.IsValidFileName(Main._DebugLogFileName);
            Game.Debug("[DEBUG] Log file name '" + Main._DebugLogFileName + "' valid=" + Convert.ToString(ok));
            self._fileNameChecked = true;
        }

        if (!PersistentData.IsValidFileName(Main._DebugLogFileName)) {
            Game.Debug("[DEBUG] Invalid log file name. Falling back to 'pvt'.");
            Main._DebugLogFileName = "pvt";
            self._fileLoaded = true;
            self._fileValid = false;
            return;
        }
        self._fileValid = true;

        if (PersistentData.FileExists(Main._DebugLogFileName)) {
            PersistentData.LoadFromFile(Main._DebugLogFileName, false);
            self._fileLog = PersistentData.GetProperty("pvt_beta_debug_log", "");
        } else {
            self._fileLog = "";
        }
        self._fileLoaded = true;
    }

    function FlushLog() {
        if (!Main._DebugLogToFile) {return;}
        if (String.Length(self._logBuffer) == 0) {return;}

        self.EnsureFileLoaded();
        if (!self._fileLoaded || !self._fileValid) {return;}

        # Overwrite file with only the last window of lines
        joined = "";
        for (line in self._recentLines) {
            joined = joined + line + String.Newline;
        }
        PersistentData.SetProperty("pvt_beta_debug_log", joined);
        PersistentData.SaveToFile(Main._DebugLogFileName, false);

        self._logBuffer = "";
        self._flushCounter = 0;
    }

    function ClearLog() {
        if (!PersistentData.IsValidFileName(Main._DebugLogFileName)) {return;}
        PersistentData.Clear();
        PersistentData.SetProperty("pvt_beta_debug_log", "");
        PersistentData.SaveToFile(Main._DebugLogFileName, false);
        self._fileLog = "";
        self._logBuffer = "";
        self._flushCounter = 0;
        self._fileLoaded = false;
        self._fileValid = false;
        self._recentLines = List();
    }
}

extension MovementSystem {
    lastMagnitudes = new Dict();

    function TrackMovement() {
        if (!Main._EnableMovementSystem) {return;}

        # Track only local human's last known movement magnitude
        localChar = Network.MyPlayer.Character;
        if (localChar != null && localChar.Type == "Human") {
            mag = localChar.Velocity.Magnitude;
            if (mag > 1) {
                self.lastMagnitudes.Set("mag-"+localChar.Player.ID, mag);
            }
        }
    }
}

extension DamageSystem {
    function HandleDamage(victim, killer, killerName, damage) {
        if (!Main._EnableDamageSystem) {return;}
        
        # Basic validation
        if (victim == null || victim.Health > 0 || victim.Player == null) {
            return;
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
        if (killer == null && String.EndsWith(killerName, "'s Rock")) {
            self.HandleRockKill(victim, killer, killerName, damage);
        }
    }

    function HandleHumanKiller(victim, killer, killerName, damage) {
        # Human kill feed and scoring
        Game.ShowKillFeed(
            TeamSystem.TeamHeader(killer),
            TeamSystem.TeamHeader(victim),
            damage,
            "Blade",
        );
        
        # Update killer's score if local player
        if (killer.Name == Network.MyPlayer.Name) {
            ScoreSystem.UpdateScore(killer.Player, true, damage, false);
        } 
        
        # Update victim's score if local player
        if (victim.Name == Network.MyPlayer.Name) {
            ScoreSystem.UpdateScore(victim.Player, false, 0, false);
        }
    }

    function HandleTitanKiller(victim, killer, killerName, damage) {
        # ---------- VICTIM SIDE ----------
        # Only the victim reliably knows the real velocity-based damage
        if (victim.Name == Network.MyPlayer.Name) {

            # Compute velocity-based titan damage
            titanDamage =
                MovementSystem.lastMagnitudes.Get(
                    "mag-" + victim.Player.ID,
                    5.0
                ) * 10.0 + 1;

            titanDamageInt = Convert.ToInt(titanDamage);

            killerHeader = TeamSystem.TeamHeader(killer);

            anim = String.ToLower(killer.CurrentAnimation);

            # Jump attack → Nom suffix
            if (String.Contains(anim, "attack.jumper")) {
                killerHeader = killerHeader + "'s NOM";
            }

            # Show kill feed with computed damage
            Game.ShowKillFeedAll(
                killerHeader,
                TeamSystem.TeamHeader(victim),
                titanDamageInt,
                "Titan"
            );

            # Victim only gets death
            ScoreSystem.UpdateScore(victim.Player, false, 0, false);

            # Sync real damage to killer
            Network.SendMessageAll(
                "KillCredit|" +
                killer.Name + "|" +
                Convert.ToString(titanDamageInt)
            );
        }
    }

    function HandleRockKill(victim, killer, killerName, damage) {
        # Rock damage is also velocity-based and ONLY correct on victim side
        rockDamage =
            MovementSystem.lastMagnitudes.Get(
                "mag-" + victim.Player.ID,
                5.0
            ) * 10.0 + 1;

        rockDamageInt = Convert.ToInt(rockDamage);

        # ---------- VICTIM SIDE ----------
        if (victim.Name == Network.MyPlayer.Name) {

            Game.ShowKillFeedAll(
                TeamSystem.RockHeader(killerName),
                TeamSystem.TeamHeader(victim),
                rockDamageInt,
                "Titan"
            );

            # Victim only gets death
            ScoreSystem.UpdateScore(victim.Player, false, 0, false);

            # Extract rock owner name (string-only)
            rockOwnerName =
                String.Replace(killerName, "'s Rock", "");

            # 🔴 SYNC REAL DAMAGE TO KILLER
            Network.SendMessageAll(
                "KillCredit|" +
                rockOwnerName + "|" +
                Convert.ToString(rockDamageInt)
            );
        }
    }

    function NamesMatchLoose(a, b) {
        aa = String.ToLower(String.Trim(a));
        bb = String.ToLower(String.Trim(b));
        return (aa == bb || String.Contains(aa, bb) || String.Contains(bb, aa));
    }

    function HandleKillCreditMessage(sender, message) {
        # message format:
        # KillCredit|<ownerName>|<damageInt>
        parts = String.Split(message, "|");
        if (parts.Count < 3) { return; }

        ownerName = parts.Get(1);
        dmgStr = parts.Get(2);
        dmg = Convert.ToInt(dmgStr);

        # Only the owner (local player) should apply credit
        if (self.NamesMatchLoose(Network.MyPlayer.Name, ownerName)) {
            Game.ShowKillScore(dmg);
            ScoreSystem.UpdateScore(Network.MyPlayer, true, dmg, false);
        }
    }
}

extension NetworkSystem {
    function HandleMessage(sender, message) {
        # Route incoming network messages to handlers
        if (!Main._EnableNetworkSystem) {return;}
        
        if (String.StartsWith(message, "WinSync:")) {
            ScoreSystem.HandleWinSync(message);
        }
        elif (String.StartsWith(message, "clearchat")) {
            self.HandleClearChat(sender, message);
        }
        elif (String.StartsWith(message, "KillCredit|")) {
            DamageSystem.HandleKillCreditMessage(sender, message);
        }
    }

    function HandleClearChat(sender, message) {
        # Clear chat log for all players
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
    # _debugPopupCreated removed (debug popup removed)
    _adminRulesPopupCreated = false;

    function HandleButtonClick(buttonName) {
        # Route popup button actions
        if (buttonName == "CloseRules") {
            UI.HidePopup("RulesPopup");
        }
        elif (buttonName == "CloseAdminRules") {
            UI.HidePopup("AdminRulesPopup");
        }
    }

    function CreateRulesPopup() {
        # Build the rules popup UI once
        if (self._rulesPopupCreated) {return;}
        
        # 1. Create popup container (same dimensions)
        UI.CreatePopup("RulesPopup", "Original Gamemode PvT - GUIDELINES", 900, 700);
        
        # 2. Header (original + balance note)
        UI.AddPopupLabel("RulesPopup", 
            "<color=#AAAAAA>These guidelines help maintain balanced gameplay. " +
            String.Newline +
            "Host may adjust rules to ensure everyone is having fun!</color>" + 
            String.Newline + String.Newline +
            "<color=#AAAAAA>This mode is actively tweaking and adapting to game state & META to keep things fun and balanced.</color>" +
            String.Newline + String.Newline +
            "<size=24><color=#FF5555>WEAPON RESTRICTIONS</color></size>");
        
        # 3. Weapon rules (original formatting + AHSS note)
        UI.AddPopupLabel("RulesPopup", 
            "<color=#FF9999>NO APG/TS weapons allowed (OP Against PTs)</color>" + 
            String.Newline + 
            "<size=16><i>may change if balance shifts</i></size>" +
            String.Newline +
            "<size=24><color=#66CCFF>Standard loadouts only.</color></size>");

        # 4. Titan abilities (updated rock throw note)
        UI.AddPopupLabel("RulesPopup", 
            String.Newline + "<size=24><color=#FFAA00>TITAN ABILITIES</color></size>" +
            String.Newline +
            "<color=#FFCC00>Rock throw usually 2 PTs</color>" +
            String.Newline +
            "Host may allow more depending on balance (max usually 4)");

        # 6. Kill-to-revive + Titan stats
        UI.AddPopupLabel("RulesPopup",
            String.Newline + "<size=24><color=#FF55FF>KILL TO REVIVE</color></size>" +
            String.Newline +
            "Humans revive after <color=#FFFF00>" + Convert.ToString(Main.KillsToReviveHuman) + "</color> kills" +
            String.Newline +
            "Titans revive after <color=#FFFF00>" + Convert.ToString(Main.KillsToReviveTitan) + "</color> kills" +
            String.Newline + String.Newline +
            "<size=24><color=#FFCC00>TITAN STATS</color></size>" +
            String.Newline +
            "AtkSpeed " + Convert.ToString(Main._TitanAttackSpeed) +
            " | Stamina " + Convert.ToString(Main._TitanStamina) + "/" + Convert.ToString(Main._TitanMaxStamina) +
            " | Pause " + Convert.ToString(Main._TitanAttackPause) +
            " | JumpCD " + Convert.ToString(Main._JumpCoolDown)
        );

        # 7. Tips / commands (short)
        UI.AddPopupLabel("RulesPopup",
            String.Newline + "<size=24><color=#00CCFF>TIPS</color></size>" +
            String.Newline +
            "Humans: focus one PT at a time" + String.Newline +
            "Titans: push together, don't fight alone" + String.Newline +
            String.Newline +
            "<size=24><color=#00CCFF>COMMANDS</color></size>" + String.Newline +
            "#adminrules | #rules  |  #tutorial"
        );
        
        # 6. Close button (identical implementation)
        UI.AddPopupBottomButton("RulesPopup", "CloseRules", 
            UI.WrapStyleTag("UNDERSTOOD", "color", "#FFFFFF"));
        
        self._rulesPopupCreated = true;
    }


    function ShowRulesPopup() {
        # Lazy-create then show rules popup
        if (!self._rulesPopupCreated) {
            self.CreateRulesPopup();
        }
        UI.ShowPopup("RulesPopup");
    }

    function CreateAdminRulesPopup() {
        if (self._adminRulesPopupCreated) {return;}

        UI.CreatePopup("AdminRulesPopup", "PvT - ADMIN RULES", 900, 800);

        # Admin commands (non-debug)
        UI.AddPopupLabel("AdminRulesPopup",
            "<size=24><color=#FFAA00>ADMIN COMMANDS</color></size>" + String.Newline +
            "• #resetkdall" + String.Newline +
            "• #setwins <human> <titan>" + String.Newline +
            "• #mode (toggle FullClear)" + String.Newline +
            "• #clearchat"
        );

        # Hidden settings (underscore)
        settings = "<size=24><color=#55FF55>HIDDEN SETTINGS</color></size>" + String.Newline +
            "TitanAttackSpeed: " + Convert.ToString(Main._TitanAttackSpeed) + String.Newline +
            "TitanMaxStamina: " + Convert.ToString(Main._TitanMaxStamina) + String.Newline +
            "TitanStamina: " + Convert.ToString(Main._TitanStamina) + String.Newline +
            "TitanAttackPause: " + Convert.ToString(Main._TitanAttackPause) + String.Newline +
            "JumpCoolDown: " + Convert.ToString(Main._JumpCoolDown);

        UI.AddPopupLabel("AdminRulesPopup", String.Newline + settings);

        UI.AddPopupBottomButton("AdminRulesPopup", "CloseAdminRules",
            UI.WrapStyleTag("CLOSE", "color", "#FFFFFF"));

        self._adminRulesPopupCreated = true;
    }

    function ShowAdminRulesPopup() {
        if (!self._adminRulesPopupCreated) {
            self.CreateAdminRulesPopup();
        }
        UI.ShowPopup("AdminRulesPopup");
    }

    
}

extension RockThrowSystem {
    rockthrowers = new List();
    
    function Init() {
        # Cache authorized rock throwers list
        self.rockthrowers = String.Split(Main.AuthorizedRockThrower, "-");
    }
    
    function OnSecond() {
        # Disable rock throw input for unauthorized players
        if (!Main._EnableRockThrowSystem) {return;}

        if (Network.MyPlayer != null && 
            Network.MyPlayer.Character != null && 
            Network.MyPlayer.Character.Type == "Titan" && 
            Network.MyPlayer.Status == "Alive" && 
            !self.rockthrowers.Contains(Convert.ToString(Network.MyPlayer.ID))) {
            
            Input.SetKeyDefaultEnabled("Titan/AttackRockThrow", false);
        }
    }
    
    function HandleSpawn(character) {
        # Add outline to authorized player titans
        if (!Main._EnableRockThrowSystem) {return;}

        if (character.Type == "Titan" && !character.IsAI) {
            playerID = Convert.ToString(character.Player.ID);
            
            # Red outline for rock throwers
            if (self.rockthrowers.Contains(playerID)) {
                character.AddOutline(Color("#FF0000"), "OutlineVisible");
            }
        }
    }
}

extension CommandSystem {
    function HandleCommand(message) {
        if (String.StartsWith(message, "#")) {
            # Parse command and arguments
            message = String.ToLower(message);
            fullcmd = String.Substring(message, 1);
            listcmd = String.Split(fullcmd, " ");
            cmdword = listcmd.Get(0);
            listcmd.RemoveAt(0);

            # ADMIN commands
            # ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

            # Reset all player stats
            if (cmdword == "resetkdall") {
                if (Network.IsMasterClient) {
                    Network.SendMessageAll("resetkdall");
                    Game.Print("All players' stats have been reset.");
                } else {
                    Game.Print(_nopermission);
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
                    Game.Print("<color=#CC0000>Error: Only MasterClient can change mode!</color>");
                    return false;
                }
                Main.FullClear = !Main.FullClear;
                
                # UI feedback for mode change
                if (Main.FullClear) {
                    Game.Print("<color=#FFA500>Mode Changed:</color> <color=#00FF00>Full AI Clear: ON</color>");
                    UI.SetLabelForTime("TopRight", "<color=#FF0000>STRICT MODE</color>Kill ALL AIs", 5);
                } else {
                    Game.Print("<color=#FFA500>Mode Changed:</color> <color=#00FF00>Full AI Clear: OFF</color>");
                    UI.SetLabelForTime("TopRight", "<color=#00FF00>NORMAL MODE</color> AIs can survive", 5);
                }
                return false;
            }

            # Debug: print current position
            if (cmdword == "pos") {
                if (Network.MyPlayer != null && Network.MyPlayer.Character != null) {
                    pos = Network.MyPlayer.Character.Position;
                    Game.Print("POS: " + 
                        Convert.ToString(pos.X) + ", " + 
                        Convert.ToString(pos.Y) + ", " + 
                        Convert.ToString(pos.Z));
                } else {
                    Game.Print("POS: character not available.");
                }
                return false;
            }

            # Debug controls
            if (cmdword == "debugstart") {
                Main._DebugMode = true;
                Main._DebugLogToFile = true;
                Main._DebugLogFileName = "pvt";
                Game.Print("Debug logging enabled.");
                return false;
            }
            if (cmdword == "debugstop") {
                Main._DebugMode = false;
                Main._DebugLogToFile = false;
                Main._SuperDebugMode = false;
                Main._SuperDebugLogToFile = false;
                Game.Print("Debug logging disabled.");
                return false;
            }
            if (cmdword == "superdebugstart") {
                Main._SuperDebugMode = true;
                Main._SuperDebugLogToFile = true;
                Game.Print("Super debug enabled (frame-by-frame).");
                return false;
            }
            if (cmdword == "superdebugstop") {
                Main._SuperDebugMode = false;
                Main._SuperDebugLogToFile = false;
                Game.Print("Super debug disabled.");
                return false;
            }
            if (cmdword == "superdebugflush") {
                DebugSystem.FlushSuperLog();
                Game.Print("Super debug log flushed to file.");
                return false;
            }
            if (cmdword == "superdebugclear") {
                DebugSystem.ClearSuperLog();
                Game.Print("Super debug log cleared.");
                return false;
            }
            if (cmdword == "debugflush") {
                DebugSystem.FlushLog();
                Game.Print("Debug log flushed to file.");
                return false;
            }
            if (cmdword == "debugclear") {
                DebugSystem.ClearLog();
                Game.Print("Debug log cleared.");
                return false;
            }
            if (cmdword == "debugfiletest") {
                names = List();
                names.Add("pvtbetadebug");
                names.Add("pvt_beta_debug");
                names.Add("pvt-beta-debug");
                names.Add("pvt");
                names.Add("debug");
                names.Add("pvt1");
                for (n in names) {
                    ok = PersistentData.IsValidFileName(n);
                    Game.Print("FILETEST " + n + " => " + Convert.ToString(ok));
                }
                return false;
            }

            # Clear chat  
            if (cmdword == "clearchat") {
                if (Network.IsMasterClient) {
                    Network.SendMessageAll("clearchat");
                    Game.Print("Cleared chat for all players.");
                } else {
                    Game.Print(Main._nopermission);
                }
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
            # ADMIN commands

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
            if (cmdword == "adminrules") {
                if (!Network.IsMasterClient) {
                    Game.Print(Main._nopermission);
                    return false;
                }
                UISystem.ShowAdminRulesPopup();
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

}

extension ScoreSystem {
    _HumanScore = 0;
    _TitanScore = 0;
    
    function UpdateScore(x, iskiller, damage, restarting) {
        # Update kills/deaths and damage stats
        if (!Main._EnableScoreSystem) {return;}
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
        # Reset player stats and clear persisted values
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
        # Sync win counts from network message
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
}

extension TeamSystem {
    function UpdateTeamUI() {
        # Update top-center team UI labels
        if (!Main._EnableTeamSystem) {return;}
        TeamScore = "";
        if (Main._ShowTeamScore) {
            TeamScore = String.Newline + "<size=20><color='#fe0000'>" + Main.TeamOneName + ": " + ScoreSystem._HumanScore + "</color> | " + "<color='#FFE14C'>" + Main.TeamTwoName + ": " + ScoreSystem._TitanScore + "</color></size>";
        }

        UI.SetLabel("TopCenter",
            "<color='#00ccff'><b>»</b> <color='white'>Player vs Titan</color> <b>«</b></color>"
            + String.Newline
            + "<b><color='#fe0000'>H</color></b> " + Game.PlayerHumans.Count
            + " | <b><color='#AAAAAA'>AI</color></b> " + Game.AITitans.Count
            + " | <b><color='#FFE14C'>T</color></b> " + Game.PlayerTitans.Count
            + TeamScore
        );
    }
    
    function TeamHeader(player) {
        # Build colored header for kill feed
        prefix = "";
        aiColour = "#AAAAAA";
        tColour = "#FFE14C";
        hColour = "#f06262";
        
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

    function TeamHeaderText(tag, colour, text) {
        # Format team header with tag and color
        return "<b><color='" + colour + "'>(" + tag + ")</color></b> " + text;
    }

    function RockHeader(killerName) {
        # Header for rock kills
        return self.TeamHeaderText("R", "#AAAAAA", killerName);
    }

    function CheckVictoryConditions() {
        # Check and process win conditions
        if (!Main._EnableTeamSystem) {return;}

        # Case 1: All humans dead - Titans win
        if (Game.PlayerHumans.Count == 0) {
            # Titans win condition
            ScoreSystem._TitanScore += 1;
            Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
            RoomData.SetProperty("human_wins", ScoreSystem._HumanScore);
            RoomData.SetProperty("titan_wins", ScoreSystem._TitanScore);
            UI.SetLabelForTime("MiddleCenter",
                "<color='#FFE14C'>TITANS WIN!</color>" + String.Newline + "(All Humans eliminated)", 
                5
            );
            
            Game.End(10);
        # Case 2: All player titans dead - check AI conditions
        } elif (Game.PlayerTitans.Count == 0) {
            # Full Clear mode requires eliminating all AI titans
            if (Main.FullClear) {
                if (Game.AITitans.Count == 0) {
                    ScoreSystem._HumanScore += 1;
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                    RoomData.SetProperty("human_wins", ScoreSystem._HumanScore);
                    RoomData.SetProperty("titan_wins", ScoreSystem._TitanScore);
                    UI.SetLabelAll("TopRight", "");
                    UI.SetLabelForTime("MiddleCenter",
                        "<color='#00FF00'>HUMANS WIN!</color>" + String.Newline + "(All Titans eliminated)",
                        5
                    );

                    Game.End(10);
                } else {
                    UI.SetLabelAll("TopRight", "<color='#FF0000'>AIs left to win: </color>" + Game.AITitans.Count);
                }
            } else {
                if (Game.AITitans.Count < 5) {
                    ScoreSystem._HumanScore += 1;
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                    RoomData.SetProperty("human_wins", ScoreSystem._HumanScore);
                    RoomData.SetProperty("titan_wins", ScoreSystem._TitanScore);
                    UI.SetLabelForTime("MiddleCenter",
                        "<color='#FFFF00'>AUTO-RESTARTING...</color>",
                        3
                    );

                    Game.End(5);
                }
            }
        }
    }
}

extension TitanJumpCooldown {
    _jumpKeyEnabled = true;
    _action = List();

    function Init() {
        # Initialize jump cooldown state
        self._jumpKeyEnabled = true;
        self._action = List();
    }

    function OnFrame() {
        # Monitor jump animations and disable input
        if (!Main._EnableTitanJumpCooldown) { return; }

        character = Network.MyPlayer.Character;
        if (character != null && character.Type == "Titan") {
            # Detect jump animation start
            if (self._jumpKeyEnabled &&
                character.CurrentAnimation == "Amarture_VER2|attack.jumper.0") {
                self._action.Add(character.CurrentAnimation);
                self._jumpKeyEnabled = false;
                self.DelayJump(Main._JumpCoolDown);
            }

            # Handle post-jump actions
            if (!self._jumpKeyEnabled && self._action.Count != 0) {
                if (!self._action.Contains(character.CurrentAnimation) &&
                    character.CurrentAnimation == "Amarture_VER2|attack.jumper.1") {
                    self._action.Add(character.CurrentAnimation);
                    Input.SetKeyDefaultEnabled("Titan/Jump", false);
                } elif (!self._action.Contains(character.CurrentAnimation) &&
                       character.CurrentAnimation != "Amarture_VER2|attack.jumper.1") {
                    Input.SetKeyDefaultEnabled("Titan/Jump", false);
                }
            }
        }
    }

    coroutine DelayJump(seconds) {
        # Wait and then re-enable jump input
        wait seconds;

        # Reset jump state
        Input.SetKeyDefaultEnabled("Titan/Jump", true);
        self._action.Clear();
        self._jumpKeyEnabled = true;
    }
}

extension PlayerTitanStats {
    function ApplyStats(character) {
        # Apply configurable titan stats
        self.TitanStamina = Main._TitanStamina;
        self.TitanMaxStamina = Main._TitanMaxStamina;
        self.TitanAttackPause = Main._TitanAttackPause;
        self.TitanAttackSpeed = Main._TitanAttackSpeed;

        if (character != null &&
            character.Type == "Titan" &&
            character.IsMine &&
            !character.IsAI)
        {
            character.Stamina = self.TitanStamina;
            character.MaxStamina = self.TitanMaxStamina;
            character.AttackPause = self.TitanAttackPause;
            character.AttackSpeedMultiplier = self.TitanAttackSpeed;

        }
    }

    function OnCharacterSpawn(character) {
        # Apply stats on spawn
        self.ApplyStats(character);
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
