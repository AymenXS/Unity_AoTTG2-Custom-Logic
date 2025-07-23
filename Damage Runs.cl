class Main {   
    Description = "ASO Damage Run";
    
    Goal = "Damage";
    GoalDropbox = "Damage, Kills";

    function OnGameStart() {
        if (Network.IsMasterClient) {
            Utils.PauseGame();
            Waves.NextWave();
        }
    }

    function OnCharacterSpawn(character) {
        if (character.IsMine && character.Type == "Titan") {
            character.DetectRange = 2000;
        }

        if (character.Type == "Shifter") {
            Run.EndRun();
        }
    }

    function OnPlayerSpawn(player, character) {
        if (character.IsMainCharacter) {
            Run._playerCharacter = character;

            player.ClearKDR(); 
            
            Utils.ResumeGame();
        }
    }

    function OnTick() {
        if (!Network.IsMasterClient || Game.IsEnding || Run._isFinished) {
            return;
        }

        Run.UpdateTimer();
    }

    function OnSecond() {
        Run.UpdateUI();
    }

    function OnCharacterDie(victim, killer, killerName) {
        if (victim.Type == "Human" && Game.Humans.Count == 0 && !Run._isFinished) {
            Run.EndRun();
        }

        if (victim.Type == "Titan") {
            Run.UpdateUI();
            Waves.CheckForNewWave();
        }
    }

    function OnCharacterDamaged(victim, killer, killerName, damage) {
        if (victim.Type == "Titan") {
            Splits.Update(damage);
        }
    }

    function OnButtonClick(button) {
        if (button == "Restart") {
            Game.End(0);
        }

        if (button == "Back") {
            Utils.ResumeGame();
        }
    }
}

extension Run {
    _runLength = 600.0;
    _runTime = 0.0;
    _isFinished = false;
    _playerCharacter = null;
    _pace = 0;

    function UpdateTimer() {
        self._runTime = Time.GameTime;

        if (self._runTime > self._runLength) {
            self.EndRun();
        }
    }

    function EndRun() {
        self._isFinished = true;
        Utils.PauseGame();

        self.UpdateRunStatus();

        kills = self._playerCharacter.Player.Kills;  
        damage = self._playerCharacter.Player.TotalDamage;
        highestDamage = self._playerCharacter.Player.HighestDamage;
        CustomUI.ShowEndScreen(self._playerCharacter.Name, kills, damage, highestDamage);
    }

    function UpdateUI() {
        if (self._playerCharacter == null) {
            return;
        }

        titans = Game.Titans.Count;
        wave = Waves._currentWave;
        time = self._runTime;

        CustomUI.ShowTopLabel(titans, wave, time);

        if (Main.Goal == "Kills") {
            kills = self._playerCharacter.Player.Kills;  
            self._pace = Utils.CalculatePace(kills);
        } else {
            damage = self._playerCharacter.Player.TotalDamage;
            self._pace = Utils.CalculatePace(damage);
        }

        CustomUI.ShowSplitsLabel(self._pace);
    }
}

extension Splits {
    _splits = List();
    _currentSplit = 0;

    function Update(damage) {
        if (Run._runTime / 100 >= self._splits.Count) {
            self._splits.Add(0);
        }

        lastIndex = self._splits.Count - 1;

        if (Main.Goal == "Kills") {
            self._currentSplit = self._splits.Get(lastIndex) + 1;
        } else {
            self._currentSplit = self._splits.Get(lastIndex) + damage;
        }

        self._splits.Set(lastIndex, self._currentSplit);
    }
}

extension Waves {
    _currentWave = 0;
    _startTitans = 3;
    _addTitansPerWave = 1;
    _sizeMin = 2.5;
    _sizeMax = 3.0;

    function NextWave() {
        self._currentWave = self._currentWave + 1;

        titansAmount = self._addTitansPerWave * (self._currentWave - 1) + self._startTitans;

        titans = Game.SpawnTitans("Normal", titansAmount);

        for (titan in titans) {
            randomSize = Random.RandomFloat(self._sizeMin, self._sizeMax);
            titan.Size = randomSize;
        }
    }

    function CheckForNewWave() {
        titans = Game.Titans.Count;

        if (titans == 0) {
            self.NextWave();
        }
    }
}

extension CustomUI {
    function ShowTopLabel(titans, wave, time) {
        UI.SetLabelAll("TopCenter", 
            "Titans Left: " + Convert.ToString(titans) 
            + " Wave: " + Convert.ToString(wave) 
            + String.Newline + String.FormatFloat(time, 0) + " / " + Convert.ToString(Run._runLength) + " Seconds");
    }

    function ShowSplitsLabel(pace) {
        splitsLabelText = "<size=25>Splits:</size>" + String.Newline;

        sum = 0;
        for (i in Range(0, Splits._splits.Count, 1)) {
            split = Splits._splits.Get(i);
            sum += split;

            splitsLabelText = splitsLabelText + 
                Convert.ToString((i + 1) * 100) + "s | " +
                Convert.ToString(split) + " | " +
                Convert.ToString(sum) + String.Newline;
        }

        splitsLabelText = splitsLabelText + String.Newline + "<size=23>Pace: " + String.FormatFloat(pace, 0) +  "</size>";

        UI.SetLabelAll("TopLeft", splitsLabelText);
    }

    function ShowEndScreen(playerName, kills, totalDamage, highestDamage) {
        score = null;

        if (Main.Goal == "Damage") {
            score = totalDamage;
        } else {
            score = kills;
        }
        
        UI.CreatePopup("Finished", "Run Finished", 500, 500);
        UI.AddPopupLabel("Finished", "<b>" + playerName + " - " + score + "</b>");
        UI.AddPopupLabel("Finished", "Kills: " + Convert.ToString(kills));
        UI.AddPopupLabel("Finished", "Total Damage: " + Convert.ToString(totalDamage));
        UI.AddPopupLabel("Finished", "Highest Damage: " + Convert.ToString(highestDamage));

        if (kills > 0) {
            damageAverage = totalDamage / kills;
            UI.AddPopupLabel("Finished", "Damage Average: " + Convert.ToString(damageAverage));
        }
        
        UI.AddPopupBottomButton("Finished", "Restart", "Restart");
        UI.ShowPopup("Finished");
    }
}

extension Utils {
    function PauseGame() {
        Time.TimeScale = 0.0;
    }

    function ResumeGame() {
        Time.TimeScale = 1.0;
    }

    function CalculatePace(value) {
        return (value / Run._runTime) * Run._runLength; 
    }
}
