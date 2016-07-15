<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
<%@page import = "java.io.*"%>
        <%
		request.setCharacterEncoding("UTF-8");	
           String fileName = null;
           String id = null;
           String pw = null;
           String filePath = null;
           String usingPath = null; 
           BufferedReader reader = null;
           String userId;
           String userPw;
        try{	
        //세션으로 
            id = request.getParameter("id");
            pw = request.getParameter("pw");
            session.setAttribute("id",id);
            session.setAttribute("pw",pw);
            filePath = application.getRealPath("./finalTerm/member/" + id + ".txt");
            usingPath = application.getRealPath("./finalTerm/member/" + id + "_이용내역.txt");

            //out.println(filePath);

            if(!(new File(filePath).exists())&&(new File(usingPath).exists())){
        %>	
            <script>alert("존재하지 않는 아이디");</script>
        <%
                return ;
            }	
           reader = new BufferedReader(new FileReader(filePath));
           userPw = reader.readLine();
	//out.println(userPw + "/" + pw); 
            if(userPw == pw){
            %> <script> alert("비밀번호 입력 실패");
				document.location.replace("index.jsp"); return;</script>
        	<%
            return ;
			}
        }
        catch(IOException ioe){
            out.println(filePath);
            ioe.printStackTrace();
        }
        %><script>
            alert('전송성공');
            var url = "MarkerShow.jsp";
            document.location.replace(url);  </script>	

