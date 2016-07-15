<%@page language = "java" contentType = "text/html; charset =UTF-8"
pageEncoding = "UTF-8"%>
<%@page import = "java.net.URLEncoder"%>
<%@page import = "java.io.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String lastPoint = (String) session.getAttribute("curPoint");

	String extraPoint = request.getParameter("pointForm");
	String resultPoint = "0";
	resultPoint = (String) session.getAttribute("curPoint");
	String message = null;
	//out.println(String.valueOf(lastPoint));
	//out.println(String.valueOf(extraPoint));
try{	
	
		resultPoint = String.valueOf(Integer.parseInt(extraPoint) + Integer.parseInt(lastPoint));
		String user = (String)session.getAttribute("id");
		String userPath =
		application.getRealPath("hw3_online_store/member/"+user+".txt/");

		String content = null;
		out.println("\r\n"+userPath);
		BufferedReader userReader = new BufferedReader(new FileReader(userPath));
		content =  userReader.readLine() + "\r\n";
		userReader.close();	
	
		FileWriter userWriter = new FileWriter(new File(userPath));
		//out.println(content);
		content += (resultPoint + "\r\n");
		userWriter.write(content);
		//out.println(content);	
		userWriter.close();
		message =resultPoint;

	}	
catch (Exception error) {
		message = "포인트를 추가할 수 없습니다.";
}
finally {

	if (message.equals(resultPoint))
			response.sendRedirect("storeSystem.jsp");
	else
			response.sendRedirect("storeSystem.jsp?result=" +
					URLEncoder.encode(message, "utf-8"));
	
}
%>
