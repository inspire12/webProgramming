// Target the canvas element on the page
var canvas = document.getElementById('canvas');
var context;
// Array of markers

window.onload = function() {
            
		if (canvas == null || canvas.getContext == null) return;
        context = canvas.getContext("2d");
		
// Add mouse click event listener to canvas	  
		canvas.addEventListener("mousedown", mouseClicked, false);
		
		context = canvas.getContext("2d");
		
		context.font = "15px Georgia";
		context.textAlign = "center";
        
		setInterval(main, (1000 / 60)); // Refresh 60 times a second
}
// Map sprite

var mapSprite = new Image();
var Markers = new Array();
mapSprite.src;

// Create a basic class which will be used to create a marker
function Marker(){
    this.Sprite = new Image();
    this.Sprite.src = "./marker/gym.png"
    this.Width = 24;
    this.Height = 30;
    this.XPos = 0;
    this.YPos = 0;
	this.name = 0;
	this.src =0;
}
// When the user clicks their mouse on our canvas run this code

var selectMarker = new Marker();

function mouseClicked(mouse) {
    // Get corrent mouse coords
	if(markerClick(mouse)){
		//alert(selectMarker.src);
		var string = selectMarker.src;
		var strArray = string.split('/finalTerm/');

		alert(strArray[0]);
		strArray[0] = "http://"+strArray[0];
		document.getElementById("view").src = strArray[0];
	}else{
		var rect = canvas.getBoundingClientRect();
		var mouseXPos = (mouse.x - rect.left);
		var mouseYPos = (mouse.y - rect.top);
	
		// Move the marker when placed to a better location
		var marker = new Marker();
		marker.XPos = mouseXPos - (marker.Width / 2);
		marker.YPos = mouseYPos - marker.Height;
		marker.name = prompt("운동명 혹은 운동 방법을 적으세요.");
		marker.src = prompt("동영상 url을 입력하세요.");
		// Push our new marker to our Markers array
		if(marker.name!=null ||marker.src != null){
			Markers.push(marker);
			saveUrl();
		}
	}
}
function markerClick(mouse){
	var rect = canvas.getBoundingClientRect();
	var mouseXPos = (mouse.x - rect.left);
	var mouseYPos = (mouse.y - rect.top);
	if(Markers.length==0)return 0;
	
	for(var i=0; i<Markers.length;i++){
		if(Math.abs(Markers[i].XPos- mouseXPos)<24 && Math.abs(Markers[i].YPos- mouseYPos)<30){
			selectMarker = Markers[i];
			return 1;
		}
	}

	return 0;
}

// This will be called 60 times a second, look at the code at the bottom `setInterval`
function main() {
    // Update our canvas
    draw();
};
function changePlace(placeUrl,marker){
	mapSprite.src = "./place/"+placeUrl;	
	var longMarkers = marker.split('!');
	Markers=longMarkers;
	for(var i=0; i<longMarkers.length;i++){
	
		var tmpMarker = new Marker();
		var strArray = longMarkers[i].split('|');
		tmpMarker.XPos = strArray[0];
		tmpMarker.YPos = strArray[1];
		tmpMarker.name = strArray[2];
		tmpMarker.src = strArray[3];
	//	alert(tmpMarker.src);
		Markers[i] = tmpMarker;
	}
}
function saveUrl(){
	var save ="";
	for(var i=0; i<Markers.length; i++){
		if(typeof Markers[i].XPos!==undefined){	
		save +=
			Markers[i].XPos+"|"+Markers[i].YPos+"|"+Markers[i].name+"|"+Markers[i].src+"!";
		}
	}
	var src = (mapSprite.src).split('/');
	
	var Url =
		"http://52.79.99.48:8080/inspire12/finalTerm/MarkerSave.jsp?src="+src[src.length-1]+"&url="+save;
	var myWindow = window.open(Url, "_blank");
	myWindow.close();
	mapSprite.src = "./place/"+src[src.length-1];
}
function draw () {
    // Clear Canvas
    context.fillStyle = "#000";
    context.fillRect(0, 0, canvas.width, canvas.height);
    
    context.drawImage(mapSprite, 0, 0, canvas.width, canvas.height);

    // Draw markers
    for (var i = 0; i < Markers.length; i++) {
        var tempMarker = Markers[i];
        // Draw marker
        context.drawImage(tempMarker.Sprite, tempMarker.XPos, tempMarker.YPos, tempMarker.Width, tempMarker.Height);

        // Calculate position text
        var markerText = "운동명 : "+tempMarker.name +" url = "+tempMarker.src;

        // Draw a simple box so you can see the position
        var textMeasurements = context.measureText(markerText);
        context.fillStyle = "#000";
        context.globalAlpha = 0.7;
        context.fillRect(tempMarker.XPos - (textMeasurements.width / 2), tempMarker.YPos - 15, textMeasurements.width, 20);
        context.globalAlpha = 1;

        // Draw position above
        context.fillStyle = "#fff";
        context.fillText(markerText, tempMarker.XPos, tempMarker.YPos);
    }
};

