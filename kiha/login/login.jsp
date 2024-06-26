<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 로그인 정보 </title>
</head>
<body>
<%
    // 클라이언트로부터 전송된 사용자 아이디를 가져온다.
    String id = request.getParameter("userId");
    // 클라이언트로부터 전송된 비밀번호를 가져온다.
    String pw = request.getParameter("password");
%>
<%!
    // null 값을 "NO DATA"로 대체하는 함수
    public String checkNull(String data) {
        if (null == data)
            return "NO DATA";
        else
            return data;
    }
%>
<%
    // 접속할 DBMS 주소
    String url = "jdbc:postgresql://172.30.0.7/donghae";
    
    // DBMS의 사용자 이름
    String user = "kimkiha";
    
    // 위 사용자 이름에 대한 비밀번호
    String pwd = "tiger";
    
    // 연결을 위한 변수
    Connection con = null;
    // 쿼리를 실행하는 PreparedStatement 변수
    PreparedStatement pstmt = null;
    // 쿼리 실행 결과를 저장하는 ResultSet 변수
    ResultSet rs = null;
    
    // SQL 쿼리, 로그인 정보 확인
    String query = "SELECT * FROM login WHERE userId = ? AND password = ?";
    
    try {
        // PostgreSQL JDBC 드라이버를 로드한다.
        Class.forName("org.postgresql.Driver");
        
        // DBMS와 연결한다.
        con = DriverManager.getConnection(url, user, pwd);
        
        // PreparedStatement를 생성하고 SQL 쿼리를 설정한다.
        pstmt = con.prepareStatement(query);
        // 첫 번째 물음표(?)에 사용자 아이디를 설정한다.
        pstmt.setString(1, id);
        // 두 번째 물음표(?)에 비밀번호를 설정한다.
        pstmt.setString(2, pw);

        // SQL 쿼리를 실행하고 결과를 rs에 저장한다.
        rs = pstmt.executeQuery();
        
        // 결과가 있는지 확인한다.
        if (rs.next()) {
            // 결과가 있으면 사용자 아이디와 이름을 가져온다.
            id = rs.getString("userId");
            String name = rs.getString("name");

            // 세션에 사용자 아이디와 이름을 저장한다.
            session.setAttribute("user_id", id);
            session.setAttribute("user_name", name);
            // 로그인 성공 시 리다이렉트한다.
            response.sendRedirect("http://localhost:42888/");
        } else {
            // 로그인 실패 시 리다이렉트한다.
            response.sendRedirect("login_fail.jsp");
        }
        
        // ResultSet을 닫는다.
        rs.close();
        // PreparedStatement를 닫는다.
        pstmt.close();
        // 연결을 닫는다.
        con.close();
    } catch (Exception ex) {
        // 예외 발생 시 에러 메시지를 출력한다.
        out.println("err: " + ex.toString());
    }
%>	

</body>
</html>
