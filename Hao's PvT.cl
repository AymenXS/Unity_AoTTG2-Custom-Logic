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
    ChangeTitanSizeTooltip = "玩家巨改变尺寸CD";

	TitanBaseDamage=100;
	TitanBaseDamageTooltip = "玩家巨基础伤害";
	TitanDamageRate=10;
  	TitanDamageRateTooltip = "玩家巨伤害随自身移速变化的倍率";
	
    _skillCD = null;

    _humanSkill = null;
    HaoTianChuiCD = 10;
    TitanBlowawayForce = 200.0;

    Description = "Survive a single round of titans.";
    Titans = 0;
    _hasSpawned = false;
    

	function Init()
	{
         self._skillCD = SkillCD();
         self._humanSkill = HumanSkill();        
	}
      	 
	 function OnNetworkMessage(sender, message)
        {     
          self._humanSkill.OnNetworkMessage(sender, message);
        }

  
    function OnGameStart()
    {
        if (Network.IsMasterClient)
        {
            Game.SpawnTitans("Default", self.Titans);
        }
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
      		self._skillCD.OnSecond();
          self._humanSkill.OnSecond();
	}


    function OnTick()
    {
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
                UI.SetLabelAll("MiddleCenter", "Humanity wins!");
                Game.End(10.0);
                return;
            }
            if (humans == 0 && playerShifters == 0 && self._hasSpawned)
            {
                UI.SetLabelAll("MiddleCenter", "Humanity failed!");
                Game.End(10.0);
                return;
            }
            UI.SetLabelAll("TopCenter", "Titans Left: " + Convert.ToString(titans));
        }
    }

    	function OnFrame()
	{
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

      	self._skillCD.OnFrame();
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
  class SkillCD{
    _jumpKeyEnabled = true;
    _jumpRoundTime = 0;
    _rockThrowEnabled = true;
    _rockThrowRoundTime = 0;
    _changeTitanSizeEnabled = true;
    _changeTitanSizeRoundTime = 0;

    _action = List();

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

        str = "";
        str += "跳跃cd：" + UI.WrapStyleTag(Convert.ToString(self._jumpRoundTime), "color", "#FFD700") + "    ";
        str += "投石cd：" + UI.WrapStyleTag(Convert.ToString(self._rockThrowRoundTime), "color", "#FFD700") + "    ";
        str += "改变体型cd f1：" + UI.WrapStyleTag(Convert.ToString(self._changeTitanSizeRoundTime), "color", "#FFD700") + "    ";
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
      }
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
          chuiEnabled = "持续时间剩余：" + Convert.ToString(self._haoTianChuiRoundTime);
        }else{
          chuiEnabled = "不可使用";
        }
        str += "昊天锤：" + UI.WrapStyleTag(chuiEnabled, "color", "#FFD700") + "    ";
        str += String.Newline + String.Newline + String.Newline + String.Newline;
        UI.SetLabel("BottomCenter", str);


        if(Input.GetKeyDown("Interaction/Function1")) {
          if(self._haoTianChuiEnabled){
            self._haoTianChuiEnabled = false;
            Game.Print("使用昊天锤");
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
        for(p in self._playerData){

          if(p.Get("player") == sender){
            Map.DestroyMapObject(p.Get("L"), true);
            Map.DestroyMapObject(p.Get("R"), true);
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
