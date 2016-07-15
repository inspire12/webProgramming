	<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
	<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.*"%>
<%@page import="java.util.StringTokenizer"%>

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
     String point = (String)session.getAttribute("curPoint");
     String pw = null;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/ht    ml4/loose.dtd">

     <html>
        <head>
             <META charset = "UTF - 8"></META>
             <link rel = "stylesheet" href = "./styleMenu.css">
         </head>
      <body>
	  <div id = "list">
		<table>
		<form action = "purchaseCancel.jsp" method = "post">
			<tr><th></th><th>물품명</th> <th>가격</th><th>날짜 </th><th></th></tr>
     <%!int i=0;%>
     <% String id = sessionId;
		String listPath =
		application.getRealPath("/hw3_online_store/member/"+id+"_이용내역.txt");
		String[] info = new String[5];
		//out.println(listPath);
		try{
		BufferedReader listReader = new BufferedReader(new FileReader(listPath));
		String product = listReader.readLine();
		StringTokenizer tokens;
		int j =0 ;
		for(j=0;product !=null;j++){
			tokens = new StringTokenizer(product,"|");
		product = listReader.readLine();
		while(tokens.hasMoreTokens()){
			info[i] = tokens.nextToken();
			i++;
		}
		//out.println(info[0] );
		i = 0;
%>
		<tr><td><%=info[0]%></td><td><%=info[1]%></td><td><%=info[2]%></td><td><%=info[3]%></td>
		<%if(info[4].equals("구매")){
		%> 
		<td><button  name ="cancel" value="<%=info[0]%>"	>구매취소 </button></td></tr>
		<% }else{
			%><td> 구매 취소 </td></tr> <%

				}
			} 
		if(j == 0){
		 out.println("<script> alert('이용내역이 존재하지 않습니다.') </script>");
		 out.println("<script> document.location.replace('storeSystem.jsp'); </script>");
		 return ;
		}
		%>
		</table>
		</div>
			<div id = "pointList">
		          <div id = "point">
			            정보<br>
			            아이디 : <echo><%=sessionId %> </echo><br>
			             포인트 : <echo><%=point %></echo><br>
			             <button onclick = "form.action = 'logout.jsp'" >
			             로그 아웃 </button>
			             </form>
			         </div>
			</div>
		<%

		}
		catch(Exception e){

		}finally{
		}
      %>
	</table>  
		</body>
</html>


