var startOn = 0;
var curEv
var time =0;
var timer;
var maximum = 0;
//전역변수로 드래그 중인 데이터 저장

//

// 드레그앤 드랍시 드래그와 드랍의 이벤트가 다르다. drag 시 
function onRank(){
	var rankTable = document.getElementById("rankTable");
	var scoreArray;
//	var score = document.getElementById("showTimer").firstChild; //string이어야
	var score = time;
	var a;
	
	if(typeof(Storage) !=="undefined"){
		a = localStorage.getItem("maximum")
		var index = localStorage.length-1;
			if(index<0)index=0;
		if(index >=10){
			if( a > score){
				localStorage.setItem("score"+9,score);
			}
		}else{
			localStorage.setItem("score"+index,score);
		}
	}
	var b =onRankList();
	localStorage.setItem("maximum",b);
}
function onRankList(){
	var list = new Array();
	if(typeof(Storage) !=="undefined"){
		for(i =0 ; i<localStorage.length-1; i++ ){
			var rankScore = localStorage.getItem("score"+i);
			list.push(rankScore);
		}
	}
	list.sort(function(a,b){return a-b});
	if(typeof(Storage) !=="undefined"){
		for(i =0 ; i<localStorage.length-1; i++ ){
			localStorage.setItem("score"+i,list[i]);
		
		}
	}
	for(i =1; i<= 10; i++){
		//뿌려준다. 
		
		if(i>list.length) {
			list.pop();
			break;}
		
		//var scoreValue = document.createTextNode(list.pop());
		//document.getElementById("rank"+i).appendChild(scoreRank);
		document.getElementById("rank"+i).innerHTML = i;
		//document.getElementById("rankScore"+i).appendChild(scoreValue);
		document.getElementById("rankScore"+i).innerHTML = fomatTime(list[i-1]);
		
	}
	var k = list[list.length-1];
		return k;
}
function drag(ev){
	ev.dataTransfer.setData("text", ev.target.id);
	curEv = ev;
}
//
function allowDrop(ev){
	ev.preventDefault();
}
function drop(ev){
	ev.preventDefault();
	if(ev.target.tagName == "TD"){
		var data = ev.dataTransfer.getData("text");
		ev.target.appendChild(document.getElementById(data));
	}else if(ev.target.tagName == "DIV"){
		var id = ev.dataTransfer.getData("text");
		tmpEv = ev;
		curEv.target.id = tmpEv.target.id;
		ev.target.id = id; //
	}
	isCorrect();
}

function isCorrect(){
	var correct = document.getElementsByName("img");
	if(correct[0].id=="img1" &&correct[1].id=="img2"
	&&correct[2].id=="img3"&&correct[3].id=="img4"
	&&correct[4].id=="img5"&&correct[5].id=="img6"
	&&correct[6].id=="img7"&&correct[7].id=="img8"
	&&correct[8].id=="img9"&&correct[9].id=="img10"
	&&correct[10].id=="img11"&&correct[11].id=="img12"
	&&correct[12].id=="img13"&&correct[13].id=="img14"
	&&correct[14].id=="img15"&&correct[15].id=="img16"){
		//맞추면
		offTimer();
		onRank();
		time = 0;
		startOn = 0;
		var startBtn = document.getElementById("startButton").firstChild;
		startBtn.data = "시작";
		alert("성공!");
		var tdList = document.getElementsByName("tdList");
		for(i=0; i<16; i++){
	//removeAttribute
			tdList[i].removeAttribute("ondragover");
			tdList[i].removeAttribute("ondrop");
			var divImage = tdList[i].firstChild;	
			divImage.removeAttribute("ondragstart");	
		}
	}
}

function onTimer(){
	timer = setInterval(subTimer,1000);
}
function offTimer(){
	clearInterval(timer)
}
function fomatTime(time){
	var hour = (Math.ceil(time/60)-1 );
	if(hour<0)hour =0;
	return hour + " : "+(time% 60);
}
function subTimer(){
	time +=1;
	var hour = Math.ceil(time/60)-1;
	var showTimer = document.getElementById("showTimer").innerHTML =  fomatTime(time); 
}
function start(){	

	var startBtn = document.getElementById("startButton").firstChild;
	var tdList = document.getElementsByName("tdList");
	var imgList = document.getElementsByName("img");
	onRankList();
	if(startOn==0){
		document.getElementById("showTimer").innerHTML =  "0 : 0";
		var numArray = randomBackground(1,16,16);	
		onTimer();
		for(i=0; i<16; i++){
		
			tdList[i].setAttribute("ondragover","event.preventDefault()");
			tdList[i].setAttribute("ondrop","drop(event)");
			
			var divImage = tdList[i].firstChild;
			divImage.setAttribute("id","img"+(numArray[i]));
			//divImage.setAttribute("id","img"+(i+1));
			
			//divImage.setAttribute("id","img"+numArray.pop());
			divImage.setAttribute("ondragstart","drag(event)");	
		}
		startBtn.data = "정지";
		startOn = 1;
		//타이머 시작
	}else if(startOn == 1){
		//일시정지
		offTimer();
		for(i=0; i<16; i++){
	//removeAttribute
			tdList[i].removeAttribute("ondragover");
			tdList[i].removeAttribute("ondrop");
			var divImage = tdList[i].firstChild;	
			divImage.removeAttribute("ondragstart");	
		}
		startOn = 2;
		startBtn.data = "다시시작";
	
	}else if(startOn == 2){
		//다시시작
			onTimer();
		for(i=0; i<16; i++){
	
		tdList[i].setAttribute("ondragover","event.preventDefault()");
		tdList[i].setAttribute("ondrop","drop(event)");
		var divImage = tdList[i].firstChild;	
		divImage.setAttribute("ondragstart","drag(event)");	
		}
		startOn = 1;
		startBtn.data = "정지";
	}
}
//drag & drop 을 하면 두개의 그림을 바꾼다. 
// 무작위 섞여 createElement로 해야겠다. for로 16개 하고 
// 완성되었는지는 어떻게 알까?
// local Storage 저장
// 버튼을 통해 시작 -> 정지 & 게임시간 증가
function resetStorage(){
	localStorage.clear();
	var rankTable = document.getElementsByName("ranking");
	//rankTable.clear();
	for(i=0;i<rankTable.length;i++){
		rankTable[i].innerHTML="";
	}
}

function randomBackground(min, max, choice) {
     
     var bgArray = [];
     var bgResult = [];
     var bgNum;
     
     for (i=min; i<=max; i++) {
         bgArray.push(i);
     }
     for (i=0; i<choice; i++) {
        bgNum = Math.floor(Math.random() * bgArray.length);
        bgResult.push(bgArray[bgNum]); // 랜덤으로 선택된 숫자 순서대로 bgReult에 저장
        bgArray.splice(bgNum, 1);    // 선택된 숫자 bgArray에서 삭제, 중복 선택 방지
     }
     
  //   bgResult = bgResult.join(', ');
     return (bgResult);
}
