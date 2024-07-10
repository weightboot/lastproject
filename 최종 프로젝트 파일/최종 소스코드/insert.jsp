<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import=    "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전주 편의점 상세 정보</title>
</head>
<body>
<%
    String pnu = request.getParameter("pnu1");//기존 객체필지랑 폴리곤으로 만든 필지의 구분을 pnu로 하고 있기 때문
    
    out.println(pnu);
    
    
    
    if("polygons".equals(pnu)){
        String pol_id = request.getParameter("sql_id");
        out.println(pol_id);
        out.println(pol_id);
        out.println(pol_id);
        String p_Arate = request.getParameter("Arate");
        String p_Erate = request.getParameter("Erate");  
        String p_RGArate = request.getParameter("RGArate");
        String p_RGdist = request.getParameter("RGdist");
        String p_FMdist = request.getParameter("FMdist");
        String p_Seadist = request.getParameter("Seadist");
        String p_high = request.getParameter("high");
        String p_slant1 = request.getParameter("slant1");
        String p_CVdist = request.getParameter("CVdist");    
        String p_price = request.getParameter("price");    
        String p_Rdist = request.getParameter("Rdist");    
        String p_ddist = request.getParameter("ddist");

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
            
            // DBMS에 쿼리할 준비를 한다.
            stmt = con.createStatement();
        
            String qryCVS = "UPDATE polygon SET " +

            "p_Arate = CASE WHEN '"+p_Arate+"' <> '' THEN "+p_Arate+" END, " +

            "p_Erate = CASE WHEN '"+p_Erate+"' <> '' THEN "+p_Erate+" END, " +

            "p_RGArate = CASE WHEN '"+p_RGArate+"' <> '' THEN "+p_RGArate+" END, " +

            "p_RGdist = CASE WHEN '"+p_RGdist+"' <> '' THEN "+p_RGdist+" END, " +

            "p_FMdist = CASE WHEN '"+p_FMdist+"' <> '' THEN "+p_FMdist+" END, " +

            "p_Seadist = CASE WHEN '"+p_Seadist+"' <> '' THEN "+p_Seadist+" END, " +

            "p_high = CASE WHEN '"+p_high+"' <> '' THEN "+p_high+" END, " +

            "p_slant = CASE WHEN '"+p_slant1+"' <> '' THEN '"+p_slant1+"' END, " +

            "p_CVdist = CASE WHEN '"+p_CVdist+"' <> '' THEN "+p_CVdist+" END, " +

            "p_price = CASE WHEN '"+p_price+"' <> '' THEN "+p_price+" END, " +    

            "p_Rdist = CASE WHEN '"+p_Rdist+"' <> '' THEN "+p_Rdist+" END, " +

            "p_Ddist = CASE WHEN '"+p_ddist+"' <> '' THEN "+p_ddist+" END " +

            "WHERE id = " + pol_id;
            
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
        String sql_id = request.getParameter("sql_id");
        out.println(sql_id);
        out.println(sql_id);
        out.println(sql_id);
        out.println(sql_id);
        out.println(sql_id);
        out.println(sql_id);
        out.println(sql_id);
        out.println(sql_id);
        String Arate = request.getParameter("Arate");
        String Erate = request.getParameter("Erate");  
        String RGArate = request.getParameter("RGArate");
        String RGdist = request.getParameter("RGdist");
        String FMdist = request.getParameter("FMdist");
        String Seadist = request.getParameter("Seadist");
        String high = request.getParameter("high");
        String slant1 = request.getParameter("slant1");
        String CVdist = request.getParameter("CVdist");    
        String price = request.getParameter("price");    
        String Rdist = request.getParameter("Rdist");    
        String ddist = request.getParameter("ddist");        
        String sql_id_array [] = sql_id.split(",");
        out.println(sql_id_array[0]);

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
        // postgresql JDBC를 읽어들인다(로드한다 = 메모리에 올려 사용할  준비를 한다).
        Class.forName("org.postgresql.Driver");
        
        // DBMS와 연결한다. url: 접속할 서버. user: DBMS 사용자 계정, pwd: user의 비밀번호
        con = DriverManager.getConnection(url, user, pwd);
        
        // DBMS에 쿼리할 준비를 한다.
        stmt = con.createStatement();
      
        for(int i=0;i<sql_id_array.length;i++){

        // String qryCVS = "update land_evaluation_view set Arate = '"+Arate+"',Erate = '"+Erate+"',RGArate ='"+RGArate+"',RGdist ='"+RGdist+"',FMdist ='"+FMdist+"',Seadist ='"+Seadist+"',high ='"+high+"',slant ='"+slant1+"',CVdist ='"+CVdist+"',price ='"+price+"',Rdist ='"+Rdist+"' where id="+sql_id_array [i];

        //html에서 form input이 빈칸으로 파라미터를 넘기면 빈 문자열이 저장이 된다. 처음엔 이걸 몰라서 "Arate = CASE WHEN '"+Arate+"' is not null and'" +Arate+"' <> '' THEN '"+Arate+"' ELSE Arate END, " + 이런식으로 작성했으나
        //계속 null관련하여 오류가 났다. 파라미터값을 넘긴 변수를 출력해봐도 null이 뜨니 double타입이 문제인줄 알았으나 빈 문자열이 들어가도 서버에서 그값을 null로 보여준다는 걸 알고 고치니 문제가 해결됨
        //그문제가 아니였음 저렇게 하면 결국 기존에 있는 값을 냅두는게 아니라 덧씌우는거라 null값이 덧씌워지면서 오류가 난거 결국 이 구문은 틀렸다
        //결국 빈칸이 아닐때 입력하고 나머지 조건은 무시로 임시로 만듬


        String qryCVS = "UPDATE land_evaluation_view SET " +
        "Arate = CASE WHEN '"+Arate+"' <> '' THEN "+Arate+" ELSE Arate END, " +
        "Erate = CASE WHEN '"+Erate+"' <> '' THEN "+Erate+" ELSE Erate END, " +
        "RGArate = CASE WHEN '"+RGArate+"' <> '' THEN "+RGArate+" ELSE RGArate END, " +
        "RGdist = CASE WHEN '"+RGdist+"' <> '' THEN "+RGdist+" ELSE RGdist END, " +
        "FMdist = CASE WHEN '"+FMdist+"' <> '' THEN "+FMdist+" ELSE FMdist END, " +
        "Seadist = CASE WHEN '"+Seadist+"' <> '' THEN "+Seadist+" ELSE Seadist END, " +
        "high = CASE WHEN '"+high+"' <> '' THEN "+high+" ELSE high END, " +
        "slant = CASE WHEN '"+slant1+"' <> '' THEN '"+slant1+"' ELSE slant END, " +
        "CVdist = CASE WHEN '"+CVdist+"' <> '' THEN "+CVdist+" ELSE CVdist END, " +
        "price = CASE WHEN '"+price+"' <> '' THEN "+price+" ELSE price END, " +    
        "Rdist = CASE WHEN '"+Rdist+"' <> '' THEN "+Rdist+" ELSE Rdist END, " +
        "Ddist = CASE WHEN '"+ddist+"' <> '' THEN "+ddist+" ELSE ddist END " +
        "WHERE id = " + sql_id_array[i];
                
        stmt.executeUpdate(qryCVS);
        }
        
      
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
                
    }

%>
<% 	

    response.sendRedirect("index.html");
%>	
<%-- <script>
alert("저장 성공!");
location.href = 'index.html';
</script> --%>


</body>
</html>