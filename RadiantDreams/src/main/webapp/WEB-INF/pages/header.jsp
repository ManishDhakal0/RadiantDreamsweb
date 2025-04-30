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
        <h1 class="logo">
            <a href="<%= contextPath %>">
                <img src="<%= contextPath %>/resources/images/system/logo.png" alt="Logo" />
            </a>
        </h1>
        <ul class="main-nav">
            <li><a href="home">Home</a></li>
            <li><a href="contact">Contact Us</a></li>
            <li><a href="products">Products</a></li>
            <li><a href="portfolio">Portfolio</a></li>
           
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            <li><a href="about">About Us</a></li>
        </ul>
    </header>
</div>