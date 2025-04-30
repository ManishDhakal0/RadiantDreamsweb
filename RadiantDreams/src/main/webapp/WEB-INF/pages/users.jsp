<%@ page import="com.RadiantDreams.util.SessionUtil" %>
<%
    String username = (String) SessionUtil.getAttribute(request, "username");
    String role = (String) SessionUtil.getAttribute(request, "role");

    if (username == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Sample user data - in a real application, this would come from a database
    String[][] users = {
        {"1001", "sarah_johnson", "sarah.j@example.com", "Customer", "Active"},
        {"1002", "michael_brown", "mbrown@example.com", "Customer", "Active"},
        {"1003", "emma_smith", "emma.s@example.com", "Customer", "Inactive"},
        {"1004", "james_wilson", "jwilson@example.com", "Customer", "Active"},
        {"1005", "olivia_davis", "odavis@example.com", "Customer", "Active"}
    };
    
    int totalUsers = 12524;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management - RadiantDreams</title>
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
        .user-modal {
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
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users" class="active">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement">Products</a></li>
            </ul>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>User Management</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>
            
            <div class="stats-summary">
                <h3>Users Overview</h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-label">Total Users</div>
                        <div class="stat-value"><%= totalUsers %></div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Active Users</div>
                        <div class="stat-value">8,276</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">New This Month</div>
                        <div class="stat-value">243</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-label">Premium Members</div>
                        <div class="stat-value">1,452</div>
                    </div>
                </div>
            </div>

            <div class="actions-bar">
                <input type="text" placeholder="Search users..." class="search-box">
                <button class="add-button" onclick="showAddUserModal()">Add New User</button>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] user : users) { %>
                    <tr>
                        <td><%= user[0] %></td>
                        <td><%= user[1] %></td>
                        <td><%= user[2] %></td>
                        <td><%= user[3] %></td>
                        <td><%= user[4] %></td>
                        <td class="action-links">
                            <a href="#" class="edit-link" onclick="showEditUserModal('<%= user[0] %>')">Edit</a>
                            <a href="#" class="delete-link" onclick="confirmDelete('<%= user[0] %>')">Delete</a>
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
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&raquo;</a></li>
            </ul>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="user-modal">
        <div class="modal-content">
            <span class="close-button" onclick="hideAddUserModal()">&times;</span>
            <h3>Add New User</h3>
            <form class="modal-form">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
                
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
                
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                
                <label for="role">Role</label>
                <select id="role" name="role">
                    <option value="Customer">Customer</option>
                    <option value="Admin">Admin</option>
                    <option value="Editor">Editor</option>
                </select>
                
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
                
                <button type="submit">Add User</button>
            </form>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editUserModal" class="user-modal">
        <div class="modal-content">
            <span class="close-button" onclick="hideEditUserModal()">&times;</span>
            <h3>Edit User</h3>
            <form class="modal-form">
                <input type="hidden" id="editUserId" name="userId">
                
                <label for="editUsername">Username</label>
                <input type="text" id="editUsername" name="username" required>
                
                <label for="editEmail">Email</label>
                <input type="email" id="editEmail" name="email" required>
                
                <label for="editRole">Role</label>
                <select id="editRole" name="role">
                    <option value="Customer">Customer</option>
                    <option value="Admin">Admin</option>
                    <option value="Editor">Editor</option>
                </select>
                
                <label for="editStatus">Status</label>
                <select id="editStatus" name="status">
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
                
                <button type="submit">Update User</button>
            </form>
        </div>
    </div>

    <script>
        function showAddUserModal() {
            document.getElementById('addUserModal').style.display = 'block';
        }
        
        function hideAddUserModal() {
            document.getElementById('addUserModal').style.display = 'none';
        }
        
        function showEditUserModal(userId) {
            // In a real application, you would fetch user data based on userId
            document.getElementById('editUserId').value = userId;
            document.getElementById('editUserModal').style.display = 'block';
            
            // For demonstration, pre-fill with some data based on userId
            if (userId === '1001') {
                document.getElementById('editUsername').value = 'sarah_johnson';
                document.getElementById('editEmail').value = 'sarah.j@example.com';
                document.getElementById('editRole').value = 'Customer';
                document.getElementById('editStatus').value = 'Active';
            }
        }
        
        function hideEditUserModal() {
            document.getElementById('editUserModal').style.display = 'none';
        }
        
        function confirmDelete(userId) {
            if (confirm('Are you sure you want to delete user #' + userId + '?')) {
                // In a real application, you would send a request to delete the user
                alert('User #' + userId + ' deleted successfully.');
            }
        }
    </script>
</body>
</html>