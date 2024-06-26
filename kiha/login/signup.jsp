<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("userid");
    String pw = request.getParameter("password");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone"); 
    String gender = request.getParameter("gender");
    
    // 1. 변수선언
    String url = "jdbc:postgresql://172.30.0.7/donghae";
    
    // DBMS의 사용자 이름
    String user = "kimkiha";
    
    // 위 사용자 이름에 대한 비밀번호
    String pwd = "tiger";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    // SQL 쿼리에서 따옴표 문제 수정
    String sql = "INSERT INTO login (userid, password, name, phone, gender) VALUES (?, ?, ?, ?, ?)";
    
    try {
        // 1. 드라이버 로드
        Class.forName("org.postgresql.Driver");
        
        // 2. conn 생성
        conn = DriverManager.getConnection(url, user, pwd);
        
        // 3. pstmt 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, pw);
        pstmt.setString(3, name);
        pstmt.setString(4, phone); 
        pstmt.setString(5, gender);
        
        // 4. SQL문 실행
        int result = pstmt.executeUpdate();
        
        if (result == 1) { // 성공
            response.sendRedirect("signup_success.html");
        } else { // 실패
            response.sendRedirect("signup_fail.html");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (conn != null) conn.close();
            if (pstmt != null) pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
