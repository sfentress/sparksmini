﻿//sparks.flash.sendCommand('insert_component', 'capacitor', "woo", "e30,e22", "C10");

package {

    import flash.display.Loader;
    import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Graphics;
    import flash.display.Sprite;
	import fl.motion.*;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
	import flash.geom.Rectangle;//kpc
    import flash.geom.Matrix;//kpc
	import flash.geom.Point;
	import flash.display.CapsStyle; //KPC
    import flash.net.URLRequest;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
	import flash.events.KeyboardEvent;
	import flash.text.*;

	import Lead;
    import org.concord.sparks.JavaScript;
    import Globe;
    
    public class ComponentCapacitor extends ComponentObj {
              
        private var graphicsLayer:MovieClip;
		private var lead1:Lead;
		private var lead2:Lead;
		private var lead:Lead; //KPC for drawleads registration point
		private var lead1ConnectPointX:Number;  //KPC
		private var lead2ConnectPointX:Number;  //KPC
		private var lead1ConnectPointY:Number;  //KPC
		private var lead2ConnectPointY:Number;  //KPC
		
		var angle:Number;  
		var leadOffset_x:Number;
		var leadOffset_y:Number;
		
		
		private var _leadColor1:uint; //KPC copy from wire
		private var _leadColor2:uint;  //KPC copy from wire
		private var connectLeads:Shape = new Shape(); //KPC
		
		private var _x1:Number;
		private var _y1:Number;
		private var _x2:Number;
		private var _y2:Number;
		private var _angle:Number;
		
		private var _lead_x1:Number;
		private var _lead_y1:Number;
		private var _lead_x2:Number;
		private var _lead_y2:Number;
		private var _leadTilt:Number = 15 * Math.PI/180;  //extra rotation for cap/reductor leads in radions 
		
		private var _leadLength:Number;
		private var capacitorColor:String; //kpc
		
		private var bandZoom:Boolean = true;
		private var embedVerdana:Font = new Font1();
		private var embedArialBlack:Font = new Font2();
		
		private var printColor:TextField = new TextField();
		private var labelTextField = new TextField();
		private var format:TextFormat = new TextFormat();
		private var formatLabel:TextFormat = new TextFormat();
		
		private const textTrim:Number = 8;

        
        public function ComponentCapacitor() {
            
			super();
            graphicsLayer = MovieClip(this.getChildByName('capacitor_mc'));
			_leadLength = 45; //5//length of exposed metal ends of wire in pixels
			
            //get leads and position leads
				this.putLeadsOnBottom();
				lead1 = this.getEnds()[0];
				lead2 = this.getEnds()[1];
	 
				this.graphicsLayer.getChildByName('label_mc').visible=false;
				capacitorColor="blue";
				setColor();
				//graphicsLayer.alpha = .5;
			   //Beginning of KPC Code for moving Ends and readjusting wire
				this.addChild(connectLeads);
				swapChildren(connectLeads, graphicsLayer);
				
        }
		
		public function setColor():void {
			switch(capacitorColor) {
				case 'green':
				this.graphicsLayer.gotoAndStop('green');
				break;
				case 'yellow':
				this.graphicsLayer.gotoAndStop('yellow');
				break;
				case 'blue':
				this.graphicsLayer.gotoAndStop('blue');
				break;
				case 'red':
				this.graphicsLayer.gotoAndStop('red');
				break;
			}
			
        
		}
		
		public function dimensionCapacitor(x1:Number,y1:Number,x2:Number,y2:Number):void {
			
			if(x1<=x2) {
				_x1 = x1;
				_y1 = y1;
				_x2 = x2;
				_y2 = y2;
			} else {
				_x1 = x2;
				_y1 = y2;
				_x2 = x1;
				_y2 = y1;
			}
			
			angle = Math.atan( (_y2-_y1) / (_x2-_x1) );  // angle of the line's slope in radians
			_angle = angle;
			leadOffset_x = _leadLength * Math.cos(_angle);
			leadOffset_y = _leadLength * Math.sin(_angle);
			
			 
			positionLeads(lead1, _x1, _y1, _angle-_leadTilt);
            positionLeads(lead2, _x2, _y2, _angle+_leadTilt);
			
			///KPC variables for getting curve to correct point on end of Lead. Luke's help with Trig
			_lead_x1 = _x1 + Math.cos(_angle - _leadTilt) * _leadLength;
 		    _lead_y1 = _y1 + Math.sin(_angle - _leadTilt) * _leadLength;
			_lead_x2 = _x2 - Math.cos(_angle + _leadTilt) * _leadLength;
    		_lead_y2 = _y2 - Math.sin(_angle + _leadTilt) * _leadLength;

			drawLeads();
			
		}
		//sparks.flash.sendCommand('insert_component', 'capacitor', "woo", "e30,e22", "C10");
		public function drawLeads():void  {
			
			
			var center_mc:MovieClip = MovieClip(this.graphicsLayer.getChildByName('center_mc'));
			var curveToPointY:Number;
			_leadColor1 = 0xA0A0A0; // the lead's outer color - the lead is two-toned
			_leadColor2 = 0xE5E5E5;
			
			//center the main resistor between the leads  
			graphicsLayer.x =  (lead1.x + lead2.x) /2;
			graphicsLayer.y = (lead1.y + lead2.y)/2;
			graphicsLayer.rotation += _angle*180/Math.PI;  //KPC Capacitors need to rotate.
			
			//KPC curveToPoint vector coordinates - I don't know why these coordinates works, but they do.
			var curveToPoint:Point=new Point(graphicsLayer.x + leadOffset_y*2, graphicsLayer.y - leadOffset_x*2);
			
			connectLeads.graphics.clear();
			
			connectLeads.graphics.lineStyle(8.5, 0x565656, 1.0,false, "normal", CapsStyle.NONE, null, 0);
			connectLeads.graphics.moveTo(_lead_x1, _lead_y1);
			connectLeads.graphics.curveTo(curveToPoint.x, curveToPoint.y, _lead_x2, _lead_y2);	
			
			
			connectLeads.graphics.lineStyle(5, _leadColor1, 1.0,false, "normal", CapsStyle.NONE, null, 0);
			connectLeads.graphics.moveTo(_lead_x1, _lead_y1);
			connectLeads.graphics.curveTo(curveToPoint.x, curveToPoint.y, _lead_x2, _lead_y2);	
			
			connectLeads.graphics.lineStyle(2, _leadColor2, 1);
			connectLeads.graphics.moveTo(_lead_x1, _lead_y1);
			connectLeads.graphics.curveTo(curveToPoint.x, curveToPoint.y, _lead_x2, _lead_y2);	
		}
						
		public function setLabel(labelStr:String){
			if(labelStr != ''){
				trace('resistorLabel is: '+labelStr);
				var label_mc:MovieClip = MovieClip(this.graphicsLayer.getChildByName('label_mc'));
				var threeDigitTextWidth:int = 35;
				formatLabel.font = embedArialBlack.fontName;
				formatLabel.color = 0xFFFFFF;
				formatLabel.size = 18;
				formatLabel.bold = true;
			
				label_mc.labelTextField = new TextField();
				label_mc.labelTextField.defaultTextFormat = formatLabel;
				label_mc.labelTextField.selectable = false; 
				label_mc.labelTextField.embedFonts = true;
				label_mc.labelTextField.antiAliasType = AntiAliasType.ADVANCED;
				label_mc.labelTextField.x = 0;
				label_mc.labelTextField.y = 2;
				label_mc.labelTextField.text = labelStr;
				label_mc.labelTextField.width = label_mc.labelTextField.textWidth+5;
				label_mc.labelTextField.height = label_mc.labelTextField.textHeight+2;	
				//label_mc.labelTextField.embedFonts = true;
				label_mc.addChild(label_mc.labelTextField);
				//mock centering of label text
				if ( label_mc.labelTextField.textWidth < threeDigitTextWidth ) {
					label_mc.x +=5;
				}
				trace("text width="+label_mc.labelTextField.textWidth);
			
				this.addEventListener(MouseEvent.MOUSE_OVER, labelOn);
				this.addEventListener(MouseEvent.MOUSE_OUT, labelOff);
			}
		}
		
		private function labelOn(event:MouseEvent):void {
			this.graphicsLayer.getChildByName('label_mc').visible=true;
		}
		private function labelOff(event:MouseEvent):void {
			this.graphicsLayer.getChildByName('label_mc').visible=false;
		}       
    }
}