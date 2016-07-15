<%@page language = "java" contentType = "text/html; charset = UTF-8"
pageEncoding = "UTF-8"%>
<%@page import = "java.io.*"%>
<%@page import = "java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("UTF-8");
	String user = (String) session.getAttribute("id");
	String sessionPoint = (String) session.getAttribute("curPoint");
    
	if(((user == null) || (user.equals("")))){
          out.println(" <script>alert('로그인이  되어있습니다.')");
          out.println("document.location.href = 'storeSystem.jsp' ; </script>");
  	}
	
	try{
		String productId = request.getParameter("productId");
		String productPath = application.getRealPath("/hw3_online_store/shopContent/" + productId + ".txt");
		BufferedReader productReader = new BufferedReader(new FileReader(productPath));
		String productName = productReader.readLine();
		String productPrice = (String)productReader.readLine();
		String productStock = (String)productReader.readLine();
		
		String productImg = productReader.readLine();
		String productDate = new SimpleDateFormat("yyyyMMdd").format(new
				Date(System.currentTimeMillis()));
		String productRealPrice = productPrice.replace(",","");
		int a = (Integer.parseInt(sessionPoint) -
				Integer.parseInt(productRealPrice ));
		//out.println(a);	
		if(a<0){
			
			%><script>window.alert('포인트가 부족합니다.');</script><%
			
		}else{
				
			String purchasePath =
				application.getRealPath("/hw3_online_store/member/" + user+ "_이용내역.txt");
			//out.println(purchasePath);
			productReader.close();	

			BufferedReader listReader = new BufferedReader(new FileReader(purchasePath));
			int productNum ;
			for(productNum = 1 ;listReader.readLine() != null ;productNum++){}
			
			//out.println(productNum);
			
			String into = productNum +"|" + productName + "|" + productPrice
			+"|"+productDate+"|"+"구매\n";
			listReader.close();
			//out.println(into);
			if(Integer.parseInt(productStock) <= 0){
				%>
				<script type="text/javascript">
				alert('품절되어 구매가	불가능합니다.');
			    </script><%
				return;
			}
			productStock = String.valueOf(Integer.parseInt(productStock) - 1); 
			String shopInto =
				productName+"\r\n"+ 
				productPrice+"\r\n"+ 
				productStock+"\r\n"+ 
				productImg ;

			String shopPath = 
				application.getRealPath("/hw3_online_store/shopContent/" +
						productId + ".txt");
			FileWriter shopWriter = new FileWriter(new File(shopPath),false);
			shopWriter.write(shopInto);
			shopWriter.close();

			//out.println(purchasePath);
			FileWriter purchaseWriter = new FileWriter(new
					File(purchasePath),true);
			purchaseWriter.append(into);
			purchaseWriter.close();

			String userPath =  
				application.getRealPath("/hw3_online_store/member/" +
						user + ".txt");
			FileWriter userWriter = new FileWriter(new File(userPath),false);
			String userInfo = session.getAttribute("pw")+"\n";
			userInfo += String.valueOf(Integer.parseInt(sessionPoint) -
					Integer.parseInt(productRealPrice));
			userWriter.write(userInfo);
			userWriter.close();

		}
	}
catch(NumberFormatException e){

		out.println("alert('2.숫자')");
}
catch(Exception error){
		out.println("alert('1.ssion')");

	}

	finally{
		out.println("<script>document.location.href	='storeSystem.jsp'</script>");
	}




%>


