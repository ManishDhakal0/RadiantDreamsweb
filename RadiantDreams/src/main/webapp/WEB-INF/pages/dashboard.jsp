<%@ page import="com.RadiantDreams.util.SessionUtil" %>
<%
    String username = (String) SessionUtil.getAttribute(request, "username");
    String role = (String) SessionUtil.getAttribute(request, "role");

    if (username == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    int totalUsers = 12524;
    int totalProducts = 5243;
    int activeUsers = 8276;
    double totalRevenue = 156629.00;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - RadiantDreams</title>
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
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-box {
            background-color: white;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .stat-box h3 {
            font-size: 16px;
            margin-top: 0;
            margin-bottom: 10px;
            color: #555;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h1>Admin Panel</h1>
            <ul>
                <li><a href="${pageContext.request.contextPath}/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/productsmanagement">Products</a></li>
            </ul>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>Dashboard</h2>
                <div class="user-info">Admin User: <%= username %></div>
            </div>

            <div class="stats-container">
                <div class="stat-box">
                    <h3>Total Users</h3>
                    <div class="stat-value"><%= totalUsers %></div>
                </div>
                <div class="stat-box">
                    <h3>Total Products</h3>
                    <div class="stat-value"><%= totalProducts %></div>
                </div>
                <div class="stat-box">
                    <h3>Active Users</h3>
                    <div class="stat-value"><%= activeUsers %></div>
                </div>
                <div class="stat-box">
                    <h3>Total Revenue</h3>
                    <div class="stat-value">$<%= String.format("%,.2f", totalRevenue) %></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
