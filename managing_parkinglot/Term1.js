var carList = new Array(); //차량 목록
var maxEnrolledCar = 20;
var maxParkingCar = 10;
var enrolledCar = 0;
var parkingCar = 0;
var pInfo;

function in_storage() {
    if(parkingCar >= maxParkingCar){alert("더 이상 주차할 수가 없습니다.");return;}  
    var checkedIndex = search();
    if(carList[checkedIndex][5] == "출고"){
        carList[checkedIndex][5] = "입고";
        var textnode = document.createTextNode(carList[checkedIndex][5]);
        var item = document.getElementById("ParkingList").childNodes[checkedIndex+4];
        item.replaceChild(textnode,item.childNodes[5]);
	
    }else{
			alert("현재 입고상태입니다.");
	}
    numberOfCar();  
}

function out_storage() {
     if(parkingCar < 0){alert("");return;}
      var checkedIndex = search();
    if(carList[checkedIndex][5]=="입고"){
        carList[checkedIndex][5]="출고";
          var textnode = document.createTextNode(carList[checkedIndex][5]);
        var item = document.getElementById("ParkingList").childNodes[checkedIndex+4];
        item.replaceChild(textnode,item.childNodes[5]);
    }else{
        
        alert("현재 출고 상태입니다.");
    }
    numberOfCar();
}

function enrollCar() {
    if(parkingCar >= maxParkingCar){alert("더 이상 주차할 수가 없습니다.");return;}
    if(enrolledCar >= maxEnrolledCar){alert("더 이상 등록할 수가 없습니다.");return;}
    var Car = {
        1: document.getElementById("manuList").value,
        2: document.getElementById("kindInput").value,
        3: document.getElementById("priceInput").value +"원",
        4: document.getElementById("sizeInput").value,
        5: "입고",
        
        get manu (){
            return this[1];
        },
        get kind (){
            return this[2];
        },
        get price (){
            return this[3];
        },
        get size (){
            return this[4];
        } ,  
        get state (){
            return this[5];
        }
    
    };
    var storagePath=document.getElementById("ParkingList");
    var carInfo = document.createElement("tr");
    var tdList= new Array();
    
    //값 설정하고 객체로 관리
    
    var datatest=0;
    var fill="";
        Car[5] = "출고"  
    
    if(Car.manu==""){fill+="제조사 ";datatest++;}
    if(Car.kind==""){fill+="차종류 ";datatest++;}
    if(Car.price=="원"){fill+="가격 ";datatest++;};
    if(Car.size==""){fill+="사이즈 ";datatest++;}
    if(datatest>0){alert(fill+" 데이터를 채우세요"); return; }       
    carList.push(Car);
    
    var radioInfo = document.createElement("input");
    radioInfo.setAttribute("type", "radio");
    radioInfo.setAttribute("name", "CarList");
   // radioInfo.setAttribute("onclick","deleteCarInfo()");
	tdList[0] = document.createElement("td");
    tdList[0].appendChild(radioInfo);
    carInfo.appendChild(tdList[0]);
   
    for(var i = 1; i<=5; i++){
        tdList[i] = document.createElement("td"); tdList[i].appendChild(document.createTextNode(Car[i]));
        carInfo.appendChild(tdList[i]);
    }
    storagePath.appendChild(carInfo); 
    numberOfCar();
}


function deleteCarInfo(){
		var checkedIndex = search();
		var info = carList[checkedIndex];
		pInfo = "제조사 : "+info.manu+" 차종 : "+info.kind+" 가격 : "+info.price+" 크기 : "+info.size+" 상태 : "+info.state+'<br>';
		//pInfo.appendChild(document.createElement("br"));
		document.getElementById("deleteCarOutput").innerHTML+=pInfo;
	
}
function deleteCar() {
    var checkedIndex = search();
    if(checkedIndex==-1)return;
	deleteCarInfo()
    var list = document.getElementById("ParkingList");
    if(carList[checkedIndex][5]=="입고"){parkingCar--;}
     list.removeChild(list.childNodes[checkedIndex+4]);
	
    carList.splice(checkedIndex,1);
	
    numberOfCar();
}

function search(){
	var searchCar = document.getElementsByName('CarList');
    var checkedIndex = -1;
    var i;
    for (i=0; i<searchCar.length; i++ ) {
		if(searchCar[i].checked) {
			checkedIndex = i;
            break;
        }
	}
    if(checkedIndex==-1) alert("차량을 선택하세요");
    return checkedIndex;
}

function numberOfCar(){
    enrolledCar = carList.length;
    document.getElementById("numberOfEnroll").innerHTML="등록 차량수 : "+enrolledCar+"대";
    parkingCar=0;
    for(var i in carList){
       if(carList[i][5]=="입고")parkingCar++; 
    }
    document.getElementById("numberOfStocked").innerHTML=" 입고 차량수 : "+parkingCar+"대";
}
    
function isNum(){
    var priceInput2 = document.getElementById("priceInput").value;
    if(isNaN(priceInput2)){ 
        
        alert("가격은 숫자로만 입력해 주시기 바랍니다.");
        document.getElementById("priceInput").value="";}
}