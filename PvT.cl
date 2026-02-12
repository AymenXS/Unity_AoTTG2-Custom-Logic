#======================================================================
# PvT GAME MODE CORE SCRIPT
# Credits to Jibs & Sonic
# Credits to Lavasuna for the BetterWaves CL
#
# Features:
# - Tutorial and rules popup
# - Team system with win conditions and UI counters
# - Dynamic respawn timers and scaling
# - Velocity-based damage and custom kill feed
# - Kill-to-revive for humans and titans
# - Rock throw restrictions for PTs
# - Idle/AFK auto-kill and respawn
# - Admin commands (revive, reset, scores)
# - Network sync (wins, revive-all, damage credit)
# - Titan jump cooldown
# - Configurable player titan stats
# - Slow-motion match ending
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

# Spawn / Respawn System
    _EnableRespawnSystem = true;

    Titans = 15;              
    TitansTooltip = "Initial number of AI Titans spawned at match start.";

    _BaseRespawnTime = 60.0;     # Default respawn delay
    BaseRespawnTimeTooltip = "Default respawn delay in seconds.";

    _MinRespawnTime = 30.0;
    MinRespawnTimeTooltip = "Minimum possible respawn delay (cannot go below this).";

    respawn_timer_keys = new List(); # Active timers

    _RespawnHumanScale = 1.0;
    _RespawnHumanScaleTooltip = "How much human respawn time reduces per missing teammate.";

    _RespawnTitanScale = 4.0; 
    _RespawnTitanScaleTooltip = "How much titan respawn time reduces per missing teammate.";

    ManualHumanTimer = 0;          # Manual human respawn time
    ManualHumanTimerTooltip = "Override human dynamic respawn time in seconds.";

    ManualTitanTimer = 0;          # Manual titan respawn time
    ManualTitanTimerTooltip = "Override human dynamic respawn time in seconds.";
    
    _ReviveAllDelay = 5.0;
    _ReviveAllDelayTooltip = "Delay in seconds before ReviveAll commands respawn players.";

# Idle System
    _EnableIdleSystem = true;

    _IdleKillTime = 60;
    _IdleKillTimeTooltip = "Time in seconds before a player is considered Idle and is killed.";

    _IdleRespawn = true;
    _IdleRespawnTooltip = "Allow Idle users to respawn immediately by pressing W.";

# Rock Throw System
    _EnableRockThrowSystem = true;

    AuthorizedRockThrower = "1";
    AuthorizedRockThrowerTooltip = "Player IDs separated by hyphens (1-2-3) who can throw rocks as Titans.";

    # Kill To Revive System
    EnableKillToReviveSystem = true;

    KillsToReviveHuman = 10;
    KillsToReviveTitan = 4;

    # 1v1 Lock (no respawns when last Human vs last PT)
    NoRespawnAfter1v1 = true;
    NoRespawnAfter1v1Tooltip = "Locks normal respawn and kill-to-revive when only 1 Human and 1 PT remain.";
    Final1v1HumanPos = Vector3(176.4036, 78.80701, 356.9931);
    Final1v1TitanPos = Vector3(-113.188, 82.42618, 348.2049);
    _Final1v1TimeScale = 0.2;
    _Final1v1TimeScaleTooltip = "Time scale during final 1v1 countdowns (lower = slower).";

# Titan Jump Cooldown
    _EnableTitanJumpCooldown = true;

    _JumpCoolDown = 3.0;  # Cooldown in seconds

# Titan Stats
    _TitanAttackSpeed = 1.5;
    _TitanMaxStamina = 20; 
    _TitanStamina = 20; 
    _TitanAttackPause = 0.1;

# System Toggles (no per-setting fields)
    _EnableAhssUnlockSystem = false;
    _EnableDamageSystem = true;
    _EnableScoreSystem = true;
    _EnableMovementSystem = true;
    _EnableNetworkSystem = true;

# Slow Motion Ending
    _SlowMode = true;
    _SlowModeTooltip = "If enabled, this will give a slow-motion ending when the last titan/player is killed.";
    _SlowModeScale = 0.3;
    _SlowModeScaleTooltip = "Time scale used for end-of-round slow motion.";

# UI State
    _rulesPopupCreated = false;
    # _debugPopupCreated removed (debug popup removed)

# Permission Messages
    _nopermission = "<color=#CC0000>Error: You do not have permission!</color>";

# Runtime state
    _NoRespawnLockActive = false;
    _Final1v1Teleported = false;
    _Final1v1SequenceRunning = false;

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
        if (Main._EnableIdleSystem) {
            IdleSystem.AfkKillTime = self._IdleKillTime;
            IdleSystem.IdleRespawn = self._IdleRespawn;
        }
        
        if (Main._EnableRespawnSystem) {
            RespawnSystem.BaseRespawnTime = self._BaseRespawnTime;
            RespawnSystem.MinRespawnTime = self._MinRespawnTime;
            RespawnSystem.RespawnHumanScale = self._RespawnHumanScale;
            RespawnSystem.RespawnTitanScale = self._RespawnTitanScale;
            RespawnSystem.respawn_timers = new Dict();
            RespawnSystem.respawn_timer_keys = new List();
        }
        
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
        
        if (Main._EnableAhssUnlockSystem) {
            AHSSUnlockSystem.Initialize();
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
        if (Main._EnableIdleSystem) {IdleSystem.OnFrame(); DebugSystem.Inc("IdleFrame");}
        if (Main._EnableAhssUnlockSystem) {AHSSUnlockSystem.OnFrame(); DebugSystem.Inc("AHSSFrame");}
        if (Main._EnableTitanJumpCooldown) {
            TitanJumpCooldown.OnFrame();
            DebugSystem.Inc("TitanJumpFrame");
        }
        DebugSystem.FrameSnapshot();
    }

    function OnSecond() {
        # Per-second updates for enabled systems
        if (Main._EnableIdleSystem) {IdleSystem.OnSecond(); DebugSystem.Inc("IdleSecond");}
        if (Main._EnableRespawnSystem) {RespawnSystem.OnSecond(); DebugSystem.Inc("RespawnSecond");}
        if (Main._EnableRockThrowSystem) {RockThrowSystem.OnSecond(); DebugSystem.Inc("RockThrowSecond");}
        if (Main._EnableAhssUnlockSystem) {AHSSUnlockSystem.OnSecond(); DebugSystem.Inc("AHSSSecond");}
        if (Main._EnableTitanJumpCooldown) {
            TitanJumpCooldown.OnSecond();
            DebugSystem.Inc("TitanJumpSecond");
        }
        if (Main._EnableTeamSystem) {TeamSystem.CheckFinal1v1Lock(); DebugSystem.Inc("TeamSecond");}

        DebugSystem.ReportAndReset();

    }

    function OnCharacterSpawn(character) {
        # Update UI and apply spawn-related systems
        if (Main._NoRespawnLockActive && Main.NoRespawnAfter1v1) {
            player = character.Player;
            allow = false;
            for (h in Game.PlayerHumans) {
                if (h != null && h.Player != null && h.Player.ID == player.ID) {
                    allow = true;
                    break;
                }
            }
            if (!allow) {
                for (t in Game.PlayerTitans) {
                    if (t != null && t.Player != null && t.Player.ID == player.ID) {
                        allow = true;
                        break;
                    }
                }
            }
            if (!allow) {
                character.GetKilled("Final1v1");
                Network.SendMessage(player, "Final1v1Lock");
                return;
            }
        }
        if (Main._EnableTeamSystem) {TeamSystem.UpdateTeamUI(); DebugSystem.Inc("TeamSpawn");}
        if (Main._EnableRockThrowSystem) {RockThrowSystem.HandleSpawn(character); DebugSystem.Inc("RockThrowSpawn");}
        if (Main.EnableKillToReviveSystem) {KillToReviveSystem.OnSpawn(); DebugSystem.Inc("KTRSpawn");}
        PlayerTitanStats.OnCharacterSpawn(character);
    }

    function OnCharacterDamaged(victim, killer, killerName, damage) {   
        # Damage processing and win checks
        if (Main._EnableDamageSystem) {DamageSystem.HandleDamage(victim, killer, killerName, damage); DebugSystem.Inc("Damage");}
        if (Main._EnableTeamSystem) {TeamSystem.UpdateTeamUI(); DebugSystem.Inc("TeamDamage");}
    }

    function OnCharacterDie(victim, killer, killerName) {
        # Death handling for revival and stats
        if (Main._EnableAhssUnlockSystem) {AHSSUnlockSystem.ProcessTitanKill(victim, killer, killerName); DebugSystem.Inc("AHSSKill");}
        if (Main._EnableDamageSystem) {DeathSystem.HandleDeath(victim, killer, killerName); DebugSystem.Inc("Death");}
        if (Main._EnableTeamSystem) {
            # Only check win conditions on relevant deaths (Human or Player Titan)
            if (victim.Type == "Human" || (victim.Type == "Titan" && !victim.IsAI)) {
                TeamSystem.CheckVictoryConditions();
            }
            TeamSystem.UpdateTeamUI();
            DebugSystem.Inc("TeamDeath");
        }
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

extension DeathSystem {
    function HandleDeath(victim, killer, killerName) {
        # Process death events for revival and kill tracking
         if (victim.Type == "Titan" && killer != null) {
            value = 1;
            if (killer.Type == "Human") {
                if (killer.Weapon != "Blade") {
                    value = 0.5;
                }
            }
            if (killer.Type == "Human") {
                KillToReviveSystem.ProcessKill("Human", killerName, value);
            }
        }

        if (victim.Type == "Human") {
            if (killer != null && killer.Type == "Titan") {
                KillToReviveSystem.ProcessKill("Titan", killerName, 1);
            } elif (killer == null && String.EndsWith(killerName, "'s Rock")) {
                KillToReviveSystem.ProcessKill("Titan", killerName, 1);
            }
        }
    }
}

extension NetworkSystem {
    function HandleMessage(sender, message) {
        # Route incoming network messages to handlers
        if (!Main._EnableNetworkSystem) {return;}
        
        if (message == "AHSS_LOCKED") {
            AHSSUnlockSystem._ahssUnlocked = true;
        }
        elif (String.StartsWith(message, "AHSS_UNLOCK|")) {
            # Handle AHSS unlock sync
        }
        elif (message == "AHSS_EXHAUSTED") {
            AHSSUnlockSystem.HandleExhausted();
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
        elif (String.StartsWith(message, "ReviveAllRespawn|")) {
            self.HandleReviveAllRespawn(message);
        }
        elif (String.StartsWith(message, "KillCredit|")) {
            DamageSystem.HandleKillCreditMessage(sender, message);
        }
        elif (message == "Final1v1Lock") {
            UI.SetLabelForTime("MiddleCenter",
                "<size=26><color=#FFAA00>Final 1v1 in progress</color></size>" +
                String.Newline +
                "<size=20><color=#FFFFFF>Please wait for the round to end.</color></size>",
                5
            );
        }
    }

    function HandleSlowMo(message) {
        # Toggle slow motion based on message
        if (message == "slowmo_off") {
            Time.TimeScale = 1.0;
            Game.Print("Slow motion disabled");
        } else {
            Time.TimeScale = Main._SlowModeScale;
            Game.Print("Slow motion enabled");
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

    function HandleReviveAllRespawn(message) {
        # Sync revive-all countdowns to all clients
        parts = String.Split(message, "|");
        if (parts.Count < 3) {return;}

        playerID = parts.Get(1);
        delay = Convert.ToFloat(parts.Get(2));

        target = null;
        for (p in Network.Players) {
            if (Convert.ToString(p.ID) == playerID) {
                target = p;
                break;
            }
        }

        if (target != null && target.Status == "Dead") {
            RespawnSystem.QueueRespawnWithDelay(target, delay);
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
            "<size=24><color=#66CCFF>AHSS is optional and can be unlocked.</color></size>");
        
        # 4. Respawn rules (original colors + updates)
        UI.AddPopupLabel("RulesPopup", 
            String.Newline + "<size=24><color=#55FF55>RESPAWN</color></size>" +
            String.Newline +
            "Base respawn: <color=#FFFF00>" + Convert.ToInt(Main._BaseRespawnTime) + " seconds</color>" +
            String.Newline +
            "Adjusted down to <color=#FFFF00>" + Convert.ToInt(Main._MinRespawnTime) + "s minimum</color> for disadvantaged teams" +
            String.Newline +
            "<color=#FFAA00>Final 1v1:</color> All respawns locked");

        # 5. Titan abilities (updated rock throw note)
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
            "• #reviveall" + String.Newline +
            "• #reviveallpt" + String.Newline +
            "• #reviveallhumans" + String.Newline +
            "• #setwins <human> <titan>" + String.Newline +
            "• #mode (toggle FullClear)" + String.Newline +
            "• #slowmo (toggle)" + String.Newline +
            "• #clearchat"
        );

        # Hidden settings (underscore)
        settings = "<size=24><color=#55FF55>HIDDEN SETTINGS</color></size>" + String.Newline +
            "RespawnHumanScale: " + Convert.ToString(Main._RespawnHumanScale) + String.Newline +
            "RespawnTitanScale: " + Convert.ToString(Main._RespawnTitanScale) + String.Newline +
            "ReviveAllDelay: " + Convert.ToString(Main._ReviveAllDelay) + String.Newline +
            "IdleKillTime: " + Convert.ToString(Main._IdleKillTime) + String.Newline +
            "IdleRespawn: " + Convert.ToString(Main._IdleRespawn) + String.Newline +
            "SlowMode: " + Convert.ToString(Main._SlowMode) + String.Newline +
            "TitanAttackSpeed: " + Convert.ToString(Main._TitanAttackSpeed) + String.Newline +
            "TitanMaxStamina: " + Convert.ToString(Main._TitanMaxStamina) + String.Newline +
            "TitanStamina: " + Convert.ToString(Main._TitanStamina) + String.Newline +
            "TitanAttackPause: " + Convert.ToString(Main._TitanAttackPause) + String.Newline +
            "JumpCoolDown: " + Convert.ToString(Main._JumpCoolDown) + String.Newline +
            "BaseRespawnTime: " + Convert.ToString(Main._BaseRespawnTime) + String.Newline +
            "MinRespawnTime: " + Convert.ToString(Main._MinRespawnTime);

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

            if (cmdword == "reviveall") {
                if (Network.IsMasterClient) {
                    Network.SendMessageAll("reviveall");
                    Game.Print("All players have been revived.");
                } else {
                    Game.Print(_nopermission);
                }
                return false;
            }

            # Revive all player titans
            if (cmdword == "reviveallpt") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color=#CC0000>Error: You are not the MasterClient!</color>");
                } else {
                    self.ReviveAllPTs();
                }
                return false;
            }

            # Revive all player titans
            if (cmdword == "reviveallhumans") {
                if (!Network.IsMasterClient) {
                    Game.Print("<color=#CC0000>Error: You are not the MasterClient!</color>");
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

            # Slow motion toggle
            if (cmdword == "slowmo") {
                if (!Network.IsMasterClient) {
                    Game.Print(Main._nopermission);
                    return false;
                }
                if (Time.TimeScale == 1.0) {
                    Time.TimeScale = 0.5;
                    Game.Print("Slow motion enabled");
                    Network.SendMessageAll("slowmo");
                } else {
                    Time.TimeScale = 1.0;
                    Game.Print("Slow motion disabled");
                    Network.SendMessageAll("slowmo_off");
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

    function ReviveAllPTs() {
        # Respawn all player titans
        ptcount = 0;
        for (p in Network.Players) {
            if (p.CharacterType == "Titan") {
                ptcount = ptcount + 1;
                if (p.Status == "Dead") {
                    RespawnSystem.QueueRespawnWithDelay(p, Main._ReviveAllDelay);
                    Network.SendMessageAll("ReviveAllRespawn|" + Convert.ToString(p.ID) + "|" + Convert.ToString(Main._ReviveAllDelay));
                }
            }
        }
        if (ptcount == 0) {
            # Game.Print("There are no player titans in this room.");
        } else {
            # Game.Print("Revived all PTs.");
        }
    }

    function ReviveAllHumans() {
        # Respawn all human players
        humanCount = 0;
        for (h in Network.Players) {
            if (h.CharacterType == "Human") {
                humanCount = humanCount + 1;
                if (h.Status == "Dead") {
                    RespawnSystem.QueueRespawnWithDelay(h, Main._ReviveAllDelay);
                    Network.SendMessageAll("ReviveAllRespawn|" + Convert.ToString(h.ID) + "|" + Convert.ToString(Main._ReviveAllDelay));
                }
            }
        }
        if (humanCount == 0) {
            # Game.Print("There are no humans in this room.");
        } else {
            # Game.Print("Revived all Humans!");
        }
    }
}

extension AHSSUnlockSystem {
    # Configuration - adjust these values as needed
    PointsForAHSS = 15;
    AITitanPointValue = 1;
    PlayerTitanPointValue = 3;
    _ahssConfirmationEnabled = true;
    
    # State tracking
    PlayerData = Dict();
    _ahssUnlocker = null;
    _ahssUnlocked = false;
    _ahssExhausted = false;
    _unlockPending = false;
    _unlockHoldSeconds = 0;
    _equipHoldSeconds = 0;
    _lastAmmoRound = -1;
    _lastAmmoLeft = -1;
    _manualLockHoldSeconds = 0;
    
    # Initialization
    function Initialize()
    {
        self.PlayerData.Clear();
        self._ahssUnlocker = null;
        self._ahssUnlocked = false;
        self._ahssExhausted = false;
        self._unlockPending = false;
        self._unlockHoldSeconds = 0;
        self._equipHoldSeconds = 0;
        self._lastAmmoRound = -1;
        self._lastAmmoLeft = -1;
        self._manualLockHoldSeconds = 0;
    }
    
    # Core functionality
    function ProcessTitanKill(victim, killer, killerName) {
        if (!Main._EnableAhssUnlockSystem) {return false;}
        if (victim == null || killer == null || killer.Type != "Human") {return false;}
        if (self._ahssExhausted) {return false;}
        
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
    function GetPlayerData(playerName) {
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
        if (self._ahssExhausted) {return false;}
        self._ahssUnlocked = true;
        self._ahssUnlocker = playerName;
        
        UI.SetLabelAll("TopRight", "");
        UI.SetLabelAll("TopCenter", "AHSS Unlocked!");
        
        if (self._ahssConfirmationEnabled && character.IsMine)
        {
            self._unlockPending = true;
            self._unlockHoldSeconds = 0;
        }
        else
        {
            self.ActivateAHSS(character);
        }
        
        return true;
    }

    function OnFrame()
    {
        if (!Main._EnableAhssUnlockSystem) {return;}

        if (Network.MyPlayer == null || Network.MyPlayer.Character == null) {return;}
        character = Network.MyPlayer.Character;
        if (character.Type != "Human") {return;}
        if (self._ahssUnlocked && !self.IsLocalUnlocker()) {
            UI.SetLabel("BottomRight", "");
            return;
        }

        if (self._unlockPending) {
            UI.SetLabel("BottomRight", "Hold <color=yellow>'Reload'</color> for 2s to unlock AHSS");
        }

        # Auto-drop AHSS when ammo is exhausted
        if (character.Weapon == "AHSS") {
            # Detect gas-station refill by total ammo increase
            if (self._lastAmmoLeft != -1 &&
                character.CurrentAmmoLeft > self._lastAmmoLeft) {
                self.MarkExhausted();
                return;
            }

            if (character.CurrentAmmoRound <= 0 && character.CurrentAmmoLeft <= 0) {
                self.MarkExhausted();
                return;
            }

            self._lastAmmoRound = character.CurrentAmmoRound;
            self._lastAmmoLeft = character.CurrentAmmoLeft;
        }

        # Prompt and allow switching back to AHSS after unlock
        if (self._ahssUnlocked && !self._ahssExhausted && character.Weapon != "AHSS") {
            UI.SetLabel("BottomRight", "Hold <color=yellow>'Reload'</color> for 2s to equip AHSS");
        } else {
            if (!self._unlockPending) {
                UI.SetLabel("BottomRight", "");
            }
        }
    }

    function OnSecond()
    {
        if (!Main._EnableAhssUnlockSystem) {return;}
        if (Network.MyPlayer == null || Network.MyPlayer.Character == null) {return;}
        character = Network.MyPlayer.Character;
        if (character.Type != "Human") {return;}
        if (self._ahssUnlocked && !self.IsLocalUnlocker()) {return;}

        if (self._unlockPending) {
            if (Input.GetKeyHold("Human/Reload")) {
                self._unlockHoldSeconds += 1;
                if (self._unlockHoldSeconds >= 2) {
                    self._unlockPending = false;
                    self._unlockHoldSeconds = 0;
                    self.ActivateAHSS(character);
                }
            } else {
                self._unlockHoldSeconds = 0;
            }
            return;
        }

        if (self._ahssUnlocked && !self._ahssExhausted && character.Weapon != "AHSS") {
            if (Input.GetKeyHold("Human/Reload")) {
                self._equipHoldSeconds += 1;
                if (self._equipHoldSeconds >= 2) {
                    self._equipHoldSeconds = 0;
                    self.ActivateAHSS(character);
                }
            } else {
                self._equipHoldSeconds = 0;
            }
        } else {
            self._equipHoldSeconds = 0;
        }

        # Manual lock: hold reload 2s while on AHSS to force blades + lock
        if (character.Weapon == "AHSS" && !self._ahssExhausted) {
            if (Input.GetKeyHold("Human/Reload")) {
                self._manualLockHoldSeconds += 1;
                if (self._manualLockHoldSeconds >= 2) {
                    self._manualLockHoldSeconds = 0;
                    self.MarkExhausted();
                }
            } else {
                self._manualLockHoldSeconds = 0;
            }
        } else {
            self._manualLockHoldSeconds = 0;
        }
    }

    function IsLocalUnlocker()
    {
        if (self._ahssUnlocker == null) {return false;}
        return String.ToLower(String.Trim(self._ahssUnlocker)) ==
               String.ToLower(String.Trim(Network.MyPlayer.Name));
    }

    function SwitchToBlades(character)
    {
        if (character.Type != "Human") {return;}
        character.SetWeapon("Blade");
        self._lastAmmoRound = -1;
        self._lastAmmoLeft = -1;
    }

    function MarkExhausted()
    {
        if (self._ahssExhausted) {return;}
        self._ahssExhausted = true;
        if (Network.IsMasterClient) {
            Network.SendMessageAll("AHSS_EXHAUSTED");
        } else {
            Network.SendMessageAll("AHSS_EXHAUSTED");
        }
        character = Network.MyPlayer.Character;
        if (character != null && character.Type == "Human") {
            self.SwitchToBlades(character);
        }
        UI.SetLabelAll("TopRight", "");
        UI.SetLabelAll("BottomRight", "");
    }

    function HandleExhausted()
    {
        self._ahssExhausted = true;
        UI.SetLabelAll("TopRight", "");
        UI.SetLabelAll("BottomRight", "");
    }

    function ActivateAHSS(character)
    {
        if (character.Type != "Human") {return;}
        if (self._ahssExhausted) {return;}
        
        character.SetWeapon("AHSS");
        character.CurrentAmmoRound = 2;
        character.CurrentAmmoLeft = 3;
        character.MaxAmmoRound = 2;
        character.MaxAmmoTotal = 3;
        self._lastAmmoRound = character.CurrentAmmoRound;
        self._lastAmmoLeft = character.CurrentAmmoLeft;
        
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
        # Allow idle players to respawn on input
        if (!Main._EnableIdleSystem) {return;}

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
        # Sync AFK flag to networked properties
        Network.MyPlayer.SetCustomProperty(self.IdleProp, self.IsAfk);
    }

    function OnSecond(){
        # Track idle timer and kill if inactive
        if (!Main._EnableIdleSystem) {return;}

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

extension KillToReviveSystem {
    _humanKillCounter = 0;
    _titanKillCounter = 0;

    function ResetState() {
        # Reset kill counter and clear UI
        self._humanKillCounter = 0;
        self._titanKillCounter = 0;
    }

    function OnSpawn() {
        # Reset on player spawn
        if (!Main.EnableKillToReviveSystem) {return;}
        self.ResetState();
    }

    function GetLocalTeamType()
    {
        if (Network.MyPlayer == null) { return "Human"; }
        if (Network.MyPlayer.CharacterType != null) { return Network.MyPlayer.CharacterType; }
        if (Network.MyPlayer.Character != null) { return Network.MyPlayer.Character.Type; }
        return "Human";
    }

    function ProcessKill(killerTeam, killerName, value)
    {
        # Count kills toward revival and revive when threshold reached
        if (!Main.EnableKillToReviveSystem) {return;}
        if (Main._NoRespawnLockActive) {return;}
        if (Network.MyPlayer.Status != "Dead" || IdleSystem.IsAfk)
        {
            return;
        }

        localTeam = self.GetLocalTeamType();
        if (localTeam != killerTeam) {
            return;
        }

        if (localTeam == "Human") {
            self._humanKillCounter += value;
            current = self._humanKillCounter;
        } else {
            self._titanKillCounter += value;
            current = self._titanKillCounter;
        }

        killsNeeded = Main.KillsToReviveHuman;
        if (localTeam == "Titan") {
            killsNeeded = Main.KillsToReviveTitan;
        }
        if (current >= killsNeeded)
        {
            if (localTeam == "Human") {
                self._humanKillCounter = 0;
            } else {
                self._titanKillCounter = 0;
            }
            Game.SpawnPlayer(Network.MyPlayer, false);

            UI.SetLabelForTime("MiddleCenter", 
                "<size=30><color=#33FF33>You have been revived by " + 
                "<b>" + killerName + "</b></color></size>", 5.0);
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
        # Tick down respawn timers and spawn when ready
        if (!Main._EnableRespawnSystem) {return;}

        # Initialize/reset if needed
        if (self.respawn_timers == null) {
            self.respawn_timers = new Dict();
            self.respawn_timer_keys = new List();
        }

        if (self.respawn_timer_keys == null || self.respawn_timer_keys.Count == 0) {
            self.UpdateRespawnUI(); # Still update UI even if no timers
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
                if (Main._NoRespawnLockActive) {
                    keys_to_remove.Add(key);
                    continue;
                }
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
                }
                keys_to_remove.Add(key);
            }
        }
    
        # Cleanup Timers
        for (key in keys_to_remove) {
            self.respawn_timer_keys.Remove(key);
            self.respawn_timers.Remove(key);
        }
        
        # Update UI for all players
        self.UpdateRespawnUI();
    }

    function GetHumanRespawnDelay() {
        # Calculate human respawn delay (with overrides)
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
        # Calculate titan respawn delay (with overrides)
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
        # Queue a respawn timer for a dead player
        if (!Main._EnableRespawnSystem) {return;}
        if (Main._NoRespawnLockActive) {return;}

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

    function QueueRespawnWithDelay(player, delay) {
        # Queue a respawn timer with a fixed delay (used by admin revive commands)
        if (!Main._EnableRespawnSystem) {return;}
        if (Main._NoRespawnLockActive) {return;}
        if (player == null) {return;}

        teamPrefix = "T-";
        if (player.CharacterType == "Human") {
            teamPrefix = "H-";
        }

        playerIDstr = Convert.ToString(player.ID);
        if (String.Length(playerIDstr) == 0) {
            Game.Print("[ERROR] Invalid player ID");
            return;
        }
        storeKey = teamPrefix + playerIDstr;

        if (delay == null) {return;}
        delayValue = Math.Max(Convert.ToFloat(delay), 0.0);

        self.respawn_timers.Set(storeKey, delayValue);
        if (self.respawn_timer_keys == null) {
            self.respawn_timer_keys = new List();
        }
        if (!self.respawn_timer_keys.Contains(storeKey)) {
            self.respawn_timer_keys.Add(storeKey);
        }
    }

    function UpdateRespawnUI() {
        # Show respawn timer UI for local player
        if (!Main._EnableRespawnSystem) {return;}
        
        # Get local player's status
        localPlayer = Network.MyPlayer;
        if (localPlayer == null || localPlayer.Status != "Dead") {
            UI.SetLabel("BottomCenter", ""); # Clear if not dead
            return;
        }
        
        # Determine team prefix based on character type
        teamPrefix = "T-"; # Default to Titan
        if (localPlayer.CharacterType == "Human") {
            teamPrefix = "H-";
        }
        
        storeKey = teamPrefix + Convert.ToString(localPlayer.ID);
        
        # Safely check if key exists
        if (self.respawn_timers != null && self.respawn_timers.Contains(storeKey)) {
            timeLeft = Convert.ToInt(self.respawn_timers.Get(storeKey));
            
            # Format the display message
            message = "<size=24><color=#FF5555>RESPAWN IN: ";
            message += Convert.ToString(timeLeft) + " SECONDS</color></size>";
            
            UI.SetLabel("BottomCenter", message);
        } else {
            UI.SetLabel("BottomCenter", 
                "<size=24><color=#FFFF00>WAITING TO RESPAWN...</color></size>"
            );
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
    
    # Safe float conversion with null checking
    function f(inp) {
        # Ensure numeric conversion is always valid
        return Convert.ToFloat(inp);
    }
}

extension TeamSystem {
    function CheckFinal1v1Lock() {
        if (!Main.NoRespawnAfter1v1) {return;}

        is1v1 = (Game.PlayerHumans.Count == 1 && Game.PlayerTitans.Count == 1);
        if (is1v1 && !Main._NoRespawnLockActive) {
            Main._NoRespawnLockActive = true;
            Main._Final1v1Teleported = false;
            Main._Final1v1SequenceRunning = true;

            # Clear any pending respawns
            if (RespawnSystem.respawn_timer_keys != null) {
                RespawnSystem.respawn_timer_keys.Clear();
            }
            if (RespawnSystem.respawn_timers != null) {
                RespawnSystem.respawn_timers.Clear();
            }

            self.StartFinal1v1Sequence();
        } elif (!is1v1 && Main._NoRespawnLockActive) {
            Main._NoRespawnLockActive = false;
            Main._Final1v1Teleported = false;
            Main._Final1v1SequenceRunning = false;
        }
    }

    function TeleportFinal1v1Players() {
        if (Main._Final1v1Teleported) {return;}

        # Find the last human and last player titan
        human = null;
        titan = null;
        for (h in Game.PlayerHumans) {
            if (h != null) { human = h; break; }
        }
        for (t in Game.PlayerTitans) {
            if (t != null) { titan = t; break; }
        }

        if (human != null) {
            human.Position = Main.Final1v1HumanPos;
        }
        if (titan != null) {
            titan.Position = Main.Final1v1TitanPos;
        }

        Main._Final1v1Teleported = true;
    }

    coroutine StartFinal1v1Sequence() {
        if (Main._Final1v1SequenceRunning == false) { return; }

        Time.TimeScale = Main._Final1v1TimeScale;

        # Countdown before teleport
        for (i in Range(5, 0, -1)) {
            UI.SetLabelAll("MiddleCenter",
                "<size=32><color=#FFAA00>FINAL 1V1</color></size>" +
                String.Newline +
                "<size=24><color=#FFFFFF>Teleporting in " + Convert.ToString(i) + "</color></size>"
            );
            wait 0.2;
        }

        self.TeleportFinal1v1Players();
        self.RefillFinal1v1Players();

        # Countdown after teleport
        for (i in Range(5, 0, -1)) {
            UI.SetLabelAll("MiddleCenter",
                "<size=32><color=#FFAA00>FINAL 1V1</color></size>" +
                String.Newline +
                "<size=24><color=#FFFFFF>Fight starts in " + Convert.ToString(i) + "</color></size>"
            );
            wait 0.2;
        }

        UI.SetLabelAll("MiddleCenter", "");
        Time.TimeScale = 1.0;
        Main._Final1v1SequenceRunning = false;
    }

    function RefillFinal1v1Players() {
        # Find the last human and last player titan
        human = null;
        titan = null;
        for (h in Game.PlayerHumans) {
            if (h != null) { human = h; break; }
        }
        for (t in Game.PlayerTitans) {
            if (t != null) { titan = t; break; }
        }

        if (human != null) {
            human.RefillImmediate();
            human.SetWeapon("Blade");
        }
        if (titan != null) {
            titan.Stamina = titan.MaxStamina;
        }
    }
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
            UI.SetLabelForTime("MiddleCenter",
                "<color='#FFE14C'>TITANS WIN!</color>" + String.Newline + "(All Humans eliminated)", 
                5
            );
            
            if (Main._SlowMode) {
            Time.TimeScale = Main._SlowModeScale; # slowmo ending
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
                        Time.TimeScale = Main._SlowModeScale;
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
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                    RoomData.SetProperty("human_wins", ScoreSystem._HumanScore);
                    RoomData.SetProperty("titan_wins", ScoreSystem._TitanScore);
                    UI.SetLabelForTime("MiddleCenter", 
                        "<color='#FFFF00'>AUTO-RESTARTING...</color>", 
                        3
                    );
                    
                    if (Main._SlowMode) {
                        Time.TimeScale = Main._SlowModeScale;
                        Game.End(3.33);
                    } else {
                        Game.End(5);
                    }
                } elif (Network.IsMasterClient) {
                    ScoreSystem._HumanScore += 1;
                    CommandSystem.ReviveAllHumans();
                    CommandSystem.ReviveAllPTs();
                    Game.Print("Round Reset!");
                    Network.SendMessageAll("WinSync:human_wins=" + ScoreSystem._HumanScore + ";titan_wins=" + ScoreSystem._TitanScore);
                }
            }
        }
    }
}

extension TitanJumpCooldown {
    _jumpKeyEnabled = true;
    _jumpRoundTime = 0;
    _action = List();
    
    function Init() {
        # Initialize jump cooldown state
        # Initialize jump cooldown from Main config
        self._jumpKeyEnabled = true;
        self._jumpRoundTime = 0;
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
    
    function OnSecond() {
        # Decrease cooldown timer
        if (!Main._EnableTitanJumpCooldown) { return; }
        
        # Update cooldown timer
        if (!self._jumpKeyEnabled && self._jumpRoundTime > 0) {
            self._jumpRoundTime -= 1;
        }
    }
    
    coroutine DelayJump(seconds) {
        # Wait and then re-enable jump input
        self._jumpRoundTime = seconds;
        wait seconds;
        
        # Reset jump state
        Input.SetKeyDefaultEnabled("Titan/Jump", true);
        self._action.Clear();
        self._jumpKeyEnabled = true;
        self._jumpRoundTime = 0;
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
