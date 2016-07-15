<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
<%@page import = "java.io.*"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<%
   request.setCharacterEncoding("UTF-8");
   String fileName;
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   //String point = "0";
	int point = 0;
	PrintWriter writer = null;
  	PrintWriter usingWriter = null;
 
   String filePath = application.getRealPath("./hw3_online_store/member/" + id + ".txt");
   String usingPath = application.getRealPath("./hw3_online_store/member/" + id + "_이용내역.txt");
//out.println(filePath);

	if((new File(filePath).exists())||(new File(usingPath).exists())){
%>	<script>alert("존재하는 이름");
    var url = "index.jsp";
	document.location.href = url;
    </script>
    
<%
		return ;
	}	
try{
	writer = new PrintWriter(filePath);
   	writer.println(pw);
   	writer.println(point);
	
	usingWriter = new PrintWriter(usingPath);  

}   
catch(FileNotFoundException ioe){
}
 finally{   
	try { 
	writer.close();
	usingWriter.close();
	}
	catch (Exception e) { }
}
%><script>
	alert('가입 성공');
	var url = "index.jsp";
	document.location.href = url;  </script>	

<!--  response.sendRedirect("userinfo.jsp?name="+name);-->
<script>

</script>
    
</body>
    
</html>
