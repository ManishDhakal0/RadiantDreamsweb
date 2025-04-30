<%@ page import="com.RadiantDreams.util.SessionUtil" %>
<%
    String username = (String) SessionUtil.getAttribute(request, "username");
    String role = (String) SessionUtil.getAttribute(request, "role");

    if (username == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Sample product data - in a real application, this would come from a database
    String[][] products = {
        {"101", "Radiant Mattress", "$25.00", "120", "Mattress"},
        {"102", "Dream Sleep Pillow", "$40.00", "80", "Pillows"},
        {"103", "Dream Sleep Bedding", "$30.00", "150", "Beddings"},
        {"104", "Bed Frame Large", "$22.50", "95", "Bed"},
        {"105", "Bed Frame Medium", "$35.00", "65", "Bed"},
        {"106", "Bed Frame Small", "$32.00", "110", "Bed"},
        {"107", "Bed Frame Kids", "$18.50", "200", "Bed"}
    };
    
    int totalProducts = 5243;
    int lowStockProducts = 127;
    double totalInventoryValue = 142650.75;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Management - RadiantDreams</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
        }
        .container {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            padding: 20px 0;
            color: #fff;
        }
        .sidebar h1 {
            padding: 0 20px;
            margin-bottom: 30px;
            font-size: 24px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        .sidebar li {
            margin-bottom: 10px;
        }
        .sidebar a {
            display: block;
            padding: 10px 20px;
            color: #fff;
            text-decoration: none;
            background-color: #34495e;
            margin: 0 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .sidebar a:hover, .sidebar a.active {
            background-color: #1a2533;
        }
        .logout-form {
            margin: 10px;
        }
        .logout-button {
            width: 100%;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
        }
        .logout-button:hover {
            background-color: #c0392b;
        }
        .main-content {
            flex: 1;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .user-info {
            font-size: 14px;
            color: #666;
        }
        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-box {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 250px;
        }
        .add-button {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .add-button:hover {
            background-color: #219653;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #444;
        }
        tbody tr:hover {
            background-color: #f5f5f5;
        }
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
        }
        .edit-link {
            color: #3498db;
        }
        .delete-link {
            color: #e74c3c;
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
        }
        .pagination li {
            margin: 0 5px;
        }
        .pagination a {
            display: block;
            padding: 8px 12px;
            background-color: white;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
        }
        .pagination a.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        .product-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            width: 50%;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .close-button {
            float: right;
            cursor: pointer;
            font-size: 20px;
            font-weight: bold;
        }
        .modal-form label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        .modal-form input, .modal-form select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .modal-form button {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .modal-form button:hover {
            background-color: #2980b9;
        }
        .stats-summary {
            background-color: white;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .stats-summary h3 {
            margin-top: 0;
            color: #555;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        .stat-item {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
        }
        .stat-label {
            font-size: 14px;
            color: #777;
        }
        .stat-value {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-top: 5px;
        }
        .category-filter {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement" class="active">Products</a></li>
            </ul>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>Product Management</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>
            
            <div class="stats-summary">
                <h3>Products Overview</h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-label">Total Products</div>
                        <div class="stat-value"><%= totalProducts %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Low Stock Products</div>
                        <div class="stat-value"><%= lowStockProducts %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Total Inventory Value</div>
                        <div class="stat-value">$<%= String.format("%,.2f", totalInventoryValue) %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Categories</div>
                        <div class="stat-value">12</div>
                    </div>
                </div>
            </div>

            <div class="actions-bar">
                <div>
                    <input type="text" placeholder="Search products..." class="search-box">
                    <select class="category-filter">
                        <option value="">All Categories</option>
                        <option value="Skincare">Skincare</option>
                        <option value="Makeup">Makeup</option>
                        <option value="Haircare">Haircare</option>
                        <option value="Fragrance">Fragrance</option>
                    </select>
                </div>
                <button class="add-button" onclick="showAddProductModal()">Add New Product</button>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] product : products) { %>
                    <tr>
                        <td><%= product[0] %></td>
                        <td><%= product[1] %></td>
                        <td><%= product[2] %></td>
                        <td><%= product[3] %></td>
                        <td><%= product[4] %></td>
                        <td class="action-links">
                            <a href="#" class="edit-link" onclick="showEditProductModal('<%= product[0] %>')">Edit</a>
                            <a href="#" class="delete-link" onclick="confirmDelete('<%= product[0] %>', '<%= product[1] %>')">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <ul class="pagination">
                <li><a href="#">&laquo;</a></li>
                <li><a href="#" class="active">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">&raquo;</a></li>
            </ul>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div id="addProductModal" class="product-modal">
        <div class="modal-content">
            <span class="close-button" onclick="hideAddProductModal()">&times;</span>
            <h3>Add New Product</h3>
            <form class="modal-form">
                <label for="productName">Product Name</label>
                <input type="text" id="productName" name="productName" required>
                
                <label for="price">Price ($)</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required>
                
                <label for="stock">Stock</label>
                <input type="number" id="stock" name="stock" min="0" required>
                
                <label for="category">Category</label>
                <select id="category" name="category">
                    <option value="Skincare">Mattresses</option>
                    <option value="Makeup">Beds</option>
                    <option value="Haircare">Beddings</option>
                    <option value="Fragrance">Pillows</option>
                </select>
                
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4"></textarea>
                
                <button type="submit">Add Product</button>
            </form>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <div id="editProductModal" class="product-modal">
        <div class="modal-content">
            <span class="close-button" onclick="hideEditProductModal()">&times;</span>
            <h3>Edit Product</h3>
            <form class="modal-form">
                <input type="hidden" id="editProductId" name="productId">
                
                <label for="editProductName">Product Name</label>
                <input type="text" id="editProductName" name="productName" required>