﻿	package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.transitions.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

	
	public class ExpandOnFocus extends MovieClip {
		
		private var startX:Number;
		private var startY:Number;
		private var offsetX:Number;
		private var offsetY:Number;
		private var scaleBig:Number;
		private var scaleSmall:Number;
		private var targetMC:MovieClip;
		private var duration:Number; //seconds for animation
		private var hitAreaMC:MovieClip; //optional property, can set the hitArea to a movieclip, the default is the target movieclip
		private var collapseDelay:Number;
		private var delayElapsed:Boolean;
		private var collapseTimer:Timer;
		private var mouseXi:Number;
		private var mouseYi:Number;
		private var mouseMoveTol:Number;
		
		private var collapseX:Tween = null;
		private var collapseY:Tween = null;
		private var collapseScaleX:Tween = null;
		private var collapseScaleY:Tween = null;
		private var expandX:Tween = null;
		private var expandY:Tween = null;
		private var expandScaleX:Tween = null;
		private var expandScaleY:Tween = null;

		public function ExpandOnFocus(targetMC:MovieClip, scaleBig:Number, offsetX:Number, offsetY:Number, ...hitAreaMC) {
			trace('ENTER ExpandOnFocus');
			super();
			this.targetMC = targetMC;
			this.startX = this.targetMC.x;
			this.startY = this.targetMC.y;
			this.offsetX = offsetX; //stage.stageWidth/2;
			this.offsetY = offsetY; //stage.stageHeight/2;
			this.scaleSmall = targetMC.scaleX; // initial scale
			this.scaleBig = scaleSmall*scaleBig; // how many times the smaller starting scale
			this.duration = 1; // in seconds
			this.hitAreaMC = hitAreaMC[0];
			this.collapseDelay = .2; //in seconds
			this.delayElapsed = true;
			this.mouseMoveTol = 30; //in pixels
			this.mouseXi = mouseX;
			this.mouseYi = mouseY;
						
			startExpandOnFocus();
		}

		//add timer that limits number of times the object can grow and shrink in a given amount of time


		//set start positions
		//set scales


		private function expand(event:MouseEvent) {
			if(hitHitArea() && mouseMoved()) {
				trace("rolled on" + event.currentTarget.name);
				this.targetMC.removeEventListener(MouseEvent.MOUSE_DOWN, this.expand);

				expandX = new Tween(this.targetMC,"x",Strong.easeOut,this.targetMC.x,startX+offsetX,duration,true);
				expandY = new Tween(this.targetMC,"y",Strong.easeOut,this.targetMC.y,startY+offsetY,duration,true);
				expandScaleX = new Tween(this.targetMC,"scaleX",Strong.easeOut,scaleSmall,scaleBig,duration,true);
				expandScaleY = new Tween(this.targetMC,"scaleY",Strong.easeOut,scaleSmall,scaleBig,duration,true);

				this.mouseXi = mouseX;
				this.mouseYi = mouseY;
				this.targetMC.addEventListener(MouseEvent.ROLL_OUT, collapse);
				//this.targetMC.addEventListener(MouseEvent.ROLL_OUT, this.setDelayElapsed);
			
				
			}
		}
				
		private function setDelayElapsed(event:MouseEvent):void {
			collapseTimer = new Timer(collapseDelay*1000,1);
			collapseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, collapse);
			collapseTimer.start();
		}
		
		public function hitHitArea():Boolean {
			if(this.hitAreaMC != null) {
				if(this.hitAreaMC.hitTestPoint(mouseX, mouseY, true)){
					return true;
				} else {
					return false;
				}
			} else {
				return true;
			}
		}
		
		public function mouseMoved():Boolean {
			if((this.collapseX != null && this.collapseX.isPlaying) || (this.expandX != null && this.expandX.isPlaying)) {
				var mouseChange = Math.sqrt(Math.pow(this.mouseXi - mouseX,2) + Math.pow(this.mouseYi - mouseY,2)); //calculate distance moved since last exapnd/collapse tween
				this.mouseYi = mouseY;
				this.mouseXi = mouseX;
				if( mouseChange < this.mouseMoveTol) { 
					if(hitAreaMC != null) { //check if in the hit area, if one is designated
						if(!this.hitAreaMC.hitTestPoint(mouseX,mouseY,true)) { 
							//trace('mouse move listener');
							targetMC.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.collapse);
						} else {
							//trace('remove move listener');
							targetMC.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.collapse);
						}
					} else if (!this.hitTestPoint(mouseX,mouseY,true)){ //if outside movieclip
						targetMC.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.collapse);
					}
					//trace('mouse did not move');
					return false; 
				} else { 
					//trace('mouse moved');
					//this.removeEventListener(MouseEvent.MOUSE_MOVE,this.collapse);
					return true;
					// save event for when mouse does move
				}
			}
			return true;
		}
		
		private function collapse(event:MouseEvent) {
			if(!this.hitTestPoint(mouseX,mouseY,true) /*&& mouseMoved()*/){
				trace('collapse');
				targetMC.stage.removeEventListener(MouseEvent.MOUSE_MOVE,collapse);
				//this.targetMC.removeEventListener(MouseEvent.ROLL_OUT,this.setDelayElapsed);
				this.targetMC.removeEventListener(MouseEvent.ROLL_OUT, this.collapse);
				collapseX = new Tween(this.targetMC,"x",Strong.easeOut,this.targetMC.x,startX,duration,true);
				collapseY = new Tween(this.targetMC,"y",Strong.easeOut,this.targetMC.y,startY,duration,true);
				collapseScaleX = new Tween(this.targetMC,"scaleX",Strong.easeOut,scaleBig,scaleSmall,duration,true);
				collapseScaleY = new Tween(this.targetMC,"scaleY",Strong.easeOut,scaleBig,scaleSmall,duration,true);

				this.mouseXi = mouseX;
				this.mouseYi = mouseY;
				this.targetMC.addEventListener(MouseEvent.MOUSE_DOWN, this.expand);
			
				//collapseScaleX.addEventListener(TweenEvent.MOTION_FINISH, collapseComplete);
			}
		}

		public function startExpandOnFocus() {
			this.targetMC.addEventListener(MouseEvent.MOUSE_DOWN, this.expand);
		}
		
		public function stopExpandOnFocus() {
			this.targetMC.removeEventListener(MouseEvent.MOUSE_DOWN, this.expand);
		}
		
		public function setStartX(value:Number):void {
			this.startX = value;
		}
		
		public function setStartY(value:Number):void {
			this.startY = value;
		}
	}
}