<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>

<%
	String sessionId = (String) session.getAttribute("id");
			if(!((sessionId == null) || (sessionId.equals("")))){
%>	          <script>alert("로그인이  되어있습니다.")
		               document.location.href = "MarkerShow.jsp" ;  
	           </script><%
		   }
%>
<!DOCTYPE html> 
<html>
    <head>
        <META charset = "UTF-8"/>
		<link rel = "stylesheet" href = "loginCss.css">
</head>

  <body>

    
<!-- Mixins-->
<!-- Pen Title-->

<div class="container">
  <div class="card"></div>
  <div class="card">
    <h1 class="title">Login</h1>
    <form method = "post">
      <div class="input-container">
        <input type="text" id="id" name = "id" required="required"/>
        <label for="id">Username</label>
        <div class="bar"></div>
      </div>
      <div class="input-container">
        <input type="password" id="pw" name = "pw" required="required"/>
        <label for="pw">Password</label>
        <div class="bar"></div>
      </div>
      <div class="button-container">
        <button onclick = "this.form.action = 'login.jsp'"><span>Login</span></button>
		  <button onclick = "this.form.action = 'join.jsp'"><span>Join</span></button>
		<p> 계정이 없으시면 입력폼에 기입 후 join을 눌러주세요</p>      
	  </div>
      <div class="footer"><a href="#">201203431 서영학</a></div>
    </form>
  </div>
  
</div>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    
    
  </body>
</html>


