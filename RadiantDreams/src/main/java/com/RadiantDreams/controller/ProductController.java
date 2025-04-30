package com.RadiantDreams.controller;

import com.RadiantDreams.model.ProductModel;
import com.RadiantDreams.model.CategoryModel;
import com.RadiantDreams.service.ProductService;
import com.RadiantDreams.service.CategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;
    private CategoryService categoryService;

    public ProductController() {
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
}
