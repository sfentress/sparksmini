﻿package org.concord.sparks.activity.series_measuring {
    
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;
    import flash.display.MovieClip;
    import flash.geom.Point;
    
    import org.concord.sparks.Activity;
    import org.concord.sparks.circuit.multimeter.dmm_centech.DmmCentech2;
    import org.concord.sparks.util.Debug;
	
	import Globe;
    
    public class Activity extends org.concord.sparks.Activity {

        private var circuit:Circuit;
        //public var multimeter:DmmCentech2;
        //private var breadboard:MovieClip;

        public function Activity(name:String, root, topDir):void {
            trace('ENTER Activity: ' + new Date());
            super(name, root, topDir);
            
            //Debug.traceDisplayList(root);

            circuit = new Circuit(this, root);
            
            //breadboard = root.outer_breadboard_mc.breadboard_mc;
            
            //multimeter = new DmmCentech2({ activity: this, root: root });
            //multimeter.setDisplayText('       ');
            
            // initActivity must be called after the ExternalInterface is 
            // ready to communicate with JavaScript.
            javascript.call('initActivity');
        }
        
        public override function processMessageFromJavaScript(args) {
            trace('processMessageFromJavaScript args=' + args);
            var command:String = args[0];
            switch (command) {
                case 'set_multimeter_display':
                    circuit.getMultimeter().setDisplayText(args[1]);
                    return 'ok';
                case 'set_resistor_colors':
                    var resistor = circuit.getResistor(args[1]);
                    resistor.setColorBands(args[2]);
                    return 'ok';
				case 'insert_component':
					var newArg:Array = args.slice(5,args.length);
					circuit.insertComponent(args[1],args[2],args[3],args[4],newArg);
					return 'ok';
				case 'set_multimeter_visibility':
					circuit.getMultimeter().setVisibility(args[1]);
					return 'ok';
				case 'connect_probe':
					trace('CONNECT PROBE');
					circuit.connectProbe(args[1]);
					return 'ok';
				case 'set_probe_visibility':
					circuit.setProbeVisibility('dmm_probes', args[1]);
					return 'ok';
			    case 'set_oscope_probe_visibility':
					circuit.setProbeVisibility('oscope_probes', args[1]);
					return 'ok';
				case 'enable_probe_dragging':
					circuit.enableProbeDragging(args[1],args[2]);
					return 'ok';
				case 'mouse_up':
					  circuit.getMultimeter().fakeMouseUp();
					  return 'ok';
				case 'enable_component_dragging':
					Globe.enable_component_dragging = args[1];
					return 'ok';
            }
            return 'UNKNOWN';
        }
		
		//flash.sendCommand('insert_component','resistor','resistor1','d29,b17','5band','label-text','green,blue,blue,red,red');
        //old//flash.sendCommand('insert_component','resistor','resistor1','d29,b17','5band','green,blue,blue,red,red');
		//flash.sendCommand('insert_component','wire','wire3','a11,c13','0xA0A0A0');
		//flash.sendCommand('set_multimeter_visiblity','true');
		
		
		
		
        private function resetCircuit() {
            trace('ENTER resetCircuit');
            /*
            multimeter.setDial('acv_750');
            multimeter.turnOff();
            multimeter.redProbe.snapTo(redProbeDefaultPos);
            multimeter.blackProbe.snapTo(blackProbeDefaultPos);
            multimeter.redProbe.disconnect();
            multimeter.blackProbe.disconnect();
            javascript.sendEvent("multimeter_power", false);
            */
        }
        
        private function setupEvents() {
            /*
            root.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            root.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            root.addEventListener(MouseEvent.MOUSE_DOWN, handleClickCapture, true, 1000);
            root.addEventListener(MouseEvent.CLICK, handleClick);
            root.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
            */
        }
        

        private function handleMouseDown(event:MouseEvent):void {
            //trace('ENTER ResistorColors.handleMouseDown');
            
        }
        
        private function handleMouseUp(event:MouseEvent) {
            //trace('ENTER ResistorColors.handleMouseUp');
        }

/*
        private function getResistor(id:String) {
            return breadboard[id];
        }*/
    }
}
