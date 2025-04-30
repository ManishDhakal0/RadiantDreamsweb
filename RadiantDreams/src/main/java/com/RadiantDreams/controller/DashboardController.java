package com.RadiantDreams.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DashboardController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if the user is logged in and is an admin
        if (session != null) {
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if (username != null && "admin".equalsIgnoreCase(role)) {
                // Forward to dashboard page
                request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
                return;
            }
        }

        // If not admin or not logged in, redirect to login
        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Process dashboard form submissions here
        // For logout, the request should be sent to LogoutController instead
        
        // If you need to handle other POST operations for the dashboard:
        // [Your other POST handling code here]
        
        // If no specific action is found, redirect to dashboard again
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}