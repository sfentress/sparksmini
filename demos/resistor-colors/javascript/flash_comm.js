function getFlashMovie(movieName) {
  var isIE = navigator.appName.indexOf("Microsoft") != -1;
  return (isIE) ? window[movieName] : document[movieName];
}  

function sendCommand() {
  var params = [];
  for (var i = 0; i < arguments.length; ++i) {
      params[i] = arguments[i];
  }
  flash = getFlashMovie("resistor_colors");
  retVal = flash.sendMessageToFlash.apply(flash, params);
  console.log('Returned by flash: ' + retVal);
}

function receiveEvent(name, value, time) {
  console.log('received: ' + name + ', ' + value + ', ' + new Date(parseInt(time)));
  var activity = getActivity();
  console.log(0);
  var multimeter = activity.multimeter;
  console.log(1);
  if (name == 'connect') {
	  var ids = value.split('|');
	  if (ids[0] == 'red_lead') {
		  multimeter.redLeadConnection = ids[1];
	  }
	  else if (ids[0] == 'black_lead') {
		  multimeter.blackLeadConnection = ids[1];
	  }
	  multimeter.update();
  }
  else if (name == 'disconnect') {
	  if (value == 'red_lead') {
		  multimeter.redLeadConnection = null;
	  }
	  else if (value == 'black_lead') {
		  multimeter.blackLeadConnection = null;
	  }
	  multimeter.update();
  }
}

