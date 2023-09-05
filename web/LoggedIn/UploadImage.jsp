<%@include file="Header.jsp"%>
<div class="min-h-screen bg-gray-100 flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-md w-full sm:max-w-md">
        <h1 class="text-2xl font-semibold mb-6">Change Your Image</h1>
        <div class="flex justify-center items-center mb-6">
            <div class="w-32 h-32 rounded-full overflow-hidden">
                <img src="EmployeesImages/Img<%=session.getAttribute("LoggedEmpId")%>.jpg"
                     class="object-cover w-full h-full"
                     onerror="if (this.src != 'ProfileImg.jpg') this.src = 'EmployeesImages/ProfileImg.jpg';">
            </div>
        </div>
        <form action="../EmpServlet" method="post" enctype="multipart/form-data" class="flex flex-col items-center">
            <label for="empimage" class="mb-2 text-gray-600">Select a new image</label>
            <input type="file" name="empimage" id="empimage" class="border rounded px-3 py-2 mb-4">
            <button type="submit" name="btnUpload" class="btn btn-primary w-full">Upload</button>
            <% if (request.getAttribute("flag") != null) { %>
                <p class="text-green-500 mt-4">Image has been uploaded successfully</p>
            <% } %>
        </form>
    </div>
</div>
<%@include file="Footer.html" %>
