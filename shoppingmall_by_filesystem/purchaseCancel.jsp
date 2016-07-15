	<%@page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "UTF-8"%>
	<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.*"%>
<%@page import = "java.util.*"%>

<%@page import="java.text.SimpleDateFormat"%>
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
     String pw = null;
%>

     <% String id = sessionId;
	 	String index = request.getParameter("cancel");
//	out.println(index);
		String tmp = "판매";
	 	String listPath =
		application.getRealPath("/hw3_online_store/member/"+id+"_이용내역.txt");
//		out.println(listPath);
		String list="";
		BufferedReader listReader = new BufferedReader(new FileReader(listPath));
		String product = listReader.readLine();
		StringTokenizer tokens;
		String refundInfo = "0";
		String productName = "";
		try{
			String info[] = new String[5];
			String ab="";
			for(int j=0 ;product !=null; j++){
				int i=0;
				tokens = new StringTokenizer(product,"|");
//				out.println(product);
				product = listReader.readLine();
				while(tokens.hasMoreTokens()){
					info[i] = tokens.nextToken();
			//		out.println(info[i]);
					i++;
				}

			if(info[0].equals(index)){

				String productDate = new
					SimpleDateFormat("yyyyMMdd").format(new Date(System.currentTimeMillis()));
				if(Integer.parseInt(productDate) - Integer.parseInt(info[3]) > 3){
					out.println("<script>alert('환불가능 기간 3일이 지났습니다');</script>");
					return ;
				}
				out.println(info[0]);
				if(info[1].charAt(0) =='7'){
					productName = "product1.txt";
				}else if(info[1].charAt(0)=='청'){
					productName = "product2.txt";
				}else if(info[1].charAt(0)=='띠'){
					productName = "product3.txt";
				}
				else if(info[1].charAt(0) =='V'){
					productName = "product4.txt";
				}else {
				}

				refundInfo = info[2].replace(",","");
				info[4]= "구매취소";}
				list += info[0] + "|"+ info[1] + "|" + info[2] + "|" + info[3]
				+ "|" + info[4] +"\n";
				//이용내역 저장
			}
			FileWriter listWriter = new FileWriter(new File(listPath),false);
			listWriter.write(list);
			listWriter.close(); //이용내역 저장

			String userPath =
				application.getRealPath("./hw3_online_store/member/" + id + ".txt");

			FileWriter userWriter = new FileWriter(new File(userPath),false);	
			String userP = (String)session.getAttribute("curPoint");
						userP =
				String.valueOf(Integer.parseInt(userP)+Integer.parseInt(refundInfo));
			String userW = sessionPw + "\n"+ userP  ;
			userWriter.write(userW);
			userWriter.close();//point 늘려야지
			
		

			//out.println(productName);
			String productPath =
				application.getRealPath("./hw3_online_store/shopContent/" +
						productName);
			BufferedReader productReader = new BufferedReader(new
					FileReader(productPath));
			String a = productReader.readLine();
			String b = "";
			for(int k =0 ; a != null; k++){
				b += (a + "\n");
				a = productReader.readLine();
				if(k==1){ a = String.valueOf(Integer.parseInt(a)+1);}
			}
			//out.println(b);
			FileWriter productWriter = new FileWriter(new File(productPath),false);
			productWriter.write(b);
			productWriter.close();

			//재고 늘려야지
		}
		catch(Exception e){
			out.println("오류");

		}finally{
			out.println("<script> document.location.href = 'storeSystem.jsp' </script>");
		}

      %>
	  


