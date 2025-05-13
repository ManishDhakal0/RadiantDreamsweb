package com.RadiantDreams.controller;

import com.RadiantDreams.model.ProductModel;
import com.RadiantDreams.model.CategoryModel;
import com.RadiantDreams.service.ProductService;
import com.RadiantDreams.service.CategoryService;
import com.RadiantDreams.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;
    private CategoryService categoryService;

    public ProductsController() {
        productService = new ProductService();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String category = request.getParameter("category"); // <-- get selected category from URL
        
        List<ProductModel> products;
        if (category != null && !category.equalsIgnoreCase("all")) {
            products = productService.getProductsByCategory(category); // <-- filter from database
        } else {
            products = productService.getAllProducts(); // <-- no filter, show all
        }

        List<CategoryModel> categories = categoryService.getAllCategories();

        request.setAttribute("productList", products);
        request.setAttribute("categoryList", categories);
        request.setAttribute("selectedCategory", category); // pass selected category back to JSP

        request.getRequestDispatcher("/WEB-INF/pages/products.jsp").forward(request, response);
    }
    


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("buy".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = 1; // Default quantity

            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            boolean success = false;

            try {
                OrderService orderService = new OrderService();
                orderService.placeOrder(username, productId, quantity);
                success = true;
            } catch (Exception e) {
                e.printStackTrace(); // You can log this instead
            }

            // Set feedback message
            session.setAttribute("message", success ? "Purchase successful!" : "Product out of stock!");

            // Redirect to GET handler with optional category filter
            String category = request.getParameter("category");
            if (category != null && !category.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products?category=" + category);
            } else {
                response.sendRedirect(request.getContextPath() + "/products");
            }
        }
    }




}
