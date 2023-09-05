<%@include file="Header.jsp"%>
<link rel="stylesheet" href="../css/addTask.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<div class="min-h-screen bg-gray-100 flex items-center justify-center">
  <% int JobID = Integer.parseInt(session.getAttribute("LoggedJobID").toString()); %>
  <div class="bg-white p-8 rounded-lg shadow-md w-full">
    <h1 class="text-2xl font-semibold mb-6">Add Task</h1>
    <form method="post" action="../EmpServlet">
      <table class="w-full">
        <tr>
          <th class="w-1/4 py-2">Task Name</th>
          <td><input type="text" class=" form-control w-full border border-gray-300 px-3 py-2 rounded-md focus:ring-blue-500 focus:border-blue-500" name="txtTaskName" id="txtTaskName"></td>
        </tr>
        <tr>
          <th class="py-2" colspan="2">Description</th>
        </tr>
        <tr>
          <td colspan="2"><textarea name="txtDescription" class="w-full border border-gray-300 px-3 py-2 rounded-md focus:ring-blue-500 focus:border-blue-500" placeholder="Please Enter Task Description Here .." rows="7"></textarea></td>
        </tr>
        <tr>
          <th class="py-2">Last Date</th>
          <td>
            <input type="text" class=" form-control w-full border border-gray-300 px-3 py-2 rounded-md focus:ring-blue-500 focus:border-blue-500 datepicker" name="txtLastDate" id="txtLastDate">
          </td>
        </tr>
        <tr>
          <th class="py-2">Priority</th>
          <td class="form-inline">
            <input type="radio" name="radioPriority" id="radioPriority1" value="L" class="mr-2" checked> Low
            <input type="radio" name="radioPriority" id="radioPriority2" value="M" class="mr-2"> Medium
            <input type="radio" name="radioPriority" id="radioPriority3" value="H" class="mr-2"> High
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <table class="w-full border-collapse border border-gray-300 mt-4">
              <tr>
                <th class="border border-gray-300 py-2"></th>
                <th class="border border-gray-300 py-2">Employee ID</th>
                <th class="border border-gray-300 py-2">Employee Name</th>
                <th class="border border-gray-300 py-2">Employee Contact</th>
                <th class="border border-gray-300 py-2">Department Name</th>
                <th class="border border-gray-300 py-2">Job ID</th>
                <th class="border border-gray-300 py-2">Job Name</th>
              </tr>
              <% datalayer.DALEmployees objDAL = new datalayer.DALEmployees(session.getServletContext()); ArrayList<beans.Employees> AL = objDAL.showEmpAdded(Integer.parseInt(session.getAttribute("LoggedEmpId").toString())); for (beans.Employees x : AL) { %>
              <tr>
                <td class="border border-gray-300 py-2"><input type="checkbox" class=" form-control big-check form-checkbox h-5 w-5 text-blue-500" name="checkEmpSelect" value="<%=x.getEmpID()%>"></td>
                <td class="border border-gray-300 py-2"><%=x.getEmpID()%></td>
                <td class="border border-gray-300 py-2"><%=x.getEmpName()%></td>
                <td class="border border-gray-300 py-2"><%=x.getEmpContactNumber()%></td>
                <td class="border border-gray-300 py-2"><%=x.getDepartmentName()%></td>
                <td class="border border-gray-300 py-2"><%=x.getJobID()%></td>
                <td class="border border-gray-300 py-2"><%=x.getJobName()%></td>
              </tr>
              <% } %>
            </table>
          </td>
        </tr>
        <tr>
          <td class="py-4" colspan="2">
            <input type="submit" value="Add Task" class="btn btn-primary" name="btnAddTask">
          </td>
        </tr>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript">
  document.addEventListener('DOMContentLoaded', function () {
    flatpickr('.datepicker', {
      dateFormat: 'd-m-Y', // Customize the date format as dd-mm-yyyy
      // You can add more options and callbacks here
    });
  });
</script>
<%@include file="Footer.html"%>
