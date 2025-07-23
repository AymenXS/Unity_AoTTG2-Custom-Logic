class Main
{   
    Description = "Spawn a titan at the position you want. Type 'pos' to get your current position.";
    SpawnPositionX = 0;
    SpawnPositionY = 0;
    SpawnPositionZ = 0;
    TitanType = "Normal";
    TitanTypeDropbox = "Normal, Abnormal, Jumper, Crawler";
    _currentWave = 0;
    _hasSpawned = false;
    _MyCharacter = null;

    function OnGameStart()
    {
        if (Network.IsMasterClient)
        {
            self.NextWave();
            UI.SetLabelAll("TopRight", "Titan size = " + Convert.ToString(Game.GetTitanSetting("TitanSizeMin")) + " - " + Convert.ToString(Game.GetTitanSetting("TitanSizeMax")));
        }
    }

    function OnCharacterSpawn(character)
    {
        if (character.IsMine && character.Type == "Titan")
        {
            character.DetectRange = 2000;
        }
        if (character.IsMainCharacter && character.Type == "Human")
        {
            self._MyCharacter = Network.MyPlayer.Character;
        }

    }

    function OnTick()
    {
        if (Network.IsMasterClient && !Game.IsEnding)
        {
            titans = Game.Titans.Count;
            humans = Game.Humans.Count;
    playerShifters = Game.PlayerShifters.Count;
            if (humans > 0 || playerShifters > 0)
            {
                self._hasSpawned = true;
            }
            if (titans == 0)
            {
                self.NextWave();
            }
            if (humans == 0 && playerShifters == 0 && self._hasSpawned)
            {
                UI.SetLabelAll("MiddleCenter", "Humanity failed!");
                Game.End(10.0);
                return;
            }
            UI.SetLabelAll("TopCenter", "Titans Left: " + Convert.ToString(titans) + "  " + "Wave: " + Convert.ToString(self._currentWave));
        }
    }

    function NextWave()
    {
        self._currentWave = self._currentWave + 1;
        if (self._currentWave > 20)
        {
            UI.SetLabelAll("MiddleCenter", "All waves cleared, humanity wins!");
            Game.End(10.0);
            return;
        }
        if (self._currentWave != 1)
        {
            amount = 1 * (self._currentWave - 1) + 1;
            Game.SpawnTitans(self.TitanType, amount);
        }
        else
        {
            SpawnPosition = Vector3(self.SpawnPositionX, self.SpawnPositionY, self.SpawnPositionZ);
            Game.SpawnTitanAt(self.TitanType, SpawnPosition);
        }
        
    }

    function OnChatInput(message)
{        
    if (message == "pos")
    {
        Game.Print("<size=20><color=#ff0000>X: " + Convert.ToString(Math.Round(self._MyCharacter.Position.X)) + "   </color><color=#00FF00>Y: " + Convert.ToString(Math.Round(self._MyCharacter.Position.Y)) + "   </color><color=#0000FF>Z: " + Convert.ToString(Math.Round(self._MyCharacter.Position.Z)) + "</color></size>");
    }
}
}