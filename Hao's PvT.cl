class Main
{   
    HumanLine=true;
    HumanLineTooltip = "人类描边(默认开启)";
      TitanLine=false;
    TitanLineTooltip = "巨人描边(默认关闭)";

	HumanHealth=100;
	 HumanHealthTooltip = "人类生命值";

   	PThealth=11;
	 PThealthTooltip = "玩家巨生命值";

	HumanMaxSpeed = 120.0;
  	HumanMaxSpeedTooltip = "人类最大速度限制";

	_isGasBurst = false;
	GasBurstForce = 40;
	GasBurstForceTooltip = "人类地面爆气力度";

	HumanSize=1;
	HumanSizeTooltip = "人类尺寸
(仅巨人视角可见)";

   JumpCD = 4.0;
    JumpCDTooltip = "玩家巨跳跃CD";
    RockThrowCD = 30.0;
    RockThrowCDTooltip = "玩家巨投石CD
(至少5秒)";
    ChangeTitanSizeCD = 30.0;
    ChangeTitanSizeCDTooltip = "玩家巨改变尺寸CD";

    TitanAngryRoundTime = 10;
    TitanAngryRoundTimeTooltip = "玩家巨暴走持续时间";

	TitanBaseDamage=100;
	TitanBaseDamageTooltip = "玩家巨基础伤害";
	TitanDamageRate=10;
  	TitanDamageRateTooltip = "玩家巨伤害随自身移速变化的倍率";

    WindPowerCD = 30.0;
    WindPowerTooltip = "玩家巨风压CD";

	/*计时*/	
	EndTime=300.0;
	EndTimeTooltip="时间限制";	
	_LastTime=null;
	_time=0;
	_bbb=true;


      MagicLoopAfterKick = 10000;
      MagicLoopAfterKickTooltip = "踢出违规词玩家后产生一点小卡顿";


    _titanSkill = null;

    _humanSkill = null;
    HaoTianChuiCD = 10;
    TitanBlowawayForce = 200.0;

    Description = "Survive a single round of titans.";
    Titans = 0;
    _hasSpawned = false;
    _invalidWords = null;

    Ping = 200;
    PingTooltip="Ping值超过该数值时自动踢出房间";	

	function Init()
	{
         self._titanSkill = TitanSkill();
	 self._humanSkill = HumanSkill();
         self._invalidWords = List();
         self._invalidWords.Add("fuck");
	}

    function OnPlayerJoin(player)
        {
          if (Network.IsMasterClient)
          {
            Network.SendMessage(player, "CheckYouName|");
          }
        }
      
        function OnNetworkMessage(sender, message)
        {
          if (String.StartsWith(message, "Kickme|"))
          {
            Network.KickPlayer(sender, reason="Having Invalid Words");
            self.AutoClear();
          }
          elif(sender==Network.MasterClient && String.StartsWith(message, "CheckYouName|"))
          {
            if (self.CheckInvalidString(Network.MyPlayer.Name))
            {
              return;
            }
            if (self.CheckInvalidString(Network.MyPlayer.Guild))
            {
              return;
            }
          }
		self._humanSkill.OnNetworkMessage(sender, message);
    self._titanSkill.OnNetworkMessage(sender, message);

            if(message == "pingKick|"){
              Network.KickPlayer(sender, reason="Ping High");
            }
        }
      
        coroutine AutoClear()
        {
          await 0.1;
          for(i in Range(0, 40, 1))
          {
            Game.PrintAll("神秘小巨人：1");
          }
        }

        coroutine PunishBadPlayer()
        {
          for (i in Range(0, Main.MagicLoopAfterKick, 1))
          {
            napeNew = Map.CreateMapObjectRaw("Scene,Geometry/Cube1,0,0,1,0,1,0,BladeRegion,0,0,0,0,0,0,0,0,0,Region,Characters,Default,Transparent|255/0/0/111|Misc/None|1/1|0/0,AnnoyComponent");
          }
        }
      
        function CheckInvalidString(str)
        {
          for(s in self._invalidWords)
          {
            if (String.Contains(str, s))
            {
              Network.SendMessage(Network.MasterClient, "Kickme|");
              self.PunishBadPlayer();
              return true;
            }
          }
          return false;
        }
      
        function OnChatInput(message)
        {
          if (self.CheckInvalidString(message))
          {
            return false;
          }
          return true;
        }

    function OnGameStart()
    {
        if (Network.IsMasterClient)
        {
            Game.SpawnTitans("Default", self.Titans);
        }

        self._titanSkill.OnGameStart();
    }

    function OnCharacterSpawn(character)
    {
	
	if(character.Type == "Titan")
	{
		character.CustomDamageEnabled = true;
	}

	if(Main.TitanLine==true)
	{
			if(character.Type == "Titan")
			{
			character.AddOutline(Color(255,0,0), "OutlineVisible");	
			}
	}
	
	if(Main.HumanLine==true)
	{
			if(character.Type=="Human")
			{
			character.AddOutline(Color(0,0,255), "OutlineVisible");	
			}
	}

	  if (character.IsMainCharacter && character.Type == "Human")
        {
            self.CurrentCharacter = character;
            character.CanDodge = false;
	}

	/*
	for(i in Range(0, Game.PlayerTitans.Count, 1))
	 {
			Game.PlayerTitans.Get(i).FarAttackCooldown=Main.ThrowCD;
	 }
	*/
	for(i in Range(0, Game.PlayerTitans.Count, 1))
	 {
	   	Game.PlayerTitans.Get(i).MaxHealth=Main.PThealth;
		Game.PlayerTitans.Get(i).Health=Main.PThealth;
	}
	
	if(character.Type == "Human")
	{
		character.MaxHealth=Main.HumanHealth;
		character.Health=Main.HumanHealth;
	}


    }

	function OnSecond()
	{
      		self._titanSkill.OnSecond();
          self._humanSkill.OnSecond();

      # ping高踢出
      if(Network.Ping > self.Ping){
        if(!Network.IsMasterClient){
          Network.SendMessage(Network.MasterClient, "pingKick|");
        }
      }
	}


    function OnTick()
    {

	if(Main._bbb==true&&Network.IsMasterClient)
	{
		Main._time+=Time.TickTime;
		Main._LastTime=Main.EndTime-Main._time;
		UI.SetLabelForTimeAll("TopCenter",Game.Titans.Count+"头巨人剩余 , 倒计时:"+Convert.ToInt(Main._LastTime)+"秒",Main.EndTime);
	}

	if (Network.IsMasterClient&&Main._LastTime<=0)
	{
		UI.SetLabelForTimeAll("MiddleCenter","未在规定时间清除巨人,人类战败...",10.0);		   		
		Game.End(10.0);
	}

        if (Network.IsMasterClient && !Game.IsEnding)
        {
            titans = Game.Titans.Count;
            humans = Game.Humans.Count;
            playerShifters = Game.PlayerShifters.Count;
            if (titans > 0 &&(humans > 0 || playerShifters > 0))
            {
                self._hasSpawned = true;
            }
            if (titans == 0 && self._hasSpawned)
            {
                UI.SetLabelAll("MiddleCenter", "人类胜利!");
                Game.End(10.0);
                return;
            }
            if (humans == 0 && playerShifters == 0 && self._hasSpawned)
            {
                UI.SetLabelAll("MiddleCenter", "人类失败!");
                Game.End(10.0);
                return;
            }
            UI.SetLabelAll("TopCenter", "Titans Left: " + Convert.ToString(titans));
        }
    }

    	function OnFrame()
	{

	for(i in Range(0, Game.AITitans.Count, 1))
	{
		Game.AITitans.Get(i).CustomDamage=Main.TitanBaseDamage;
	}

	
	CurrentCharacter = Network.MyPlayer.Character;
        cond = CurrentCharacter != null && CurrentCharacter.Health > 0 && CurrentCharacter.Type == "Human" && CurrentCharacter.Grounded;
		if (cond)
        	{
			if (!self._isGasBurst && CurrentCharacter.CurrentGas >= 1.0 && Input.GetKeyDown("Human/Dodge"))
			{
                	CurrentCharacter.StopSound("GasBurst");
                	CurrentCharacter.PlaySound("GasBurst");
                	effectRotation = Quaternion.LookRotation(CurrentCharacter.Forward).Euler;
                	Game.SpawnEffect("GasBurst", CurrentCharacter.Position, effectRotation, 1.0);
                	CurrentCharacter.MountTransform(CurrentCharacter.Transform, Vector3.Zero, Vector3.Zero);
                	CurrentCharacter.AddForce((CurrentCharacter.Forward.Normalized) * self.GasBurstForce * 0.5 / 0.007 + Vector3(0,300,0));
                	self._isGasBurst = true;
                	self.GasBurst(CurrentCharacter.GetAnimationLength("Armature|dash"));
                	CurrentCharacter.CurrentGas -= 1.0;
			}
        	}

      	self._titanSkill.OnFrame();
        self._humanSkill.OnFrame();

      	# 人类玩家限速
      	currentCharacter = Network.MyPlayer.Character;
      		if (currentCharacter != null && currentCharacter.Type == "Human")
      		{
        		if (currentCharacter.Velocity.Magnitude > Main.HumanMaxSpeed)
        		{
          		currentCharacter.Velocity = currentCharacter.Velocity.Normalized * Main.HumanMaxSpeed;
        		}
      		}
    	}
	coroutine GasBurst(delay)
    	{
        wait delay;
        self._isGasBurst = false;
    	}	
}

  # 巨人技能
  class TitanSkill{
    _jumpKeyEnabled = true;
    _jumpRoundTime = 0;
    _rockThrowEnabled = true;
    _rockThrowRoundTime = 0;
    _changeTitanSizeEnabled = true;
    _changeTitanSizeRoundTime = 0;
    _TitanAngryEnabled = true;
    _TitanAngryRoundTime = 0;
    _windPowerEnabled = true;
    _windPowerRoundTime = 0;

    _action = List();

    # 风压技能
    force = 130.0;
    _radius = 70.0;

    function Init()
    {
	self._TitanAngryRoundTime = Main.TitanAngryRoundTime;
    }

    function OnGameStart(){
      # 风压相关
      CustomEffects.FetchObjects();
    }

    function OnNetworkMessage(sender, message){
      if(message == "clearHook"){
        character = Network.MyPlayer.Character;
        if(character != null && character.Type == "Human"){
          self.ClearHook(sender, 1.0, self._radius, self.force);
        }
        return;
      }

      if(message == "windEffects"){
        length = sender.Character.GetAnimationLength("Amarture_VER2|attack.scream") - 0.5;
        CustomEffects.ActivateTime(2.0, sender.Character.Transform, length, 3.0);
        return;
      }
    }

    function OnFrame(){
      if(Network.MyPlayer.Character!= null && Network.MyPlayer.Character.Type == "Titan"){

	Network.MyPlayer.Character.CustomDamage=Main.TitanBaseDamage+Main.TitanDamageRate*Network.MyPlayer.Character.Velocity.Magnitude;

	for (human in Game.Humans)
	{	
	human.Transform.Scale=Vector3(Main.HumanSize,Main.HumanSize,Main.HumanSize);
	}

        if(self._jumpKeyEnabled && Network.MyPlayer.Character.CurrentAnimation == "Amarture_VER2|attack.jumper.0"){
          self._action.Add(Network.MyPlayer.Character.CurrentAnimation);
          self._jumpKeyEnabled = false;
          self.delay("Titan/Jump", Main.JumpCD);
        }

	if(Network.MyPlayer.Character != null && self._TitanAngryRoundTime <= 0)
	{
			Network.MyPlayer.Character.MaxStamina=3;
			Network.MyPlayer.Character.AttackWait=0.1;
			Network.MyPlayer.Character.RunSpeedBase=10;
			Network.MyPlayer.Character.TurnPause=0.75;
			Network.MyPlayer.Character.TurnSpeed=1;
			Network.MyPlayer.Character.AttackPause=0.1;
			Network.MyPlayer.Character.ActionPause=0.1;
			Network.MyPlayer.Character.AttackSpeedMultiplier=1.25;
	}


        # 跳后是否做其他动作
        if(!self._jumpKeyEnabled && self._action.Count != 0){
          if(!self._action.Contains(Network.MyPlayer.Character.CurrentAnimation) && Network.MyPlayer.Character.CurrentAnimation == "Amarture_VER2|attack.jumper.1"){
            self._action.Add(Network.MyPlayer.Character.CurrentAnimation);
            Input.SetKeyDefaultEnabled("Titan/Jump", false);
          }elif(!self._action.Contains(Network.MyPlayer.Character.CurrentAnimation) && Network.MyPlayer.Character.CurrentAnimation != "Amarture_VER2|attack.jumper.1"){
            Input.SetKeyDefaultEnabled("Titan/Jump", false);
          }
        }

        if(self._rockThrowEnabled && Network.MyPlayer.Character.CurrentAnimation == "Amarture_VER2|attack.throw"){
          self._rockThrowEnabled = false;
          Input.SetKeyDefaultEnabled("Titan/AttackRockThrow", false);
          self.delay("Titan/AttackRockThrow", Main.RockThrowCD);
        }

	if(Network.MyPlayer.Character!= null && Network.MyPlayer.Character.Type == "Titan")
	{
        str = "";
        if(self._TitanAngryEnabled)
	{
          AngryEnabled = "可使用";
        }elif(!self._TitanAngryEnabled && self._TitanAngryRoundTime > 0){
          AngryEnabled = "时间剩余：" + Convert.ToString(self._TitanAngryRoundTime);
        }else{
          AngryEnabled = "不可使用";
        }

        str = "";
        str += "跳跃：" + UI.WrapStyleTag(Convert.ToString(self._jumpRoundTime), "color", "#FFD700") + "    ";
        str += "投石：" + UI.WrapStyleTag(Convert.ToString(self._rockThrowRoundTime), "color", "#FFD700") + "    ";
        str += "改变体型 F1：" + UI.WrapStyleTag(Convert.ToString(self._changeTitanSizeRoundTime), "color", "#FFD700") + "    ";
        str += "装死F2：" + UI.WrapStyleTag("可使用", "color", "#FFD700") + "    ";
	      str += "暴走F3：" + UI.WrapStyleTag(AngryEnabled, "color", "#FFD700") + "    ";
        str += "风压F4：" + UI.WrapStyleTag(Convert.ToString(self._windPowerRoundTime), "color", "#FFD700") + "    ";
        str += String.Newline + String.Newline;
        UI.SetLabel("BottomCenter", str);


        
        if(Input.GetKeyDown("Interaction/Function1")) {
          if(self._changeTitanSizeEnabled){
            self._changeTitanSizeEnabled = false;
            if(Network.MyPlayer.Character.Size >= 3){
              Network.MyPlayer.Character.Size = 1;
            }else{
              Network.MyPlayer.Character.Size = 3;
            }
            self.delay("changeTitanSize", Main.ChangeTitanSizeCD);
          }
        }

        if(Input.GetKeyDown("Interaction/Function2")) {
          Game.SpawnEffect("PunchHit", Network.MyPlayer.Character.NapePosition, Vector3.Zero, 1);
          Network.MyPlayer.Character.PlayAnimation("Amarture_VER2|die.front");
        }
      }

	if(Input.GetKeyDown("Interaction/Function3")) 
	{
          	if(self._TitanAngryEnabled)
		{
		Game.Print("开启暴走");
            	self._TitanAngryEnabled = false;
            		if(Network.MyPlayer.Character != null && self._TitanAngryRoundTime>0)
			{
              		Network.MyPlayer.Character.MaxStamina=6;
			Network.MyPlayer.Character.Stamina=6;
			Network.MyPlayer.Character.AttackWait=0.0;
			Network.MyPlayer.Character.RunSpeedBase=40;
			Network.MyPlayer.Character.TurnPause=0.5;
			Network.MyPlayer.Character.TurnSpeed=5;
			Network.MyPlayer.Character.AttackPause=0.1;
			Network.MyPlayer.Character.ActionPause=0.1;
			Network.MyPlayer.Character.AttackSpeedMultiplier=1.8;
			}
          	}
        }
	}

    # 风压相关
      CustomEffects.OnFrame();
      character = Network.MyPlayer.Character;
      if (character != null && character.Type == "Titan"){
        if(Input.GetKeyDown("Interaction/Function4")) {

          if(self._windPowerEnabled){
            self._windPowerEnabled = false;
            character.Emote("Roar");
            Network.SendMessageAll("windEffects");
            self.delay("windPower", Main.WindPowerCD);
          }
        }
      }

    }
   

    function OnSecond(){
      if(!self._jumpKeyEnabled && self._jumpRoundTime <= Main.JumpCD){
        self._jumpRoundTime -= 1;
      }

      if(!self._rockThrowEnabled && self._jumpRoundTime <= Main.RockThrowCD){
        self._rockThrowRoundTime -= 1;
      }

      if(!self._changeTitanSizeEnabled && self._changeTitanSizeRoundTime <= Main.ChangeTitanSizeCD){
        self._changeTitanSizeRoundTime -= 1;
      }

      if(!self._TitanAngryEnabled && self._TitanAngryRoundTime <= Main.TitanAngryRoundTime)
      {
        self._TitanAngryRoundTime -= 1;
      }

      if(!self._windPowerEnabled && self._windPowerRoundTime <= Main.WindPowerCD)
      {
        self._windPowerRoundTime -= 1;
      }

      character = Network.MyPlayer.Character;
      if (character != null && character.Type == "Titan"){
        if(character.CurrentAnimation == "Amarture_VER2|attack.scream"){
          Network.SendMessageOthers("clearHook");
        }
      }
    	
    }

    coroutine delay(key, second){
      if(key == "Titan/Jump"){
        self._jumpRoundTime = second;
        wait second;
        Input.SetKeyDefaultEnabled("Titan/Jump", true);
        self._action.Clear();
        self._jumpKeyEnabled = true;
        self._jumpRoundTime = 0;
      }elif(key == "Titan/AttackRockThrow"){
        self._rockThrowRoundTime = second;
        wait second;
        Input.SetKeyDefaultEnabled("Titan/AttackRockThrow", true);
        self._rockThrowEnabled = true;
        self._rockThrowRoundTime = 0;
      }elif(key == "changeTitanSize"){
        self._changeTitanSizeRoundTime = second;
        wait second;
        self._changeTitanSizeEnabled = true;
        self._changeTitanSizeRoundTime = 0;
      }elif(key == "windPower"){
        self._windPowerRoundTime = second;
        wait second;
        self._windPowerEnabled = true;
        self._windPowerRoundTime = 0;
      }
    }

    # 风压相关
    coroutine ClearHook(sender, delay, radius, force){
      wait delay;
      character = Network.MyPlayer.Character;
      distance = Vector3.Distance(character.Position , sender.Character.Position);
      if (distance < radius)
      {
        start = sender.Character.Position;
        end = character.Position;
        direction = (end - start).Normalized;
        character.Velocity += direction * force ;
        character.ClearHooks();
        character.LeftHookEnabled = false;
        character.RightHookEnabled = false;
        self.HookEnables(character, 2);
      }
    }

    coroutine HookEnables(character, delay){
      wait delay;
      character.LeftHookEnabled = true;
      character.RightHookEnabled = true;
    }
  }

  # 玩家技能
  class HumanSkill{
    TitanBlowawayForce = 0.0;
    _hammerL = null;
    _hammerR = null;
    _haoTianChuiCD = 0;
    _haoTianChuiEnabled = true;
    _haoTianChuiRoundTime = 0;


    _followDistance = 0;
    _speed = 0;
    _maxGas = 0;
    _currentGas = 0;
    _maxBladeDurability = 0;
    _currentBladeDurability = 0;

    _playerData = List();

    function Init()
    {
      self._hammerL = Map.FindMapObjectByName("HammerOriginL");
      self._hammerR = Map.FindMapObjectByName("HammerOriginR");
      self._haoTianChuiCD = Main.HaoTianChuiCD;
      self.TitanBlowawayForce = Main.TitanBlowawayForce;
    }

    function OnFrame(){
      if(Network.MyPlayer.Character!= null && Network.MyPlayer.Character.Type == "Human"){
        str = "";
        if(self._haoTianChuiEnabled){
          chuiEnabled = "可使用";
        }elif(!self._haoTianChuiEnabled && self._haoTianChuiRoundTime > 0){
          chuiEnabled = "时间剩余：" + Convert.ToString(self._haoTianChuiRoundTime);
        }else{
          chuiEnabled = "不可使用";
        }
        str += "玩个锤子 F1：" + UI.WrapStyleTag(chuiEnabled, "color", "#FFD700") + "    ";
        str += String.Newline + String.Newline + String.Newline + String.Newline;
        UI.SetLabel("BottomCenter", str);


        if(Input.GetKeyDown("Interaction/Function1")) {
          if(self._haoTianChuiEnabled){
            self._haoTianChuiEnabled = false;
            Game.Print("玩个锤子");
            character = Network.MyPlayer.Character;

            self._followDistance = Camera.FollowDistance;
            self._speed = character.Speed;
            self._maxGas = character.MaxGas;
            self._currentGas = character.CurrentGas;
            self._maxBladeDurability = character.MaxBladeDurability;
            self._currentBladeDurability = character.MaxBladeDurability;

            Camera.FollowDistance = 6;
            Network.SendMessageAll("setup|");
          }
        }
      }
    }


    function OnNetworkMessage(sender, message)
    { 
      if(String.StartsWith(message, "CreateRagdoll|")){
        index = String.IndexOf(message, "|");
        viewID = Convert.ToInt(String.Substring(message, index + 1));
        titan = Game.FindCharacterByViewID(viewID);
        if (titan != null)
        {
          self.CreateRagdoll(sender.Character.Position, titan, Network.MyPlayer.Name);
        }
        return;
      }

      if(message == "setup|"){
        sender.Character.Speed *= 4;
        sender.Character.MaxGas = 99999;
        sender.Character.CurrentGas = 99999;
        sender.Character.MaxBladeDurability = 99999;
        sender.Character.CurrentBladeDurability = 99999;
        hammerL = Map.CopyMapObject(self._hammerL, true);
        hammerR = Map.CopyMapObject(self._hammerR, true);
        hammerL.Active = true;
        hammerR.Active = true;
        hammerL.GetComponent("Hammer").Setup(sender.Character);
        hammerR.GetComponent("Hammer").Setup(sender.Character);
        playerDict = Dict();
        playerDict.Set("player", sender);
        playerDict.Set("L", hammerL);
        playerDict.Set("R", hammerR);
        self._playerData.Add(playerDict);
        if(sender == Network.MyPlayer){
          self.Delay(sender.Character, self._haoTianChuiCD, hammerL, hammerR);
        }
        
        return;
      }

      if(message == "Destroy|"){
        for(i in Range(0, self._playerData.Count, 1)){
          if(self._playerData.Get(i).Get("player") == sender && sender.Status == "Alive"){
            Map.DestroyMapObject(self._playerData.Get(i).Get("L"), true);
            Map.DestroyMapObject(self._playerData.Get(i).Get("R"), true);
          }
        }
        return;
      }
    }

    function CreateRagdoll(hammer, titan, name)
    {
        pos = titan.Position.X + ", " + (titan.Position.Y + titan.Size * 10) + ", " + titan.Position.Z;
        rot = titan.Rotation.X + ", " + titan.Rotation.Y + ", " + titan.Rotation.Z;

        r = Map.CreateMapObjectRaw("Scene,Geometry/Capsule,15,0,1,1,0,0,Capsule,"+pos+","+rot+",0.9,0.9,0.9,Physical,MapObjects,Default,Default|255/0/255/255,RagdollTitan|,Rigidbody|Mass:2|Gravity:0/-20/0|FreezeRotation:false|Interpolate:false");
        r.GetComponent("RagdollTitan").Setup(titan);

        rb = r.GetComponent("Rigidbody");
        force = ((r.Position - hammer).Normalized) * self.TitanBlowawayForce;
        torque = Random.RandomVector3(Vector3(0.1,0.1,0.1) * (0-self.TitanBlowawayForce), Vector3(0.1,0.1,0.1) * self.TitanBlowawayForce);
        rb.AddForceWithMode(force, "VelocityChange");
        rb.AddTorque(torque, "VelocityChange");
        /*
        titan.GetKilled(name);
        titan.PlayAnimation("Idle");
        */
       self.FlyDelay(3.0, r);
    }

    function OnSecond(){
      if(!self._haoTianChuiEnabled && self._haoTianChuiRoundTime <= Main.HaoTianChuiCD){
        self._haoTianChuiRoundTime -= 1;
      }
    }

    coroutine Delay(character, second, L, R){
      self._haoTianChuiRoundTime = second;
      wait second;
      Camera.FollowDistance = self._followDistance;
      character.Speed = self._speed;
      character.MaxGas = self._maxGas;
      character.CurrentGas = self._currentGas;
      character.MaxBladeDurability = self._maxBladeDurability;
      character.CurrentBladeDurability = self._currentBladeDurability;
      Network.SendMessageAll("Destroy|");
    }

    coroutine FlyDelay(second, r){
      wait second;
      Map.DestroyMapObject(r, true);
    }
  }

  component AnnoyComponent
{

    function OnTick()
    {
        sum = 0;
        for (i in Range(0,10000,1))
        {
          sum = sum + 1;
        }
    }

    function OnCollisionStay(other)
    {
        
    }
}


# 锤子相关组件
component RagdollTitan
{
    titan = null;

    function Setup(titan)
    {
        self.titan = titan;
    }

    function OnFrame()
    {
        if (self.titan != null)
        {
            self.titan.Position = self.MapObject.Position - self.MapObject.Up * self.titan.Size * 10;
            self.titan.QuaternionRotation = self.MapObject.QuaternionRotation;
        }
        else
        {
            Map.DestroyMapObject(self.MapObject, true);
        }
    }

}

component Hammer
{
    LeftHanded = false;

    _human = null;
    _collider = null;

    function HandleCollision(other)
    {
        if (self._human.IsMine && ((self._human.State == "Attack" && !Input.GetKeyHold("Human/AttackDefault")) || (self._human.State == "SpecialAttack" && !Input.GetKeyHold("Human/AttackSpecial"))))
        {
            Game.SpawnEffect("Boom1", self._collider.MapObject.Position, Vector3.Zero, 2);
            /*
            if (Network.IsMasterClient)
            { 
              
                Main._humanSkill.CreateRagdoll(self.MapObject.Position, other, Network.MyPlayer.Name);
            }
            else
            {
                Network.SendMessage(Network.MasterClient, "CreateRagdoll|" + Convert.ToString(other.ViewID));
            }
             */
            Network.SendMessageAll("CreateRagdoll|" + Convert.ToString(other.ViewID));
        }
    }

    function Setup(human)
    {
        # waits a frame since components are loaded a frame after the object is copied
        wait 0.0;

        self._collider = self.MapObject.GetChild("collider").GetComponent("HammerCollision");
        self._collider.SetHandler(self);

        transform = null;

        if (self.LeftHanded)
        {
            transform = human.Transform.GetTransform("Armature/Core/Controller_Body/hip/spine/chest/shoulder_L/upper_arm_L/forearm_L/hand_L");
            self.MapObject.Parent = transform;
            self.MapObject.LocalRotation = Vector3(0,0,90);
        }
        else
        {
            transform = human.Transform.GetTransform("Armature/Core/Controller_Body/hip/spine/chest/shoulder_R/upper_arm_R/forearm_R/hand_R");
            self.MapObject.Parent = transform;
            self.MapObject.LocalRotation = Vector3(0,0,-90);
        }

        self.MapObject.LocalPosition = Vector3.Zero;
        self._human = human;
    }
}

component HammerCollision
{
    _handler = null;

    function SetHandler(handler)
    {
        self._handler = handler;
    }

    function OnCollisionEnter(other)
    {
        if (self._handler != null && (other.Type == "Titan") && other.Health > 0)
        {
            self._handler.HandleCollision(other);
        }
    }
}


# 特效——风压相关扩展
  extension CustomEffects
  {
      # @type List
      _objects = List();
      
      StepOffsetX = 1.0;
      StepOffsetY = 1.0;
      
      RotationStepX = 200.0;
      RotationStepY = 30.0;
      RotationStepZ = 100.0;
    _isExecuting = false;
    
    # @type MapObject
      _parentObject = null;

      function Init()
      {
          return;
      }

      function FetchObjects()
      {
      self._parentObject = Map.CreateMapObjectRaw("Scene,Geometry/NavMeshObstacle,90000,0,1,0,0,0,SoundWave,31.80826,8.113185,129.3632,0,0,0,1,1,1,
      None,Characters,Default,Default|255/255/255/255,");

          Map.CreateMapObjectRaw("Scene,Geometry/Ring1,90001,0,1,0,1,0,Stripes,31.80826,8.113185,129.3632,354.6134,14.39247,20.09388,45,11.00024,
          45,None,Entities,Default,Transparent|255/255/255/255|Misc/Gradient6|0.3/2|0/0.8");

          Map.CreateMapObjectRaw("Scene,Geometry/Ring1,90002,0,1,0,1,0,Stripes,31.80826,8.113185,129.3632,4.309014,14.74416,344.0661,52,6.695132,
          52,None,Entities,Default,Transparent|255/255/255/255|Misc/Gradient6|0.3/2|0/0.7");

          Map.CreateMapObjectRaw("Scene,Geometry/Ring1,90003,0,1,0,1,0,Stripes,31.80826,8.113185,129.3632,347.1119,351.5952,123.5219,57,6.032907,
      57, None,Entities,Default,Transparent|255/255/255/255|Misc/Gradient6|0.3/2|0/0.7");

          self._objects = Map.FindMapObjectsByName("Stripes");

      self._parentObject.Active = false;
      
      for (mobject in self._objects)
      {
        mobject.Parent = self._parentObject;
      }
      }

    coroutine ActivateTime(delay, object, time, scaleFactor)
    {
      if (self._isExecuting)
      {
        return;
      }
      self._isExecuting = true;
      prevScale = self._parentObject.Scale;
      self._parentObject.Scale *= scaleFactor;
      wait delay;
      if (self._parentObject.Active)
      {
        return;
      }
      self._parentObject.Active = true;
      if (object == null)
      {
        self._parentObject.Active = false;
        self._isExecuting = false;
        self._parentObject.Scale = prevScale;
        return;
      }
      self._parentObject.Position = object.Position;
      wait time;
      self._parentObject.Active = false;
      self._isExecuting = false;
      self._parentObject.Scale = prevScale;
    }
      function OnFrame()
      {
      if (self._parentObject != null && self._parentObject.Active)
      {
        for (i in Range(0, self._objects.Count, 1))
        {
          x = 1;
          y = 1;
          z = 1;
          if ( i == 0 )
          {
            y = -1.4;
          }
          elif ( i == 1 )
          {
            z = -1.0;
            y = 1.3;
          }
          elif ( i == 2 )
          {
            x = -1.0;
            y = 1.3;
          }
          # @type MapObject
          stripes = self._objects.Get(i);
          stripes.TextureOffsetX += Time.FrameTime * self.StepOffsetX;
          stripes.TextureOffsetY += Time.FrameTime * self.StepOffsetY;
          stripes.LocalRotation += Time.FrameTime * Vector3(self.RotationStepX * x ,  self.RotationStepY * y , self.RotationStepZ * z);
        }
      }
      }
  }