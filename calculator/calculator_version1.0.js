var num=0;//
var result=0;
var equalbutton=0;
var showResult="0"; 
var express="";

var op;
var operate=0; //숫자 연산자 
var calcul=0;  // 어떤 연산인지
var quit=0; //연산자 연속 방지
var lastNum=0;

function command(num){ //숫자가 입력
    if(document.calculator.expressScreen.value.length>=16)return;
    lastop=op;
    op="";
    if(num==0&&(calcul)==4){ //0으로나눌때
        document.calculator.numScreen.value="0으로나눌수없습니다.";
        return 0;
    }
    if(equalbutton==1){// = 눌러도 계산
        clearscreen();
        equalbutton=0;
    }

    var str=String(document.calculator.numScreen.value); 
    express=String(document.calculator.expressScreen.value); 

    str=(str!="0") ? ((operate==0) ? str : "") : "";  
    str=str + String(num); //자리수 고려
    
    operate=0; 
    quit=0; 
    document.calculator.numScreen.value=str; 
    if(str!="0"){
        document.calculator.expressScreen.value=express+num;
    }
    
} 

function calculate(){ 
    if(equalbutton==0){
        showResult=Number(document.calculator.numScreen.value); 
        lastNum=showResult;
    }else{
        showResult=lastNum;
    }
    
    express=document.calculator.expressScreen.value;
    if(num!=0&&quit!=1){  //
        switch(calcul){  
        case 1:result=num+showResult;lastop="+";break;  
        case 2:result=num-showResult;lastop="-";break;  
        case 3:result=num*showResult;lastop="x";break; 
        case 4:if(showResult!=0){result=num/showResult;lastop="/";}else{document.calculator.numScreen.value="0으로나눌수없습니다."; } break; 
        } 
        quit=1; 
    } 
    else{ 
        result=showResult; 
    }
    
    showResult=String(result); 
   
    num=result; 
} 


function dot(){ 
    if(document.calculator.expressScreen.value.length>=16)return;
    var str=String(document.calculator.numScreen.value); 
    str=(str!="0") ? ((operate==0) ? str : "0") : "0"; 
    for(i=0; i<=str.length;i++){ 
    if(str.substr(i,1)==".") return false; 
    } 
    str=str + "."; 
    document.calculator.expressScreen.value=str; 
    document.calculator.numScreen.value=str; 
    
    operate=0; 
} 
function del(){ 
    var exp=String(document.calculator.expressScreen.value);
    exp=(exp!="0") ? exp : ""; 
    exp=exp.substr(0,exp.length-1); 
    exp=(exp!="") ? exp : "0";
    
    var str=String(document.calculator.numScreen.value); 
    str=(str!="0") ? str : ""; 
    str=str.substr(0,str.length-1); 
    str=(str!="") ? str : "0"; 
    document.calculator.expressScreen.value=exp;
    if(exp=="0") document.calculator.expressScreen.value="";
    document.calculator.numScreen.value=str; 
    
} 

function clearscreen(){  
num=0;//
 result=0;
 equalbutton=0;
 showResult="0"; 
 express="";

 op="";
 operate=0; //숫자 연산자 
 calcul=0;  // 어떤 연산인지
 quit=0; //연산자 연속 방지
 lastNum=0; 
    document.calculator.numScreen.value="0"; 
    document.calculator.expressScreen.value=""; 
} 
function plus(){
    if(operate==1)return;
    if(document.calculator.expressScreen.value.length>=16)return;
    if(equalbutton==1){document.calculator.expressScreen="= 눌렸음"; return;}
    op="+";  
    calculate();
    operate=1;  
    calcul=1;  
    printResult();

} 
function minus(){ 
    if(operate==1)return;
    if(document.calculator.expressScreen.value.length>=16)return;
    
    if(equalbutton==1){document.calculator.expressScreen="= 눌렸음"; }
    op="-";
    calculate(); 
    operate=1; 
    calcul=2; 
   printResult();
} 
function multiply(){
    if(operate==1)return;
    if(document.calculator.expressScreen.value.length>=16)return;
    op="*";
    calculate(); 
    operate=1; 
    calcul=3; 
    printResult();
} 
function divide(){ 
    if(operate==1)return;
    if(document.calculator.expressScreen.value.length>=16)return;
    op="/";
    calculate(); 
    operate=1; 
    calcul=4; 
    printResult();
} 

var j=0;
var count = 0;

function equal(){ 
    if(document.calculator.expressScreen.value.length>16)return;
    calculate(); 
    
    printResult();
   
    quit=0;
    equalbutton=1;

    saveHistory();
    
        
}

function printResult(){

     document.calculator.numScreen.value=showResult;  
    if(equalbutton==0){
        if((calcul==4)||(calcul==3)){
        	document.calculator.expressScreen.value="("+express+")"+op; 
        }else{
            
            document.calculator.expressScreen.value=express+op; 
        }
        
    }else{//=두번누름
         
            document.calculator.expressScreen.value=showResult+lastop+lastNum; 
        
    }
    
}

function changeTool(){
    var a = document.calculator.expressScreen.value;
    a =a.substring(a.length-1,a.length);
    if(a=="+"){
        calcul=2;
        var exp=String(document.calculator.expressScreen.value);
        exp=(exp!="0") ? exp : ""; 
        exp=exp.substr(0,exp.length-1); 
        exp=(exp!="") ? exp : "0";
        exp+="-"
        op="-"
        document.calculator.expressScreen.value=exp;
    }
     if(a=="-"){
        calcul=1;
        var exp=String(document.calculator.expressScreen.value);
        exp=(exp!="0") ? exp : ""; 
        exp=exp.substr(0,exp.length-1); 
        exp=(exp!="") ? exp : "0";
        exp+="+"
        op="-"
        document.calculator.expressScreen.value=exp;
    }
}

function saveHistory(){
    // 윗 input 창의 수치를 읽어 저장
    var a = document.calculator.expressScreen.value;
    // 아래 input 창의 수치를 읽어 저장
    var b = document.calculator.numScreen.value;
    // string 연결(5+3=8 형식이로 됨)
    var c = a+"="+b;
	
    var list_history;
    // id가  history인 div 안에 있는 모든 태그의 집합
    var element1 = document.getElementById("history_1").childNodes;
    var element2 = document.getElementById("history_1");
    for(var i = 0; i<element1.length;i++){
        j++;

        if(element1[i]!="li"){

            list_history = document.createElement("li");
            list_history.style.cssText="list-style-type:none;";
            list_history.setAttribute("id","data"+j);
            list_history.setAttribute("onclick","attatchHistory('data"+j+"')");
            element2.appendChild(list_history);
            list_history.innerHTML=c;	
            break;
        }	
    }
}
function attatchHistory(dataID){
	
	var a = document.getElementById(dataID).innerHTML;
	var e = a.lastIndexOf("=");
	var b = a.substring(0,e);
	var c = a.substring(e+1);
	document.calculator.expressScreen.value = b;
	document.calculator.numScreen.value = c;
}
