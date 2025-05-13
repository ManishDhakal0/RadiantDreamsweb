<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>

<%
    // Initialize necessary objects and variables
    HttpSession userSession = request.getSession(false);
    String currentUser  = (String) (userSession != null ? userSession.getAttribute("username") : null);
    // Set contextPath variable
    String contextPath = request.getContextPath();
    // Set currentUser  in page context for later use
    pageContext.setAttribute("currentUser ", currentUser );
%>

<div id="header">
    <header class="header">
	<div class="logo">RADIANT DREAMS</div>
        <ul class="main-nav">
            <li><a href="home">Home</a></li>
            <li><a href="contact">Contact Us</a></li>
            <li><a href="products">Products</a></li>
            <li><a href="portfolio">Portfolio</a></li>
           <li><a href="about">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            
        </ul>
    </header>
</div>