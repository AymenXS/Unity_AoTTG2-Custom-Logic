cutscene MainCutscene
{
    coroutine Start()
    {
        if (Main.titanophobiac == 0)
        {
        startPosition = Vector3(1017.117, 616.5865, -3500.642);
        startRotation = Vector3(38.69585, 3.754292, -0.00001381067);
        Camera.SetPosition(startPosition);
        Camera.SetRotation(startRotation);
            if (UI.GetLanguage() != "PT-BR")
            {
            Cutscene.ShowDialogue("Levi1", "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>", "Welcome to <color=#000000>Titan</color><color=#8A2BE2>Fall</color>, wait in tent to spawn and protect the supply!
Discord - <color=#6495ED>discord.gg/Y2J8Wgkd6w</color>");
            }
            else
            {
            Cutscene.ShowDialogue("Levi1", "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>", "Bem-vindo(a) <color=#000000>Titan</color><color=#8A2BE2>Fall</color>, espere na tenda e proteja o supply!
Discord - <color=#6495ED>discord.gg/Y2J8Wgkd6w</color>");
            }
        wait 15.0;
        }
        if (Main.titanophobiac == 1)
        {
        startPosition = Vector3(997.5, 664.8, -1020.0);
        startRotation = Vector3(24.9, 317.0, 0.000009418);
        Camera.SetPosition(startPosition);
        Camera.SetRotation(startRotation);
        }
    }
}

cutscene PhobiaCutscene
{
    coroutine Start()
    {
        Network.SendMessageAll("coff|teste");
        if (UI.GetLanguage() != "PT-BR")
        {
        Cutscene.ShowDialogue("Levi1", "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>", "Welcome to <color=#000000>Titan</color><color=#8A2BE2>Fall</color>, we need to discover the eldian boss type! Open the book with F1
Discord - <color=#6495ED>discord.gg/Y2J8Wgkd6w</color>");
        }
        else
        {
        Cutscene.ShowDialogue("Levi1", "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>", "Bem-vindo(a) <color=#000000>Titan</color><color=#8A2BE2>Fall</color>, precisamos descobrir o tipo de boss eldiano! Abra o livro com F1
Discord - <color=#6495ED>discord.gg/Y2J8Wgkd6w</color>");
        }
        startPosition = Vector3(997.5, 664.8, -1020.0);
        startRotation = Vector3(24.9, 317.0, 0.000009418);
        Camera.SetPosition(startPosition);
        Camera.SetRotation(startRotation);
        Main.PhobiaFXStart("ShifterThunder");
        wait 13.0;
        Network.SendMessageAll("con|teste");
    }
}

cutscene PhobiaCutscene2
{
    coroutine Start()
    {
        Network.SendMessageAll("coff|teste");
        if (UI.GetLanguage() != "PT-BR")
        {
        Cutscene.ShowDialogue("Levi1", "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>", "Welcome to <color=#000000>Titan</color><color=#8A2BE2>Fall</color>, we need to discover the eldian boss type! Open the book with F1
Discord - <color=#6495ED>discord.gg/Y2J8Wgkd6w</color>");
        }
        else
        {
        Cutscene.ShowDialogue("Levi1", "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>", "Bem-vindo(a) <color=#000000>Titan</color><color=#8A2BE2>Fall</color>, precisamos descobrir o tipo de boss eldiano! Abra o livro com F1
Discord - <color=#6495ED>discord.gg/Y2J8Wgkd6w</color>");
        }
        startPosition = Vector3(997.5, 664.8, -1020.0);
        startRotation = Vector3(24.9, 317.0, 0.000009418);
        Camera.SetPosition(startPosition);
        Camera.SetRotation(startRotation);
        Main.PhobiaFXStart2("ShifterThunder");
        wait 13.0;
        Network.SendMessageAll("con|teste");
    }
}


cutscene FMUTGCutscene
{
    coroutine Start()
    {
        startPosition = Vector3(997.5, 664.8, -1020.0);
        startRotation = Vector3(24.9, 317.0, 0.000009418);
        Camera.SetPosition(startPosition);
        Camera.SetRotation(startRotation);
        wait 5.0;
    }
}

cutscene CutsceneDialog
{
    coroutine Start()
    {
        Cutscene.ShowDialogue(DialogVariables.Icon, DialogVariables.Name, DialogVariables.Text);
        wait 10.0;
    }
}

extension DialogVariables
{
    Icon = "Levi1";
    Name = "User";
    Text = "Text";
    Time = 10.0;
}

extension Titanophobia
{
    speed = List();
    size = List();
    damage = List();
    hp = List();
    sizeptbr = List();
    damageptbr = List();
    hpptbr = List();
    sizeen = List();
    damageen = List();
    hpen = List();
    appeartime = List();
    actiontime = List();
    appeartimemin = 5.0;
    appeartimemax = 30.0;
    actiontimemin = 5.0;
    actiontimemax = 30.0;
    ingametextptbr = List();
    ingametexten = List();
    selectedsize = 0.0;
    seleteddamage = 0;
    selectedhp = 0;
    selectedsizeptbr = "";
    selecteddamageptbr = "";
    selectedhpptbr = "";
    selectedsizeen = "";
    selecteddamageen = "";
    selectedhpen = "";
    titanotypesmin = 1;
    titanotypesmax = 5;

    function Init()
    {

    self.size.Add(-0.8);
    self.size.Add(-0.5);
    self.size.Add(0.0);
    self.size.Add(1.5);
    self.size.Add(2.5);

    self.damage.Add(-50);
    self.damage.Add(-15);
    self.damage.Add(0);
    self.damage.Add(25);
    self.damage.Add(100);

    self.hp.Add(10);
    self.hp.Add(100);
    self.hp.Add(300);
    self.hp.Add(500);
    self.hp.Add(800);

    self.appeartime.Add(5);
    self.appeartime.Add(10);
    self.appeartime.Add(30);
    self.appeartime.Add(60);
    self.appeartime.Add(120);
    self.appeartime.Add(240);

    self.sizeptbr.Add("Anão");
    self.sizeptbr.Add("Pequeno");
    self.sizeptbr.Add("Mediano");
    self.sizeptbr.Add("Grande");
    self.sizeptbr.Add("Colossal");

    self.damageptbr.Add("Anêmico");
    self.damageptbr.Add("Fraco");
    self.damageptbr.Add("Letal");
    self.damageptbr.Add("Mortífero");
    self.damageptbr.Add("Sanguinário");

    self.hpptbr.Add("Vidro");
    self.hpptbr.Add("Frágil");
    self.hpptbr.Add("Resistente");
    self.hpptbr.Add("Blindado");
    self.hpptbr.Add("Cristalizado");

    self.sizeen.Add("Dwarf");
    self.sizeen.Add("Small");
    self.sizeen.Add("Average");
    self.sizeen.Add("Large");
    self.sizeen.Add("Colossal");

    self.damageen.Add("Anemic");
    self.damageen.Add("Weak");
    self.damageen.Add("Lethal");
    self.damageen.Add("Deadly");
    self.damageen.Add("Bloodthirsty");

    self.hpen.Add("Glass");
    self.hpen.Add("Fragile");
    self.hpen.Add("Resilient");
    self.hpen.Add("Armored");
    self.hpen.Add("Crystallized");

    self.ingametextptbr.Add("Mistura compatível");
    self.ingametextptbr.Add("Reação química válida");
    self.ingametextptbr.Add("Fórmula harmonica resultante");

    self.ingametextptbr.Add("Reagente incompatível");
    self.ingametextptbr.Add("Inconsistência na fórmula");
    self.ingametextptbr.Add("Anomalia química detectada");

    self.ingametextptbr.Add("Experimento neutralizado");
    self.ingametextptbr.Add("Ameaça eliminada");
    self.ingametextptbr.Add("Esterilização concluída");

    self.ingametextptbr.Add("Anomalia semi-neutralizada");
    self.ingametextptbr.Add("Esterilização parcial realizada");
    self.ingametextptbr.Add("Conclusão diferente do esperado");


    self.ingametexten.Add("Compatible mix");
    self.ingametexten.Add("Valid chemical reaction");
    self.ingametexten.Add("Resulting harmonic formula");

    self.ingametexten.Add("Incompatible reagent");
    self.ingametexten.Add("Inconsistency in the formula");
    self.ingametexten.Add("Chemical anomaly detected");

    self.ingametexten.Add("Experiment was neutralized");
    self.ingametexten.Add("Threat eliminated");
    self.ingametexten.Add("Sterilization completed");

    self.ingametexten.Add("Semi-neutralized anomaly");
    self.ingametexten.Add("Partial sterilization performed");
    self.ingametexten.Add("Conclusion different from expected");

    self.selectedsize = self.size.Get(2);
    self.seleteddamage = self.damage.Get(2);
    self.selectedhp = self.hp.Get(2);

    self.appeartimemin = self.appeartime.Get(0);
    self.appeartimemax = self.appeartime.Get(3);

    self.actiontimemin = self.appeartime.Get(0);
    self.actiontimemax = self.appeartime.Get(3);

    self.titanotypesmin = 1;
    self.titanotypesmax = 5;
    }

}

class Main
{
    spawnDistMin = -500.0;
    spawnDistMax = 500.0;
    pointer = Vector3(0.0, 0.0, 0.0);
    pointer2 = Vector3(0.0, 0.0, 0.0);
    spawner = Vector3(0.0, 0.0, 0.0);
    fxspawner = Vector3(0.0, 0.0, 0.0);
    resppoint = Vector3(1017.0, 608.0, -3487.0);
    horda = 0;
    shortwavespawn = 0;
    maxtitans = 5;
    chase = 0;
    hprestore = 1;
    hordatimer = 8;
    hordatime = 8;
    resp = 0;
    resptimer = 10;
    respseconds = 10;
    check = 0;
    cutdialog = true;
    StartTitans = 3;
    AddTitansPerWave = 1;
    MaxWaves = 20;
    RespawnOnWave = true;
    GradualSpawn = true;
    GradualSpawnTooltip = "Spawn new titans gradually over time. Helpful for reducing lag.";
    _currentWave = 0;
    _hasSpawned = false;
    waves = 0;
    speedcollider = 0.0;
    fataldelta = 50.0;
    heal = 0;
    carryguy = null;
    tied = false;
    fatalcollision = 1;
    rvp = 1;
    quicktimes = 0;
    quicktime = 0;
    quickclicks = 0;
    lastspecial = "";
    timerquick = 0;
    fatalplayer = null;
    Settings = null;
    TimeActualScale = 1.0;
    canahss = 0;
    canapg = 0;
    cants = 0;
    titanophobiac = 1;
    acting = 0;
    phobia = 0;
    phobiaactions = 0;
    phobiacode = "";
    phobiahintcode = "";
    phobiatitan = null;
    phobiaminion1 = null;
    phobiaminion2 = null;
    phobiaminion3 = null;
    phobiaminion4 = null;
    phobiaminion5 = null;
    mitosetimer = 0;
    protectiontimer = 0;
    sick = null;
    sickness = 0;
    radiated = null;
    radiation = 0;
    supplyrespawntime = 45;
    restarttimer = 0;
    wrongcombine = 0;
    combinating = 0;
    staycombine = 0;
    difficulty = 1;

    function OnGameStart()
    {
        Cutscene.Start("MainCutscene", true);
        if (Network.IsMasterClient)
        {
            Game.PrintAll("<size=18><color=#000000>TITAN</color><color=#8A2BE2>FALL</color></size> <color=#FFFFFF>discord.gg/Y2J8Wgkd6w</color>");
            if (MissionSupply.Supply == null && self.check == 0)
            {
                self.StartGame2Sec();
                if(self.titanophobiac == 0)
                {
                    self.NextWave();
                }
            }
        }
        self.SetupSettings();
    }

    coroutine PhobiaFXStart2(effect)
    {
        if (effect == "ShifterThunder")
        {
            Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
        }
    }

    coroutine PhobiaFXStart(effect)
    {
        if (effect == "ShifterThunder")
        {
            time = 1.5;
            for (i in Range(0, 25, 1))
            {
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                time = time - 0.1;
                wait time;
            }
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                wait 0.1;
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                wait 0.1;
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
        }       
    }

    coroutine PhobiaFX(effect)
    {
        if (effect == "ShifterThunder")
        {
            time = 2.0;
            for (i in Range(0, 25, 1))
            {
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                time = time - 0.1;
                wait time;
            }
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                wait 0.1;
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                wait 0.1;
                Game.SpawnEffect(effect, Vector3(81.49187,270.9437,-231.8494) , Vector3(0.0,0.0,0.0), 4.0);
                Game.End(0.1);
        }       
    }

    coroutine StrangeAction(strangeacttype, waittimermin, waittimermax)
    {
        time = Random.RandomFloat(waittimermin, waittimermax);
        wait time;
        if (self.acting == 1)
        {
            if (strangeacttype == "Stop")
            {
                acts = 3;
                for (titan in Game.Titans)
                {
                    if (acts >= 1)
                    {
                        titan.Idle(10.0);
                    }
                }
            }
            elif (strangeacttype == "Retard")
            {
                acts = 3;
                for (titan in Game.Titans)
                {
                    if (acts >= 1)
                    {
                        titan.MoveTo(Vector3(), 7.0, true);
                        acts -= 1;
                    }
                }
            }
            elif (strangeacttype == "Mitose")
            {
                self.mitosetimer = 30;
            }
            elif (strangeacttype == "Protection")
            {
                self.protectiontimer = 60;
            }
            elif (strangeacttype == "ShortBoss")
            {
                random = Random.RandomInt(1, 6);
                if (random == 1)
                {
                    titan = Game.SpawnTitan("Normal");
                    titan.MaxHealth = 8000;
                    titan.Health = 8000;
                }
                elif (random == 2)
                {
                    titan = Game.SpawnTitan("Abnormal");
                    titan.MaxHealth = 6000;
                    titan.Health = 6000;
                }
                elif (random == 3)
                {
                    titan = Game.SpawnTitan("Punk");
                    titan.MaxHealth = 5000;
                    titan.Health = 5000;
                }
                elif (random == 4)
                {
                    titan = Game.SpawnTitan("Crawler");
                    titan.MaxHealth = 2500;
                    titan.Health = 2500;
                }
                elif (random == 5)
                {
                    titan = Game.SpawnTitan("Thrower");
                    titan.MaxHealth = 3000;
                    titan.Health = 3000;
                }
            }
            elif (strangeacttype == "Sickness")
            {
                acts = 1;
                for (player in Network.Players)
                {
                    if (acts >= 1 && player.Character != null)
                    {
                        self.sick = player;
                        self.sickness = 20;
                        Network.SendMessage(player, "sickness|teste");
                        acts -= 1;
                    }
                }
            }
            elif (strangeacttype == "Radiation")
            {
                acts = 1;
                for (player in Network.Players)
                {
                    if (acts >= 1 && player.Character != null)
                    {
                        self.radiated = player;
                        if(player != Network.MyPlayer)
                        {
                            Network.SendMessageOthers("radiated|" + player.ID);
                        }
                        player.Character.Reveal(15);
                        self.radiation = 15;
                        acts -= 1;
                    }
                }
            }
            if (self.phobia == 1)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Stop", 60, 240);
                }
                else
                {
                self.StrangeAction("Retard", 60, 120);
                }
            }

            elif (self.phobia == 2)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Retard", 60, 240);
                }
                else
                {
                self.StrangeAction("Mitose", 60, 120);
                }
            }

            elif (self.phobia == 3)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Stop", 60, 120);
                }
                else
                {
                self.StrangeAction("Mitose", 60, 240);
                }
            }

            elif (self.phobia == 4)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Mitose", 60, 120);
                }
                else
                {
                self.StrangeAction("Protection", 60, 240);
                }
            }

            elif (self.phobia == 5)
            {
                self.PhobiaAction(60, 240);
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Retard", 60, 120);
                }
                else
                {
                self.StrangeAction("ShortBoss", 60, 240);
                }
            }

            elif (self.phobia == 6)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Stop", 60, 120);
                }
                else
                {
                self.StrangeAction("ShortBoss", 60, 240);
                }
            }

            elif (self.phobia == 7)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Protection", 60, 120);
                }
                else
                {
                self.StrangeAction("ShortBoss", 60, 240);
                }
            }

            elif (self.phobia == 8)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("ShortBoss", 60, 120);
                }
                else
                {
                self.StrangeAction("Sickness", 60, 240);
                }
            }

            elif (self.phobia == 10)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Radiation", 60, 240);
                }
                else
                {
                self.StrangeAction("Stop", 60, 120);
                }
            }

            elif (self.phobia == 12)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Weak", 60, 240);
                }
                else
                {
                self.StrangeAction("Protection", 60, 120);
                }
            }

            elif (self.phobia == 13)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Radiation", 60, 240);
                }
                else
                {
                self.StrangeAction("Mitose", 60, 120);
                }
            }

            elif (self.phobia == 14)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Weak", 60, 240);
                }
                else
                {
                self.StrangeAction("Sickness", 60, 120);
                }
            }

            elif (self.phobia == 15)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Radiation", 60, 240);
                }
                else
                {
                self.StrangeAction("Sickness", 60, 120);
                }
            }

            elif (self.phobia == 16)
            {
                random = Random.RandomInt(1,3);
                if (random == 1)
                {
                self.StrangeAction("Radiation", 60, 240);
                }
                else
                {
                self.StrangeAction("Weak", 60, 120);
                }
            }
        }
    }

    coroutine ReversePhobia()
    {
        wait 15.0;
        text = "Dangerous Variant";
        Game.PrintAll("<color=#FF0000> ☠</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
        self.DialogTextAll("Ymir2", "Ymir", "<color=#FF0000> ☠</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
        annie = Game.SpawnShifter("Annie");
        Cutscene.Start("FMUTGCutscene", true);
        if (String.StartsWith(self.phobiacode, "0"))
        {
            annie.MaxHealth = 2000;
            annie.Health = 2000;
        }
        if (String.StartsWith(self.phobiacode, "1"))
        {
            annie.MaxHealth = 3000;
            annie.Health = 3000;
        }
        if (String.StartsWith(self.phobiacode, "2"))
        {
            annie.MaxHealth = 4000;
            annie.Health = 4000;
        }
        if (String.StartsWith(self.phobiacode, "3"))
        {
            annie.MaxHealth = 5000;
            annie.Health = 5000;
        }

    }

    coroutine SpawnPhobiaMinion1(waittimermin,waittimermax)
    {
        wait Random.RandomFloat(waittimermin, waittimermax);  
        self.phobiaminion1 = Game.SpawnTitan("Crawler");
        self.phobiaminion1.MaxHealth = 2000;
        self.phobiaminion1.Health = 2000;
    }

    coroutine PhobiaAction(waittimermin, waittimermax)
    {
        timemin = waittimermin;
        timemax = waittimermax;
        timerand = Random.RandomFloat(waittimermin, waittimermax + 1.0);
        wait timerand;

        if(self.acting == 1)
        {

            if (self.phobiaactions == 1)
            {
                if (self.phobia > 0)
                {
                    random = Random.RandomInt(1, 4);
                    if (random == 1)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                        text = "Chemical compound " + self.phobiahintcode;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1;
                        }
                        else
                        {
                        text = "Composto químico " + self.phobiahintcode;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1;
                        }
                    }
                    elif (random == 2)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                        text = Titanophobia.selectedsizeen + "..." + Titanophobia.selectedsizeen + "..." + Titanophobia.selectedsizeen;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1; 
                        }
                        else
                        {
                        text = Titanophobia.selectedsizeptbr + "..." + Titanophobia.selecteddamageptbr + "..." + Titanophobia.selectedhpptbr;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1;
                        }
                    }
                    else
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                        text = "Strange chemical compound";
                        Game.PrintAll("<color=#FF8C00> ♟Ymir 「Strange chemical compound」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else
                        {
                        text = "Composto estranho detectado";
                        Game.PrintAll("<color=#FF8C00> ♟Ymir 「Composto estranho detectado」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        }

                        titan = Game.SpawnTitan("Abnormal");
                        titan.MaxHealth = 2000;
                        titan.Health = 2000;
                    }        
                }
            }

            if (self.phobiaactions == 2)
            {
                if (self.phobia > 0)
                {
                    random = Random.RandomInt(1, 4);
                    if (random == 1)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                        text = "Chemical compound " + self.phobiahintcode;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1;
                        }
                        else
                        {
                        text = "Composto químico " + self.phobiahintcode;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1;
                        }
                    }
                    elif (random == 2)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                        text = Titanophobia.selectedsizeen + "..." + Titanophobia.selectedsizeen + "..." + Titanophobia.selectedsizeen;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1; 
                        }
                        else
                        {
                        text = Titanophobia.selectedsizeptbr + "..." + Titanophobia.selecteddamageptbr + "..." + Titanophobia.selectedhpptbr;
                        Game.PrintAll("<color=#6495ED> ♟Ymir 「" + text + "」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        self.phobiaactions -= 1;
                        }
                    }
                    else
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                        text = "Strange chemical compound";
                        Game.PrintAll("<color=#FF8C00> ♟Ymir 「Strange chemical compound」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else
                        {
                        text = "Composto estranho detectado";
                        Game.PrintAll("<color=#FF8C00> ♟Ymir 「Composto estranho detectado」</color>");
                        self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        titan = Game.SpawnTitan("Abnormal");
                        titan.MaxHealth = 2000;
                        titan.Health = 2000;
                    }        
                }
            }

            if (self.phobia > 0)
            {
                if (self.hordatimer > 10)
                {
                    self.hordatimer = self.hordatimer - 1;
                }
                if (self.maxtitans <= Game.PlayerHumans.Count * self.difficulty)
                {
                    self.maxtitans = self.maxtitans + 1;
                }
                self.PhobiaAction(60, 240);
            }
        }
    }

    coroutine PhobiaStart()
    {

        if (self.phobia == 1)
        {
            self.phobiacode = "00";
            self.phobiahintcode = "...Φ...";
            if (UI.GetLanguage() != "PT-BR")
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 20;
            self.hordatime = 20;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 2;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Stop", 60, 240);
            }
            else
            {
            self.StrangeAction("Retard", 60, 120);
            }
        }

        elif (self.phobia == 2)
        {
            self.phobiacode = "01";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Φ...";
            }
            else
            {
                self.phobiahintcode = "...λ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 15;
            self.hordatime = 15;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 3;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Retard", 60, 240);
            }
            else
            {
            self.StrangeAction("Mitose", 60, 120);
            }
        }

        elif (self.phobia == 3)
        {
            self.phobiacode = "10";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...λ...";
            }
            else
            {
                self.phobiahintcode = "...Φ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 3;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 3;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 15;
            self.hordatime = 15;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 3;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Stop", 60, 120);
            }
            else
            {
            self.StrangeAction("Mitose", 60, 240);
            }
        }

        elif (self.phobia == 4)
        {
            self.phobiacode = "11";
            self.phobiahintcode = "...λ...";
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 10;
            self.hordatime = 10;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 3;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Mitose", 60, 120);
            }
            else
            {
            self.StrangeAction("Protection", 60, 240);
            }
        }

        elif (self.phobia == 5)
        {
            self.phobiacode = "02";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Φ...";
            }
            else
            {
                self.phobiahintcode = "...Ω...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 15;
            self.hordatime = 15;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 3;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Retard", 60, 120);
            }
            else
            {
            self.StrangeAction("ShortBoss", 60, 240);
            }
        }

        elif (self.phobia == 6)
        {
            self.phobiacode = "20";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Ω...";
            }
            else
            {
                self.phobiahintcode = "...Φ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 15;
            self.hordatime = 15;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 4;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Stop", 60, 120);
            }
            else
            {
            self.StrangeAction("ShortBoss", 60, 240);
            }
        }

        elif (self.phobia == 7)
        {
            self.phobiacode = "12";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...λ...";
            }
            else
            {
                self.phobiahintcode = "...Ω...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 10;
            self.hordatime = 10;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 4;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Protection", 60, 120);
            }
            else
            {
            self.StrangeAction("ShortBoss", 60, 240);
            }
        }

        elif (self.phobia == 8)
        {
            self.phobiacode = "21";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Φ...";
            }
            else
            {
                self.phobiahintcode = "...Ω...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 10;
            self.hordatime = 10;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 4;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Mitose", 60, 120);
            }
            else
            {
            self.StrangeAction("Sickness", 60, 240);
            }
        }

        elif (self.phobia == 9)
        {
            self.phobiacode = "22";
            self.phobiahintcode = "...Ω...";
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 10;
            self.hordatime = 10;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 4;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("ShortBoss", 60, 120);
            }
            else
            {
            self.StrangeAction("Sickness", 60, 240);
            }
        }

        elif (self.phobia == 10)
        {
            self.phobiacode = "03";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Φ...";
            }
            else
            {
                self.phobiahintcode = "...Ϡ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 40;
            self.hordatime = 40;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Retard", 60, 120);
            }
            else
            {
            self.StrangeAction("Weak", 60, 240);
            }
        }

        elif (self.phobia == 11)
        {
            self.phobiacode = "30";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Ϡ...";
            }
            else
            {
                self.phobiahintcode = "...Φ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = Random.RandomInt(3,6);
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = 3;
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 30;
            self.hordatime = 30;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Radiation", 60, 240);
            }
            else
            {
            self.StrangeAction("Stop", 60, 120);
            }
        }

        elif (self.phobia == 12)
        {
            self.phobiacode = "13";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...λ...";
            }
            else
            {
                self.phobiahintcode = "...Ϡ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 25;
            self.hordatime = 25;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 2;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Weak", 60, 240);
            }
            else
            {
            self.StrangeAction("Protection", 60, 120);
            }
        }

        elif (self.phobia == 13)
        {
            self.phobiacode = "31";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Ϡ...";
            }
            else
            {
                self.phobiahintcode = "...λ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 25;
            self.hordatime = 25;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 2;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Radiation", 60, 240);
            }
            else
            {
            self.StrangeAction("Mitose", 60, 120);
            }
        }

        elif (self.phobia == 14)
        {
            self.phobiacode = "23";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Ω...";
            }
            else
            {
                self.phobiahintcode = "...Ϡ...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 20;
            self.hordatime = 20;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Weak", 60, 240);
            }
            else
            {
            self.StrangeAction("Sickness", 60, 120);
            }
        }

        elif (self.phobia == 15)
        {
            self.phobiacode = "32";
            random = Random.RandomInt(1,3);
            if(random == 1)
            {
                self.phobiahintcode = "...Ϡ...";
            }
            else
            {
                self.phobiahintcode = "...Ω...";
            }
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 15;
            self.hordatime = 15;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 1;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Radiation", 60, 240);
            }
            else
            {
            self.StrangeAction("Sickness", 60, 120);
            }
        }

        elif (self.phobia == 16)
        {
            self.phobiacode = "33";
            self.phobiahintcode = "...Ϡ...";
            if (UI.GetLanguage() != "PT-BR")
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeen = Titanophobia.sizeen.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageen = Titanophobia.damageen.Get(random - 1);
            random = 1;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpen = Titanophobia.hpen.Get(random - 1);
            }
            else
            {
            random = 3;
            Titanophobia.selectedsize = Titanophobia.size.Get(random - 1);
            Titanophobia.selectedsizeptbr = Titanophobia.sizeptbr.Get(random - 1);
            random = Random.RandomInt(3,6);
            Titanophobia.seleteddamage = Titanophobia.damage.Get(random - 1);
            Titanophobia.selecteddamageptbr = Titanophobia.damageptbr.Get(random - 1);
            random = 3;
            Titanophobia.selectedhp = Titanophobia.hp.Get(random - 1);
            Titanophobia.selectedhpptbr = Titanophobia.hpptbr.Get(random - 1);
            }
            self.horda = 1;
            self.hordatimer = 15;
            self.hordatime = 15;
            self.maxtitans = 3;
            Titanophobia.titanotypesmin = 3;
            Titanophobia.titanotypesmax = 5;
            self.PhobiaAction(60, 240);
            random = Random.RandomInt(1,3);
            if (random == 1)
            {
            self.StrangeAction("Radiation", 60, 240);
            }
            else
            {
            self.StrangeAction("Weak", 60, 120);
            }
        }

    }

    coroutine StartGame2Sec()
    {
        wait 3.0;
        Network.SendMessageAll("PhobiaCutscene");
        wait 5.0;
        sentahss = 0;
        sentapg = 0;
        sentts = 0;
        if(self.canahss == 0)
        {
            Network.SendMessageOthers("canahsson|teste");
        }
        elif(self.canahss == 1)
        {
            Network.SendMessageOthers("canahssoff|teste");
        }
        if(self.canapg == 0)
        {
            Network.SendMessageOthers("canapgon|teste");
        }
        elif(self.canapg == 1)
        {
            Network.SendMessageOthers("canapgoff|teste");
        }
        if(self.cants == 0)
        {
            Network.SendMessageOthers("cantson|teste");
        }
        elif(Main.cants == 1)
        {
            Network.SendMessageOthers("cantsoff|teste");
        }
        MissionSupply.Create();
        Menu.CreateWindows();
        if (Network.IsMasterClient && self.titanophobiac == 1)
        {
            wait 10.0;
            self.phobia = Random.RandomInt(1, 17);
            self.phobiaactions = Random.RandomInt(1, 3);
            self.acting = 1;
            self.supplyrespawntime = 45;
            text = "Hnn… ngh… khh…nghaaah!";
            Game.PrintAll("<color=#FFFF00> ♟Ymir 「" + text + "」</color>");
            self.DialogTextAll("Ymir1", "Ymir", text);
            wait 10.0;
            self.PhobiaStart();
        }
    }

    function SetupSettings()
    {
        self.Settings = PlayerSettings("TitanFallSettings");
        self.Settings.AddSetting("DialogIcon"     , "Ricecake1");
        self.Settings.AddSetting("DialogTextColor", "white"    );
    }

    function OnButtonClick(buttonname)
    {
        if(buttonname == "PMBook")
        {
            Menu.PlayersMenuOff();
            Menu.Book();
        }
        if(buttonname == "PMPhobiary")
        {
            Menu.PlayersMenuOff();
            Menu.Phobiary();
        }
        if(buttonname == "PMChemical")
        {
            Menu.PlayersMenuOff();
            Menu.Chemical();
        }
        if(buttonname == "General")
        {
            Menu.FirstWindowOff();
            Menu.GeneralWindow();
        }
        elif(buttonname == "RVA")
        {
            for (player in Network.Players)
            {
                Game.SpawnPlayer(player, false);
            }
        }
        elif(buttonname == "RVP")
        {
            for (player in Network.Players)
            {
                Game.SpawnPlayerAt(player, false, self.resppoint);
            }
        }
        elif(buttonname == "KPALL")
        {
            for (human in Game.Humans)
            {
                human.GetKilled("YMIR");
            }
        }
        elif(buttonname == "AF")
        {
            for (titan in Game.Titans)
            {
                titan.GetKilled("YMIR");
            }
            for (shifter in Game.Shifters)
            {
                shifter.GetKilled("YMIR");
            }
        }
        elif(buttonname == "FMF")
        {
            for (shifter in Game.Shifters)
            {
                shifter.GetKilled("YMIR");
            }
        }
        elif(buttonname == "TF")
        {
            for (titan in Game.Titans)
            {
                titan.GetKilled("YMIR");
            }
        }
        elif(buttonname == "TRegen")
        {
            if(self.hprestore == 0)
            {
                self.hprestore = 1;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.hprestore == 1)
            {
                self.hprestore = 0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }
        elif(buttonname == "Chase")
        {
            if(self.chase == 0)
            {
                self.chase = 1;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.chase == 1)
            {
                self.chase = 0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }
        elif(buttonname == "Check")
        {
            if(self.check == 0)
            {
                self.check = 1;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.check == 1)
            {
                self.check = 2;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.check == 2)
            {
                self.check = 0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }
        elif(buttonname == "Cut")
        {
            if(!self.cutdialog)
            {
                self.cutdialog = true;
                Network.SendMessageOthers("con|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            else
            {
                self.cutdialog = false;
                Network.SendMessageOthers("coff|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }
        elif(buttonname == "RD")
        {
            if(self.spawnDistMax == 300.0)
            {
                self.spawnDistMin = -500.0;
                self.spawnDistMax = 500.0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.spawnDistMax == 500.0)
            {
                self.spawnDistMin = -800.0;
                self.spawnDistMax = 800.0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.spawnDistMax == 800.0)
            {
                self.spawnDistMin = -1000.0;
                self.spawnDistMax = 1000.0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.spawnDistMax == 1000.0)
            {
                self.spawnDistMin = -1500.0;
                self.spawnDistMax = 1500.0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.spawnDistMax == 1500.0)
            {
                self.spawnDistMin = -300.0;
                self.spawnDistMax = 300.0;
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }
        elif(buttonname == "CANAHSS")
        {
            if(self.canahss == 0)
            {
                self.canahss = 1;
                Network.SendMessageOthers("canahsson|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.canahss == 1)
            {
                self.canahss = 0;
                Network.SendMessageOthers("canahssoff|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }

        elif(buttonname == "CANAPG")
        {
            if(self.canapg == 0)
            {
                self.canapg = 1;
                Network.SendMessageOthers("canapgon|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.canapg == 1)
            {
                self.canapg = 0;
                Network.SendMessageOthers("canapgoff|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }

        elif(buttonname == "CANTS")
        {
            if(self.cants == 0)
            {
                self.cants = 1;
                Network.SendMessageOthers("cantson|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
            elif(self.cants == 1)
            {
                self.cants = 0;
                Network.SendMessageOthers("cantsoff|teste");
                Menu.GeneralWindowOff();
                Menu.GeneralWindow();
                return;
            }
        }

        elif(buttonname == "Supply")
        {
            Menu.FirstWindowOff();
            Menu.SupplyWindow();
        }
        elif(buttonname == "AddSupply")
        {
            self.resppoint = Network.MasterClient.Character.Position;
            MissionSupply.Create();
            text = "Protect The Supply";
            Game.PrintAll("<color=#00FF00> ➽</color><color=#FFFF00>「</color>" + text + "<color=#FFFF00>」</color>");
            Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
        }
        elif(buttonname == "RemoveSupply")
        {
            MissionSupply.Remove();
            text = "Supply Removed";
            Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
            Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
        }
        elif(buttonname == "RVPlayers")
        {
            if(self.rvp == 0)
            {
                self.rvp = 1;
                text = "Medic Resources ON";
                Game.PrintAll("<color=#00FF00> ➽</color><color=#FFFF00>「</color>" + text + "<color=#FFFF00>」</color>");
                Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                Menu.SupplyWindowOff();
                Menu.SupplyWindow();
                return;
            }
            else
            {
                self.rvp = 0;
                text = "Medic Resources OFF";
                Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                Menu.SupplyWindowOff();
                Menu.SupplyWindow();
                return;
            }
        }


        elif(buttonname == "Commander")
        {
            Menu.FirstWindowOff();
            Menu.CommanderWindow();
        }
        elif(buttonname == "Tied")
        {
            for (character in Game.Humans)
            {
                if ((Network.MyPlayer.Character.Position - character.Position).Magnitude < 5.1)
                {
                    self.carryguy = character;
                    self.tied = true;
                }
            }
        }
        elif(buttonname == "Untied")
        {
            self.tied = false;
            self.carryguy = null;
        }
        elif(buttonname == "TP")
        {
            Network.SendMessageAll("tp|" + self.pointer);
        }
        elif(buttonname == "TP0")
        {
            self.pointer2 = Network.MasterClient.Character.Position;
            Network.SendMessageAll("tp|" + self.pointer2);
        }
        elif(buttonname == "TP0P")
        {
            if (Network.MasterClient.Character != null)
            {
                Network.MasterClient.Character.Position = self.pointer;
            }
        }
        elif(buttonname == "AIR2")
        {
            self.pointer2 = Network.MasterClient.Character.Position;
            Game.SpawnPlayerAtAll(false, self.pointer2);
        }
        elif(buttonname == "PAUSE")
        {
            Network.SendMessageAll("PAUSE|teste");
        }
        elif(buttonname == "UNPAUSE")
        {
            Network.SendMessageAll("UNPAUSE|teste");
        }
        elif(buttonname == "Players")
        {
            Menu.FirstWindowOff();
            Menu.PlayersWindow();
        }
        for (i in Range(1, 200, 1))
        {
            for (player in Network.Players)
            {
                if(buttonname == Convert.ToString(player.ID))
                {
                    Menu.playersWindowOff();
                    Menu.SelectedPlayerWindow(player);
                    return;
                }
            }
        }
        if(buttonname == "TP0S")
        {
            Network.MyPlayer.Character.Position = Menu.selectedplayer.Character.Position;
        }
        elif(buttonname == "TPALLS")
        {
            for (player in Network.Players)
            {
                Network.SendMessage(player, "tp|" + Menu.selectedplayer.Character.Position);
            }
        }
        elif(buttonname == "TPS0")
        {
            self.pointer2 = Network.MasterClient.Character.Position;
            Network.SendMessage(Menu.selectedplayer, "tp|" + self.pointer2);
        }
        elif(buttonname == "RVPLAYER")
        {
            Game.SpawnPlayer(Menu.selectedplayer, false);
        }
        elif(buttonname == "RVPLAYERP")
        {
            Game.SpawnPlayerAt(Menu.selectedplayer, false, self.pointer);
        }
        elif(buttonname == "RVPLAYERPALL")
        {
            if (Menu.selectedplayer.Character != null)
            {
                for (player in Network.Players)
                {
                    Game.SpawnPlayerAt(player, false, Menu.selectedplayer.Character.Position);
                }
            }

        }
        elif(buttonname == "POINTERP")
        {   if (Menu.selectedplayer.Character != null)
            {
                self.pointer = Menu.selectedplayer.Character.Position;
            }
        }
        elif(buttonname == "RANDOMP")
        {
            if (Menu.selectedplayer.Character != null)
            {
                spawnlocation = Menu.selectedplayer.Character.Position;
                if (spawnlocation != null)
                {
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                    var = Random.RandomInt(1, 3);
                    if (var == 1)
                    {
                        Game.SpawnTitanAt("Normal", spawnlocation);
                    }
                    if (var == 2)
                    {
                        Game.SpawnTitanAt("Abnormal", spawnlocation);
                    }
                }
            }
        }
        elif(buttonname == "NORMALP")
        {
            if (Menu.selectedplayer.Character != null)
            {
                spawnlocation = Menu.selectedplayer.Character.Position;
                if (spawnlocation != null)
                {
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));

                    Game.SpawnTitanAt("Normal", spawnlocation);
                }
            }
        }
        elif(buttonname == "ABERRANTP")
        {
            if (Menu.selectedplayer.Character != null)
            {
                spawnlocation = Menu.selectedplayer.Character.Position;
                if (spawnlocation != null)
                {
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));

                    Game.SpawnTitanAt("Abnormal", spawnlocation);
                }
            }
        }
        elif(buttonname == "PUNKP")
        {
            if (Menu.selectedplayer.Character != null)
            {
                spawnlocation = Menu.selectedplayer.Character.Position;
                if (spawnlocation != null)
                {
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));

                    Game.SpawnTitanAt("Punk", spawnlocation);
                }
            }
        }
        elif(buttonname == "CRAWLERP")
        {
            if (Menu.selectedplayer.Character != null)
            {
                spawnlocation = Menu.selectedplayer.Character.Position;
                if (spawnlocation != null)
                {
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));

                    Game.SpawnTitanAt("Crawler", spawnlocation);
                }
            }
        }
        elif(buttonname == "THROWERP")
        {
            if (Menu.selectedplayer.Character != null)
            {
                spawnlocation = Menu.selectedplayer.Character.Position;
                if (spawnlocation != null)
                {
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));

                    Game.SpawnTitanAt("Thrower", spawnlocation);
                }
            }
        }
        elif(buttonname == "ADDPLAYERHEALTH")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "ADDPLAYERHEALTH");
            }
        }
        elif(buttonname == "SUBPLAYERHEALTH")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "SUBPLAYERHEALTH");
            }
        }
        elif(buttonname == "REFILLP")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "REFILLP");
            }
        }
        elif(buttonname == "BLADESP")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "BLADEP");
            }
        }
        elif(buttonname == "AHSSP")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "AHSSP");
            }
        }
        elif(buttonname == "APGP")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "APGP");
            }
        }
        elif(buttonname == "TSP")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "TSP");
            }
        }
        elif(buttonname == "ERENP")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "ERENP");
            }
        }
        elif(buttonname == "ANNIEP")
        {   
            if (Menu.selectedplayer.Character != null)
            {
            Network.SendMessage(Menu.selectedplayer, "ANNIEP");
            }
        }
        elif(buttonname == "KPLAYER")
        {
            if (Menu.selectedplayer.Character != null)
            {
            Menu.selectedplayer.Character.GetKilled("YMIR");
            }
        }
        elif(buttonname == "KKPLAYER")
        {
            Network.KickPlayer(Menu.selectedplayer.ID,"(CMD)");
        }

        elif(buttonname == "Titans")
        {
            Menu.FirstWindowOff();
            Menu.TitansWindow();

        }
        elif(buttonname == "TitanList")
        {
            Menu.TitansWindowOff();
            Menu.TitanList();
        }
        elif(buttonname == "MoveTo")
        {
            for (titan in Game.Titans)
            {
                titan.MoveTo(self.pointer, 15.0, false);
            }
        }
        elif(buttonname == "MoveToIg")
        {
            for (titan in Game.Titans)
            {
                titan.MoveTo(self.pointer, 15.0, true);
            }
        }
        elif(buttonname == "Idle")
        {
            for (titan in Game.Titans)
            {
                for (titan in Game.Titans)
                {
                    titan.Idle(1000.0);
                }
            }
        }
        elif(buttonname == "Free")
        {
            for (titan in Game.Titans)
            {
                for (titan in Game.Titans)
                {
                    titan.Idle(0.1);
                    titan.Cripple(0.1);
                }
            }
        }
        elif(buttonname == "Cripple")
        {
            for (titan in Game.Titans)
            {
                titan.Cripple(10.0);
            }
        }
        elif (buttonname == "Blind")
        {
            for (titan in Game.Titans)
            {
                titan.Blind();
            }
        }
        elif (buttonname == "Laugh")
        {
            for (titan in Game.Titans)
            {
                titan.Emote("Laugh");
            }
        }
        elif(buttonname == "ShifterMoveTo")
        {
            for (shifter in Game.Shifters)
            {
                shifter.MoveTo(self.pointer, 15.0, false);
            }
        }
        elif(buttonname == "ShifterMoveToIg")
        {
            for (shifter in Game.Shifters)
            {
                shifter.MoveTo(self.pointer, 15.0, true);
            }
        }
        elif(buttonname == "ShifterIdle")
        {
            for (shifter in Game.Shifters)
            {
                for (shifter in Game.Shifters)
                {
                    shifter.Idle(1000.0);
                }
            }
        }
        elif(buttonname == "ShifterFree")
        {
            for (shifter in Game.Shifters)
            {
                for (shifter in Game.Shifters)
                {
                    shifter.Idle(0.1);
                    shifter.Cripple(0.1);
                }
            }
        }
        elif(buttonname == "ShifterCripple")
        {
            for (shifter in Game.Shifters)
            {
                shifter.Cripple(10.0);
            }
        }
        elif (buttonname == "ShifterBlind")
        {
            for (shifter in Game.Shifters)
            {
                shifter.Blind();
            }
        }
        elif (buttonname == "ShifterLaugh")
        {
            for (shifter in Game.Shifters)
            {
                shifter.Emote("Laugh");
            }
        }


        elif(buttonname == "Pointer")
        {
            Menu.FirstWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "HERE")
        {
            if (Network.MasterClient.Character != null)
            {
                self.pointer = Network.MasterClient.Character.Position;
                Menu.PointerWindowOff();
                Menu.PointerWindow();
            }
        }
        elif(buttonname == "North")
        {
            self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 100.0);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "West")
        {
            self.pointer = Vector3(self.pointer.X - 100.0, self.pointer.Y,self.pointer.Z);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "East")
        {
            self.pointer = Vector3(self.pointer.X + 100.0, self.pointer.Y,self.pointer.Z);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "South")
        {
            self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 100.0);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "Up")
        {
            self.pointer = Vector3(self.pointer.X, self.pointer.Y + 50.0, self.pointer.Z);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "Down")
        {
            self.pointer = Vector3(self.pointer.X, self.pointer.Y - 50.0, self.pointer.Z);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "NorthMin")
        {
            self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 10.0);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "WestMin")
        {
            self.pointer = Vector3(self.pointer.X - 10.0, self.pointer.Y,self.pointer.Z);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "EasthMin")
        {
            self.pointer = Vector3(self.pointer.X + 10.0, self.pointer.Y,self.pointer.Z);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }
        elif(buttonname == "SouthMin")
        {
            self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 10.0);
            Menu.PointerWindowOff();
            Menu.PointerWindow();
        }

        elif(buttonname == "Book")
        {
            Menu.FirstWindowOff();
            Menu.Book();
        }


    }

    function OnFrame()
    {
        mineplayer = Network.MyPlayer;
        if (Network.MyPlayer.Character != null)
        {
            if(self.canahss == 0)
            {
                if (mineplayer.Character.Weapon == "AHSS")
                {
                    Network.SendMessage(mineplayer, "BLADEP|teste");
                    Network.SendMessage(mineplayer, "REFILLP|teste");
                    Network.SendMessage(mineplayer, "SUPPLYP|teste");
                }
            }
            if(self.canapg == 0)
            {
                if (mineplayer.Character.Weapon == "APG")
                {
                    Network.SendMessage(mineplayer, "BLADEP|teste");
                    Network.SendMessage(mineplayer, "REFILLP|teste");
                    Network.SendMessage(mineplayer, "SUPPLYP|teste");
                }
            }
            if(self.cants == 0)
            {
                if (mineplayer.Character.Weapon == "Thunderspear")
                {
                    Network.SendMessage(mineplayer, "BLADEP|teste");
                    Network.SendMessage(mineplayer, "REFILLP|teste");
                    Network.SendMessage(mineplayer, "SUPPLYP|teste");
                }
            }
            if (mineplayer.Character != null && mineplayer.Character.Type != "Shifter" && mineplayer.Character.Type != "Titan")
            {
                mineplayer.Character.Acceleration = 75.0;
                mineplayer.Character.HorseSpeed = 30.0;
            }
        }
        myCharacter = Network.MyPlayer.Character;
        if (myCharacter != null)
        {
            if (Network.MyPlayer.Character.Health > 100)
            {
                health = "<size=50><color=#008888>" + Network.MyPlayer.Character.Health + "</color></size>";
            }
            if (Network.MyPlayer.Character.Health <= 100)
            {
                health = "<size=50><color=#00FF00>" + Network.MyPlayer.Character.Health + "</color></size>";
            }
            if (Network.MyPlayer.Character.Health <= 60)
            {
                health = "<size=50><color=#FFFF00>" + Network.MyPlayer.Character.Health + "</color></size>";
            }
            if (Network.MyPlayer.Character.Health <= 40)
            {
                health = "<size=50><color=#FF8C00>" + Network.MyPlayer.Character.Health + "</color></size>";
            }
            if (Network.MyPlayer.Character.Health <= 20)
            {
                health = "<size=50><color=#FF0000>" + Network.MyPlayer.Character.Health + "</color></size>";
            }
            UI.SetLabel("MiddleRight", health);
            if (myCharacter.State == "Grab" && self.quicktimes > 0)
            {
                UI.SetLabel("MiddleCenter", "PRESS " + String.ToUpper(Input.GetKeyName("Human/AttackDefault")) +  " TO ESCAPE (TIMES: " + Convert.ToString(self.quickclicks) + "/" + Convert.ToString(self.quicktimes) + ")");
            }
        }
        if(myCharacter == null)
        {
            UI.SetLabel("MiddleRight", "");
        }
        if (self.quicktime == 1 && self.timerquick == 0)
        {
            if (Input.GetKeyDown("Human/AttackDefault"))
            {
                self.quickclicks = self.quickclicks + 1;
            }
            if (self.quickclicks >= self.quicktimes)
            {
                self.timerquick = 8;
                self.quicktime = 2;
                if (myCharacter != null)
                {
                    myCharacter.SetSpecial("Escape");
                    myCharacter.ActivateSpecial();
                }
            }
        }
        if (Input.GetKeyDown("Interaction/Function2"))
        {
            Menu.LoreInitial();
        }     
        if(!Network.IsMasterClient)
        {
            if (Input.GetKeyDown("Interaction/Function1"))
            {
                Menu.PlayersMenu();
            }     
        }
        if(Network.IsMasterClient)
        {
            if (Input.GetKeyDown("Interaction/Function1"))
            {
                Menu.FirstWindow();
            }
            if (Input.GetKeyDown("Interaction/Function3"))
            {
                Menu.PlayersMenu();
            }         
        }
        if (self.tied && self.carryguy != null && Network.MyPlayer.Status == "Alive")
        {
            Network.MyPlayer.Character.Position = self.carryguy.Position - self.carryguy.Forward;
            Network.MyPlayer.Character.Rotation = self.carryguy.Rotation;
        }
        char = Network.MyPlayer.Character;
        if (char != null && char.Type == "Human" && Network.MyPlayer.Status == "Alive")
        {
            if (Input.GetKeyDown("Interaction/Function4"))
            {
                for (player in Network.Players)
                {
                    if(player.Character != null)
                    {
                        if (player.Character != char && ((Network.MyPlayer.Character.Position - player.Character.Position).Magnitude < 5.1))
                        {
                            self.carryguy = player.Character;
                            self.tied = true;
                        }
                    }
                }
            }
            if (Input.GetKeyUp("Interaction/Function4"))
            {
                self.carryguy = null;
                self.tied = false;
            }
        }
    }

    function OnSecond()
    {
        self.fataldelta = 100.0;
        self.GrabEscape();
        self.ShortWaveSpawn();
        self.RespawnTimer();
        self.HealthRegen();
        self.TitanChase();
        if (Network.MyPlayer.Character != null)
        {
            if (Network.MyPlayer.Character.CurrentSpecial == "Supply")
            {
                Network.MyPlayer.Character.SpecialCooldown = 120.0;
            }
        }
        if(self.wrongcombine == 1)
        {
            self.staycombine = 0;
            for (human in Game.Humans)
            {
                if (human.Position.X <= 14.05129 + 3.0 && human.Position.X >= 14.05129 - 3.0)
                {
                if (human.Position.Y <= 0.4923246 + 3.0 && human.Position.Y >= 0.4923246 - 3.0)
                {
                if (human.Position.Z <= 291.4498 + 3.0 && human.Position.Z >= 291.4498 - 3.0)
                {
                    self.staycombine = 1;
                }
                }
                }
            }
        }
        if (self.staycombine == 1)
        {
            self.combinating += 1;
        }
        if (self.staycombine == 0 && self.combinating > 0)
        {
            self.combinating -= 1;
        }
        if (self.combinating == 3 && self.staycombine == 1)
        {
            if(UI.GetLanguage() != "PT-BR")
            {
            text = "Start reversing combination";
            }
            else
            {
            text = "Começando a reverter";
            }
            Game.PrintAll("<color=#FFFF00> ♟Ymir 「" + text + "」</color>");
            self.DialogTextAll("Ymir1", "Ymir", text);
        }
        if (self.combinating == 15 && self.staycombine == 1)
        {
            if(UI.GetLanguage() != "PT-BR")
            {
            text = "Mid-process reversal";
            }
            else
            {
            text = "Reversão pela metade";
            }
            Game.PrintAll("<color=#FFFF00> ♟Ymir 「" + text + "」</color>");
            self.DialogTextAll("Ymir1", "Ymir", text);
        }
        if (self.combinating == 30)
        {
            if(UI.GetLanguage() != "PT-BR")
            {
            text = "Reversion complete";
            }
            else
            {
            text = "Reversão completa";
            }
            Game.PrintAll("<color=#FFFF00> ♟Ymir 「" + text + "」</color>");
            self.DialogTextAll("Ymir1", "Ymir", text);
            self.wrongcombine = 0;
            self.ReversePhobia();
        }

        if(Game.Humans.Count > 0)
        {
            self.restarttimer = 0;
        }
        if (Game.Humans.Count == 0 && Network.IsMasterClient && self.restarttimer < 60)
        {
            self.restarttimer += 1;
            if (self.restarttimer == 8)
            {
                text = "No players alive, restarting soon";
                Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
            }
            if (self.restarttimer == 30)
            {
                text = "No players alive, restarting soon";
                Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
            }
            if (self.restarttimer == 53)
            {
                text = "Restarting in 5 seconds";
                Network.SendMessageAll("coff|teste");
                Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                Game.End(5.0);
            }
        }
        if (self.supplyrespawntime > 0)
        {
            self.supplyrespawntime -= 1;
        }
        if (self.supplyrespawntime == 0)
        {
            if(MissionSupply.Supply == null)
            {
                MissionSupply.Create();
                text = "Protect The Supply";
                Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
            }
            self.supplyrespawntime = 50;
        }
        if (Network.IsMasterClient && self.mitosetimer > 0)
        {
            self.mitosetimer -= 1;
        }
        if (Network.IsMasterClient && self.protectiontimer > 0)
        {
            self.protectiontimer -= 1;
        }
        if (Network.IsMasterClient && self.sickness > 0)
        {
            if (self.sick.Character != null)
            {
                self.sick.Character.Acceleration = 30.0;
            }
            self.sickness -= 1;
        }
        if (self.radiation > 0)
        {
            if (self.radiated.Character != null)
            {
                self.radiated.Character.Health -= 1;
            }
            self.radiation -= 1;
        }
        if (Network.IsMasterClient && self.horda == 1)
        {
            if (self.hordatimer == 0)
            {
                self.hordatimer = self.hordatime;
            }
            if (self.hordatimer == self.hordatime)
            {
                if (Game.Titans.Count < self.maxtitans)
                {
                    if (self.check == 0 || self.check == 1)
                    {
                        if (self.titanophobiac == 1)
                        {
                            var = Random.RandomInt(Titanophobia.titanotypesmin, Titanophobia.titanotypesmax + 1);
                            if (var == 1) 
                            {
                                titan = Game.SpawnTitan("Normal");
                                titan.Size = titan.Size + Titanophobia.selectedsize;

                                titan.CustomDamageEnabled = true;
                                titan.CustomDamage = Titanophobia.seleteddamage;

                                titan.MaxHealth = titan.MaxHealth + Titanophobia.selectedhp;
                                titan.Health = titan.MaxHealth;
                            }
                            elif (var == 2) 
                            {
                                titan = Game.SpawnTitan("Abnormal"); 
                                titan.Size = titan.Size + Titanophobia.selectedsize;

                                titan.CustomDamageEnabled = true;
                                titan.CustomDamage = Titanophobia.seleteddamage;

                                titan.MaxHealth = titan.MaxHealth + Titanophobia.selectedhp;
                                titan.Health = titan.MaxHealth;
                            }
                            elif (var == 3) 
                            {
                                titan = Game.SpawnTitan("Punk"); 
                                titan.Size = titan.Size + Titanophobia.selectedsize;

                                titan.CustomDamageEnabled = true;
                                titan.CustomDamage = Titanophobia.seleteddamage;

                                titan.MaxHealth = titan.MaxHealth + Titanophobia.selectedhp;
                                titan.Health = titan.MaxHealth;
                            }
                            elif (var == 4) 
                            {
                                titan = Game.SpawnTitan("Crawler");
                                titan.Size = titan.Size + Titanophobia.selectedsize;

                                titan.CustomDamageEnabled = true;
                                titan.CustomDamage = Titanophobia.seleteddamage;

                                titan.MaxHealth = titan.MaxHealth + Titanophobia.selectedhp;
                                titan.Health = titan.MaxHealth;

                            }
                            elif (var == 5) 
                            {
                                titan = Game.SpawnTitan("Thrower");
                                titan.Size = titan.Size + Titanophobia.selectedsize;

                                titan.CustomDamageEnabled = true;
                                titan.CustomDamage = Titanophobia.seleteddamage;

                                titan.MaxHealth = titan.MaxHealth + Titanophobia.selectedhp;
                                titan.Health = titan.MaxHealth;
                            }
                        }
                        else
                        {
                            var = Random.RandomInt(1, 3);
                            if (var == 1) 
                            {
                                titan = Game.SpawnTitan("Normal");
                            }
                            elif (var == 2) 
                            {
                                titan = Game.SpawnTitan("Abnormal"); 
                            }
                        }
                    }
                    if (self.check == 2)
                    {
                        if (var == 1)
                        {
                            titan = Game.SpawnTitanAt("Normal", self.spawner); 
                        }
                        elif (var == 2)
                        {
                            titan = Game.SpawnTitanAt("Abnormal", self.spawner);
                        }
                    }
                }
            }
            self.hordatimer -= 1;
        }
        myCharacter = Network.MyPlayer.Character;
        if (myCharacter != null)
        {
            if (myCharacter.State != "Grab")
            {
                UI.SetLabel("MiddleCenter","");
            }
        }
    }

    function OnTick()
    {
        myCharacter = Network.MyPlayer.Character;
        self.fatalplayer = myCharacter;
        if (self.fatalplayer != null && self.fatalcollision == 1)
        {
            if (Network.IsMasterClient)
            {
                for (titan in Game.Titans)
                {
                    titan.CustomDamageEnabled = true;
                    titan.CustomDamage = Random.RandomInt(30, 61);
                }
                for (shifter in Game.AIShifters)
                {
                    shifter.CustomDamageEnabled = true;
                    shifter.CustomDamage = Random.RandomInt(40, 71);
                }
            }

            if (self.speedcollider - self.fatalplayer.Velocity.Magnitude >= self.fataldelta / 2 && self.fatalplayer.Type != "Shifter" && self.fatalplayer.Type != "Titan")
            {
                self.fatalplayer.Health -= Math.Abs(self.speedcollider - self.fatalplayer.Velocity.Magnitude) - self.fataldelta / 2;
                self.fataldelta = self.fataldelta;
                Game.SpawnEffect("Blood2", self.fatalplayer.Position, Vector3(0.0,0.0,0.0), 0.5);
            }
            self.speedcollider = self.fatalplayer.Velocity.Magnitude;
        }
        if (Network.IsMasterClient && !Game.IsEnding)
        {
            if (self.check == 0 && self.titanophobiac == 0)
            {
                titans = Game.Titans.Count;
                humans = Game.Humans.Count;
                playerShifters = Game.PlayerShifters.Count;
                TotalShifters = Game.PlayerShifters.Count + Game.Shifters.Count;
                titans = titans + TotalShifters;
                if (humans > 0 || TotalShifters > 0)
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
                if (self._currentWave > self.MaxWaves)
                {
                    UI.SetLabelAll("TopCenter", "");
                }
            }
            elif(self.check == 2 && self.waves > 0)
            {
                titans = Game.Titans.Count;
                humans = Game.Humans.Count;
                playerShifters = Game.PlayerShifters.Count;
                TotalShifters = Game.PlayerShifters.Count + Game.Shifters.Count;
                titans = titans + TotalShifters;
                if (humans > 0 || TotalShifters > 0)
                {
                    self._hasSpawned = true;
                }
                if (titans == 0)
                {
                    self.NextWave2();
                }
                if (humans == 0 && playerShifters == 0 && self._hasSpawned)
                {
                    text = "LOST OBJECTIVE! BACK OFF!";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");

                    self._currentWave = 0;
                    self._hasSpawned = false;
                    self.waves = 0;
                    UI.SetLabel("TopCenter", "");
                    return;
                }
                UI.SetLabel("TopCenter", "Titans Left: " + Convert.ToString(titans) + "  " + "Wave: " + Convert.ToString(self._currentWave));
                if (self._currentWave > self.waves)
                {
                    UI.SetLabel("TopCenter", "");
                }
            }
        }
    }

    function NextWave()
    {
        self._currentWave = self._currentWave + 1;
        if (MissionSupply.Supply == null && self.check == 0 && self._currentWave == 1)
        {
            MissionSupply.Create();
        }
        if (MissionSupply.Supply == null && self._currentWave != 1)
        {
            text = "Protect The Supply";
            Game.PrintAll("<color=#00FF00> ➽</color><color=#FFFF00>「</color>" + text + "<color=#FFFF00>」</color>");
            self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
        }
        MissionSupply.Create();
        if (self._currentWave > self.MaxWaves)
        {
            UI.SetLabel("MiddleCenter", "All waves cleared, humanity wins!");
            Game.End(10.0);
            return;
        }
        amount = self.AddTitansPerWave * (self._currentWave - 1) + self.StartTitans;
        if (self._currentWave != 5 && self._currentWave != 10 && self._currentWave != 15)
        {
            if (self.GradualSpawn)
            {
                Game.SpawnTitansAsync("Default", amount);
                for (titan in Game.Titans)
                {
                    health = Random.RandomInt(10, 501);
                    titan.MaxHealth = health;
                    titan.Health = health;
                }
            }
            else
            {
                Game.SpawnTitans("Default", amount);
                for (titan in Game.Titans)
                {
                    health = Random.RandomInt(10, 501);
                    titan.MaxHealth = health;
                    titan.Health = health;
                }
            }
        }
        if (self.RespawnOnWave)
        {
            Game.SpawnPlayerAll(false);
        }
        if (self._currentWave == 5 || self._currentWave == 10 || self._currentWave == 15 || self._currentWave == 20)
        {
            Game.SpawnTitansAsync("Default", 2);
            annie = Game.SpawnShifter("Annie");
            annie.MaxHealth = 100 * self._currentWave;
            annie.Health = 100 * self._currentWave;

            text = "<color=#AA0000>Kill The Eldian</color>";
            Game.PrintAll("<color=#FF0000> ☠</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
            self.DialogTextAll("Nanaba1", "Nanaba", "<color=#FF0000> ☠</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
            Network.SendMessageAll("prf");
        }
    }

    function NextWave2()
    {
        self._currentWave = self._currentWave + 1;
        if (MissionSupply.Supply == null && self.check == 0 && self._currentWave == 1)
        {
            MissionSupply.Create();
        }
        if (self._currentWave > self.waves)
        {
            self._currentWave = 0;
            self._hasSpawned = false;
            self.waves = 0;

            text = "OBJECTIVE COMPLETED! SHINZO WO SASAGEYO!";
            Game.PrintAll("<color=#00FF00> ☑</color><color=#00FF00>「</color>" + text + "<color=#00FF00>」</color>");
            self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#00FF00> ☑</color><color=#00FF00>「</color><color=#FFFFFF>" + text + "</color><color=#00FF00>」</color>");

            return;
        }
        amount = self._currentWave + Random.RandomInt(1, 4);
        if (self._currentWave != 3 && self._currentWave != 6 && self._currentWave != 9)
        {
            if (self.GradualSpawn)
            {
                resppointspawn = Vector3(self.resppoint.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), self.resppoint.Y + 50.0, self.resppoint.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                Game.SpawnTitansAtAsync("Default", amount, resppointspawn);
                for (titan in Game.Titans)
                {
                    health = Random.RandomInt(10, 501);
                    titan.MaxHealth = health;
                    titan.Health = health;
                }
            }
            else
            {
                resppointspawn = Vector3(self.resppoint.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), self.resppoint.Y + 50.0, self.resppoint.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                Game.SpawnTitansAtAsync("Default", amount, resppointspawn);
                for (titan in Game.Titans)
                {
                    health = Random.RandomInt(10, 501);
                    titan.MaxHealth = health;
                    titan.Health = health;
                }
            }
        }
        if (self.RespawnOnWave)
        {
            Game.SpawnPlayerAtAll(false, self.resppoint + Vector3(0, 5, 0));
        }
        if (self._currentWave == 3 || self._currentWave == 6 || self._currentWave == 9 || self._currentWave == 12)
        {
            resppointspawn = Vector3(self.resppoint.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), self.resppoint.Y + 50.0, self.resppoint.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
            amount = Random.RandomInt(1, 6);
            Game.SpawnTitansAtAsync("Default", amount, resppointspawn);
            resppointspawn = Vector3(self.resppoint.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), self.resppoint.Y + 50.0, self.resppoint.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
            if (self._currentWave == self.waves)
            {
                annie = Game.SpawnShifterAt("Annie", resppointspawn);
                annie.MaxHealth = 300 * self._currentWave;
                annie.Health = 300 * self._currentWave;

                text = "<color=#AA0000>ELDIAN COMING! PROTECT THE SUPPLIES!</color>";
                Game.PrintAll("<color=#FF0000> ☠</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF0000> ☠</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
            }
        }
    }

    function OnCharacterSpawn(character)
    {
        if (character.IsMine && character.Type == "Titan" && self.check == 0)
        {
            character.DetectRange = 2000;
        }
        if (character.Type == "Human")
        {
            if (character.CurrentSpecial == "Supply")
            {
                character.SpecialCooldown = 120.0;
            }
        }
    }

    function OnCharacterDamaged(victim, killer, killerName, damage)
    {
        if(killer != null && victim != null)
        {
            if (self.protectiontimer > 0 && damage < 300)
            {
                victim.Health = victim.MaxHealth;
            }
        }
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim.Type == "Titan" && self.mitosetimer > 0)
        {
            Game.SpawnTitanAt("Normal", victim.Position);
        }
        if (killer != null)
        {
            if (victim.Type == "Titan" && killer.Type == "Human" && killer.State == "Alive")
            {
                if (killer.Health < killer.MaxHealth - 15)
                {
                    killer.Health += 15;
                }
                else
                {
                    killer.Health = killer.MaxHealth;
                }
            }
            if (victim.Type == "Shifter" && killer.Type == "Human" && killer.State == "Alive")
            {
                if (killer.Health < killer.MaxHealth)
                {
                    killer.Health = killer.MaxHealth;
                }
            }
        }
        if (Network.IsMasterClient && Game.Titans.Count + Game.AIShifters.Count == 0 && self.horda == 0)
        {
            if (self.phobia > 0)
            {
                if (self.wrongcombine == 0)
                {
                    self.PhobiaFX("ShifterThunder");
                    random = Random.RandomInt(6, 9);
                    if (random == 6)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                            text = Titanophobia.ingametexten.Get(random);
                            Game.PrintAll("<color=#00FF00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else 
                        {
                            text = Titanophobia.ingametextptbr.Get(random);
                            Game.PrintAll("<color=#00FF00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                    }
                    elif (random == 7)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                            text = Titanophobia.ingametexten.Get(random);
                            Game.PrintAll("<color=#00FF00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else 
                        {
                            text = Titanophobia.ingametextptbr.Get(random);
                            Game.PrintAll("<color=#00FF00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                    }
                    elif (random == 8)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                            text = Titanophobia.ingametexten.Get(random);
                            Game.PrintAll("<color=#00FF00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else 
                        {
                            text = Titanophobia.ingametextptbr.Get(random);
                            Game.PrintAll("<color=#00FF00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                    }
                }
                if (self.wrongcombine == 1)
                {
                    random = Random.RandomInt(9, 12);
                    if (random == 9)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                            text = Titanophobia.ingametexten.Get(random);
                            Game.PrintAll("<color=#FF8C00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else 
                        {
                            text = Titanophobia.ingametextptbr.Get(random);
                            Game.PrintAll("<color=#FF8C00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                    }
                    elif (random == 10)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                            text = Titanophobia.ingametexten.Get(random);
                            Game.PrintAll("<color=#FF8C00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else 
                        {
                            text = Titanophobia.ingametextptbr.Get(random);
                            Game.PrintAll("<color=#FF8C00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                    }
                    elif (random == 11)
                    {
                        if (UI.GetLanguage() != "PT-BR")
                        {
                            text = Titanophobia.ingametexten.Get(random);
                            Game.PrintAll("<color=#FF8C00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                        else 
                        {
                            text = Titanophobia.ingametextptbr.Get(random);
                            Game.PrintAll("<color=#FF8C00> ♟Ymir 「" + text + "」</color>");
                            self.DialogTextAll("Ymir1", "Ymir", text);
                        }
                    }
                }
            }
        }
    }

    function OnPlayerJoin(player)
    {
        if (Network.IsMasterClient)
        {
            MissionSupply.OnPlayerJoin(player);
            Network.SendMessage(player,"lorebackup|teste");
            Network.SendMessage(player,"timescale|"+ self.TimeActualScale);
            if(self.canahss == 0)
            {
                Network.SendMessage(player, "canahssoff|teste");
            }
            elif(self.canahss == 1)
            {
                Network.SendMessage(player, "canahsson|teste");
            }
            if(self.canapg == 0)
            {
                Network.SendMessage(player, "canapgoff|teste");
            }
            elif(self.canapg == 1)
            {
                Network.SendMessage(player, "canapgon|teste");
            }
            if(self.cants == 0)
            {
                Network.SendMessage(player, "cantsoff|teste");
            }
            elif(Main.cants == 1)
            {
                Network.SendMessage(player, "cantson|teste");
            }
            if(self.titanophobiac == 1)
            {
                Network.SendMessage(player, "PhobiaCutscene2");
            }
        }

    }

    function OnNetworkMessage(sender, message)
    {
        rpc = NetworkRPC(message);

        if (MissionSupply.OnNetworkMessage(rpc))
        {

        }
        elif(rpc.Call == "safecombine")
        {
            if (self.horda == 1 && self.titanophobiac == 1)
            {
                self.horda = 0;
                self.acting = 0;
                random = Random.RandomInt(0, 3);
                if(random == 0)
                {
                    if(UI.GetLanguage() != "PT-BR")
                    {
                    text = Titanophobia.ingametexten.Get(0);
                    }
                    else
                    {
                    text = Titanophobia.ingametextptbr.Get(0);
                    }
                }
                elif(random == 1)
                {
                    if(UI.GetLanguage() != "PT-BR")
                    {
                    text = Titanophobia.ingametexten.Get(1);
                    }
                    else
                    {
                    text = Titanophobia.ingametextptbr.Get(1);
                    }
                }
                elif(random == 2)
                {
                    if(UI.GetLanguage() != "PT-BR")
                    {
                    text = Titanophobia.ingametexten.Get(2);
                    }
                    else
                    {
                    text = Titanophobia.ingametextptbr.Get(2);
                    }
                }
                Game.PrintAll("<color=#FFFF00> ♟Ymir 「" + text + "」</color>");
                self.DialogTextAll("Ymir1", "Ymir", text);
                if(self.phobia == 1 && self.phobia == 2 && self.phobia == 3 && self.phobia == 4 && self.phobia == 5 && self.phobia == 6)
                {
                    random = Random.RandomInt(1,3);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Normal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 15000;
                    self.phobiatitan.Health = 15000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Abnormal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 12000;
                    self.phobiatitan.Health = 12000;
                    }
                }
                elif(self.phobia == 7 && self.phobia == 8 && self.phobia == 9)
                {
                    random = Random.RandomInt(1,5);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Normal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 15000;
                    self.phobiatitan.Health = 15000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Abnormal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 12000;
                    self.phobiatitan.Health = 12000;
                    }
                    if (random == 3)
                    {
                    self.phobiatitan = Game.SpawnTitan("Crawler");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 8000;
                    self.phobiatitan.Health = 8000;
                    }
                    if (random == 4)
                    {
                    self.phobiatitan = Game.SpawnTitan("Punk");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 10000;
                    self.phobiatitan.Health = 10000;
                    }
                }
                elif(self.phobia == 14 && self.phobia == 13 && self.phobia == 12 && self.phobia == 11 && self.phobia == 10)
                {
                    random = Random.RandomInt(1,5);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Normal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 15000;
                    self.phobiatitan.Health = 15000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Abnormal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 12000;
                    self.phobiatitan.Health = 12000;
                    }
                    if (random == 3)
                    {
                    self.phobiatitan = Game.SpawnTitan("Crawler");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 8000;
                    self.phobiatitan.Health = 8000;
                    }
                    if (random == 4)
                    {
                    self.phobiatitan = Game.SpawnTitan("Punk");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 10000;
                    self.phobiatitan.Health = 10000;
                    }
                    if (random == 5)
                    {
                    self.phobiatitan = Game.SpawnTitan("Thrower");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 10000;
                    self.phobiatitan.Health = 10000;
                    }
                }
                elif(self.phobia == 15 || self.phobia == 16)
                {
                    random = Random.RandomInt(1,4);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Thrower");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 12000;
                    self.phobiatitan.Health = 12000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Punk");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 15000;
                    self.phobiatitan.Health = 15000;
                    }
                    if (random == 3)
                    {
                        self.phobiatitan = Game.SpawnShifter("Annie");
                        self.phobiatitan.MaxHealth = 500;
                        self.phobiatitan.Health = 500;
                    }
                }
            }
        }
        elif(rpc.Call == "badcombine")
        {
            if (self.horda == 1 && self.titanophobiac == 1)
            {
                self.horda = 0;
                self.acting = 0;
                self.wrongcombine = 1;
                random = Random.RandomInt(0, 3);
                if(random == 0)
                {
                    if(UI.GetLanguage() != "PT-BR")
                    {
                    text = Titanophobia.ingametexten.Get(3);
                    }
                    else
                    {
                    text = Titanophobia.ingametextptbr.Get(3);
                    }
                }
                elif(random == 1)
                {
                    if(UI.GetLanguage() != "PT-BR")
                    {
                    text = Titanophobia.ingametexten.Get(4);
                    }
                    else
                    {
                    text = Titanophobia.ingametextptbr.Get(4);
                    }
                }
                elif(random == 2)
                {
                    if(UI.GetLanguage() != "PT-BR")
                    {
                    text = Titanophobia.ingametexten.Get(5);
                    }
                    else
                    {
                    text = Titanophobia.ingametextptbr.Get(5);
                    }
                }
                Game.PrintAll("<color=#FF0000> ♟Ymir 「" + text + "」</color>");
                self.DialogTextAll("Ymir1", "Ymir", text);
                if(self.phobia == 1 && self.phobia == 2 && self.phobia == 3 && self.phobia == 4 && self.phobia == 5 && self.phobia == 6)
                {
                    random = Random.RandomInt(1,3);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Normal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 25000;
                    self.phobiatitan.Health = 25000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Abnormal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 22000;
                    self.phobiatitan.Health = 22000;
                    }
                    random = Random.RandomInt(1,3);
                    if (random == 1)
                    {
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    }
                    if (random == 2)
                    {
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Crawler");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    }
                }
                elif(self.phobia == 7 && self.phobia == 8 && self.phobia == 9)
                {
                    random = Random.RandomInt(1,5);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Normal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 25000;
                    self.phobiatitan.Health = 25000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Abnormal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 22000;
                    self.phobiatitan.Health = 22000;
                    }
                    if (random == 3)
                    {
                    self.phobiatitan = Game.SpawnTitan("Crawler");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 18000;
                    self.phobiatitan.Health = 18000;
                    }
                    if (random == 4)
                    {
                    self.phobiatitan = Game.SpawnTitan("Punk");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 20000;
                    self.phobiatitan.Health = 20000;
                    }
                    random = Random.RandomInt(1,3);
                    if (random == 1)
                    {
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Thrower");
                    titan = Game.SpawnTitan("Abnormal");
                    }
                    if (random == 2)
                    {
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Thrower");
                    titan = Game.SpawnTitan("Crawler");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    }
                }
                elif(self.phobia == 14 && self.phobia == 13 && self.phobia == 12 && self.phobia == 11 && self.phobia == 10)
                {
                    random = Random.RandomInt(1,5);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Normal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 25000;
                    self.phobiatitan.Health = 25000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Abnormal");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 22000;
                    self.phobiatitan.Health = 22000;
                    }
                    if (random == 3)
                    {
                    self.phobiatitan = Game.SpawnTitan("Crawler");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 18000;
                    self.phobiatitan.Health = 18000;
                    }
                    if (random == 4)
                    {
                    self.phobiatitan = Game.SpawnTitan("Punk");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 20000;
                    self.phobiatitan.Health = 20000;
                    }
                    if (random == 5)
                    {
                    self.phobiatitan = Game.SpawnTitan("Thrower");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 20000;
                    self.phobiatitan.Health = 20000;
                    }
                    random = Random.RandomInt(1,3);
                    if (random == 1)
                    {
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Thrower");
                    titan = Game.SpawnTitan("Abnormal");
                    }
                    if (random == 2)
                    {
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Thrower");
                    titan = Game.SpawnTitan("Crawler");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    }
                }
                elif(self.phobia == 15 || self.phobia == 16)
                {
                    random = Random.RandomInt(1,4);
                    if (random == 1)
                    {
                    self.phobiatitan = Game.SpawnTitan("Thrower");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 22000;
                    self.phobiatitan.Health = 22000;
                    }
                    if (random == 2)
                    {
                    self.phobiatitan = Game.SpawnTitan("Punk");
                    self.phobiatitan.Size = 3.5;
                    self.phobiatitan.MaxHealth = 25000;
                    self.phobiatitan.Health = 25000;
                    }
                    if (random == 3)
                    {
                        self.phobiatitan = Game.SpawnShifter("Annie");
                        self.phobiatitan.MaxHealth = 1000;
                        self.phobiatitan.Health = 1000;
                    }
                    random = Random.RandomInt(1,3);
                    if (random == 1)
                    {
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Punk");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    }
                    if (random == 2)
                    {
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Abnormal");
                    titan = Game.SpawnTitan("Crawler");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    titan = Game.SpawnTitan("Normal");
                    }
                }
            }
        }
        elif(rpc.Call == "sickness")
        {
            self.sick = Network.MyPlayer;
            self.sickness = 20;
        }
        elif(rpc.Call == "radiated")
        {
            for (player in Network.Players)
            {
                if (player.ID == rpc.Args.Get(0))
                {
                    player.Character.Reveal(15);
                    if (player == Network.MyPlayer)
                    {
                        self.radiated = player;
                        self.radiation = 15;
                    }
                }
            }
        }
        elif(rpc.Call == "lorebackup")
        {
            Menu.LoreInitial();
        }
        elif(rpc.Call == "lore")
        {
            content = String.Replace(message, "lore|", "");
            Menu.Lore(content);
        }
        elif(rpc.Call == "canahsson")
        {
            self.canahss = 1;
        }
        elif(rpc.Call == "canapgon")
        {
            self.canapg = 1;
        }
        elif(rpc.Call == "cantson")
        {
            self.cants = 1;
        }
        elif(rpc.Call == "canahssoff")
        {
            self.canahss = 0;
        }
        elif(rpc.Call == "canapgoff")
        {
            self.canapg = 0;
        }
        elif(rpc.Call == "cantsoff")
        {
            self.cants = 0;
        }
        elif(rpc.Call == "PAUSE")
        {
            Time.TimeScale = 0.2;
            self.TimeActualScale = Time.TimeScale;
        }
        elif(rpc.Call == "UNPAUSE")
        {
            Time.TimeScale = 1.0;
            self.TimeActualScale = Time.TimeScale;
        }
        elif(rpc.Call == "timescale")
        {
            Time.TimeScale = Convert.ToFloat(rpc.GetString(0));
        }
        elif(rpc.Call == "ADDPLAYERHEALTH")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.MaxHealth += 10;
            }
        }
        elif(rpc.Call == "SUBPLAYERHEALTH")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.MaxHealth -= 10;
            }
        }
        elif(rpc.Call == "REFILLP")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.CurrentGas = Network.MyPlayer.Character.MaxGas;
            Network.MyPlayer.Character.CurrentBlade = Network.MyPlayer.Character.MaxBlade;
            Network.MyPlayer.Character.CurrentBladeDurability = Network.MyPlayer.Character.MaxBladeDurability;
            Network.MyPlayer.Character.CurrentAmmoLeft = Network.MyPlayer.Character.MaxAmmoTotal;
            Network.MyPlayer.Character.CurrentAmmoRound = Network.MyPlayer.Character.MaxAmmoRound;
            }
        }
        elif(rpc.Call == "BLADEP")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.SetWeapon("Blade");
            Network.SendMessage(Network.MyPlayer, "REFILLP");
            }
        }
        elif(rpc.Call == "AHSSP")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.SetWeapon("AHSS");
            Network.SendMessage(Network.MyPlayer, "REFILLP");
            }
        }
        elif(rpc.Call == "APGP")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.SetWeapon("APG");
            Network.SendMessage(Network.MyPlayer, "REFILLP");
            }
        }
        elif(rpc.Call == "TSP")
        {
            if (Network.MyPlayer.Character != null)
            {
            Network.MyPlayer.Character.SetWeapon("Thunderspear");
            Network.SendMessage(Network.MyPlayer, "REFILLP");
            }
        }
        elif(rpc.Call == "SUPPLYP")
        {
            Network.MyPlayer.Character.SetSpecial("Supply");
        }
        elif(rpc.Call == "ERENP")
        {
            Network.MyPlayer.Character.SetSpecial("Eren");
            Network.MyPlayer.Character.SpecialCooldown(30.0);
        }
        elif(rpc.Call == "ANNIEP")
        {
            Network.MyPlayer.Character.SetSpecial("Annie");
            Network.MyPlayer.Character.SpecialCooldown(30.0);
        }
        elif (rpc.Call == "CutsceneDialog")
        {
            icon = rpc.GetString(0);
            name = rpc.GetString(1);
            text = rpc.GetString(2);

            self.DialogText(icon, name, text);
        }
        elif (rpc.Call == "fatalcol")
        {
            x =  rpc.GetInt(0);
            if (x == "1") { self.fatalcollision = 1; }
            if (x == "0") { self.fatalcollision = 0; }
        }
        elif (rpc.Call == "fatal")
        {
            x =  rpc.GetInt(0);
            if (x == "1") { self.fataldelta = 0100.0; }
            if (x == "2") { self.fataldelta = 0150.0; }
            if (x == "3") { self.fataldelta = 0200.0; }
            if (x == "4") { self.fataldelta = 0250.0; }
            if (x == "5") { self.fataldelta = 0300.0; }
            if (x == "6") { self.fataldelta = 0400.0; }
            if (x == "7") { self.fataldelta = 0500.0; }
            if (x == "8") { self.fataldelta = 1000.0; }
        }
        elif (rpc.Call == "tp")
        {
            pos = rpc.GetVector3(0);
            if (Network.MyPlayer.Character != null)
            {
                Network.MyPlayer.Character.Position = pos;
            }
        }
        elif (rpc.Call == "air")
        {
            pos = rpc.GetVector3(0);

            if (Network.MyPlayer.Character != null)
            {
                p_x = Network.MyPlayer.Character.Position.X;
                p_y = Network.MyPlayer.Character.Position.Y;
                p_z = Network.MyPlayer.Character.Position.Z;

                if (p_x <  1030.0 && p_x >  1000.0 &&
                    p_y <  620.0  && p_y >  595.0  &&
                    p_z < -3470.0 && p_z > -3510.0 )
                {
                    Network.MyPlayer.Character.Position = pos;
                }
            }
        }
        elif (rpc.Call == "con")
        {
            self.cutdialog = true;
        }
        elif (rpc.Call == "coff")
        {
            self.cutdialog = false;
        }
        elif (rpc.Call == "prf")
        {
            Cutscene.Start("FMUTGCutscene", true);
        }
        elif (rpc.Call == "PhobiaCutscene")
        {
            Cutscene.Start("PhobiaCutscene", true);
        }
    }

    function DialogText(icon, name, text)
    {
        DialogVariables.Icon = icon;
        DialogVariables.Name = name;
        DialogVariables.Text = text;

        Cutscene.Start("CutsceneDialog", false);
    }

    function DialogTextAll(icon, name, text)
    {
        message = NetworkMessage("CutsceneDialog", null);

        message.AddArgument(icon);
        message.AddArgument(name);
        message.AddArgument(text);

        message.SendAll();
    }

    function OnChatInput(message)
    {
        msg = message;
        if (String.StartsWith(msg, "combine"))
        {
            defaultCommand = false;
            typedcode = String.Replace(message, "combine", "");
            typedcode = String.Replace(message, " ", "");
            if (String.Contains(msg, self.phobiacode))
            {
                Network.SendMessage(Network.MasterClient,"safecombine|" + typedcode);
            }
            else
            {
                Network.SendMessage(Network.MasterClient,"badcombine|" + typedcode);
            }
        }
        if (String.StartsWith(msg, "/"))
        {
            defaultCommand = false;
            if (String.StartsWith(msg, "/d"))
            {
                color = "00FF00";
                message = String.Replace(message, "/d", "");
                num = Convert.ToInt(message);
                roll = Random.RandomInt(1, num + 1);
                num3 = (Convert.ToFloat(roll) / Convert.ToFloat(num));

                if (num3 <= 0.25)
                {
                    color = "FF0000";
                }
                elif (num3 <= 0.5)
                {
                    color = "FF8C00";
                }
                elif (num3 <= 0.75)
                {
                    color = "FFFF00";
                }

                Game.PrintAll("<b>" + Network.MyPlayer.Name + "<color=#00FF00>「</color><color=#FFFFFF> rolled a D" + num + ": (<color=#" + color + ">" + roll + "</color>) </color><color=#00FF00>」</color></b>");

            }
            elif (!Network.IsMasterClient)
            {
                if (String.StartsWith(msg, "/npc"))
                {
                    text = String.Replace(msg, "/npc ", "");
                    split = String.Split(text, " ", true);
                    spritetext = Convert.ToString(split.Get(0));
                    cutname = Convert.ToString(split.Get(1));
                    split.RemoveAt(0);
                    split.RemoveAt(0);
                    text = String.Join(split, " ");

                    Game.PrintAll("<color=#6495ED> ♟</color><color=#6495ED>" + cutname + " 「" + text + "」</color>");
                    self.DialogTextAll(spritetext, cutname, text);
                }
            }
            elif (Network.IsMasterClient)
            {
                if (MissionSupply.OnChatInput(message))
                {
                }
                elif (msg == "/tied")
                {
                    for (character in Game.Humans)
                    {
                        if ((Network.MyPlayer.Character.Position - character.Position).Magnitude < 5.1)
                        {
                            self.carryguy = character;
                            self.tied = true;
                        }
                    }
                }
                elif (msg == "/tiedoff")
                {
                    self.tied = false;
                    self.carryguy = null;
                }
                elif (String.StartsWith(msg, "/lr"))
                {
                    text = String.Replace(msg, "/lr ", "");
                    Menu.Lore(text);
                    Network.SendMessageOthers("lore|" + text);
                }
                elif (String.StartsWith(msg, "/ts"))
                {
                    text = String.Replace(msg, "/ts ", "");
                    Game.PrintAll("<color=#DAA520> ➽</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (String.StartsWith(msg, "/wn"))
                {
                    text = String.Replace(msg, "/wn ", "");
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (String.StartsWith(msg, "/vp"))
                {
                    text = String.Replace(msg, "/vp ", "");
                    Game.PrintAll("<color=#00FF00> ☑</color><color=#00FF00>「</color>" + text + "<color=#00FF00>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#00FF00> ☑</color><color=#00FF00>「</color><color=#FFFFFF>" + text + "</color><color=#00FF00>」</color>");
                }
                elif (String.StartsWith(msg, "/pr"))
                {
                    text = String.Replace(msg, "/pr ", "");
                    Game.PrintAll("<color=#FF0000> ☠</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF0000> ☠</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (String.StartsWith(msg, "/sdm"))
                {
                    text = String.Replace(msg, "/sdm ", "");
                    Game.PrintAll("<color=#00AA00> ♟</color><color=#00AA00>「" + text + "」</color>");
                    self.DialogTextAll("Gunther1", "Soldier / Soldado", "<color=#00AA00> ♟</color><color=#00AA00>「<color=#FFFFFF>" + text + "</color>」</color>");
                }
                elif (String.StartsWith(msg, "/sdf"))
                {
                    text = String.Replace(msg, "/sdf ", "");
                    Game.PrintAll("<color=#00AA00> ♟</color><color=#00AA00>「" + text + "」</color>");
                    self.DialogTextAll("Ilse1", "Soldier / Soldado", "<color=#6495ED> ♟</color><color=#6495ED>「<color=#FFFFFF>" + text + "</color>」</color>");
                }
                elif (String.StartsWith(msg, "/npc"))
                {
                    text = String.Replace(msg, "/npc ", "");
                    split = String.Split(text, " ", true);
                    spritetext = Convert.ToString(split.Get(0));
                    cutname = Convert.ToString(split.Get(1));
                    split.RemoveAt(0);
                    split.RemoveAt(0);
                    text = String.Join(split, " ");

                    Game.PrintAll("<color=#6495ED> ♟</color><color=#6495ED>" + cutname + " 「" + text + "」</color>");
                    self.DialogTextAll(spritetext, cutname, text);
                }
                elif (String.StartsWith(msg, "/npm"))
                {
                    text = String.Replace(msg, "/npm ", "");
                    Game.PrintAll("<color=#6495ED> ♟</color><color=#6495ED>「" + text + "」</color>");
                    self.DialogTextAll("Nick1", "NPC", "<color=#6495ED> ♟</color><color=#6495ED>「<color=#FFFFFF>" + text + "</color>」</color>");
                }
                elif (String.StartsWith(msg, "/npf"))
                {
                    text = String.Replace(msg, "/npf ", "");
                    Game.PrintAll("<color=#6495ED> ♟</color><color=#6495ED>「" + text + "」</color>");
                    self.DialogTextAll("Carula1", "NPC", "<color=#6495ED> ♟</color><color=#6495ED>「<color=#FFFFFF>" + text + "</color>」</color>");
                }
                elif (String.StartsWith(msg, "/enm"))
                {
                    text = String.Replace(msg, "/enm", "");
                    Game.PrintAll("<color=#AA0000> ♟</color><color=#AA0000>「" + text + "」</color>");
                    self.DialogTextAll("Kenny2", "Enemy / Inimigo", "<color=#AA0000> ♟</color><color=#AA0000>「<color=#FFFFFF>" + text + "</color>」</color>");
                }
                elif (String.StartsWith(msg, "/enf"))
                {
                    text = String.Replace(msg, "/enf ", "");
                    Game.PrintAll("<color=#AA0000> ♟</color><color=#AA0000>「" + text + "」</color>");
                    self.DialogTextAll("Yelena2", "Enemy / Inimigo", "<color=#AA0000> ♟</color><color=#AA0000>「<color=#FFFFFF>" + text + "</color>」</color>");
                }
                elif (msg == "/tk")
                {
                    Game.PrintAll("<b><color=#00FF00> TATAKAEEE!</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "TATAKAEEE!");
                }
                elif (msg == "/prp")
                {
                    Game.PrintAll("<b><color=#FFFF00> PREPARAR! PREPARE! ♜</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "PREPARAR! PREPARE!");
                }
                elif (msg == "/atk")
                {
                    Game.PrintAll("<b><color=#FF0000> ATACAR! ATTACK! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "ATTACK! ATACAR!");
                }
                elif (msg == "/al")
                {
                    Game.PrintAll("<b><color=#FF8C00> ALERTA/SUBIR! | ALERT/MOVE UP! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "ALERT, MOVE UP! ALERTA, SUBAM!");
                }
                elif (msg == "/can")
                {
                    Game.PrintAll("<b><color=#FFFF00> USE CANHÃO | USE CANNON! ♟</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "USE CANNON! USE O CANHÃO!");
                }
                elif (msg == "/fr")
                {
                    Game.PrintAll("<b><color=#FFFF00> FOGO | FIRE! ➼ ➼ ➼</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "FIRE! FOGOOO!");
                }
                elif (msg == "/pp")
                {
                    Game.PrintAll("<b><color=#FFFF00> PROSSEGUIR! PROCEED! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "PROCEED! PROSSEGUIR!");
                }
                elif (msg == "/ag")
                {
                    Game.PrintAll("<b><color=#FFFF00> ESPERE! WAIT! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "WAIT! ESPERE!");
                }
                elif (msg == "/l")
                {
                    Game.PrintAll("<b><color=#00FF00> AREA LIMPA! SECTOR CLEAR! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "AREA LIMPA! SECTOR CLEAR!");
                }
                elif (msg == "/s")
                {
                    Game.PrintAll("<b><color=#00FF00> SUSUME! AVANÇAR! FOWARD! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SUSUMEEE! FOWARD! AVANÇAAAR!");
                }
                elif (msg == "/ss")
                {
                    Game.PrintAll("<b><color=#00FF00> SHINZO WO SASAGEYO! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SHINZO WO SASAGEYO!");
                }
                elif (msg == "/rg")
                {
                    Game.PrintAll("<b><color=#8A2BE2> REAGRUPAR! REGROUP! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "REAGRUPAR! REGROUP!");
                }
                elif (msg == "/r")
                {
                    Game.PrintAll("<b><color=#00FF00> RECARREGAR! RECHARGE! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "RECARREGAR! RECHARGE!");
                }
                elif (msg == "/ap")
                {
                    Game.PrintAll("<b><color=#FF0000> PERIGO! | DANGER! ☠ ☢ ☣</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "DANGER! PERIGO! ☠ ☢ ☣");
                }
                elif (msg == "/sos")
                {
                    Game.PrintAll("<b><color=#FF0000> AJUDA! HELP! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "AJUDA! HELP!");
                }
                elif (msg == "/rc")
                {
                    Game.PrintAll("<b><color=#FF8C00> RECUAR! | BACK OFF! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "RECUAR! BACK OFF!");
                }
                elif (msg == "/ff")
                {
                    Game.PrintAll("<b><color=#FF8C00> FERIDO! | WOUNDED SOLDIER! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "WOUNDED SOLDIER! SOLDADO FERIDO!");
                }
                elif (msg == "/bar")
                {
                    Game.PrintAll("<b><color=#FF8C00> BARULHO! NOISE! ♫</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "BARULHO! NOISE!");
                }
                elif (msg == "/barr")
                {
                    Game.PrintAll("<b><color=#FF8C00> BARULHO ALTO! LOUD NOISE! ♫</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "BARULHO ALTO! LOUD NOISE!");
                }
                elif (msg == "/pt")
                {
                    Game.PrintAll("<b><color=#FF8C00> DEFENDER POSIÇÃO! DEFEND POSITION! ♜</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "DEFENDER POSIÇÃO! DEFEND POSITION!");
                }
                elif (msg == "/cv")
                {
                    Game.PrintAll("<b><color=#FF8C00> CUBRAM-SE! TAKE COVER! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "CUBRAM-SE! TAKE COVER!");
                }
                elif (msg == "/cbt")
                {
                    Game.PrintAll("<b><color=#FFFF00> COMBATE! COMBAT! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "COMBATE! COMBAT!");
                }
                elif (msg == "/nc")
                {
                    Game.PrintAll("<b><color=#FFFF00> SEM COMBATE! NO COMBAT! ♞</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SEM COMBATE! NO COMBAT!");
                }
                elif (msg == "/gg")
                {
                    Game.PrintAll("<b><color=#FF8C00> GRITOS! | SCREAM! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "GRITOS! SCREAM!");
                }
                elif (msg == "/ae")
                {
                    Game.PrintAll("<b><color=#00FF00> ELIMINADO! TARGET ELIMINATED! ☠</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "ELIMINADO! TARGET ELIMINATED!");
                }
                elif (msg == "/at")
                {
                    Game.PrintAll("<b><color=#FFFF00> ATENÇÃO! ATENTION! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "ATENÇÃO! ATENTION!");
                }
                elif (msg == "/f1")
                {
                    Game.PrintAll("<b><color=#FFFF00> FORMAÇÃO! MAINTAIN SQUAD! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "FORMAÇÃO! MAINTAIN SQUAD!");
                }
                elif (msg == "/f2")
                {
                    Game.PrintAll("<b><color=#FFFF00> DISTRAÇÃO! USE DISTRACTION! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "DISTRAÇÃO! USE DISTRACTION!");
                }
                elif (msg == "/f3")
                {
                    Game.PrintAll("<b><color=#FFFF00> SEM DMT! NO ODG! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SEM DMT! NO ODF!");
                }
                elif (msg == "/f4")
                {
                    Game.PrintAll("<b><color=#FFFF00> SEPARAR! DISPERSE! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SEPARAR! DISPERSE!");
                }
                elif (msg == "/f5")
                {
                    Game.PrintAll("<b><color=#FFFF00> AOS CAVALOS! TO HORSES! ♞</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "AOS CAVALOS! TO HORSES!");
                }
                elif (msg == "/f6")
                {
                    Game.PrintAll("<b><color=#FFFF00> CURAR! HEAL ALLIES!<b><color=#FF0000> ✙</color></b></color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "CURAR! HEAL ALLIES!");
                }
                elif (msg == "/f7")
                {
                    Game.PrintAll("<b><color=#FFFF00> DESVIE! AVOID! ♞</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "DESVIE! AVOID!");
                }
                elif (msg == "/f8")
                {
                    Game.PrintAll("<b><color=#FF0000> SACRIFICAR! SACRIFICE!<b><color=#FF0000> ☠</color></b></color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SACRIFICAR! SACRIFICE!");
                }
                elif (msg == "/F9")
                {
                    Game.PrintAll("<b><color=#FFFF00> CORRAM! RUN!<b><color=#FF0000> ☠</color></b></color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "CORRAM! RUN!");
                }
                elif (msg == "/f")
                {
                    Game.PrintAll("<b><color=#FFFF00> SIGA! | FOLLOW! ✦</color></b>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "SIGA! FOLLOW!");
                }
                elif (msg == "/rr")      { Game.End(0.0); }
                elif (msg == "/restart") { Game.End(0.0); }
                elif (msg == "/n")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 50.0);
                }
                elif (msg == "/s")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 50.0);
                }
                elif (msg == "/e")
                {
                    self.pointer = Vector3(self.pointer.X + 50.0, self.pointer.Y,self.pointer.Z);
                }
                elif (msg == "/w")
                {
                    self.pointer = Vector3(self.pointer.X - 50.0, self.pointer.Y,self.pointer.Z);
                }
                elif (msg == "/n+")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 100.0);
                }
                elif (msg == "/s+")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 100.0);
                }
                elif (msg == "/e+")
                {
                    self.pointer = Vector3(self.pointer.X + 100.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/w+")
                {
                    self.pointer = Vector3(self.pointer.X - 100.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/n++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 200.0);
                }
                elif (msg == "/s++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 200.0);
                }
                elif (msg == "/e++")
                {
                    self.pointer = Vector3(self.pointer.X + 200.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/w++")
                {
                    self.pointer = Vector3(self.pointer.X - 200.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/n+++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 300.0);
                }
                elif (msg == "/s+++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 300.0);
                }
                elif (msg == "/e+++")
                {
                    self.pointer = Vector3(self.pointer.X + 300.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/w+++")
                {
                    self.pointer = Vector3(self.pointer.X - 300.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/n++++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 1000.0);
                }
                elif (msg == "/s++++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 1000.0);
                }
                elif (msg == "/e++++")
                {
                    self.pointer = Vector3(self.pointer.X + 1000.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/w++++")
                {
                    self.pointer = Vector3(self.pointer.X - 1000.0, self.pointer.Y, self.pointer.Z);
                }
                elif (msg == "/n+++++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z + 5000.0);
                }
                elif (msg == "/s+++++")
                {
                    self.pointer = Vector3(self.pointer.X, self.pointer.Y, self.pointer.Z - 5000.0);
                }
                elif (msg == "/e+++++")
                {
                    self.pointer = Vector3(self.pointer.X + 5000.0, self.pointer.Y,self.pointer.Z);
                }
                elif (msg == "/w+++++")
                {
                    self.pointer = Vector3(self.pointer.X - 5000.0, self.pointer.Y,self.pointer.Z);
                }
                elif (msg == "/up+") { self.pointer += Vector3.Up         * 50.0;   }
                elif (msg == "/up++") { self.pointer += Vector3.Up        * 100.0;  }
                elif (msg == "/up-") { self.pointer += Vector3.Down       * 50.0;   }
                elif (msg == "/up--") { self.pointer += Vector3.Down      * 100.0;  }
                elif (msg == "/p")
                {
                    if (Network.MasterClient.Character != null)
                    {
                        self.pointer = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/php")
                {
                    self.spawner = self.pointer;
                }
                elif (msg == "/ph")
                {
                    if (Network.MasterClient.Character != null)
                    {
                        self.spawner = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/pfx")
                {
                    if (Network.MasterClient.Character != null)
                    {
                        self.fxspawner = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/phobia")
                {
                    Game.PrintAll(self.phobiacode + " " + self.phobiahintcode + " " + self.phobia);
                }
                elif (String.StartsWith(msg, "/fx "))
                {
                    effect = String.Replace(msg, "/fx ", "");
                    Game.SpawnEffect(effect, self.fatalplayer.Position, Vector3(0.0,0.0,0.0), 0.5);
                }
                elif (String.StartsWith(msg, "/fxp "))
                {
                    if (Network.MasterClient.Character != null)
                    {
                        self.fxspawner = Network.MasterClient.Character.Position;
                    }
                }
                elif (String.StartsWith(msg, "/fx1"))
                {
                    self.PhobiaFX("ShifterThunder");
                }
                elif (msg == "/p1exp1")
                {
                    self.spawner = Vector3(-51132.96, 6.086243, -15055.74);
                }
                elif (msg == "/p3exp1")
                {
                    self.pointer = Vector3(1223.96, 6.0, 35123.74);
                }
                elif (msg == "/db")
                {
                    charspd = Vector3(0.0, 0.0, 0.0);
                    charspd = Network.MasterClient.Character.Position;
                }
                elif (msg == "/cp0") { self.check = 0; }
                elif (msg == "/cp1") { self.check = 1; }
                elif (msg == "/cp2") { self.check = 2; }
                elif (msg == "/cp")
                {
                    MissionSupply.Create();
                    text = "CHECKPOINT! PREPARE!";

                    Game.PrintAll("<color=#00FF00> ☑</color><color=#00FF00>「</color>" + text + "<color=#00FF00>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#00FF00> ☑</color><color=#00FF00>「</color><color=#FFFFFF>" + text + "</color><color=#00FF00>」</color>");

                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                        self.check = 2;
                    }
                    UI.SetLabel("TopCenter", "");
                }
                elif (msg == "/hon")
                {
                    self.horda = 1;
                    self.hordatimer = 8;
                }
                elif (msg == "/hoff")
                {
                    self.horda = 0;
                    self.hordatimer = 8;
                }
                elif (msg == "/1exp1")
                {
                    Game.PrintAll("<b><color=#00FF00>Starting Expedition - Dungeon!</color></b>");
                    Network.SendMessageAll("tp|" + Vector3(-72222.02, 145.5576, -15732.33));
                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/1exp2") { Network.SendMessageAll("tp|" + Vector3(-51337.73, 2.221016, -14926.21)); }
                elif (msg == "/1exp3") { Network.SendMessageAll("tp|" + Vector3(-44171.84, 1.743037, -9617.242)); }
                elif (msg == "/2exp1")
                {
                    Game.PrintAll("<b><color=#00FF00>Starting Expedition - Way to Utgard!</color></b>");
                    Network.SendMessageAll("tp|" + Vector3(0 - 17737.11, 100.0, -836.513));
                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/2exp2") { Network.SendMessageAll("tp|" + Vector3(-13745.29, 50.77701, -5312.134)); }
                elif (msg == "/2exp3") { Network.SendMessageAll("tp|" + Vector3(-16143.6, 150.4161, -6086.652)); }
                elif (msg == "/3exp1")
                {
                    Game.PrintAll("<b><color=#00FF00>Starting Expedition - Etheria!</color></b>");
                    Network.SendMessageAll("tp|" + Vector3(10751.0, 4.0, 35507.0));
                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/3exp2") { Network.SendMessageAll("tp|" + Vector3(5931.29   , 4.0      , 35298.134     )); }
                elif (msg == "/3exp3") { Network.SendMessageAll("tp|" + Vector3(554.6     , 4.4161   , 35094.652   )); }
                elif (msg == "/3exp4") { Network.SendMessageAll("tp|" + Vector3(1659.6    , 3050.4161, 35659.652)); }
                elif (msg == "/3exp5") { Network.SendMessageAll("tp|" + Vector3(-3261.6, 4565.4161, 35082.652)); }
                elif (msg == "/3exp6") { Network.SendMessageAll("tp|" + Vector3(9337.6    , 4.4161   , 34817.652   )); }
                elif (msg == "/3exp7") { Network.SendMessageAll("tp|" + Vector3(915.6     , 6.4161   , 35112.652   )); }
                elif (msg == "/4exp1")
                {
                    Game.PrintAll("<b><color=#00FF00>Starting Expedition - Missing Docs or Blue Rocks!</color></b>");
                    Network.SendMessageAll("tp|" + Vector3(11526.0, 51.0, 0.0));
                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/4exp2") { Network.SendMessageAll("tp|" + Vector3(11139.29, 90.0, -2696.0)); }
                elif (msg == "/4exp3") { Network.SendMessageAll("tp|" + Vector3(9222.0, 157.0, -7325.0)); }
                elif (msg == "/5exp1")
                {
                    Game.PrintAll("<b><color=#00FF00>Starting Expedition - Diary!</color></b>");
                    Network.SendMessageAll("tp|" + Vector3(378.0, 5.0, -3729.0));
                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/5exp2") { Network.SendMessageAll("tp|" + Vector3(-65.0, 22.0, -518.0)); }
                elif (msg == "/5exp3") { Network.SendMessageAll("tp|" + Vector3(-88.0, 6.0, 3044.0)); }
                elif (msg == "/6exp1")
                {
                    Game.PrintAll("<b><color=#00FF00>Outside the Walls in Realism!</color></b>");
                    Network.SendMessageAll("tp|" + Vector3(-2601.0, 1.0, -4824.0));
                    if (Network.MasterClient.Character != null)
                    {
                        self.resppoint = Network.MasterClient.Character.Position;
                    }
                }
                elif (msg == "/6exp2") { Network.SendMessageAll("tp|" + Vector3(-233.0, 2.040314, -2003.0)); }
                elif (msg == "/6exp3") { Network.SendMessageAll("tp|" + Vector3(1748.288, 1105.8622, -1517.0)); }
                elif (msg == "/tp")
                {
                    Network.SendMessageAll("tp|" + self.pointer);
                }
                elif (msg == "/tp0p")
                {
                    if (Network.MasterClient.Character != null)
                    {
                        Network.MasterClient.Character.Position = self.pointer;
                    }
                }
                elif (msg == "/tp0")
                {
                    self.pointer2 = Network.MasterClient.Character.Position;
                    Network.SendMessageAll("tp|" + self.pointer2);
                }
                elif (msg == "/air")
                {
                    self.pointer2 = Network.MasterClient.Character.Position;
                    Network.SendMessageAll("air|" + self.pointer2);
                }
                elif (msg == "/air2")
                {
                    self.pointer2 = Network.MasterClient.Character.Position;
                    Game.SpawnPlayerAtAll(false, self.pointer2);
                }
                elif (msg == "/fton")
                {
                    self.fatalcollision = 1;
                    Network.SendMessageAll("fatalcol|" + "1");
                    text = "Realism Mode ON";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ftoff")
                {
                    self.fatalcollision = 0;
                    Network.SendMessageAll("fatalcol|" + "0");
                    text = "Realism Mode OFF";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/un")
                {
                    myCharacter = Network.MyPlayer.Character;
                    if (myCharacter != null)
                    {
                        special = myCharacter.CurrentSpecial;
                        myCharacter.SetSpecial("Escape");
                        myCharacter.ActivateSpecial();
                    }
                }
                elif (msg == "/ft1")
                {
                    self.fataldelta = 80.0;
                    Network.SendMessageAll("fatal|" + "1");
                    text = "Adrenaline Level = 0.8K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ft2")
                {
                    self.fataldelta = 100.0;
                    Network.SendMessageAll("fatal|" + "2");
                    text = "Adrenaline Level = 1K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ft3")
                {
                    self.fataldelta = 120.0;
                    Network.SendMessageAll("fatal|" + "3");
                    text = "Adrenaline Level = 1.2K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ft4")
                {
                    self.fataldelta = 150.0;
                    Network.SendMessageAll("fatal|" + "4");
                    text = "Adrenaline Level = 1.5K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ft5")
                {
                    self.fataldelta = 200.0;
                    Network.SendMessageAll("fatal|" + "5");
                    text = "Adrenaline Level = 2K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ft6")
                {
                    self.fataldelta = 250.0;
                    Network.SendMessageAll("fatal|" + "6");
                    text = "Adrenaline Level = 2.5K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ft7")
                {
                    self.fataldelta = 300.0;
                    Network.SendMessageAll("fatal|" + "7");
                    text = "Adrenaline Level = 3K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/ftm")
                {
                    self.fataldelta = 400.0;
                    Network.SendMessageAll("fatal|" + "8");
                    text = "Adrenaline Level = 4K";
                    Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
                    self.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
                }
                elif (msg == "/fm")
                {
                    Game.SpawnShifterAt("Annie", self.pointer);
                }
                elif (msg == "/fm500")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 500;
                    annie.Health = 500;
                }
                elif (msg == "/fm1k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 1000;
                    annie.Health = 1000;
                }
                elif (msg == "/fm2k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 2000;
                    annie.Health = 2000;
                }
                elif (msg == "/fm3k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 3000;
                    annie.Health = 3000;
                }
                elif (msg == "/fm5k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 5000;
                    annie.Health = 5000;
                }
                elif (msg == "/fm10k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 10000;
                    annie.Health = 10000;
                }
                elif (msg == "/fm15k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 15000;
                    annie.Health = 15000;
                }
                elif (msg == "/fm20k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 20000;
                    annie.Health = 20000;
                }
                elif (msg == "/fm25k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 25000;
                    annie.Health = 25000;
                }
                elif (msg == "/fm30k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 30000;
                    annie.Health = 30000;
                }
                elif (msg == "/fm40k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 40000;
                    annie.Health = 40000;
                }
                elif (msg == "/fm50k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 50000;
                    annie.Health = 50000;
                }
                elif (msg == "/fm100k")
                {
                    annie = Game.SpawnShifterAt("Annie", self.pointer);
                    annie.MaxHealth = 100000;
                    annie.Health = 100000;
                }
                elif (msg == "/spp")
                {
                    var = Random.RandomInt(1, 3);
                    if (var == 1) { Game.SpawnTitanAt("Normal"  , self.pointer); }
                    if (var == 2) { Game.SpawnTitanAt("Abnormal", self.pointer); }
                }
                elif (msg == "/spp1") { Game.SpawnTitanAt("Normal"  , self.pointer); }
                elif (msg == "/spp2") { Game.SpawnTitanAt("Abnormal", self.pointer); }
                elif (msg == "/spp3") { Game.SpawnTitanAt("Punk"    , self.pointer); }
                elif (msg == "/spp4") { Game.SpawnTitanAt("Crawler" , self.pointer); }
                elif (msg == "/spp5") { Game.SpawnTitanAt("Thrower" , self.pointer); }
                elif (msg == "/spp1m")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.Size = 0.2;
                }
                elif (msg == "/spp2m")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.Size = 0.2;
                }
                elif (msg == "/spp3m")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.Size = 0.2;
                }
                elif (msg == "/spp4m")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.Size = 0.2;
                }
                elif (msg == "/spp5m")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.Size = 0.2;
                }
                elif (msg == "/spp11k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 1000;
                    titan.Health = 1000;
                }
                elif (msg == "/spp21k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 1000;
                    titan.Health = 1000;
                }
                elif (msg == "/spp31k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 1000;
                    titan.Health = 1000;
                }
                elif (msg == "/spp41k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 1000;
                    titan.Health = 1000;
                }
                elif (msg == "/spp51k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 1000;
                    titan.Health = 1000;
                }
                elif (msg == "/spp13k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 3000;
                    titan.Health = 3000;
                }
                elif (msg == "/spp23k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 3000;
                    titan.Health = 3000;
                }
                elif (msg == "/spp33k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 3000;
                    titan.Health = 3000;
                }
                elif (msg == "/spp43k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 3000;
                    titan.Health = 3000;
                }
                elif (msg == "/spp53k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 3000;
                    titan.Health = 3000;
                }
                elif (msg == "/spp15k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 5000;
                    titan.Health = 5000;
                }
                elif (msg == "/spp25k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 5000;
                    titan.Health = 5000;
                }
                elif (msg == "/spp35k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 5000;
                    titan.Health = 5000;
                }
                elif (msg == "/spp45k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 5000;
                    titan.Health = 5000;
                }
                elif (msg == "/spp55k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 5000;
                    titan.Health = 5000;
                }
                elif (msg == "/spp110k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 10000;
                    titan.Health = 10000;
                }
                elif (msg == "/spp210k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 10000;
                    titan.Health = 10000;
                }
                elif (msg == "/spp310k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 10000;
                    titan.Health = 10000;
                }
                elif (msg == "/spp410k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 10000;
                    titan.Health = 10000;
                }
                elif (msg == "/spp510k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 10000;
                    titan.Health = 10000;
                }
                elif (msg == "/spp115k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 15000;
                    titan.Health = 15000;
                }
                elif (msg == "/spp215k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 15000;
                    titan.Health = 15000;
                }
                elif (msg == "/spp315k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 15000;
                    titan.Health = 15000;
                }
                elif (msg == "/spp415k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 15000;
                    titan.Health = 15000;
                }
                elif (msg == "/spp515k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 15000;
                    titan.Health = 15000;
                }
                elif (msg == "/spp120k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 20000;
                    titan.Health = 20000;
                }
                elif (msg == "/spp220k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 20000;
                    titan.Health = 20000;
                }
                elif (msg == "/spp320k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 20000;
                    titan.Health = 20000;
                }
                elif (msg == "/spp420k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 20000;
                    titan.Health = 20000;
                }
                elif (msg == "/spp520k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 20000;
                    titan.Health = 20000;
                }
                elif (msg == "/spp130k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 30000;
                    titan.Health = 30000;
                }
                elif (msg == "/spp230k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 30000;
                    titan.Health = 30000;
                }
                elif (msg == "/spp330k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 30000;
                    titan.Health = 30000;
                }
                elif (msg == "/spp430k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 30000;
                    titan.Health = 30000;
                }
                elif (msg == "/spp530k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 30000;
                    titan.Health = 30000;
                }
                elif (msg == "/spp140k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 40000;
                    titan.Health = 40000;
                }
                elif (msg == "/spp240k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 40000;
                    titan.Health = 40000;
                }
                elif (msg == "/spp340k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 40000;
                    titan.Health = 40000;
                }
                elif (msg == "/spp440k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 40000;
                    titan.Health = 40000;
                }
                elif (msg == "/spp540k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 40000;
                    titan.Health = 40000;
                }
                elif (msg == "/spp150k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 50000;
                    titan.Health = 50000;
                }
                elif (msg == "/spp250k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 50000;
                    titan.Health = 50000;
                }
                elif (msg == "/spp350k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 50000;
                    titan.Health = 50000;
                }
                elif (msg == "/spp450k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 50000;
                    titan.Health = 50000;
                }
                elif (msg == "/spp550k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 50000;
                    titan.Health = 50000;
                }
                elif (msg == "/spp1100k")
                {
                    titan = Game.SpawnTitanAt("Normal", self.pointer);
                    titan.MaxHealth = 100000;
                    titan.Health = 100000;
                }
                elif (msg == "/spp2100k")
                {
                    titan = Game.SpawnTitanAt("Abnormal", self.pointer);
                    titan.MaxHealth = 100000;
                    titan.Health = 100000;
                }
                elif (msg == "/spp3100k")
                {
                    titan = Game.SpawnTitanAt("Punk", self.pointer);
                    titan.MaxHealth = 100000;
                    titan.Health = 100000;
                }
                elif (msg == "/spp4100k")
                {
                    titan = Game.SpawnTitanAt("Crawler", self.pointer);
                    titan.MaxHealth = 100000;
                    titan.Health = 100000;
                }
                elif (msg == "/spp5100k")
                {
                    titan = Game.SpawnTitanAt("Thrower", self.pointer);
                    titan.MaxHealth = 100000;
                    titan.Health = 100000;
                }
                elif (msg == "/spn")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X, spawnlocation.Y + 20.0, spawnlocation.Z + 250.0);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/sps")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X, spawnlocation.Y + 20.0, spawnlocation.Z - 250.0);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/spe")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X + 250.0, spawnlocation.Y + 20.0, spawnlocation.Z);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/spw")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X - 250.0, spawnlocation.Y + 20.0, spawnlocation.Z);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/spn+")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X, spawnlocation.Y + 20.0, spawnlocation.Z + 500.0);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/sps+")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X, spawnlocation.Y + 20.0, spawnlocation.Z - 500.0);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/spe+")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X + 500.0, spawnlocation.Y + 20.0, spawnlocation.Z);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/spw+")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X - 500.0, spawnlocation.Y + 20.0, spawnlocation.Z);
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/w3")
                {
                    self.waves = 3;
                    self.chase = 1;
                    self.NextWave2();
                }
                elif (msg == "/w6")
                {
                    self.waves = 6;
                    self.chase = 1;
                    self.NextWave2();
                }
                elif (msg == "/w9")
                {
                    self.waves = 9;
                    self.chase = 1;
                    self.NextWave2();
                }
                elif (msg == "/w12")
                {
                    self.waves = 12;
                    self.chase = 1;
                    self.NextWave2();
                }
                elif (msg == "/sp")
                {
                    spawnlocation = Network.MasterClient.Character.Position;
                    if (spawnlocation != null)
                    {
                        spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                        var = Random.RandomInt(1, 3);
                        if (var == 1)
                        {
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        if (var == 2)
                        {
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                    }
                }
                elif (msg == "/sprr")
                {
                    Game.SpawnTitans("Random", 100);
                }
                elif (msg == "/spa")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            var = Random.RandomInt(1, 6);
                            if (var == 1)
                            {
                                Game.SpawnTitanAt("Normal", spawnlocation);
                            }
                            if (var == 2)
                            {
                                Game.SpawnTitanAt("Abnormal", spawnlocation);
                            }
                            if (var == 3)
                            {
                                Game.SpawnTitanAt("Punk", spawnlocation);
                            }
                            if (var == 4)
                            {
                                Game.SpawnTitanAt("Crawler", spawnlocation);
                            }
                            if (var == 5)
                            {
                                Game.SpawnTitanAt("Thrower", spawnlocation);
                            }
                        }
                        break;
                    }
                }
                elif (msg == "/spon")
                {
                    self.shortwavespawn = Random.RandomInt(1, 6);
                }
                elif (msg == "/sp1")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            Game.SpawnTitanAt("Normal", spawnlocation);
                        }
                        break;
                    }
                }
                elif (msg == "/sp2")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            Game.SpawnTitanAt("Abnormal", spawnlocation);
                        }
                        break;
                    }
                }
                elif (msg == "/sp3")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            Game.SpawnTitanAt("Punk", spawnlocation);
                        }
                        break;
                    }
                }
                elif (msg == "/sp4")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            Game.SpawnTitanAt("Crawler", spawnlocation);
                        }
                        break;
                    }
                }
                elif (msg == "/sp5")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            Game.SpawnTitanAt("Thrower", spawnlocation);
                        }
                        break;
                    }
                }
                elif (msg == "/sp1m")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.Size = 0.2;
                        }
                        break;
                    }
                }
                elif (msg == "/sp2m")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.Size = 0.2;
                        }
                        break;
                    }
                }
                elif (msg == "/sp3m")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.Size = 0.2;
                        }
                        break;
                    }
                }
                elif (msg == "/sp4m")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.Size = 0.2;
                        }
                        break;
                    }
                }
                elif (msg == "/sp5m")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.Size = 0.2;
                        }
                        break;
                    }
                }
                elif (msg == "/sp11k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 1000;
                            titan.Health = 1000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp21k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 1000;
                            titan.Health = 1000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp31k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 1000;
                            titan.Health = 1000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp41k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 1000;
                            titan.Health = 1000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp51k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 1000;
                            titan.Health = 1000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp13k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 3000;
                            titan.Health = 3000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp23k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 3000;
                            titan.Health = 3000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp33k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 3000;
                            titan.Health = 3000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp43k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 3000;
                            titan.Health = 3000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp53k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 3000;
                            titan.Health = 3000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp15k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 5000;
                            titan.Health = 5000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp25k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 5000;
                            titan.Health = 5000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp35k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 5000;
                            titan.Health = 5000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp45k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 5000;
                            titan.Health = 5000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp55k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 5000;
                            titan.Health = 5000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp110k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 10000;
                            titan.Health = 10000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp210k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 10000;
                            titan.Health = 10000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp310k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 10000;
                            titan.Health = 10000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp410k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 10000;
                            titan.Health = 10000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp510k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 10000;
                            titan.Health = 10000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp115k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 15000;
                            titan.Health = 15000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp215k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 15000;
                            titan.Health = 15000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp315k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 15000;
                            titan.Health = 15000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp415k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 15000;
                            titan.Health = 15000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp515k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 15000;
                            titan.Health = 15000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp120k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 20000;
                            titan.Health = 20000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp220k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 20000;
                            titan.Health = 20000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp320k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 20000;
                            titan.Health = 20000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp420k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 20000;
                            titan.Health = 20000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp520k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 20000;
                            titan.Health = 20000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp125k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 25000;
                            titan.Health = 25000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp225k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 25000;
                            titan.Health = 25000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp325k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 25000;
                            titan.Health = 25000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp425k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 25000;
                            titan.Health = 25000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp525k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 25000;
                            titan.Health = 25000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp130k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 30000;
                            titan.Health = 30000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp230k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 30000;
                            titan.Health = 30000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp330k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 30000;
                            titan.Health = 30000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp430k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 30000;
                            titan.Health = 30000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp530k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 30000;
                            titan.Health = 30000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp140k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 40000;
                            titan.Health = 40000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp240k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 40000;
                            titan.Health = 40000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp340k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 40000;
                            titan.Health = 40000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp440k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 40000;
                            titan.Health = 40000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp540k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 40000;
                            titan.Health = 40000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp150k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Normal", spawnlocation);
                            titan.MaxHealth = 50000;
                            titan.Health = 50000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp250k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Abnormal", spawnlocation);
                            titan.MaxHealth = 50000;
                            titan.Health = 50000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp350k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Punk", spawnlocation);
                            titan.MaxHealth = 50000;
                            titan.Health = 50000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp450k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Crawler", spawnlocation);
                            titan.MaxHealth = 50000;
                            titan.Health = 50000;
                        }
                        break;
                    }
                }
                elif (msg == "/sp550k")
                {
                    for (human in Game.Humans)
                    {
                        spawnlocation = human.Position;
                        if (spawnlocation != null)
                        {
                            spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                            titan = Game.SpawnTitanAt("Thrower", spawnlocation);
                            titan.MaxHealth = 50000;
                            titan.Health = 50000;
                        }
                        break;
                    }
                }
                elif (msg == "/idle")
                {
                    for (titan in Game.Titans)
                    {
                        titan.Idle(8.0);
                    }
                }
                elif (msg == "/blind")
                {
                    for (titan in Game.Titans)
                    {
                        titan.Blind();
                    }
                }
                elif (msg == "/cripple")
                {
                    for (titan in Game.Titans)
                    {
                        titan.Cripple(0.0);
                    }
                }
                elif (msg == "/staycripple")
                {
                    for (titan in Game.Titans)
                    {
                        titan.Cripple(10000.0);
                    }
                }
                elif (msg == "/wander")
                {
                    for (titan in Game.Titans)
                    {
                        titan.Wander();
                    }
                }
                elif (msg == "/laugh")
                {
                    for (titan in Game.Titans)
                    {
                        titan.Emote("Laugh");
                    }
                }
                elif (msg == "/fcp")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MoveTo(self.pointer, 15.0, true);
                    }
                }
                elif (msg == "/fcs")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MoveTo(MissionSupply.Supply.Position, 15.0, true);
                    }
                }
                elif (msg == "/hpon")
                {
                    self.hprestore = 1;
                }
                elif (msg == "/hpoff")
                {
                    self.hprestore = 0;
                }
                elif (msg == "/hp10")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 10;
                        titan.Health = 10;
                    }
                }
                elif (msg == "/hp500")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 500;
                        titan.Health = 500;
                    }
                }
                elif (msg == "/hp1k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 1000;
                        titan.Health = 1000;
                    }
                }
                elif (msg == "/hp2k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 2000;
                        titan.Health = 2000;
                    }
                }
                elif (msg == "/hp3k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 3000;
                        titan.Health = 3000;
                    }
                }
                elif (msg == "/hp5k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 5000;
                        titan.Health = 5000;
                    }
                }
                elif (msg == "/hp10k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 10000;
                        titan.Health = 10000;
                    }
                }
                elif (msg == "/hp15k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 15000;
                        titan.Health = 15000;
                    }
                }
                elif (msg == "/hp20k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 20000;
                        titan.Health = 20000;
                    }
                }
                elif (msg == "/hp25k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 25000;
                        titan.Health = 25000;
                    }
                }
                elif (msg == "/hp30k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 30000;
                        titan.Health = 30000;
                    }
                }
                elif (msg == "/hp40k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 40000;
                        titan.Health = 40000;
                    }
                }
                elif (msg == "/hp50k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 50000;
                        titan.Health = 50000;
                    }
                }
                elif (msg == "/hp60k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 60000;
                        titan.Health = 60000;
                    }
                }
                elif (msg == "/hp70k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 70000;
                        titan.Health = 70000;
                    }
                }
                elif (msg == "/hp80k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 80000;
                        titan.Health = 80000;
                    }
                }
                elif (msg == "/hp90k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 90000;
                        titan.Health = 90000;
                    }
                }
                elif (msg == "/hp100k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 100000;
                        titan.Health = 100000;
                    }
                }
                elif (msg == "/hp120k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 120000;
                        titan.Health = 120000;
                    }
                }
                elif (msg == "/hp150k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 150000;
                        titan.Health = 150000;
                    }
                }
                elif (msg == "/hp200k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 200000;
                        titan.Health = 200000;
                    }
                }
                elif (msg == "/hp250k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 250000;
                        titan.Health = 250000;
                    }
                }
                elif (msg == "/hp300k")
                {
                    for (titan in Game.Titans)
                    {
                        titan.MaxHealth = 300000;
                        titan.Health = 300000;
                    }
                }
                elif (msg == "/af")
                {
                    for (titan in Game.Titans)
                    {
                        titan.GetKilled("YMIR");
                    }
                    for (shifter in Game.Shifters)
                    {
                        shifter.GetKilled("YMIR");
                    }
                }
                elif (msg == "/tf")
                {
                    for (titan in Game.Titans)
                    {
                        titan.GetKilled("YMIR");
                    }
                }
                elif (msg == "/fmf")
                {
                    for (shifter in Game.Shifters)
                    {
                        shifter.GetKilled("YMIR");
                    }
                }
                elif (msg == "/kpall")
                {
                    for (human in Game.Humans)
                    {
                        human.GetKilled("YMIR");
                    }
                }
                elif (msg == "/revivallp")
                {
                    for (player in Network.Players)
                    {
                        Game.SpawnPlayerAt(player, false, self.resppoint);
                    }
                }
                elif (msg == "/rvp")
                {
                    for (player in Network.Players)
                    {
                        Game.SpawnPlayerAt(player, false, self.resppoint);
                    }
                }
                elif (msg == "/rv")
                {
                    for (player in Network.Players)
                    {
                        Game.SpawnPlayer(player, false);
                    }
                }
                elif (msg == "/revivall")
                {
                    for (player in Network.Players)
                    {
                        Game.SpawnPlayer(player, false);
                    }
                }
                elif (msg == "/max1")
                {
                    self.maxtitans = 1;
                }
                elif (msg == "/max2")
                {
                    self.maxtitans = 2;
                }
                elif (msg == "/max3")
                {
                    self.maxtitans = 3;
                }
                elif (msg == "/max4")
                {
                    self.maxtitans = 4;
                }
                elif (msg == "/max5")
                {
                    self.maxtitans = 5;
                }
                elif (msg == "/max6")
                {
                    self.maxtitans = 6;
                }
                elif (msg == "/max7")
                {
                    self.maxtitans = 7;
                }
                elif (msg == "/max8")
                {
                    self.maxtitans = 8;
                }
                elif (msg == "/max9")
                {
                    self.maxtitans = 9;
                }
                elif (msg == "/max10")
                {
                    self.maxtitans = 10;
                }
                elif (msg == "/max12")
                {
                    self.maxtitans = 12;
                }
                elif (msg == "/max15")
                {
                    self.maxtitans = 15;
                }
                elif (msg == "/max18")
                {
                    self.maxtitans = 18;
                }
                elif (msg == "/max20")
                {
                    self.maxtitans = 20;
                }
                elif (msg == "/max22")
                {
                    self.maxtitans = 22;
                }
                elif (msg == "/max25")
                {
                    self.maxtitans = 25;
                }
                elif (msg == "/max28")
                {
                    self.maxtitans = 28;
                }
                elif (msg == "/max30")
                {
                    self.maxtitans = 30;
                }
                elif (msg == "/chase")
                {
                    for (titan in Game.Titans)
                    {
                        titan.DetectRange = 99999.99;
                    }
                }
                elif (msg == "/chon")
                {
                    self.chase = 1;
                }
                elif (msg == "/choff")
                {
                    self.chase = 0;
                }
                elif (msg == "/slow")
                {
                    Time.TimeScale = 0.5;
                }
                elif (msg == "/time")
                {
                    Time.TimeScale = 1;
                }
                elif (msg == "/fast")
                {
                    Time.TimeScale = 1.3;
                }
                elif (msg == "/con")
                {
                    self.cutdialog = true;
                    Game.PrintAll("<color=#00FF00> ☑</color><color=#FFFF00>「</color><color=#FFFFFF>CutsceneChatON</color><color=#FFFF00>」</color>");
                    Network.SendMessageOthers("con|teste");
                }
                elif (msg == "/coff")
                {
                    self.cutdialog = false;
                    Game.PrintAll("<color=#FF0000> ✘</color><color=#FFFF00>「</color><color=#FFFFFF>CutsceneChatOFF</color><color=#FFFF00>」</color>");
                    Network.SendMessageOthers("coff|teste");
                }
                elif (msg == "/rvpon")   { self.rvp         = 1;   }
                elif (msg == "/rvpoff")  { self.rvp         = 0;   }
                elif (msg == "/ron")     { self.resp        = 1;   }
                elif (msg == "/roff")    { self.resp        = 0;   }
                elif (msg == "/resp0")   { self.respseconds = 0;   }
                elif (msg == "/resp1")   { self.respseconds = 1;   }
                elif (msg == "/resp3")   { self.respseconds = 3;   }
                elif (msg == "/resp5")   { self.respseconds = 5;   }
                elif (msg == "/resp10")  { self.respseconds = 10;  }
                elif (msg == "/resp10")  { self.respseconds = 15;  }
                elif (msg == "/resp20")  { self.respseconds = 20;  }
                elif (msg == "/resp30")  { self.respseconds = 30;  }
                elif (msg == "/resp45")  { self.respseconds = 45;  }
                elif (msg == "/resp60")  { self.respseconds = 60;  }
                elif (msg == "/resp90")  { self.respseconds = 90;  }
                elif (msg == "/resp120") { self.respseconds = 120; }
                elif (msg == "/speed")
                {
                    for (titan in Game.Titans)
                    {
                        titan.RunSpeedBase = 80.0;
                        titan.WalkSpeedBase = 25.0;
                    }
                }
                elif (msg == "/rd1")
                {
                    spawnDistMin = -300.0;
                    spawnDistMax = 300;
                }
                elif (msg == "/rd2")
                {
                    spawnDistMin = -500.0;
                    spawnDistMax = 500;
                }
                elif (msg == "/rd3")
                {
                    spawnDistMin = -800.0;
                    spawnDistMax = 800;
                }
                elif (msg == "/rd4")
                {
                    spawnDistMin = -1000.0;
                    spawnDistMax = 1000;
                }
                elif (msg == "/rd5")
                {
                    spawnDistMin = -1500.0;
                    spawnDistMax = 1500;
                }
                else
                {
                    defaultCommand = true;
                }
            }
            # return temporario, pode ser removido dps de trocar todos os milhões de ifs acima pra elifs
            # return false;

            if (!defaultCommand)
            {
                return false;
            }

        }
        elif (self.cutdialog)
        {
            icon = Main.Settings.Load("DialogIcon");
            name = Network.MyPlayer.Name;
            text = "<color=#6495ED> ♟</color><color=#6495ED>「<color=" + Main.Settings.Load("DialogTextColor") + ">" + message + "</color>」</color>";

            self.DialogTextAll(icon, Network.MyPlayer.Name, text);
        }
    }

    #game behaviours
    function GrabEscape()
    {
        if (self.timerquick > 0)
        {
            self.timerquick -= 1;
        }
        myCharacter = Network.MyPlayer.Character;
        if (self.timerquick < 3 && self.quicktime == 2)
        {
            UI.SetLabel("MiddleCenter", "");
            if (myCharacter != null)
            {
            myCharacter.SetSpecial(self.lastspecial);
            }
            self.timerquick  = 0;
            self.quicktime   = 0;
            self.quicktimes  = 0;
            self.quickclicks = 0;
        }
        if (myCharacter != null)
        {
            if (myCharacter.State == "Grab" && myCharacter.CurrentSpecial != "Escape")
            {
                if (self.quicktime == 0)
                {
                    if (myCharacter != null)
                    {
                        self.lastspecial = myCharacter.CurrentSpecial;
                    }
                    self.quicktimes = Random.RandomInt(10, 26);
                }
                self.quicktime = 1;
            }
        }
    }

    function ShortWaveSpawn()
    {
        if (self.shortwavespawn > 0)
        {
            for (human in Game.Humans)
            {
                spawnlocation = human.Position;
                if (spawnlocation != null)
                {
                    var = Random.RandomInt(1, 3);
                    type = "";
                    if (var == 1) { type = "Normal";   }
                    if (var == 2) { type = "Abnormal"; }
                    spawnlocation = Vector3(spawnlocation.X + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax), spawnlocation.Y + 50.0, spawnlocation.Z + Random.RandomFloat(self.spawnDistMin, self.spawnDistMax));
                    Game.SpawnTitanAt(type, spawnlocation);
                }
                break;
            }
            self.shortwavespawn -= 1;
        }
    }

    function RespawnTimer()
    {
        self.resptimer -= 1;
        if (self.resptimer == 0)
        {
            if (self.resp == 1)
            {
                if (self.check > 0)
                {
                    Game.SpawnPlayerAtAll(false, self.resppoint);
                }
            }
            self.resptimer = self.respseconds;
        }
    }

    function HealthRegen()
    {
        if (self.hprestore == 1)
        {

            for (player in Network.Players)
            {
                if (player.Character != null && player != self.radiated)
                {
                    hp = player.Character.Health;
                    hpmax = player.Character.MaxHealth;
                    if (hp < hpmax)
                    {
                        player.Character.Health = player.Character.Health + 1.0;
                    }
                }
            }

            healthMarks = Dict();
            healthMarks.Set(100,   1);
            healthMarks.Set(500,   2);
            healthMarks.Set(1000,  3);
            healthMarks.Set(3000,  5);
            healthMarks.Set(5000,  8);
            healthMarks.Set(10000, 10);
            healthMarks.Set(15000, 13);
            healthMarks.Set(20000, 15);
            healthMarks.Set(25000, 18);
            healthMarks.Set(30000, 25);

            for (titan in Game.Titans)
            {
                hp = titan.Health;
                maxhp = titan.MaxHealth;

                list = healthMarks.Keys;
                list.Sort();

                for (health in list)
                {
                    add = healthMarks.Get(health);
                    if (maxhp <= health)
                    {
                        if (hp < maxhp && hp < health / 2)
                        {
                            titan.Health += add;
                        }
                        break;
                    }
                }
            }

            for (titan in Game.Shifters)
            {
                hp = titan.Health;
                maxhp = titan.MaxHealth;

                list = healthMarks.Keys;
                list.Sort();

                for (health in list)
                {
                    add = healthMarks.Get(health);
                    if (maxhp <= health)
                    {
                        if (hp < maxhp && hp < health / 2)
                        {
                            titan.Health += add;
                        }
                        break;
                    }
                }
            }
        }
    }

    function TitanChase()
    {
        if (self.chase == 1)
        {
            for (titan in Game.Titans)
            {
                titan.DetectRange = 99999.99;
            }
        }
    }
}

extension NPCNames
{
    BALTAZAR = "<color=#000000>Balt</color><color=#8A2BE2>azar</color><color=#FFFF00>(CMD)</color>";
}

extension Utility
{
    # @param position Vector3
    # @param forward Vector3
    # @param maxDistance float

    function WallDistance(position, forward, maxDistance)
    {
        distance = maxDistance;
        wallCast = Physics.LineCast(position, position + forward * distance, "MapObjects");
        if (wallCast != null)
        {
            distance = wallCast.Distance;
        }
        return distance;
    }
    # @param position Vector3
    # @param forward Vector3
    # @param groundMaxDifference float
    # @param maxAngle float

    function CastToGround(position, forward, groundMaxDifference, maxAngle)
    {
        pos = position;
        up = Vector3.Up;
        groundCast = Physics.LineCast(pos + Vector3.Up * groundMaxDifference, pos + Vector3.Down * groundMaxDifference, "MapObjects");
        if (groundCast != null && Vector3.Angle(Vector3.Up, groundCast.Normal) <= maxAngle)
        {
            pos = groundCast.Point;
            up = groundCast.Normal;
        }
        list = List();
        list.Add(pos);
        list.Add(QuaternionX.LookRotationY(forward, up).Euler);
        return list;
    }
}

extension Chat
{
    # @param str string
    # @param prefix string
    # @param allowK bool
    # @return bool

    function IsNumberCommand(str, prefix, allowK)
    {
        if (String.StartsWith(str, prefix))
        {
            str = String.Substring(str, String.Length(prefix));
            if (str == "")
            {
                Game.Print("command " + prefix + " missing number.");
                return false;
            }
            if (allowK && String.EndsWith(msg, "k"))
            {
                str = String.SubstringWithLength(str, 0, String.Length(str) - 1);
            }
            for (i in Range(0, String.Length(str), 1))
            {
                if (!String.Contains("0123456789", String.SubstringWithLength(str, i, 1)))
                {
                    return false;
                }
            }
            return true;
        }
        return false;
    }
    # @param str string
    # @param prefix string
    # @return bool

    function IsBoolCommand(str, prefix)
    {
        if (String.StartsWith(str, prefix))
        {
            str = String.Substring(str, String.Length(prefix));
            return str == "off" || str == "on";
        }
        return false;
    }
    # @param str string
    # @param startIndex int
    # @return int

    function GetNumberFromString(str, startIndex)
    {
        value = String.Substring(str, startIndex);
        mult = 1;
        if (String.EndsWith(value, "k"))
        {
            mult = 1000;
            value = String.SubstringWithLength(value, 0, String.Length(value) - 1);
        }
        num = Convert.ToInt(value);
        return num;
    }
    # @param str string
    # @param startIndex int
    # @return bool

    function GetBoolFromString(str, startIndex)
    {
        value = String.Substring(str, startIndex);
        return value == "on";
    }
    # @param vector Vector
    # @param separator string
    # @return string

    function VectorToString(vector, separator)
    {
        return Convert.ToString(vector.X) + separator + Convert.ToString(vector.Y) + separator + Convert.ToString(vector.Z);
    }
    # @param str string
    # @return string

    function RemoveSlash(str)
    {
        if (String.StartsWith(str, "/"))
        {
            return String.Substring(str, 1);
        }
        return str;
    }
}

extension QuaternionX
{
    # @return Quaternion

    function LookRotationY(forward, up)
    {
        ztoup = Quaternion.LookRotation(up, forward * ( 0 - 1 ));
        ytoz = Quaternion.FromEuler(Vector3(90, 0, 0));
        return ztoup * ytoz;
    }
    # @return Quaternion

    function FromToRotation(start, end)
    {
        return end * Quaternion.Inverse(start);
    }
}

extension CineMessage
{
    # @param label string
    # @param text string
    # @param delay float
    # @param stayTime float
    coroutine TypeWrite(label, text, delay, stayTime)
    {
        for (i in Range(0, String.Length(text), 1))
        {
            UI.SetLabel(label, String.SubstringWithLength(text, 0, i + 1));
            wait delay;
        }
        wait stayTime;
        for (i in Range(String.Length(text), 0, -1))
        {
            UI.SetLabel(label, String.SubstringWithLength(text, 0, i));
            wait delay;
        }
        UI.SetLabel(label, "");
    }
    coroutine SimpleWrite(label, text, delay, stayTime)
    {
        texter = text;
        UI.SetLabel(label, texter);
        wait stayTime;
        UI.SetLabel(label, "");
    }
    # @param label string
    # @param text string
    # @param color string
    # @param delay float
    # @param stayTime float
    coroutine TypeWriteWithColor(label, text, color, delay, stayTime)
    {
        for (i in Range(0, String.Length(text), 1))
        {
            UI.SetLabel(label, UI.WrapStyleTag(String.SubstringWithLength(text, 0, i + 1), "color", color));
            wait delay;
        }
        wait stayTime;
        for (i in Range(String.Length(text), 0, -1))
        {
            UI.SetLabel(label, UI.WrapStyleTag(String.SubstringWithLength(text, 0, i), "color", color));
            wait delay;
        }
        UI.SetLabel(label, "");
    }
}

extension MissionSupply
{
    /* @type MapObject */
    Supply = null;
    message = "";
    # @param player Player

    function OnPlayerJoin(player)
    {
        if (self.Supply != null)
        {
            Network.SendMessage(player, self.message);
        }
    }
    # @param message string

    function OnChatInput(message)
    {
        ret = true;
        if (message == "/sup")
        {
            if (Network.MasterClient.Character != null)
            {
                Main.resppoint = Network.MasterClient.Character.Position;
            }

            self.Create();
            text = "Protect The Supply";
            Game.PrintAll("<color=#00FF00> ➽</color><color=#FFFF00>「</color>" + text + "<color=#FFFF00>」</color>");
            Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#DAA520> ➽</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
        }
        elif(message == "/rsup")
        {
            self.Remove();
            text = "Supply Removed";
            Game.PrintAll("<color=#FF8C00> ☢</color><color=#000000>「</color>" + text + "<color=#000000>」</color>");
            Main.DialogTextAll("Levi1", NPCNames.BALTAZAR, "<color=#FF8C00> ☢</color><color=#000000>「</color><color=#FFFFFF>" + text + "</color><color=#000000>」</color>");
        }
        elif(Chat.IsNumberCommand(message, "/hsup", false))
        {
            health = Chat.GetNumberFromString(message, 5);
            self.Health(Convert.ToInt(health));
            printhealth = Convert.ToInt(health);
            Game.PrintAll("<b><color=#00FF00> SUPPLY FIXED: <color=#FFFFFF>" + printhealth + "</color></color></b>");
        }
        else
        {
            ret = false;
        }
        return ret;
    }

    # @param rpcs NetworkRPC
    function OnNetworkMessage(rpc)
    {
        if (rpc.Call == "msupply")
        {
            command = rpc.GetString(0);
            if (command == "create")
            {
                pos = rpc.GetVector3(1);
                rot = rpc.GetVector3(2);
                self.Create_Function(pos, rot);
            }
            elif(command == "destroy")
            {
                self.Destroy_Function(true);
            }
            elif(command == "remove")
            {
                self.Destroy_Function(false);
            }
            return true;
        }
        return false;
    }
    # @param position Vector3
    # @param rotation Vector3

    function Create_Function(position, rotation)
    {
        if (self.Supply != null)
        {
            Map.DestroyMapObject(self.Supply, true);
        }
        pos = Chat.VectorToString(position, ",");
        rot = Chat.VectorToString(rotation, ",");
        data = "Scene,Interact/Supply2,104,0,1,0,1,1,MissionSupply," + pos + "," + rot + ",1,1,1,Physical,Entities,Default,Default|255/255/255/255,SupplyStation|UnlimitedRefills:true|MaxRefills:0|LoadoutChange:true,";
        if (Network.IsMasterClient)
        {
            data += ",MissionSupplyObject";
        }
        self.Supply = Map.CreateMapObjectRaw(data);
        self.Supply.AddBoxTarget("Human", Vector3(0, 1, 0), Vector3(5, 5, 5));
    }

    function Destroy_Function(message)
    {
        if (self.Supply != null)
        {
            Map.DestroyMapObject(self.Supply, true);
            self.message = "";
        }
    }

    function Remove_Function()
    {
        if (self.Supply != null)
        {
            Map.DestroyMapObject(self.Supply, true);
            self.message = "";
        }
    }

    function Create()
    {
        if (Main.check == 1 || Main.check == 2)
        {
            char = Network.MyPlayer.Character;
            if (char == null)
            {
                return;
            }
            groundMaxDifference = 3.0;
            distance = Utility.WallDistance(char.Position + Vector3.Up, char.TargetDirection, 6.0);
            cast = Utility.CastToGround(char.Position + char.TargetDirection * distance, char.TargetDirection, 3.0, 45);

            message = NetworkMessage("msupply", null);
            message.AddArgument("create");
            message.AddArgument(cast.Get(0));
            message.AddArgument(cast.Get(1));

            message.SendAll();
            self.message = message.ToString();
        }
        if (Main.check == 0)
        {
            message = NetworkMessage("msupply", null);

            message.AddArgument("create");
            message.AddArgument(Vector3(13.0, -0.1, 58.0));
            message.AddArgument(Vector3(359.0, 179.0, 0.0));

            message.SendAll();
            self.message = message.ToString();
        }
    }

    function Destroy()
    {
        NetworkMessage("msupply", null).AddArgument("destroy").SendAll();
    }

    function Remove()
    {
        NetworkMessage("msupply", null).AddArgument("remove").SendAll();
    }
    # @param health int

    function Health(health)
    {
        if (self.Supply != null)
        {
            self.Supply.GetComponent("MissionSupplyObject").SetHealth(health);
        }
    }
}

component MissionSupplyObject
{
    MaxHealth = 3;
    Health = 1;

    function Init()
    {
        self.MapObject.AddBoxCollider("Region", "Hitboxes", Vector3(0, 4, 0), Vector3(9, 8, 4));
        self.Health = self.MaxHealth;
    }

    function OnGetHit(character, name, damage, type, hitPosition)
    {
        if (character.Type == "Titan" && self.Health > 0)
        {
            self.GetHit();
        }
        if (character.Type == "Shifter" && self.Health > 0)
        {
            self.GetHit();
        }
        if (character.Type == "Human" && self.Health > 0)
        {
        Game.SpawnEffect("Blood2", character.Position, Vector3(0.0,0.0,0.0), 0.5);
        }
    }

    function GetHit()
    {
        self.Health -= 1;
        if (self.Health == 0)
        {
            Game.SpawnEffect("GasBurst", self.MapObject.Position, Vector3(90, 0, 0), 4.0);
            Game.SpawnEffect("Boom1", self.MapObject.Position, Vector3(-90, 0, 0), 1.0);
            self.Health = self.MaxHealth;
            MissionSupply.Destroy();
        }
        else
        {
            Game.SpawnEffect("Boom3", self.MapObject.Position + Vector3.Up * 3, Vector3(-90, 0, 0), 2);
        }
    }

    function OnCollisionEnter(other)
    {
        if (Main.check > 0 && other.Type == "Human")
        {
            for (player in Network.Players)
            {
                Game.SpawnPlayerAt(player, false, Main.resppoint);
            }
        }
        if (Main.check == 0 && Main.rvp == 1 && other.Type == "Human")
        {
            for (player in Network.Players)
            {
                Game.SpawnPlayer(player, false);
            }
        }
    }
    # @param health int

    function SetHealth(health)
    {
        self.MaxHealth = health;
        self.Health = health;
    }
}

class PlayerSettings
{
    FileName = "";
    Settings = Dict();
    # @param id string

    function Init(fileName)
    {
        if (!PersistentData.IsValidFileName(fileName))
        {
            Game.Print("Invalid setting filename! (" + fileName + ")");
            return;
        }
        self.FileName = fileName;
        PersistentData.Clear();
        if (!self.FileExists())
        {
            self.SaveFile();
        }
        PersistentData.LoadFromFile(self.FileName, false);
    }

    function AddSetting(name, defaultValue)
    {
        value = PersistentData.GetProperty(name, defaultValue);
        PersistentData.SetProperty(name, value);
        self.Settings.Set(name, value);
        self.SaveFile();
    }
    # @param name string

    function Load(name)
    {
        if (self.Settings.Contains(name))
        {
            return self.Settings.Get(name);
        }
        else
        {
            Game.Print("Error: Settings '" + name + "' does not exist!");
        }
        return null;
    }
    # @param name string

    function Save(name, value)
    {
        if (self.FileExists())
        {
            self.Settings.Set(name, defaultValue);
            PersistentData.SetProperty(name, value);
            self.SaveFile();
        }
    }

    function SaveFile()
    {
        if (self.FileNameIsSet())
        {
            PersistentData.SaveToFile(self.FileName, false);
        }
    }

    function FileExists()
    {
        if (self.FileNameIsSet())
        {
            return PersistentData.FileExists(self.FileName);
        }
        return false;
    }

    function FileNameIsSet()
    {
        return self.FileName != "";
    }
}

class Command
{
    IsCommand   = false;
    CommandName = "";
    Args        = List();
    ArgCount    = 0;

    # @param message string
    function Init(message)
    {
        if (String.StartsWith(message, "/") && String.Length(message) > 1)
        {
            self.Args        = String.Split(String.Substring(message, 1), " ", true);
            self.CommandName = self.Args.Get(0);
            self.IsCommand   = true;

            self.Args.RemoveAt(0);
            self.ArgCount = self.Args.Count;
        }
    }

    # @param id int
    # @return string
    function GetString(id)
    {
        return self.Args.Get(id);
    }

    # @param id int
    # @return float
    function GetFloat(id)
    {
        return Convert.ToFloat(self.Args.Get(id));
    }

    # @param id int
    # @return int
    function GetInt(id)
    {
        return Convert.ToInt(self.Args.Get(id));
    }

    # @param id int
    # @return bool
    function GetBool(id)
    {
        return Convert.ToBool(self.Args.Get(id));
    }

    # @param id int
    # @return Vector3
    function GetVector3(id)
    {
        vectorString = self.Args.Get(id);
        values = String.Split(String.SubstringWithLength(vectorString, 1, String.Length(vectorString) - 2), ",");
        return Vector3(Convert.ToFloat(values.Get(0)),Convert.ToFloat(values.Get(1)),Convert.ToFloat(values.Get(2)));
    }

    # @param id int
    # @return Quaternion
    function GetQuaternion(id)
    {
        quatString = self.Args.Get(id);
        values = String.Split(String.SubstringWithLength(quatString, 1, String.Length(quatString) - 2), ",");
        return Vector3(Convert.ToFloat(values.Get(0)),Convert.ToFloat(values.Get(1)),Convert.ToFloat(values.Get(2),Convert.ToFloat(values.Get(3))));
    }
}

class NetworkRPC
{
    Call       = "";
    Message    = "";
    Args       = List();
    JoinedArgs = "";

    # @param message string
    function Init(message)
    {
        split = String.Split(message, "|");
        if (split.Count == 0)
        {
            return;
        }
        call = split.Get(0);
        args = List();
        if (split.Count > 1)
        {
            args = String.Split(split.Get(1), ";");
        }

        self.Call = call;
        self.Args = args;

        split.RemoveAt(0);

        self.JoinedArgs = String.Join(split, "|");
    }

    function Print()
    {
        Game.Print("<color=white>RPC:</color> <color=green>" + self.Message + "</color>");
    }

    # @param id int
    # @return string
    function GetString(id)
    {
        return self.Args.Get(id);
    }

    # @param id int
    # @return float
    function GetFloat(id)
    {
        return Convert.ToFloat(self.Args.Get(id));
    }

    # @param id int
    # @return int
    function GetInt(id)
    {
        return Convert.ToInt(self.Args.Get(id));
    }

    # @param id int
    # @return bool
    function GetBool(id)
    {
        return Convert.ToBool(self.Args.Get(id));
    }

    # @param id int
    # @return Vector3
    function GetVector3(id)
    {
        vectorString = self.Args.Get(id);
        values = String.Split(String.SubstringWithLength(vectorString, 1, String.Length(vectorString) - 2), ",");
        return Vector3(Convert.ToFloat(values.Get(0)),Convert.ToFloat(values.Get(1)),Convert.ToFloat(values.Get(2)));
    }

    # @param id int
    # @return Quaternion
    function GetQuaternion(id)
    {
        quatString = self.Args.Get(id);
        values = String.Split(String.SubstringWithLength(quatString, 1, String.Length(quatString) - 2), ",");
        return Vector3(Convert.ToFloat(values.Get(0)),Convert.ToFloat(values.Get(1)),Convert.ToFloat(values.Get(2),Convert.ToFloat(values.Get(3))));
    }
}

class NetworkMessage
{
    Message     = "";
    Args        = List();
    CallSep     = "|";
    ArgsSep     = ";"; #

    # @Type NetworkView
    NetworkView = null;

    # @param message string
    function Init(message,networkView)
    {
        self.Message = message;
    }

    function AddArgument(arg)
    {
        self.Args.Add(Convert.ToString(arg));
        return self;
    }

    function ToString()
    {
        return self.Message + self.CallSep + String.Join(self.Args, self.ArgsSep);
    }

    function SendOthers()
    {
        if (self.NetworkView == null) {
            Network.SendMessageOthers(self.ToString());
        } else {
            self.NetworkView.SendMessageOthers(self.ToString());
        }
    }

    function SendAll()
    {
        if (self.NetworkView == null) {
            Network.SendMessageAll(self.ToString());
        } else {
            self.NetworkView.SendMessageAll(self.ToString());
        }
    }

    function Send(target)
    {
        if (self.NetworkView == null) {
            Network.SendMessage(target, self.ToString());
        } else {
            self.NetworkView.SendMessage(target, self.ToString());
        }
    }
}

extension Menu
{
    selectedplayerID = 1;
    selectedplayer = null;
    bookcontent = "";

    function BookSetup()
    {
        UI.CreatePopup("Book", "Soldier Notes", 400, 450);
    }

    function CreateWindows()
    {
        UI.CreatePopup("FirstWindow", "Commands", 250, 450);
        UI.CreatePopup("GeneralWindow", "Commands", 250, 450);
        UI.CreatePopup("CommanderWindow", "Commands", 250, 450);
        UI.CreatePopup("PlayersWindow", "Commands", 250, 450);
        UI.CreatePopup("SelectedPlayer", "Commands", 250, 450);
        UI.CreatePopup("SupplyWindow", "Commands", 250, 450);
        UI.CreatePopup("TitansWindow", "Commands", 250, 450);
        UI.CreatePopup("TitanList", "Commands", 250, 450);
        UI.CreatePopup("Pointer", "Commands", 250, 450);
        UI.CreatePopup("Book", "Soldier Notes", 400, 450);
    }

    function FirstWindow()
    {
        UI.CreatePopup("FirstWindow", "Commands", 250, 450);
        UI.AddPopupButton("FirstWindow", "General", "General");
        UI.AddPopupButton("FirstWindow", "Pointer", "Pointer");
        UI.AddPopupButton("FirstWindow", "Supply", "Supply");
        UI.AddPopupButton("FirstWindow", "Commander", "Commander");
        UI.AddPopupButton("FirstWindow", "Players", "Players");
        UI.AddPopupButton("FirstWindow", "Titans", "Titans");
        UI.AddPopupButton("FirstWindow", "Book", "Soldier´s Diary");

        UI.ShowPopup("FirstWindow");
    }
    function FirstWindowOff()
    {
        UI.HidePopup("FirstWindow");
    }


    function GeneralWindow()
    {
        UI.CreatePopup("GeneralWindow", "General", 400, 450);

        if(Main.check == 0)
        {
        UI.AddPopupButton("GeneralWindow", "Check", "Expedition <color=#FF0000>Off</color>");
        }
        elif(Main.check == 1)
        {
        UI.AddPopupButton("GeneralWindow", "Check", "Expedition <color=#FFFF00>Static</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "Check", "Expedition <color=#00FF00>On</color>");
        }

        if(Main.cutdialog)
        {
        UI.AddPopupButton("GeneralWindow", "Cut", "Cutscene Dialog <color=#00FF00>On</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "Cut", "Cutscene Dialog <color=#FF0000>Off</color>");
        }

        if(Main.hprestore == 0)
        {
        UI.AddPopupButton("GeneralWindow", "TRegen", "Titans HP Regeneration <color=#FF0000>Off</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "TRegen", "Titans HP Regeneration <color=#00FF00>On</color>");
        }

        if(Main.chase == 0)
        {
        UI.AddPopupButton("GeneralWindow", "Chase", "Titans Following <color=#FF0000>Off</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "Chase", "Titans Following <color=#00FF00>On</color>");
        }

        if(Main.spawnDistMax == 300.0)
        {
        UI.AddPopupButton("GeneralWindow", "RD", "Spawn Distance <color=#FFFF00>300</color>");
        }
        elif(Main.spawnDistMax == 500.0)
        {
        UI.AddPopupButton("GeneralWindow", "RD", "Spawn Distance <color=#FFFF00>500</color>");
        }
        elif(Main.spawnDistMax == 800.0)
        {
        UI.AddPopupButton("GeneralWindow", "RD", "Spawn Distance <color=#FFFF00>800</color>");
        }
        elif(Main.spawnDistMax == 1000.0)
        {
        UI.AddPopupButton("GeneralWindow", "RD", "Spawn Distance <color=#FFFF00>1000</color>");
        }
        elif(Main.spawnDistMax == 1500.0)
        {
        UI.AddPopupButton("GeneralWindow", "RD", "Spawn Distance <color=#FFFF00>1500</color>");
        }

        if(Main.canahss == 0)
        {
        UI.AddPopupButton("GeneralWindow", "CANAHSS", "AHSS <color=#FF0000>Off</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "CANAHSS", "AHSS <color=#00FF00>On</color>");
        }

        if(Main.canapg == 0)
        {
        UI.AddPopupButton("GeneralWindow", "CANAPG", "APG <color=#FF0000>Off</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "CANAPG", "APG <color=#00FF00>On</color>");
        }

        if(Main.cants == 0)
        {
        UI.AddPopupButton("GeneralWindow", "CANTS", "TS <color=#FF0000>Off</color>");
        }
        else
        {
        UI.AddPopupButton("GeneralWindow", "CANTS", "TS <color=#00FF00>On</color>");
        }

        UI.AddPopupButton("GeneralWindow", "RVA", "Revive All Players");
        UI.AddPopupButton("GeneralWindow", "RVP", "Revive All On Pointer");
        UI.AddPopupButton("GeneralWindow", "KPALL", "Kill All Players");
        UI.AddPopupButton("GeneralWindow", "AF", "Kill All Enemies");
        UI.AddPopupButton("GeneralWindow", "FMF", "Kill All Shifters");
        UI.AddPopupButton("GeneralWindow", "TF", "Kill All Titans");

        UI.ShowPopup("GeneralWindow");
    }
    function GeneralWindowOff()
    {
        UI.HidePopup("GeneralWindow");
    }


    function SupplyWindow()
    {
        UI.CreatePopup("SupplyWindow", "Supply Commands", 400, 450);
        UI.AddPopupButton("SupplyWindow", "AddSupply", "Setup Supply Station");
        UI.AddPopupButton("SupplyWindow", "RemoveSupply", "Remove Supply Station");

        if(Main.rvp == 0)
        {
            UI.AddPopupButton("SupplyWindow", "RVPlayers", "Supply Heal Allies <color=#FF0000>Off</color>");
        }
        if(Main.rvp == 1)
        {
            UI.AddPopupButton("SupplyWindow", "RVPlayers", "Supply Heal Allies <color=#00FF00>On</color>");
        }

        UI.ShowPopup("SupplyWindow");
    }
    function SupplyWindowOff()
    {
        UI.HidePopup("SupplyWindow");
    }


    function CommanderWindow()
    {
        UI.CreatePopup("CommanderWindow", "Commander Commands", 400, 450);
        UI.AddPopupButton("CommanderWindow", "Tied", "Tied");
        UI.AddPopupButton("CommanderWindow", "Untied", "Untied");
        UI.AddPopupButton("CommanderWindow", "TP", "TP All To Pointer");
        UI.AddPopupButton("CommanderWindow", "TP0", "TP All To Commander");
        UI.AddPopupButton("CommanderWindow", "TP0P", "TP Commander To Pointer");
        UI.AddPopupButton("CommanderWindow", "AIR2", "Heal AirShip Allies");
        UI.AddPopupButton("CommanderWindow", "PAUSE", "Pause");
        UI.AddPopupButton("CommanderWindow", "UNPAUSE", "Unpause");

        UI.ShowPopup("CommanderWindow");
    }
    function CommanderWindowOff()
    {
        UI.HidePopup("CommanderWindow");
    }


    function PlayersWindow()
    {
        UI.CreatePopup("PlayersWindow", "Players List", 400, 450);

        for (player in Network.Players)
        {
            UI.AddPopupButton("PlayersWindow", Convert.ToString(player.ID), player.ID + " - " + player.Name);
        }

        UI.ShowPopup("PlayersWindow");
    }
    function playersWindowOff()
    {
        UI.HidePopup("PlayersWindow");
    }

    function SelectedPlayerWindow(splayer)
    {
        self.selectedplayer = splayer;
        UI.CreatePopup("SelectedPlayerWindow", "Player: " + splayer.Name, 400, 450);
        UI.AddPopupButton("SelectedPlayerWindow", "TPS0", "Teleport To Commander");
        UI.AddPopupButton("SelectedPlayerWindow", "TP0S", "Teleport Commander");
        UI.AddPopupButton("SelectedPlayerWindow", "TPALLS", "Teleport Commander");
        UI.AddPopupButton("SelectedPlayerWindow", "RVPLAYER", "Revive Main");
        UI.AddPopupButton("SelectedPlayerWindow", "RVPLAYERP", "Revive On Pointer");
        UI.AddPopupButton("SelectedPlayerWindow", "RVPLAYERPALL", "Revive All On Player");
        UI.AddPopupButton("SelectedPlayerWindow", "POINTERP", "Set the Pointer");
        UI.AddPopupButton("SelectedPlayerWindow", "RANDOMP", "Random at Player");
        UI.AddPopupButton("SelectedPlayerWindow", "NORMALP", "Normal at Player");
        UI.AddPopupButton("SelectedPlayerWindow", "ABERRANTP", "Aberrant at Player");
        UI.AddPopupButton("SelectedPlayerWindow", "PUNKP", "Punk at Player");
        UI.AddPopupButton("SelectedPlayerWindow", "CRAWLERP", "Crawler at Player");
        UI.AddPopupButton("SelectedPlayerWindow", "THROWERP", "Thrower at Player");
        UI.AddPopupButton("SelectedPlayerWindow", "ADDPLAYERHEALTH", "Add 10 Health");
        UI.AddPopupButton("SelectedPlayerWindow", "SUBPLAYERHEALTH", "Subtract 10 Health");
        UI.AddPopupButton("SelectedPlayerWindow", "REFILLP", "Refill Gas and Ammo");
        UI.AddPopupButton("SelectedPlayerWindow", "BLADEP", "Set Spy Blade Killer");
        UI.AddPopupButton("SelectedPlayerWindow", "AHSSP", "Set Spy AHSS Killer");
        UI.AddPopupButton("SelectedPlayerWindow", "APGP", "Set Spy APG Killer");
        UI.AddPopupButton("SelectedPlayerWindow", "TSP", "Set Spy TS Killer");
        UI.AddPopupButton("SelectedPlayerWindow", "ERENP", "Set Eren Special");
        UI.AddPopupButton("SelectedPlayerWindow", "ANNIEP", "Set Female Special");
        UI.AddPopupButton("SelectedPlayerWindow", "KPLAYER", "Kill");
        UI.AddPopupButton("SelectedPlayerWindow", "KKPLAYER", "Kick");
        UI.ShowPopup("SelectedPlayerWindow");
    }
    function SelectedPlayerWindowOff()
    {
        UI.HidePopup("SelectedPlayerWindow");
    }


    function TitansWindow()
    {
        UI.CreatePopup("TitansWindow", "Titans Commands", 400, 450);
        UI.AddPopupButton("TitansWindow", "TitanList", "TitanList");
        UI.AddPopupButton("TitansWindow", "MoveTo", "Move Titans");
        UI.AddPopupButton("TitansWindow", "MoveToIg", "Move Titans Ignoring");
        UI.AddPopupButton("TitansWindow", "Idle", "Stop Titans");
        UI.AddPopupButton("TitansWindow", "Cripple", "Cripple Titans");
        UI.AddPopupButton("TitansWindow", "Laugh", "Laugh Titans");
        UI.AddPopupButton("TitansWindow", "Blind", "Blind Titans");
        UI.AddPopupButton("TitansWindow", "Free", "Free Titans");
        UI.AddPopupButton("TitansWindow", "ShifterMoveTo", "Move Shifters");
        UI.AddPopupButton("TitansWindow", "ShifterMoveToIg", "Move Shifters Ignoring");
        UI.AddPopupButton("TitansWindow", "ShifterIdle", "Stop Shifters");
        UI.AddPopupButton("TitansWindow", "ShifterCripple", "Cripple Shifters");
        UI.AddPopupButton("TitansWindow", "ShifterLaugh", "Laugh Shifters");
        UI.AddPopupButton("TitansWindow", "ShifterBlind", "Blind Shifters");
        UI.AddPopupButton("TitansWindow", "ShifterFree", "Free Shifters");

        UI.ShowPopup("TitansWindow");
    }
    function TitansWindowOff()
    {
        UI.HidePopup("TitansWindow");
    }


    function TitanList()
    {
        UI.CreatePopup("TitanList", "Titans", 400, 450);
        UI.AddPopupLabel("TitanList", "Total Titans: " + Game.Titans.Count);
        for (titan in Game.Titans)
        {
            UI.AddPopupButton("TitanList", "TitanList", titan.Type);
        }
        UI.ShowPopup("TitanList");
    }
    function TitanListOff()
    {
        UI.HidePopup("TitansWindow");
    }

    function PointerWindow()
    {
        UI.CreatePopup("Pointer", "Coordinates Pointer", 400, 450);
        UI.AddPopupLabel("Pointer", "<color=#FF0000>X: </color>" + Math.Round(Main.pointer.X, 2) + " <color=#00FF00>Y: </color>" + Math.Round(Main.pointer.Y, 2) + " <color=#0000FF>Z: </color>" + Math.Round(Main.pointer.Z, 2));
        UI.AddPopupButton("Pointer", "HERE", "Select Here");
        UI.AddPopupButton("Pointer", "North", "North +100");
        UI.AddPopupButton("Pointer", "West", "West +100");
        UI.AddPopupButton("Pointer", "East", "East +100");
        UI.AddPopupButton("Pointer", "South", "South +100");
        UI.AddPopupButton("Pointer", "Up", "Up +50");
        UI.AddPopupButton("Pointer", "Down", "Down +50");
        UI.AddPopupButton("Pointer", "NorthMin", "North +10");
        UI.AddPopupButton("Pointer", "WestMin", "West +10");
        UI.AddPopupButton("Pointer", "EastMin", "East +10");
        UI.AddPopupButton("Pointer", "SouthMin", "South +10");
        UI.AddPopupButton("Pointer", "NorthMax", "North +500");
        UI.AddPopupButton("Pointer", "WestMax", "West +500");
        UI.AddPopupButton("Pointer", "EastMax", "East +500");
        UI.AddPopupButton("Pointer", "SouthMax", "South +500");
        UI.ShowPopup("Pointer");
    }
    function PointerWindowOff()
    {
        UI.HidePopup("Pointer");
    }

    function PlayersMenu()
    {
        UI.CreatePopup("PlayersMenu", "Menu", 400, 450);
        if (UI.GetLanguage() != "PT-BR")
        {
            UI.AddPopupButton("PlayersMenu", "PMBook", "Soldier´s Diary");
            UI.AddPopupButton("PlayersMenu", "PMChemical", "Patoghens");
            UI.AddPopupButton("PlayersMenu", "PMPhobiary", "Phobiary");
        }
        else
        {
            UI.AddPopupButton("PlayersMenu", "PMBook", "Diário do Soldado");
            UI.AddPopupButton("PlayersMenu", "PMChemical", "Patógenos");
            UI.AddPopupButton("PlayersMenu", "PMPhobiary", "Fobiário");
        }
        UI.ShowPopup("PlayersMenu");
    }
    function PlayersMenuOff()
    {
        UI.HidePopup("PlayersMenu");
    }

    function Phobiary()
    {
        if (UI.GetLanguage() != "PT-BR")
        {
            UI.CreatePopup("Phobiary", "Phobiary", 900, 450);
            UI.AddPopupLabel("Phobiary", "This book is a catalog of creatures tested in the rift with Eldian blood and fragments composed of specific pathogens
Send combine + 2 numbers, without spaces, to confirm the choice
You can find the Eldina Alphabet in the Soldier's Diary to decipher the numbers

Nullstrikers Ϡλ
Medium and normal, with damage, aggressive types, multiply, can emit radiation, appear slowly

Dysarrayth Φλ
Large and resistant, act slowly, but have damage, multiply, appear quickly

Abysswalker ϠΩ
Medium and normal, with damage, vary greatly in types, cause weakness, can emit radiation, appear quickly

Oblithrax ΦϠ
Large and resistant, vary many types, act slowly, appear very slowly

Ariathan ΩΦ
Medium and normal, vary a little in types, sometimes stand still, appear some strong, appear fast

Zerophobia ΦΦ
Large and resistant, sometimes stand still, act slowly, appear normally

Voidstalker λϠ
Medium and normal, with damage, aggressive types, are weakened, use protection, appear slowly

Blutmor Ωλ
Medium and normal, types vary more, multiply, cause weakness, appear very quickly

Dermaclast λΦ
Medium and normal, with damage, types vary a little, multiply, stop sometimes, appear quickly

Trönix ΦΩ
Large and resistant, types vary a little, act slowly, some strong ones appear, appear quickly

Bloodlurker ϠΦ
Large and resistant, types vary a lot, sometimes stand still, can emit radiation, appear slowly

Shieldron λΩ
Medium and normal, with damage, types vary more, use protection, some strong ones appear, appear fast

Hemorak ΩΩ
Medium and normal, types vary more, some strong ones appear, cause weakness, appear very fast

Weaklean ΩϠ
Medium and normal, with damage, types vary a lot, become weakened, cause weakness, appear normally

Rattan λλ
Medium resistant, with damage, types vary a little, use protection, appear very fast

Demon´ex ϠϠ
Medium and normal, with damage, aggressive types, become weakened, can emit radiation, appear fast

Signed: Quantum Physicist Wishinsky
Groen Royal Research Department");
        }
        else
        {
            UI.CreatePopup("Phobiary", "Fobiário", 900, 450);
            UI.AddPopupLabel("Phobiary", "Este livro é um catálogo das criaturas testadas na fenda com sangue eldiano e fragmentos compostos de patógenos específicos
Envie combine + 2 números, sem espaço, para confirmar a escolha
Você pode encontrar o Alfabeto Eldiano no Diário do Soldado para descifrar os números

Nullstrikers Ϡλ
Medianos e normais, com dano, tipos agressivos, multiplicam, podem emitir radiação, surgem lentamente

Dysarrayth Φλ
Grandes e resistentes, agem de forma retardada, mas têm dano, multiplicam, surgem rápido

Abysswalker ϠΩ
Medianos e normais, com dano, variam muito os tipos, causam fraqueza, podem emitir radiação, surgem rápido

Oblithrax ΦϠ
Grandes e resistentes, variam muitos os tipos, agem de forma retardada, surgem muito lentamente

Ariatã ΩΦ
Medianos e normais, variam um pouco os tipos, ficam parados às vezes, surgem alguns fortes, surgem rápido

Zerophobia ΦΦ
Grandes e resistentes, ficam parados às vezes, agem de forma retardada, surgem normalmente

Voidstalker λϠ
Medianos e normais, com dano, tipos agressivos, ficam enfraquecidos, usam proteção, surgem lentamente

Blutmor Ωλ
Medianos e normais, variam mais os tipos, multiplicam, causam fraqueza, surgem muito rápido

Dermaclast λΦ
Medianos e normais, com dano, variam um pouco os tipos, multiplicam, param às vezes, surgem rápido

Trönix ΦΩ
Grandes e resistentes, variam um pouco os tipos, agem de forma retardada, surgem alguns fortes, surgem rápido

Bloodlurker ϠΦ
Grandes e resistentes, variam muitos os tipos, ficam parados às vezes, podem emitir radiação, surgem lentamente

Shieldron λΩ
Medianos e normais, com dano, variam mais os tipos, usam proteção, surgem alguns fortes, surgem rápido

Hemorak ΩΩ
Medianos e normais, variam mais os tipos, surgem alguns fortes, causam fraqueza, surgem muito rápido

Weaklean ΩϠ
Medianos e normais, com dano, variam muito os tipos, ficam enfraquecidos, causam fraqueza, surgem normalmente

Rattan λλ
Medianos resistentes, com dano, variam um pouco os tipos, usam proteção, surgem muito rápido

Demon´ex ϠϠ
Medianos e normais, com dano, tipos agressivos, ficam enfraquecidos, podem emitir radiação, surgem rápido

Assinado: Físico Quântico Wishinsky
Departamento de Pesquisas da Realeza de Groen");
        }
        UI.ShowPopup("Phobiary");
    }
    function PhobiaryOff()
    {
        UI.HidePopup("Phobiary");
    }

    function Chemical()
    {
        if (UI.GetLanguage() != "PT-BR")
        {
            UI.CreatePopup("Chemical", "Pathogens", 900, 450);
            UI.AddPopupLabel("Chemical", "Φ Fungus
Affects the weakest and manipulates them like Cordceps, the titans can present strange reactions, focus on gas, delay and a large size and vital force

λ Bacteria
Increased proliferation capacity, reaches more types, and a basic protection coupled, has duplication/mitosis ability

Ω Virus
Very fast propagation, covers all types including humans, and can generate diseases and excessive vital force in workers

Ϡ Radiation
Reverse effect, usually weakens the vital force of workers but can weaken that of humans too due to radiation, it is possible to feel the radiation on the skin because it is so strong");
        }
        else
        {
            UI.CreatePopup("Chemical", "Patógenos", 900, 450);
            UI.AddPopupLabel("Chemical", "Φ Fungo
Afeta os mais fracos e os manipula como o Cordceps, os titãs podem apresentar reações estranhas, focar no gás, retardo e um tamanho e força vital grande

λ Bactéria 
Capacidade de proliferação ampliada, atinge mais tipos, e uma proteção básica acoplada, possuem habilidade de duplicação/mitose

Ω Vírus
Propagação muito rápida, abrange todos os tipos incluindo humanos, e podem gerar doenças e força vital vital excessiva nas operárias

Ϡ Radiação
Efeito reverso, costuma enfraquecer a força vital das operárias mas pode enfraquecer a dos humanos também por conta da radiação, é possível sentir na pele a radiação de tão forte");
        }
        UI.ShowPopup("Chemical");
    }



    function Book()
    {
        if (UI.GetLanguage() != "PT-BR")
        {
        UI.CreatePopup("Book", "Soldier´s Diary", 400, 450);
        UI.AddPopupLabel("Book", "Soldier´s Notes:
Note 1 - Did I die? I mean...where am I? And why are people I've seen die here too? Titans...not again!

Lost Notes:
Note 1 - ξΠβξμςχξΨϦ ΦϠ ξϬϧθβξπ

Eldian Language:
A θ    J Ϯ    S Ϭ    1 λ
B ψ    K ρ    T Ϧ    2 Ω
C ϧ    L δ    U ω    3 Ϡ
D π    M χ    V Ϫ    4 Ξ
E ξ    N Ψ    W Θ    5 σ
F τ    O ϡ    X Π    6 Σ
G υ    P β    Y ζ    7 ϰ
H Δ    Q ο    Z φ    8 ϱ
I ς    R μ    0 Φ    9 ν
Punctuation be the same"+ self.bookcontent);
        UI.ShowPopup("Book");
    }

        elif (UI.GetLanguage() == "PT-BR")
        {
        UI.CreatePopup("Book", "Diário do Soldado", 400, 450);
        UI.AddPopupLabel("Book", "Notas do Soldado:
Nota 1 - Eu morri?? Digo...onde estou? E porque pessoas que já morreram estãom aqui? Titãs...de novo não!

Notas Esquecidas:
Nota 1 - ξΠβξμςχξΨϦϡ ΦϠ ξϬϧθβϡω

Alfabeto Eldiano:
A θ    J Ϯ    S Ϭ    1 λ
B ψ    K ρ    T Ϧ    2 Ω
C ϧ    L δ    U ω    3 Ϡ
D π    M χ    V Ϫ    4 Ξ
E ξ    N Ψ    W Θ    5 σ
F τ    O ϡ    X Π    6 Σ
G υ    P β    Y ζ    7 ϰ
H Δ    Q ο    Z φ    8 ϱ
I ς    R μ    0 Φ    9 ν
Sinais não mudam"+ self.bookcontent);
        UI.ShowPopup("Book");
    }

    }

    function Lore(content)
    {
        self.bookcontent += "

" +content;
        UI.CreatePopup("Lore", "Soldier´s Diary", 400, 450);
        UI.AddPopupLabel("Lore", content);

        UI.ShowPopup("Lore");
    }

    function LoreInitial()
    {
        if (UI.GetLanguage() != "PT-BR")
        {
        UI.CreatePopup("Lore", "Introduction", 600, 450);
        UI.AddPopupLabel("Lore", "Commands:
F1 - Open Soldier´s Diary and Notes
F2 - Acess this guide
F4 or /tied - Carried by a player
/d 20 Roll a dice
/npc Ymir1 Ymir Text - Speak as NPC
Look profile icons to get the NPC sprites

Supply:
Supply is a titan target, Protect It!
Wait the next wave to respawn
Touch the Supply to revive allies
If destroyed, Supply appears on next wave

Orders:
Respect the rank
Follow Commander and Captains
Pay attention on chat and rules
Respect others players

Formation:
Aways a triangle protecting the Supply
Protect your allies
Don't be impulsive / Wait for orders

Signed: " + NPCNames.BALTAZAR);
        }

        elif (UI.GetLanguage() == "PT-BR")
        {
        UI.CreatePopup("Lore", "Introdução", 600, 450);
        UI.AddPopupLabel("Lore", "Comandos:
F1 - Abrir Diário do Soldado e Notas
F2 - Acessa esse guia
F4 or /tied - Amarra a um player
/d 20 - Rola o dado de 20 lados
/npc Ymir1 Ymir Text - Fala como NPC
Consulte os NPCs em Perfil >> Ícones

Supply:
Supply é alvo de titãs, Proteja!
Aguarde a próxima wave para spawnar
Toque o Supply para reviver aliados
Reaparece na próxima wave se destruído

Ordens:
Respeite a cadeia de comando
Siga o Comandante e Líderes
Preste atenção no Chat e Regras
Respeite os outros players

Formação:
Sempre um triangulo em volta do Supply
Proteja seus aliados e evite combate
Não seja impulsivo / Siga as ordens

Assinado: " + NPCNames.BALTAZAR);
        }

        UI.ShowPopup("Lore");
    }


}