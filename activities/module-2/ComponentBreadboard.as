﻿package
{
	import flash.display.MovieClip;
	
	public class ComponentBreadboard extends MovieClip
	{		
		public var expandOnFocus:ExpandOnFocus;
		private var startX:Number;
		private var startY:Number;
	
		public function ComponentBreadboard() {
			trace('ENTER ComponentBreadboard');
			//trace('component breadboard ' +this.stage.x+' '+this.stage.y);
			//expandOnFocus = new ExpandOnFocus(this,1.25,-130,-100, this.hitArea_mc);	// give breadboard rollover behavior  12/11 kpc comment out so bb won't zoom 
			// kpc uncommented expandOnFocus in Circuit.as
		}
		
		public function setStartX(value:Number) {
			this.startX = value;
		}
		public function setStartY(value:Number) {
			this.startY = value;
		}
		
	}
}