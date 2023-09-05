<%@include file="Header.jsp"%>
<%
    datalayer.DALEmployees objDAL1 = new datalayer.DALEmployees(session.getServletContext());
    beans.Employees emp = objDAL1.getEmpByID(Integer.parseInt(request.getParameter("ID")));
    datalayer.DALDepartments objDAL2 = new datalayer.DALDepartments(session.getServletContext());
    beans.Departments dep = objDAL2.getDepartmentByJobID(emp.getJobID());
    datalayer.DALJobs objDAL3 = new datalayer.DALJobs(session.getServletContext());
    emp.setJobName(objDAL3.getJobByJobID(emp.getJobID()));
    emp.setDepartmentName(dep.getDepartmentName());
    emp.setDepartmentID(dep.getDepartmentID());
    String gender = "-";
    if(emp.getEmpGender() == 'M') gender = "Male";
    else if(emp.getEmpGender() == 'F') gender = "Female";

    ArrayList<beans.Employees> AL = objDAL1.showEmpAdded(emp.getEmpID());
%> 

<div class="min-h-screen bg-gray-100 p-8">
    <div class="bg-white rounded-lg shadow-md p-8 mb-8">
        <div class="flex items-center justify-between mb-4">
            <h1 class="text-2xl font-semibold"><%= emp.getEmpName() %></h1>
            <img src="EmployeesImages/Img<%= emp.getEmpID() %>.jpg"
                 class="rounded-full w-20 h-20 object-cover"
                 onerror="if (this.src != 'ProfileImg.jpg') this.src = 'EmployeesImages/ProfileImg.jpg';">
        </div>
        <table class="table w-full">
            <tbody>
                <tr>
                    <th class="w-1/4 text-left">Employee ID</th>
                    <td><%= emp.getEmpID() %></td>
                </tr>
                <tr>
                    <th class="text-left">Employee Gender</th>
                    <td><%= gender %></td>
                </tr>
                <tr>
                    <th class="text-left">Employee Designation</th>
                    <td><%= emp.getJobName() %></td>
                </tr>
                <tr>
                    <th class="text-left">Employee Department</th>
                    <td><%= emp.getDepartmentName() %></td>
                </tr>
                <tr>
                    <th class="text-left">Employee Contact Number</th>
                    <td><%= emp.getEmpContactNumber() %></td>
                </tr>
                <tr>
                    <th class="text-left">Employee Email</th>
                    <td><%= emp.getEmpEmailID() %></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="bg-white rounded-lg shadow-md p-8">
        <h3 class="text-lg font-semibold mb-4">Employees Under <%= emp.getEmpName() %></h3>
        <table class="table w-full">
            <thead>
                <tr>
                    <th class="text-left">Employee ID</th>
                    <th class="text-left">Employee Name</th>
                    <th class="text-left">Employee Contact</th>
                    <th class="text-left">Department Name</th>
                    <th class="text-left">Job ID</th>
                    <th class="text-left">Job Name</th>
                </tr>
            </thead>
            <tbody>
                <% for(beans.Employees x : AL) { %>
                    <tr>
                        <td><%= x.getEmpID() %></td>
                        <td><a href="EmpProfile.jsp?ID=<%= x.getEmpID() %>" class="text-blue-500"><%= x.getEmpName() %></a></td>
                        <td><%= x.getEmpContactNumber() %></td>
                        <td><%= x.getDepartmentName() %></td>
                        <td><%= x.getJobID() %></td>
                        <td><%= x.getJobName() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<%@include file="Footer.html" %>
