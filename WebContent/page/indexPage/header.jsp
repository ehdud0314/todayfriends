<%@page import="member.model.vo.Member"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/login.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/join.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/modify.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/searchIdNPw.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board.css">

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
#d2 {
    position: relative;
    display: inline-block;
    float: right;
    left: -30;
}
</style>
<title>오늘의 친구</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
   <header>
   <%Member member = (Member)session.getAttribute("member"); %>
<% String CPath = request.getContextPath(); %>
      <div id="d1">
         <a href="<%=CPath%>/page/indexPage/main"><img src="../../img/logo.png"></a>
      </div>
      <a href="<%=CPath%>/page/indexPage/introduceourself" id="introduce" class="bar-item button">5조 소개</a> 
      <a href="<%=CPath%>/page/indexPage/serviceintro" id="introduce1" class="bar-item button">서비스 소개</a>
      <div class="dropdown-hover">
         <button class="button" id="meet" name="meet">친구 만나러 가기</button>
         <div class="dropdown-content bar-block">
<%
if (member == null){ 
	
%>
<script>
$("#meet").click(function(){
	   alert("오늘의 친구 회원이 아니세요~");
		});
</script>
<%}else{ %>
            <a href="<%=CPath%>/page/board/boardread?hobbyId=1&locnum=<%=member.getLocnum() %>" class="bar-item button">운동</a> 
            <a href="<%=CPath%>/page/board/boardread?hobbyId=2&locnum=<%=member.getLocnum() %>" class="bar-item button">영화</a>
            <a href="<%=CPath%>/page/board/boardread?hobbyId=3&locnum=<%=member.getLocnum() %>" class="bar-item button">게임</a>
            <a href="<%=CPath%>/page/board/boardread?hobbyId=4&locnum=<%=member.getLocnum() %>" class="bar-item button">음식</a> 
            <a href="<%=CPath%>/page/board/boardread?hobbyId=5&locnum=<%=member.getLocnum() %>" class="bar-item button">주식</a> 
            <a href="<%=CPath%>/page/board/boardread?hobbyId=6&locnum=<%=member.getLocnum() %>" class="bar-item button">자유/후기</a>
<%} %>
         </div>
      </div>
<%
if (member == null){ 
%>
<%}else{ %>
      <a class="bar-item button" id="amyPage">마이페이지</a>
<%} %>
      <div id="d2">
<%
if (member == null){ 
	
%>
         <button class="header-btn button" id="loginbtn">로그인</button>
<%
}  else {

	 String grade ="";
     if(member.getGradeid()==1){
        grade = "브론즈";
     }else if (member.getGradeid()==2){
        grade = "실버";
     }else if (member.getGradeid()==3){
        grade = "골드";
     }else if (member.getGradeid()==4){
        grade = "플래티넘";
     }else{
        grade = "다이아몬드";
     }
     
     if(member.getLEVnum()==0){
%>
<p>반가운 <%=member.getName()%>님! <br> <span class="pointspan"><span>등급 : <%=grade%> / </span> <span>포인트: <%=member.getMpoint()%></span></span></p>
			<button type="button" id="btnLogout" onclick="location.href='<%=CPath%>/page/indexpage/logout';">로그아웃</button>
<%	
	} else{
%>
<p>
<div>관리자님!</div>
	<button type="button" id="btnLogout" onclick="window.open('<%=CPath%>/page/admin/adminPageIndex.jsp')">관리자모드</button>
	<button type="button" id="btnLogout" onclick="location.href='<%=CPath%>/page/indexpage/logout';">로그아웃</button>
</p>
<%
	}
}
%>
      </div>
      <!-- 로그인 모달창 -->
      <div class="loginmodal">
         <div class="form">
            <span class=close>&#10006;</span>
            <p class="pabouttitle">LOGIN</p>
            <br><span class="smsg">오늘의 친구에 오신 것을 환영합니다</span><br><br>
            <form class="login-form" id="frm">
               <input type="text" placeholder="id" name="id" /> <input
                  type="password" placeholder="password" name="passwd" />
               <br>
               <button class="btnsearch" id="btnLogin">login</button>
               <p class="message">
                  <a href="<%=request.getContextPath() %>/page/member/searchIdNPw.jsp">ID/PW찾기</a>
                  <a href="<%=request.getContextPath() %>/page/member/join" id="join" class="join">회원가입</a>
               </p>
            </form>
         </div>
      </div>
      <!-- 모달 끝! -->
      <!-- 포인트 모달창 -->
        <div class="pointbg" id="pointbg">
         <div class="pointmodal">
            <span id=close2>&#10006;</span>
	 			<img src="../../img/포인트모달.png" class="pointimg"> 
         </div>
      </div>
      <!-- 모달 끝! -->
   </header>
<script>
        $(function () {
            $("#loginbtn").click(login);
            $(".pointspan").click(point);
            $(".close").click(loginclose);
            $("#close2").click(pointclose);
           
            $("#amyPage").click(function(){               		
            	 location.href='<%=CPath%>/page/member/myPageIndex';
            		});
           
            function login() {
                $(".loginmodal").css("display", "block");
                $(".form").css("display", "block");
            };
            
            function loginclose() {
                $(".loginmodal").css("display", "none");
            };           
            
            function point() {
                $(".pointbg").css("display", "block");
                $(".pointmodal").css("display", "block");
            };

            function pointclose() {
                $(".pointbg").css("display", "none");
            };           
           
           $("#btnLogin").click(function(){
				any = 1;
              	var frm = document.getElementById("frm");
              	frm.action = "<%=request.getContextPath()%>/page/indexpage/login";
            	frm.method = "post";
            	frm.submit();
      		});
           
           
   });
</script>