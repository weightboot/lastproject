<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전주 편의점 상세 정보</title>
</head>
<body>
<%
    String sql_id = request.getParameter("sql_id");
    out.println(sql_id);
    String land_score_submit = request.getParameter("land_score_submit");
    String char_score_submit = request.getParameter("char_score_submit");  
    String total_score_submit = request.getParameter("total_score_submit");    
    String sql_id_array [] = sql_id.split(",");
    out.println(sql_id_array[0]);
    out.println(land_score_submit);
    out.println(sql_id);
%>
<% 	// 캠핑 정보를 가져온다.
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
        


        // ////----- cvshop 테이블의 전체 데이터 갯수를 가져온다. -----/////
        // Statement stmt_count = con.createStatement();        

        // // 시험문제 7번. cvshop 테이블의 전체 데이터 갯수를 가져오는 쿼리를 만든다.
        // String qryCount="select count(*) as CCOUNT from first_data";

        // ResultSet rs_count = stmt_count.executeQuery(qryCount);
        
        // if (rs_count.next())
        // {
        //     String sDataCount = rs_count.getString("CCOUNT");
        //     out.println("전체 자료 수: " + sDataCount);
        // }
        // rs_count.close();
        // ////----- cvshop이 테이블의 전체 데이터 갯수를 가져오기 끝. -----/////

        // DBMS에 쿼리할 준비를 한다.
        stmt = con.createStatement();
        for(int i=0;i<sql_id_array.length;i++){
        
        String qryCVS = "update first_data set land_score = '"+land_score_submit+"',char_score = '"+char_score_submit+"',total_score ='"+total_score_submit+"' where id="+sql_id_array [i];
        // 여기가 답 자리. 이 줄을 지우고 답을 적으세요.        
                
        // select 쿼리를 실행한다. 검색 결과가 rs에 담긴다.
        stmt.executeUpdate(qryCVS);
        }
        //값을 입력 하기 떄문에 정보를 보여주는게 필요가 없다
        // if (rs_cvs.next())
        // {
        //     out.println("<H2>" + rs_cvs.getString("ID") + ". " + rs_cvs.getString("address") + "</H2>");            
            
        //     out.print("<ul>");

        //     out.println("<li>도로명 주소: " + rs_cvs.getString("jibun") + "</li>");
        //     out.println("<li>지번 주소: " + rs_cvs.getString("area") + "</li>");
            
        //     out.println("<li>전화번호: " + rs_cvs.getString("price") + "</li>");
        //     // 여기가 답 자리. 이 줄을 지우고 답을 적으세요.

        //     out.print("</ul>");
        // } 			
        
        // 시험문제 10번. 서버 담당자가 메모리가 줄어들기만 하고 회복이 되지 않는다고 연락해 왔다. 쿼리 결과는 꼭 닫아주자.
        //rs_cvs.close();
        
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

    //response.sendRedirect("index.html");
%>	
<%-- <script>
alert("저장 성공!");
location.href = 'index.html';
</script> --%>


</body>
</html>