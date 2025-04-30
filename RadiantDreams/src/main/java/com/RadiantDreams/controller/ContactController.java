package com.RadiantDreams.controller;

import com.RadiantDreams.model.ContactModel;
import com.RadiantDreams.service.ContactService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {

    private ContactService contactService;

    @Override
    public void init() throws ServletException {
        contactService = new ContactService();
    }

    // ✅ This handles the form page loading
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }

    // ✅ This handles form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String number = req.getParameter("number");
        String message = req.getParameter("message");

        ContactModel contact = new ContactModel(name, email, number, message);
        boolean success = contactService.saveMessage(contact);

        if (success) {
            req.setAttribute("success", "Message sent successfully!");
        } else {
            req.setAttribute("error", "There was a problem. Try again later.");
        }

        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }
}
