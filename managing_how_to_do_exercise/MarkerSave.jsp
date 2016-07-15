<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
<%@page import = "java.io.*"%>
<!DOCTYPE html>
<head>
     <meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="mainStyle.css"> 
<script src="navList.js" type = "text/javascript"></script> 
     <title>Good Health Show</title>
</head>
<body>
<%	String sessionId = (String) session.getAttribute("id");
   if((sessionId == null) || (sessionId.equals(""))){
         %><script>alert("로그인을 먼저 하세요.")
             document.location.href = "index.jsp" ;  
         </script><%
  }
%>
<p>운동방법을 저장 해보세요</p>
<canvas id="canvas" width ="1000px" height ="800px">Do not </canvas>
	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
		<%
			int pos;
			String path = application.getRealPath("./finalTerm/place/");;
			File f = new File(path);
			File[] files = f.listFiles();
			for(int i=0; i<files.length; i++){
				String userMarkerUrl = "";	
				if(files[i].isFile()){
					String loc = files[i].getName();
					pos = loc.lastIndexOf(".");
					String locE = pos>0 ? loc.substring(0,pos):loc;
					String locTxt = application.getRealPath("/finalTerm/placeUrl/"+locE+".txt");
					File locFile = new File(locTxt);
					if(!locFile.isFile()){
						locFile.createNewFile();
					}else{
						BufferedReader placeReader = new BufferedReader(new
								FileReader(locTxt));
						String userData = placeReader.readLine();
						if(userData == null) userMarkerUrl="null";
						for(int urlCount=0; userData!=null; urlCount++){		
								userMarkerUrl += userData+'!';
								userData = placeReader.readLine();
						}
						placeReader.close();
					}
				out.println("바꿀 장소 ");
				//out.println(userMarkerUrl);
				%>
			<a href="#" onclick =
			"changePlace('<%=loc%>','<%=userMarkerUrl%>')"><%=locE %></a>
		<%	}
		}//end of nav

		%>
	</div>
	<br>
  	<%
		String Url = request.getParameter("Url");
		//out.println(Url);
		String src = request.getParameter("src");
		//out.println(src);
		String initPath = application.getRealPath("./finalTerm/placeUrl/");
	pos = src.lastIndexOf(".");
	 String locE = pos>0 ? src.substring(0,pos):src;

		//out.println("path:"+src);
//	try{	
//		FileWriter UrlWriter = new FileWriter(new File(path),false);
		//out.println("Url:"+Url);
//		UrlWriter.write(Url);
//		UrlWriter.close();
//	}catch(Exception e){
	//	out.println("123");
//	}
	String param = request.getParameter("src");%>
	<script> var a = "<%=param%>";
document.getElementById("hidden").setAttribute("name", a);</script>
	<input type = 'hidden' id ='hidden' >	
	<span><button id = "open" onclick = "openNav()">장소변경 </button>
	<button id = "upload" onclick="">장소등록</button>
	<br>
<button id = "logout" onclick ="document.location.href = 'logout.jsp'"> 
     로그아웃 </button></span>


<script src="testMarkerSave.js" type = "text/javascript"></script> 
</body>
</html>
