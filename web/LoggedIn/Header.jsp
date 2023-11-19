<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*" errorPage=""%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.16/dist/tailwind.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="../css/custom-logged.css">
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            #navbar {
                background-color: #000;
                color: #fff;
                height: 70px;
            }

            #navbar-title {
                display: flex;
                align-items: center;
            }

            #navbar-buttons {
                display: flex;
                align-items: center;
                margin-left: auto;
            }

            .navbar-button {
                color: #fff;
                text-decoration: none;
                padding: 10px 20px;
                margin-left: 10px;
                transition: background-color 0.3s ease;
            }

            .navbar-button:hover {
                background-color: #2d3748;
            }

            #profile-dropdown {
                position: fixed;
                cursor: pointer;
                right: 20px;
            }

            #profile-dropdown .profile-image {
                border-radius: 50%;
                width: 50px;
                height: 50px;
                object-fit: cover;
            }

            #profile-dropdown .dropdown-menu {
                position: absolute;
                right: 0;
                top: 100%;
                background-color: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 4px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                display: none;
                padding: 0;
                z-index: 10;
            }

            #profile-dropdown:hover .dropdown-menu {
                display: block;
            }

            #sidebar {
                background-color: #333;
                color: #fff;
                display: flex;
                justify-content: space-between;
                padding: 10px 20px;
            }

            #sidebar a {
                color: #cbd5e0;
                text-decoration: none;
                margin-right: 20px;
                transition: color 0.3s ease;
            }

            #sidebar a:hover {
                color: #fff;
            }

        </style>
        <script>
            function toggleSidebar() {
                var sidebar = document.getElementById("sidebar");
                sidebar.classList.toggle("open");
            }
        </script>
    </head>
    <body class="bg-gray-200">
        <nav class="navbar navbar-expand-lg navbar-light bg-blue-500" id="navbar">
            <div class="container">
                <!-- Logo and Title -->

                <% if (session.getAttribute("LoggedEmpId") == null) { %>
                   <div id="navbar-title">
                    <img src="../img/logo.svg" alt="Logo" class="h-12">
                    <span class="text-white text-2xl font-bold ml-2">task</span>
                </div>
                <a href="/LoggedIn/about.jsp" class="navbar-button">About</a>
                <a href="/LoggedIn/home.jsp" class="navbar-button">Home</a>
                <a href="/LoggedIn/Login.jsp" class="navbar-button">Login</a>
                <% } else {%>
                  <div id="navbar-title">
                    <img src="./img/logo.svg" alt="Logo" class="h-12">
                    <span class="text-white text-2xl font-bold ml-2">task</span>
                </div>
                <a href="./about.jsp" class="navbar-button">About</a>
                <a href="./home.jsp" class="navbar-button">Home</a>
                <a href="./Tasks.jsp" id="link1" onclick="return samePage('link1')">
                    <span class="icon text-lg"><i class="fas fa-tasks"></i></span>
                    <span class="hidden-xs">tasks</span>
                </a>
                <a href="./AddTask.jsp" id="link2" onclick="return samePage('link2')">
                    <span class="icon text-lg"><i class="fas fa-plus-circle"></i></span>
                    <span class="hidden-xs">add Task</span>
                </a>
                <a href="./AddEmp.jsp" id="link3" onclick="return samePage('link3')" >
                    <span class="icon text-lg"><i class="fas fa-user-plus"></i></span>
                    <span class="hidden-xs">add Employee</span>
                </a>
                <a href="./EmpAdded.jsp" id="link4" onclick="return samePage('link4')" >
                    <span class="icon text-lg"><i class="fas fa-users"></i></span>
                    <span class="hidden-xs">added employees</span>
                </a>
                <a href="./ClosedTasks.jsp" id="link5" onclick="return samePage('link5')">
                    <span class="icon text-lg"><i class="fas fa-check"></i></span>
                    <span class="hidden-xs">closed tasks</span>
                </a>
                <!-- Add more buttons as needed -->
                <% String pageName = request.getServletPath(); %>
                <% if(!pageName.equals("/home.jsp")) { %>
                <div id="profile-dropdown" class="text-white cursor-pointer relative">
                    <div class="text-white">
                        <img src="EmployeesImages/Img<%=session.getAttribute("LoggedEmpId")%>.jpg"
                             class="profile-image"
                             onerror="if (this.src != 'ProfileImg.jpg') this.src = 'EmployeesImages/ProfileImg.jpg';">
                        <div class="dropdown-menu absolute hidden mt-2 bg-white rounded shadow-lg">
                            <a href="UploadImage.jsp" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Change Picture</a>
                            <div class="h-px bg-gray-300 mx-4 my-2"></div>
                            <a href="ChangePassword.jsp" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Change Password</a>
                            <div class="h-px bg-gray-300 mx-4 my-2"></div>
                            <a href="../EmpServlet?logout=y" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Sign Out</a>
                        </div>
                    </div>
                </div>
                             <% } %>
                <% }%>


            </div>
        </nav>
        <div class="container mx-auto mt-16 px-4">
            <!-- The rest of your content goes here -->
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
    </body>
</html>
