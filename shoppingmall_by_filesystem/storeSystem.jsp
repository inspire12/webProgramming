
<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
<%@page import = "java.io.*"%>
<%@page import = "java.util.Enumeration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--세션 처리-->    
 <%
request.setCharacterEncoding("UTF-8");
 	String key;
     Object value;
     for (Enumeration ea = session.getAttributeNames() ; ea.hasMoreElements() ;) {
         key = (String) ea.nextElement();
		 value = session.getAttribute(key);
         //out.println("key ="+key+" value="+value+"<br>");
     } 
%> 
<!--로그인 처리 -->
<%
   String sessionId = (String) session.getAttribute("id");
   if((sessionId == null) || (sessionId.equals(""))){
		%><script>alert("로그인을 먼저 하세요.")
			document.location.href = "index.jsp" ; 	
		</script><%
  }
	String sessionPw = (String) session.getAttribute("pw");
   	String idPath = application.getRealPath("/hw3_online_store/member/" + sessionId+".txt");
   	String point = null;
   	String pw = "";
	BufferedReader idReader = null;

    try{
       idReader = new BufferedReader(new FileReader(idPath));
        pw = idReader.readLine();
        point = idReader.readLine();
		session.setAttribute("curPoint",point);
//비밀번호 처리 
		if(!pw.equals(sessionPw)){
		out.println("<script> alert('비밀번호가 틀립니다.')");
			session.removeAttribute("id");

			out.println("document.location.replace('index.jsp');</script>");
		}
    }catch(IOException ioe){
        out.println(idPath);
        
    	out.println("<script>alert('등록되지 않았습니다.');</script>");
		session.removeAttribute("id");
		session.removeAttribute("pw");
        out.println("<script>document.location.href = 'index.jsp';</script>");
    }finally{
   	}	
%>
    
	<html>
	   <head>
            <META charset = "UTF - 8"></META>
            <link rel = "stylesheet" href = "./styleMenu.css">
        </head>
    <body>
    <%
       String id = sessionId;
	%>

	<!-- 파일 읽어서 뿌리기 -->
<div id = "MenuList">
        <div id = "Menu">
		<%
		String productPath = application.getRealPath("/hw3_online_store/shopContent/product1.txt");
		BufferedReader productReader = new BufferedReader(new
				FileReader(productPath));
		String productName = productReader.readLine();
		String productPrice = productReader.readLine();
		%>
		<%String productStock = productReader.readLine();%>
		<%String productImg = productReader.readLine();
		%>
		<form action = "purchaseItem.jsp" method = "post">
			<table>
				<tr><td rowspan="5"><img src =<%=productImg%> alt = "없네" ></td>   </tr>
            	<tr id = "pn"><td>이름</td><td> <%=productName %></td></tr>
            	<tr><td>가격</td><td> <%=productPrice  %> </td></tr>
            	<tr><td>재고</td><td> <%=productStock %></td></tr>
	    	
			<tr><td>	
			<%
		if(Integer.parseInt(productStock) !=0){
	%>
			<button name = "productId" value = "product1" >구매
			</button>
	<% } else{ %>
		구매불가
	<%}%>
		</td></tr>
				</table> 
		</form>
        </div>
        <div id = "Menu">
		<%
		productPath =
		application.getRealPath("/hw3_online_store/shopContent/product2.txt");
		productReader = new BufferedReader(new FileReader(productPath));
		productName = productReader.readLine();
		productPrice = productReader.readLine();
		productStock = productReader.readLine();
		productImg = productReader.readLine();
		%>
		<form action = "purchaseItem.jsp" method = "post">
			<table>
				<tr><td rowspan="5"><img src =<%=productImg%> alt = "없네" ></td>   </tr>
            	<tr id = "pn"><td>이름</td><td> <%=productName %></td></tr>
            	<tr><td>가격</td><td> <%=productPrice  %> </td></tr>
            	<tr><td>재고</td><td> <%=productStock %></td></tr>
				
			<tr><td>	
			<%
		if(Integer.parseInt(productStock) !=0){
	%>
			<button name = "productId" value = "product2" >구매
			</button>
	<% } else{ %>
		구매불가
	<%}%>
		</td></tr>
				</table> 
        </div>
        <div id = "Menu">
        
		<%
		productPath =
		application.getRealPath("/hw3_online_store/shopContent/product3.txt");
		productReader = new BufferedReader(new
				FileReader(productPath));
		productName = productReader.readLine();
		productPrice = productReader.readLine();
		productStock = productReader.readLine();
		productImg = productReader.readLine();
		%>
		<form action = "purchaseItem.jsp" method = "post">
		<table>
			<tr><td rowspan="5"><img src =<%=productImg%> alt = "없네" ></td>   </tr>
			<tr id = "pn"><td>이름</td><td> <%=productName %></td></tr>
			<tr><td>가격</td><td> <%=productPrice  %> </td></tr>
			<tr><td>재고</td><td> <%=productStock %></td></tr>
			<tr><td>	
			<%
		if(Integer.parseInt(productStock) !=0){
	%>
			<button name = "productId" value = "product3" >구매
			</button>
	<% } else{ %>
		구매불가
	<%}%>
		</td></tr>
		</table> 
		</div>
        <div id = "Menu">
		<%
		productPath =
		application.getRealPath("/hw3_online_store/shopContent/product4.txt");
		productReader = new BufferedReader(new FileReader(productPath));
		productName = productReader.readLine();
		productPrice = productReader.readLine();
		productStock = productReader.readLine();
		productImg = productReader.readLine();
		%>
		<form action = "purchaseItem.jsp" method = "post">
			<table>
				<tr><td rowspan="5"><img src =<%=productImg%> alt = "없네" ></td>   </tr>
            	<tr id = "pn"><td>이름</td><td> <%=productName %></td></tr>
            	<tr><td>가격</td><td> <%=productPrice  %> </td></tr>
            	<tr><td>재고</td><td> <%=productStock %></td></tr>
	    	
			<tr><td>	
			<%
		if(Integer.parseInt(productStock) !=0){
	%>
			<button name = "productId" value = "product4" >구매
			</button>
	<% } else{ %>
		구매불가
	<%}%>
		</td></tr>
				</table> 
		</div>
	</div>
		<div id = "pointList">
      	  <div id = "point">
            정보<br>
            아이디 : <echo><%=id %> </echo><br>
            포인트 : <echo><%=point %></echo><br>
            <button onclick = "form.action = 'purchaseList.jsp'">
			이용내역 확인</button>
			<button onclick = "form.action = 'logout.jsp'" >
			로그 아웃 </button>
			</form>
        </div>
        <div id = "point">
            <form action = "point.jsp" method = "POST"><span>
            포인트 추가</span><br>
            <input type = "text" name = "pointForm" style ="width : 100px;">
            <button  name = "pointForm" ><span>포인트 추가</span></button>
            
				</form>
        	</div>
		</div>
	</body>
</html>


