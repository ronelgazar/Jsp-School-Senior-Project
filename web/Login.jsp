<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css">
    <link rel="icon" href="img/logo.svg">
</head>
<body class="bg-gray-100">
    <div class="flex items-center justify-center h-screen">
        <div class="w-96 p-8 bg-white rounded shadow-md">
            <h1 class="text-2xl font-semibold mb-6"><img src="img/logo.svg" alt="Logo" class="w-16 h-16 mr-2"> Welcome</h1>
            <form method="post" action="EmpServlet" onsubmit="return validateLogin()">
                <div class="mb-4">
                    <label for="txtEmployeeId" class="block font-medium mb-1">מספר עובד</label>
                    <input type="text" class="w-full px-3 py-2 border rounded" id="txtEmployeeId" name="txtEmployeeId">
                    <div class="text-red-500" id="msgEmployeeID"></div>
                </div>
                <div class="mb-4">
                    <label for="pwdPassword" class="block font-medium mb-1">סיסמה</label>
                    <input type="password" class="w-full px-3 py-2 border rounded" id="pwdPassword" name="pwdPassword">
                    <div class="text-red-500" id="msgPassword"></div>
                </div>
                <a href="#" class="block text-right mb-4 text-blue-500">שכחת את הסיסמא?</a>
                <input type="submit" name="btnLogin" value="Login" class="w-full px-4 py-2 bg-blue-500 text-white rounded">
                <span class="text-red-500" id="msg"><%=request.getAttribute("flag") != null ? "שם המשתמש או הסיסמה שגויים" : ""%></span>
                <h3 class="block text-center mt-4 text-blue-500">אין משתמש? - דברו עם האחראי</h3>
                <hr class="my-4">
            </form>
             <button onclick="window.location.href='ExplaningPage.jsp'" class="w-full px-4 py-2 mt-4 bg-blue-500 text-white rounded">לעמוד הסברים</button>
        </div>
    </div>

    <script src="LatestJQuery.js"></script>
    <script>
        function validateLogin() {
            let ret = true;
            let txt1 = document.getElementById("txtEmployeeId");
            let txt2 = document.getElementById("pwdPassword");
            document.getElementById("msgEmployeeID").textContent = "";
            document.getElementById("msgPassword").textContent = "";
            if (txt1.value.trim().length === 0) {
                document.getElementById("msgEmployeeID").textContent = "Employee ID cannot be empty!";
                ret = false;
            }
            if (txt2.value.trim().length === 0) {
                document.getElementById("msgPassword").textContent = "Password cannot be empty!";
                ret = false;
            }
            return ret;
        }
    </script>
</body>
</html>
