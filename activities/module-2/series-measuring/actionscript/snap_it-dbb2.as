﻿var blackPlugArmatureNumber:Number = 22;var blackPlugikBoneName:Number = 32;var redPlugArmatureNumber:Number = 24;var redPlugikBoneName:Number = 287;var plugOne_pluggedIn:Boolean = false;var plugTwo_pluggedIn:Boolean = false;var plugThree_pluggedIn:Boolean = false;var whichPlug1:String = "empty";var whichPlug2:String = "empty";var whichPlug3:String = "empty";//stop plug_IN mcs from loopingdmm_mc.plug_IN1.gotoAndStop("black");dmm_mc.plug_IN2.gotoAndStop("black");dmm_mc.plug_IN3.gotoAndStop("black");//set alpha levels for all plugs and statesdmm_mc.plug_black.alpha = 1;dmm_mc.plug_IN1.alpha = 0;dmm_mc.plug_IN2.alpha = 0;dmm_mc.plug_IN3.alpha = 0;stage.addEventListener(MouseEvent.MOUSE_UP, snap_to_place);function snap_to_place(event:MouseEvent):void{	var minX:Array = new Array(0, -69, -69, -69); //values for plug hotspots,	var maxX:Array = new Array(0, -29, -29, -29);  // ignore index 0, plug1, plug2 and plug3	var minY:Array = new Array(0, 301, 338, 370); 	var maxY:Array = new Array(0, 330, 367, 410);		var blackPlug_armature:IKArmature = IKManager.getArmatureByName('Armature_' + blackPlugArmatureNumber);	var blackPlug_bone:IKBone = blackPlug_armature.getBoneByName('ikBoneName' + blackPlugikBoneName);	var blackPlug_boneTip:Point = blackPlug_bone.tailJoint.position;	var blackPlug_tipX = dmm_mc.plug_black.x + blackPlug_boneTip.x;	var blackPlug_tipY = dmm_mc.plug_black.y + blackPlug_boneTip.y;		var redPlug_armature:IKArmature = IKManager.getArmatureByName('Armature_' + redPlugArmatureNumber);	var redPlug_bone:IKBone = redPlug_armature.getBoneByName('ikBoneName' + redPlugikBoneName);	var redPlug_boneTip:Point = redPlug_bone.tailJoint.position;	var redPlug_tipX = dmm_mc.plug_red.x + redPlug_boneTip.x;	var redPlug_tipY = dmm_mc.plug_red.y + redPlug_boneTip.y;	//trace("**************");////trace("blackPlug_boneTip " + blackPlug_boneTip);//trace("dmm_mc.plug_black.x " + dmm_mc.plug_black.x);//trace("dmm_mc.plug_black.y " + dmm_mc.plug_black.y);//trace("blackPlug_tipX " + blackPlug_tipX);//trace("blackPlug_tipY " + blackPlug_tipY);//////trace("**************");////trace("redPlug_boneTip " + redPlug_boneTip);//trace("dmm_mc.plug_red.x " + dmm_mc.plug_red.x);//trace("dmm_mc.plug_red.y " + dmm_mc.plug_red.y);//trace("redPlug_tipX " + redPlug_tipX);//trace("redPlug_tipY " + redPlug_tipY); if (  (blackPlug_tipX > minX[1] && blackPlug_tipX < maxX[1]) 		&& (blackPlug_tipY > minY[1] && blackPlug_tipY < maxY[1])		&& plugOne_pluggedIn == false  )   	{	 	dmm_mc.plug_black.alpha = 0;	 	dmm_mc.plug_IN1.alpha = 1;		dmm_mc.plug_IN1.gotoAndStop("black");		plugOne_pluggedIn = true;		whichPlug1="black"; 	} 	else if ( (blackPlug_tipX > minX[2] && blackPlug_tipX < maxX[2]) 		&& (blackPlug_tipY > minY[2] && blackPlug_tipY < maxY[2])		&& plugTwo_pluggedIn == false )  	{	 	dmm_mc.plug_black.alpha = 0;	 	dmm_mc.plug_IN2.alpha = 1;		dmm_mc.plug_IN2.gotoAndStop("black");		plugTwo_pluggedIn = true;		whichPlug2="black"; 	}		else if ( (blackPlug_tipX > minX[3] && blackPlug_tipX < maxX[3]) 		&& (blackPlug_tipY > minY[3] && blackPlug_tipY < maxY[3])		&& plugThree_pluggedIn == false )  	{	 	dmm_mc.plug_black.alpha = 0;	 	dmm_mc.plug_IN3.alpha = 1;		dmm_mc.plug_IN3.gotoAndStop("black");		plugThree_pluggedIn = true;		whichPlug3="black";				 	}		 else if (  (redPlug_tipX > minX[1] && redPlug_tipX < maxX[1]) 		&& (redPlug_tipY > minY[1] && redPlug_tipY < maxY[1])		&& plugOne_pluggedIn == false  )   	{	 	dmm_mc.plug_red.alpha = 0;	 	dmm_mc.plug_IN1.alpha = 1;		dmm_mc.plug_IN1.gotoAndStop("red");		plugOne_pluggedIn = true;		whichPlug1="red"; 	}		else if (  (redPlug_tipX > minX[2] && redPlug_tipX < maxX[2]) 		&& (redPlug_tipY > minY[2] && redPlug_tipY < maxY[2])		&& plugTwo_pluggedIn == false  )   	{	 	dmm_mc.plug_red.alpha = 0;	 	dmm_mc.plug_IN2.alpha = 1;		dmm_mc.plug_IN2.gotoAndStop("red");		plugTwo_pluggedIn = true;		whichPlug2="red";		 	}		else if (  (redPlug_tipX > minX[3] && redPlug_tipX < maxX[3]) 		&& (redPlug_tipY > minY[3] && redPlug_tipY < maxY[3])		&& plugThree_pluggedIn == false  )   	{	 	dmm_mc.plug_red.alpha = 0;	 	dmm_mc.plug_IN3.alpha = 1;		dmm_mc.plug_IN3.gotoAndStop("red");		plugThree_pluggedIn = true;		whichPlug3="red"; 	}	/*	trace("plugOne_pluggedIn = " + plugOne_pluggedIn);	trace("plugTwo_pluggedIn = " + plugTwo_pluggedIn);	trace("plugThree_pluggedIn = " + plugThree_pluggedIn);	trace("***********************");	trace('Probe Location: x=' + blackPlug_tipX + ', y=' + blackPlug_tipY);*/}stage.addEventListener(MouseEvent.MOUSE_DOWN, container_visible);function container_visible(event:MouseEvent):void{	//Add Stage Values for hotspot variables at normal size dmm_mc.  Add space to grab entire plug	var minX:Array = new Array(0, 1390, 1390, 1390); //values for plug hotspots relative to Stage,	var maxX:Array = new Array(0, 1464, 1464, 1464);  // ignore index 0, plug1, plug2 and plug3	var minY:Array = new Array(0, 295, 334, 372); 	var maxY:Array = new Array(0, 324, 363, 401);	if ( (event.stageX > (minX[1] ) && event.stageX < (maxX[1] )) 		&& (event.stageY > (minY[1] )  && event.stageY < (maxY[1] ))		&& plugOne_pluggedIn == true  && whichPlug1=="black")	{		dmm_mc.plug_black.alpha = 1;		dmm_mc.plug_IN1.alpha = 0;		plugOne_pluggedIn = false;		whichPlug1="empty";	}		else if ( (event.stageX > (minX[1] ) && event.stageX < (maxX[1] )) 		&& (event.stageY > (minY[1] )  && event.stageY < (maxY[1] ))		&& plugOne_pluggedIn == true  && whichPlug1=="red")	{		dmm_mc.plug_red.alpha = 1;		dmm_mc.plug_IN1.alpha = 0;		plugOne_pluggedIn = false;		whichPlug1="empty";	}				else if ( (event.stageX > (minX[2] ) && event.stageX < (maxX[2] )) 		&& (event.stageY > (minY[2] ) && event.stageY < (maxY[2] ))		&& plugTwo_pluggedIn == true  && whichPlug2=="black" )	{		dmm_mc.plug_black.alpha = 1;		dmm_mc.plug_IN2.alpha = 0;		plugTwo_pluggedIn = false;		whichPlug2="empty";	}			else if ( (event.stageX > (minX[2] ) && event.stageX < (maxX[2] )) 		&& (event.stageY > (minY[2] ) && event.stageY < (maxY[2] ))		&& plugTwo_pluggedIn == true  && whichPlug2=="red" )	{		dmm_mc.plug_red.alpha = 1;		dmm_mc.plug_IN2.alpha = 0;		plugTwo_pluggedIn = false;		whichPlug2="empty";	}		else if ( (event.stageX > (minX[3] ) && event.stageX < (maxX[3])) 		&& (event.stageY > (minY[3] ) && event.stageY < (maxY[3] ))		&& plugThree_pluggedIn == true && whichPlug3=="black"  )	{		dmm_mc.plug_black.alpha = 1;		dmm_mc.plug_IN3.alpha = 0;		plugThree_pluggedIn = false;		whichPlug3="empty";	}		else if ( (event.stageX > (minX[3] ) && event.stageX < (maxX[3])) 		&& (event.stageY > (minY[3] ) && event.stageY < (maxY[3] ))		&& plugThree_pluggedIn == true && whichPlug3=="red"  )	{		dmm_mc.plug_red.alpha = 1;		dmm_mc.plug_IN3.alpha = 0;		plugThree_pluggedIn = false;		whichPlug3="empty";	}}	