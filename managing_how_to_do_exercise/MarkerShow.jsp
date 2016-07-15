<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
<%@page import = "java.io.*"%>

<!DOCTYPE html>
<head>
	<meta http-equiv="X-Frame-Options" content="allow">
     <meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="mainStyle.css"> 
<script src="navList.js" type = "text/javascript"></script> 
     <title>Good Health Show</title>
</head>
<body>
<%String sessionId = (String) session.getAttribute("id");
   if((sessionId == null) || (sessionId.equals(""))){
         %><script>alert("로그인을 먼저 하세요.")
             document.location.href = "index.jsp" ;  
         </script><%
  }
%>
<p>운동방법을 확인  해보세요</p>

<canvas id="canvas" width ="1000px" height ="800px">do not </canvas>
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
		<%
		try{
			String path = application.getRealPath("./finalTerm/place/");;
			File f = new File(path);
			File[] files = f.listFiles();
			for(int i=0; i<files.length; i++){
				String userMarkerUrl = "";	
				if(files[i].isFile()){
					String loc = files[i].getName();
					int pos = loc.lastIndexOf(".");
					String locE = pos>0 ? loc.substring(0,pos):loc;
					String locTxt = application.getRealPath("/finalTerm/placeUrl/"+locE+".txt");
					File locFile = new File(locTxt);
					if(!locFile.isFile()){
						locFile.createNewFile();
					}else{
					
					try{
						BufferedReader placeReader = new BufferedReader(new FileReader(locTxt));
						String userData = placeReader.readLine();
						if(userData == null) userMarkerUrl="null";
						for(int urlCount=0; userData!=null; urlCount++){		
								userMarkerUrl += userData+'!';
								userData = placeReader.readLine();
						}
						
						placeReader.close();
					}catch(Exception e){
						out.println("<scipt>배열?</script>");
					}
				}
				out.println("바꿀 장소 ");
				%>
			<a href="#" onclick =
			"changePlace('<%=loc%>','<%=userMarkerUrl%>')"><%=locE %></a>
		<%
				}
			}
		
		}catch(Exception e){
			out.println("<script>alert('asdfas');</script>");
		}finally{

		}

		%>
	</div>
	<br>
	
	
  	<span><button id = "open" onclick = "openNav()">장소변경 </button>
	<button id = "save" onclick = "confirmNextPage()"> 운동 저장 페이지 </button>
	<button id = "logout" onclick ="logout()">
	로그아웃 </button></span>
	<br>

<script src="testMarker.js" type = "text/javascript"></script> 
</body>
</html>
