package com.RadiantDreams.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = {"/users"})
public class UsermanagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String role = (String) request.getSession().getAttribute("role");

        if (username == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("login");
        } else {
            request.getRequestDispatcher("/WEB-INF/pages/users.jsp").forward(request, response);
        }
    }
}
