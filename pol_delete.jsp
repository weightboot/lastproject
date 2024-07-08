<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전주 편의점 상세 정보</title>
</head>
<body>
<%  
    String pnu = request.getParameter("pnu2");

    String del_id = request.getParameter("del_id");

     out.println(del_id);
    // String Arate = request.getParameter("Arate");
    // String Erate = request.getParameter("Erate");  
    // String RGArate = request.getParameter("RGArate");
    // String RGdist = request.getParameter("RGdist");
    // String FMdist = request.getParameter("FMdist");
    // String Seadist = request.getParameter("Seadist");
    // String high = request.getParameter("high");
    // String slant1 = request.getParameter("slant1");
    // String CVdist = request.getParameter("CVdist");    
    // String price = request.getParameter("price");    
    // String Rdist = request.getParameter("Rdist");    
    // String ddist = request.getParameter("ddist");        
    //String del_id_array [] = del_id.split(",");
    
%>
<% 	
    if("polygons".equals(pnu))
{
    // 접속할 DBMS 주소 		
    String url = "jdbc:postgresql://172.30.0.7/donghae";
    
    // DBMS의 사용자 이름
    String user = "scott";
    
    // 위 사용자 이름에 대한 비밀번호.
    String pwd = "tiger";
    
    // 연결을 위한 변수 
    Connection con = null;
    
    // 쿼리를 실행하는 Statement 변수
    Statement stmt = null;
    
    // 시도한다. 이 try {} 안에서 실행을 시도하다가 문제가 생기면 catch {} 로 간다.
    try
    {
        // postgresql JDBC를 읽어들인다(로드한다 = 메모리에 올려 사용할 준비를 한다).
        Class.forName("org.postgresql.Driver");
        
        // DBMS와 연결한다. url: 접속할 서버. user: DBMS 사용자 계정, pwd: user의 비밀번호
        con = DriverManager.getConnection(url, user, pwd);
     
        stmt = con.createStatement();
                
        String qryCVS = "delete from polygon where id="+del_id;

        // String qryCVS = "update land_evaluation_view set Arate = "+Arate+",Erate = "+Erate+",RGArate ="+RGArate+",RGdist ="+RGdist+",FMdist ="+FMdist+",Seadist ="+Seadist+",high ="+high+",slant ="+slant1+",CVdist ="+CVdist+",price ="+price+",Rdist ="+Rdist+",ddist ="+ddist+" where id="+sql_id_array [i];
                
        // select 쿼리를 실행한다. 검색 결과가 rs에 담긴다.
        stmt.executeUpdate(qryCVS);
        
        
        // 쿼리 실행기를 닫는다.
        stmt.close();

        // 연결을 닫는다.
        con.close();
    }		
    catch(Exception ex)		// 위 try{} 에서 문제가 발생하면 이 안으로 들어온다.
    {
        // 만약 try 안의 내용을 실행하는 중에 에러가 발생하면 그 에러 내용을 보여준다.
        out.println("err: " + ex.toString());
    }

}

else{
    out.println("<script>alert('삭제 할 수 없습니다!');</script>");

}
   //response.sendRedirect("index.html");
%>	
<%-- <script>
alert("저장 성공!");
location.href = 'index.html';
</script> --%>


</body>
</html>