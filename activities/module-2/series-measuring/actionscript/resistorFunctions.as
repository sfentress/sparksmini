﻿  	var redProbeArmatureNumber:Number = 8;	var redProbeikBoneName:Number = 131;	var blackProbeArmatureNumber:Number = 16;	var blackProbeikBoneName:Number = 202;	var probeOnLeft:Boolean = false;	var probeOnRight:Boolean = false;	var blackProbeOnRight:Boolean = false;	var redProbeOnRight:Boolean = false;	var blackProbeOnLeft:Boolean = false;	var redProbeOnLeft:Boolean = false;	var sndClickIt:clickit3;	var sndClickItChannel:SoundChannel;	var transform1:SoundTransform=new SoundTransform();		//manually set x and y values for probe mc's	var probeRedX:Number = 360.8;	var probeRedY:Number = 40.4;	var probeBlackX:Number = -264.4;	var probeBlackY:Number = 68.8;		var currentHoleOne:MovieClip = null;	var currentHoleTwo:MovieClip = null;		var resistorLeftLocation:String;	var resistorRightLocation:String;		this.resistor_rollover_left.alpha=0;	this.probe_engaged_left.alpha = 0;	this.resistor_rollover_right.alpha=0;	this.probe_engaged_right.alpha = 0;		loadResistor();	resistorLocationInitialValues();    //testResistorTips();	function resistorLocationInitialValues():void{	resistorOnBoard();	//trace(MovieClip(parent).rows[1][1]);	//var gridSize:int = 2;  //var mainArr:Array = new Array(gridSize);  //var i:int;  //var j:int;  //for (i = 0; i < gridSize; i++) {  //    mainArr[i] = new Array(gridSize);  //    for (j = 0; j < gridSize; j++) {  //        mainArr[i][j] = "[" + i + "][" + j + "]";  //    }  }  function resistorOnBoard():void{	if (currentHoleOne != null )	{		currentHoleOne.gotoAndStop(1);		currentHoleOne = null;	}		if (currentHoleTwo != null )	{		currentHoleTwo.gotoAndStop(1);		currentHoleTwo = null;	}		//for every row ...	for(var rowNum:int = 1; rowNum<=10; rowNum++)	{		//start at left of grid		//accessin the list of row by index		var row:Array = MovieClip(parent).rows[rowNum]; 				//for every hole in the row...		for (var holeNum:int = 1; holeNum <=30; holeNum++)		{			var h:MovieClip = row[holeNum];			//trace("h.x = " + h.x + " " + "h.y = " + h.y);			var boardRow:String;						switch(rowNum)			{				case 1:					boardRow="a";					break;				case 2:					boardRow="b";					break;				case 3:					boardRow="c";					break;				case 4:					boardRow="d";					break;				case 5:					boardRow="e";					break;				case 6:					boardRow="f";					break;				case 7:					boardRow="g";					break;				case 8:					boardRow="h";					break;				case 9:					boardRow="i";					break;				case 10:					boardRow="j";					break;			}								if (  (resistorTipLeftX > h.x) &&  (resistorTipLeftX < h.x + 12)  &&  (resistorTipLeftY > h.y) &&  (resistorTipLeftY < h.y + 12) )			{				currentHoleOne = h;				h.gotoAndStop(2);				resistorLeftLocation = boardRow+holeNum;				trace (this.name + " " + resistorLeftLocation + " Left On" );				//trace(this.name + " Row = " + boardRow + " Column = " + holeNum + " Left Side On");			}						else if (  (resistorTipRightX > h.x) &&  (resistorTipRightX < h.x + 12)  &&  (resistorTipRightY > h.y) &&  (resistorTipRightY < h.y + 12) )			{				currentHoleTwo = h;				h.gotoAndStop(2);				resistorRightLocation = boardRow+holeNum;				trace (this.name + " " + resistorRightLocation + " Right On" );				//trace(this.name + " Row = " + boardRow + " Column = " + holeNum + " Left Side On");			}		}	}}stage.addEventListener(MouseEvent.MOUSE_UP, onResistorMove);function onResistorMove(event:MouseEvent):void{	var newResistorTipLeftX:Number = (this).x + 2;	var newResistorTipLeftY:Number = (this).y + 9;	var newResistorTipRightX:Number = (this).x + .8 + 53 + 10;	var newResistorTipRightY:Number = (this).y + 9;			if ((newResistorTipLeftX != resistorTipLeftX) || (newResistorTipLeftY != resistorTipLeftY) )	{		resistorTipLeftX = newResistorTipLeftX;		resistorTipLeftY = newResistorTipLeftY;		resistorTipRightX = newResistorTipRightX;		resistorTipRightY = newResistorTipRightY;		this.resistorOnBoard();	}}/*stage.addEventListener(MouseEvent. MOUSE_UP, clip_it_right);	function clip_it_right(event:MouseEvent):void	{		//trace("parent =" + (parent).x);	//trace("resistor rolloverY = " + ((this).y + resistor_rollover_left.y));	//trace("(parent).x" + (parent).x);	//trace("(parent.parent).x" + (parent.parent).x);	//trace(resistor_rollover_right.x);	//trace("hotspot1Right_minX" + hotspot1Right_minX);	//trace("hotspot1Right_maxX" + hotspot1Right_maxX);	//trace("hotspot1Right_minY" + hotspot1Right_minY);	//trace("hotspot1Right_maxY" + hotspot1Right_maxY);	//trace("--------");		var hotspot1Right_minX:Number = (parent).x + (this).x + 47.2;	var hotspot1Right_maxX:Number = (parent).x + (this).x + 70.2;	var hotspot1Right_minY:Number = (parent).y + (this).y + -4;	var hotspot1Right_maxY:Number = (parent).y + (this).y + 15.1;			var redProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + redProbeArmatureNumber);	var redProbe_bone:IKBone = redProbe_armature.getBoneByName('ikBoneName' + redProbeikBoneName);	var redProbe_boneTip:Point = redProbe_bone.tailJoint.position;	var redProbe_tipX = (parent).x + probeRedX + redProbe_boneTip.x;	var redProbe_tipY = (parent).y + probeRedY + redProbe_boneTip.y;	//trace("resistor rolloverX = " + ((parent).x +(this).x + hotspotWidth + resistorBodyWidth));	//trace("red probetipX = " + redProbe_tipX);	//trace("red probetipY = " + redProbe_tipY);	var blackProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + blackProbeArmatureNumber);	var blackProbe_bone:IKBone = blackProbe_armature.getBoneByName('ikBoneName' + blackProbeikBoneName);	var blackProbe_boneTip:Point = blackProbe_bone.tailJoint.position;	var blackProbe_tipX = (parent).x + probeBlackX + blackProbe_boneTip.x;	var blackProbe_tipY = (parent).y + probeBlackY + blackProbe_boneTip.y;	if (  (redProbe_tipX > hotspot1Right_minX && redProbe_tipX < hotspot1Right_maxX) 		&& (redProbe_tipY > hotspot1Right_minY && redProbe_tipY < hotspot1Right_maxY)		&& this.probeOnRight == false ) 	{		sndClickIt=new clickit3();		sndClickItChannel=sndClickIt.play(); 		transform1.volume=.75;		sndClickItChannel.soundTransform=transform1;		probeOnRight = true;		redProbeOnRight = true;		this.probe_engaged_right.alpha = 1;		//var clip_coordinate_x:Number = redProbe_tipX;		//var clip_coordinate_y:Number = redProbe_tipY;		//trace(redProbe_tipX);		//trace(redProbe_tipY);		//trace(clip_coordinate_x);		//trace(clip_coordinate_y);		//left_clip.alpha=1;		//left_clip.x = clip_coordinate_x;		//left_clip.y = clip_coordinate_y; 	} 		else if ( (blackProbe_tipX > hotspot1Right_minX && blackProbe_tipX < hotspot1Right_maxX) 		&& (blackProbe_tipY > hotspot1Right_minY && blackProbe_tipY < hotspot1Right_maxY)		&& this.probeOnRight == false)	{		sndClickIt=new clickit3();		sndClickItChannel=sndClickIt.play(); 		transform1.volume=.75;		sndClickItChannel.soundTransform=transform1;		probeOnRight = true;		blackProbeOnRight = true;		this.probe_engaged_right.alpha = 1;	}		else if (  (redProbe_tipX > hotspot1Right_minX && redProbe_tipX < hotspot1Right_maxX) 		&& (redProbe_tipY > hotspot1Right_minY && redProbe_tipY < hotspot1Right_maxY)		&& redProbeOnRight == true )		 	{ 		probeOnRight = true;		redProbeOnRight = true;		this.probe_engaged_right.alpha = 1;	}		else if ( (blackProbe_tipX > hotspot1Right_minX && blackProbe_tipX < hotspot1Right_maxX) 		&& (blackProbe_tipY > hotspot1Right_minY && blackProbe_tipY < hotspot1Right_maxY)		&& blackProbeOnRight == true ) 	{		probeOnRight = true;		blackProbeOnRight = true;		this.probe_engaged_right.alpha = 1;	}		else 	{		probeOnRight = false;		blackProbeOnRight = false;		redProbeOnRight = false;		this.probe_engaged_right.alpha = 0;	}	//	trace(this.name + " probeOnRight = " + probeOnRight);//	trace(this.name + "redProbeOnRight = " + redProbeOnRight);//	trace(this.name + " blackProbeOnRight = " + blackProbeOnRight);}		///////////////////////////////stage.addEventListener(MouseEvent.MOUSE_UP, clip_it_left);function clip_it_left(event:MouseEvent):void{				var hotspot1Left_minX:Number = (parent).x + (this).x + -5;	var hotspot1Left_maxX:Number = (parent).x + (this).x + 20;	var hotspot1Left_minY:Number = (parent).y + (this).y + -10;	var hotspot1Left_maxY:Number =  (parent).y + (this).y + 19;		//var hotspotWidth:Number = 14;	//var hotspotHeight:Number = 7;	//	//var rolloverLeft_x:Number = (parent).x +(this).x + resistor_rollover_left.x;	//var rolloverLeft_y:Number = (parent).x +(this).x + resistor_rollover_left.y;	//set position of probe_red and probe_black movie clips manually	//because function doesn't recognize these mc's	var redProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + redProbeArmatureNumber);	var redProbe_bone:IKBone = redProbe_armature.getBoneByName('ikBoneName' + redProbeikBoneName);	var redProbe_boneTip:Point = redProbe_bone.tailJoint.position;	var redProbe_tipX = (parent).x + probeRedX + redProbe_boneTip.x;	var redProbe_tipY = (parent).y + probeRedY + redProbe_boneTip.y;	var blackProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + blackProbeArmatureNumber);	var blackProbe_bone:IKBone = blackProbe_armature.getBoneByName('ikBoneName' + blackProbeikBoneName);	var blackProbe_boneTip:Point = blackProbe_bone.tailJoint.position;	var blackProbe_tipX = (parent).x + probeBlackX + blackProbe_boneTip.x;	var blackProbe_tipY = (parent).y + probeBlackY + blackProbe_boneTip.y;	if (  (redProbe_tipX > hotspot1Left_minX && redProbe_tipX < hotspot1Left_maxX) 		&& (redProbe_tipY > hotspot1Left_minY && redProbe_tipY < hotspot1Left_maxY)		&& probeOnLeft == false )   	{		sndClickIt=new clickit3();		sndClickItChannel=sndClickIt.play(); 		transform1.volume=.75;		sndClickItChannel.soundTransform=transform1;		probeOnLeft = true;		redProbeOnLeft = true;		this.probe_engaged_left.alpha = 1;	 	} 		else if ((blackProbe_tipX > hotspot1Left_minX && blackProbe_tipX < hotspot1Left_maxX) 		&& (blackProbe_tipY > hotspot1Left_minY && blackProbe_tipY < hotspot1Left_maxY)		&& probeOnLeft == false )	{		sndClickIt=new clickit3();		sndClickItChannel=sndClickIt.play(); 		transform1.volume=.75;		sndClickItChannel.soundTransform=transform1;		probeOnLeft = true;		blackProbeOnLeft = true;		this.probe_engaged_left.alpha = 1;		}		else if (  (redProbe_tipX > hotspot1Left_minX && redProbe_tipX < hotspot1Left_maxX) 		&& (redProbe_tipY > hotspot1Left_minY && redProbe_tipY < hotspot1Left_maxY)		&& redProbeOnLeft == true )		 	{ 		probeOnLeft = true;		redProbeOnLeft = true;		this.probe_engaged_left.alpha = 1;	}		else if ((blackProbe_tipX > hotspot1Left_minX && blackProbe_tipX < hotspot1Left_maxX) 		&& (blackProbe_tipY > hotspot1Left_minY && blackProbe_tipY < hotspot1Left_maxY)		&& blackProbeOnLeft == true ) 	{		probeOnLeft = true;		blackProbeOnLeft = true;		this.probe_engaged_left.alpha = 1;	}		else 		{		probeOnLeft = false;		redProbeOnLeft = false;		blackProbeOnLeft = false;		this.probe_engaged_left.alpha = 0;	}	//	trace(this.name + " probeOnLeft = " + probeOnLeft);//	trace(this.name + "redProbeOnLeft = " + redProbeOnLeft);//	trace(this.name + " blackProbeOnLeft = " + blackProbeOnLeft);}////////////////////////////////stage.addEventListener(Event.ENTER_FRAME, resistor_rollovers_right);function resistor_rollovers_right(event:Event):void{	var hotspot1Right_minX:Number = (parent).x + (this).x + 47.2;	var hotspot1Right_maxX:Number = (parent).x + (this).x + 70.2;	var hotspot1Right_minY:Number = (parent).y + (this).y + -4;	var hotspot1Right_maxY:Number = (parent).y + (this).y + 15.1;		var redProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + redProbeArmatureNumber);	var redProbe_bone:IKBone = redProbe_armature.getBoneByName('ikBoneName' + redProbeikBoneName);	var redProbe_boneTip:Point = redProbe_bone.tailJoint.position;	var redProbe_tipX = (parent).x + probeRedX + redProbe_boneTip.x;	var redProbe_tipY = (parent).y + probeRedY + redProbe_boneTip.y;	var blackProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + blackProbeArmatureNumber);	var blackProbe_bone:IKBone = blackProbe_armature.getBoneByName('ikBoneName' + blackProbeikBoneName);	var blackProbe_boneTip:Point = blackProbe_bone.tailJoint.position;	var blackProbe_tipX = (parent).x + probeBlackX + blackProbe_boneTip.x;	var blackProbe_tipY = (parent).y + probeBlackY + blackProbe_boneTip.y;	if (     (redProbe_tipX > hotspot1Right_minX && redProbe_tipX < hotspot1Right_maxX) 		&& (redProbe_tipY > hotspot1Right_minY && redProbe_tipY < hotspot1Right_maxY)		&& probeOnRight == false  		||   (blackProbe_tipX > hotspot1Right_minX && blackProbe_tipX < hotspot1Right_maxX) 		&& (blackProbe_tipY > hotspot1Right_minY && blackProbe_tipY < hotspot1Right_maxY)		&& probeOnRight == false ) 	{		this.resistor_rollover_right.alpha = 1;	}		else	{		this.resistor_rollover_right.alpha = 0;	}	}///////////////////////////stage.addEventListener(Event.ENTER_FRAME, resistor_rollovers_left);function resistor_rollovers_left(event:Event):void{				var hotspot1Left_minX:Number = (parent).x + (this).x + -5;	var hotspot1Left_maxX:Number = (parent).x + (this).x + 20;	var hotspot1Left_minY:Number = (parent).y + (this).y + -10;	var hotspot1Left_maxY:Number =  (parent).y + (this).y + 19;		var redProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + redProbeArmatureNumber);	var redProbe_bone:IKBone = redProbe_armature.getBoneByName('ikBoneName' + redProbeikBoneName);	var redProbe_boneTip:Point = redProbe_bone.tailJoint.position;	var redProbe_tipX = (parent).x + probeRedX + redProbe_boneTip.x;	var redProbe_tipY = (parent).y + probeRedY + redProbe_boneTip.y;	var blackProbe_armature:IKArmature = IKManager.getArmatureByName('Armature_' + blackProbeArmatureNumber);	var blackProbe_bone:IKBone = blackProbe_armature.getBoneByName('ikBoneName' + blackProbeikBoneName);	var blackProbe_boneTip:Point = blackProbe_bone.tailJoint.position;	var blackProbe_tipX = (parent).x + probeBlackX + blackProbe_boneTip.x;	var blackProbe_tipY = (parent).y + probeBlackY + blackProbe_boneTip.y;	if (     (redProbe_tipX > hotspot1Left_minX && redProbe_tipX < hotspot1Left_maxX) 		&& (redProbe_tipY > hotspot1Left_minY && redProbe_tipY < hotspot1Left_maxY)		&& probeOnLeft == false  		||   (blackProbe_tipX > hotspot1Left_minX && blackProbe_tipX < hotspot1Left_maxX) 		&& (blackProbe_tipY > hotspot1Left_minY && blackProbe_tipY < hotspot1Left_maxY)		&& probeOnLeft == false ) 	{		this.resistor_rollover_left.alpha = 1;	}		else	{		this.resistor_rollover_left.alpha = 0;	}}*///NOTES	//enter values because resistor is smaller on screen yet program looks at true values 	//var hotspotWidth:Number = 12;	//var hotspotHeight:Number = 3.4;	//var resistorBodyWidth:Number = 43;	//resistor rollover left x = .8	//resistor rollover left y = 7.3	//resistor rollover right x =     //hard code rollover and resistorTip values based on resistor width of 67	//use resistor_sm.fla for guidance - set size to desired size of resistor	//use testResistorTips to tweak resistorTip x and y values		//function to determine extact hotspot for the purpose of tweaking resistorTip values/*function testResistorTips():void{	var square:Sprite = new Sprite();	(MovieClip(parent).addChild(square));	square.graphics.lineStyle(1,0xFFFF00);	square.graphics.beginFill(0xFFFF00);	square.graphics.drawRect(0,0,2,2);	square.graphics.endFill();	square.x = resistorTipLeftX;	square.y = resistorTipLeftY;	square.alpha = .5;		var square2:Sprite = new Sprite();	(MovieClip(parent).addChild(square2));	square2.graphics.lineStyle(1,0xFFFF00);	square2.graphics.beginFill(0xFFFF00);	square2.graphics.drawRect(0,0,2,2);	square2.graphics.endFill();	square2.x = resistorTipRightX;	square2.y = resistorTipRightY;	square2.alpha = .5;}*/