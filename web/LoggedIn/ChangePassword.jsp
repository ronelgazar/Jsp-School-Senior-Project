<%@include file="Header.jsp"%>
<div class="min-h-screen bg-gray-100">
    <div class="container mx-auto p-8">
        <h1 class="text-3xl font-semibold mb-4">Change Your Password</h1>
        <form method="post" action="../EmpServlet" onsubmit="return validateChangePassword()">
            <div class="w-full max-w-md mx-auto">
                <div class="mb-4">
                    <label for="pwdCurrectPassword" class="block text-gray-700 font-medium">Current Password</label>
                    <input type="password" id="pwdCurrectPassword" name="pwdCurrectPassword" class="form-input mt-1">
                    <%=(request.getParameter("fail") != null) ? "<p class='text-red-500'>Wrong Password Entered</p>" : "" %>
                </div>
                <div class="mb-4">
                    <label for="pwdNewPassword" class="block text-gray-700 font-medium">New Password</label>
                    <input type="password" id="pwdNewPassword" name="pwdNewPassword" class="form-input mt-1">
                    <p id="msg1" class="text-red-500"></p>
                </div>
                <div class="mb-4">
                    <label for="pwdCNewPassword" class="block text-gray-700 font-medium">Confirm New Password</label>
                    <input type="password" id="pwdCNewPassword" name="pwdCNewPassword" class="form-input mt-1">
                    <p id="msg2" class="text-red-500"></p>
                </div>
                <div class="flex justify-center">
                    <input type="submit" value="Change Password" class="btn btn-warning" name="btnChngPwd">
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    function validateChangePassword() {
        let ret = true;
        document.getElementById("msg1").textContent = "";
        document.getElementById("msg2").textContent = "";

        if (document.getElementById("pwdNewPassword").value.length < 8) {
            document.getElementById("msg1").textContent = "Password should be 8 characters or more";
            ret = false;
        }
        if (document.getElementById("pwdNewPassword").value !== document.getElementById("pwdCNewPassword").value) {
            document.getElementById("msg2").textContent = "Password Mismatch";
            ret = false;
        }
        return ret;
    }
</script>
<%@include file="Footer.html" %>
