<%@include file="Header.jsp"%>
<div class="min-h-screen bg-gray-100 flex items-center justify-center">
  <% int JobID = Integer.parseInt(session.getAttribute("LoggedJobID").toString()); %>
  <div class="bg-white p-8 rounded-lg shadow-md w-full  sm:max-w-md">
    <h1 class="text-2xl font-semibold mb-6">Add Employee</h1>
    <form method="post" action="../EmpServlet">
      <div class="space-y-4">
        <div>
          <label for="txtEmpName" class="block text-sm font-medium text-gray-700">Employee Name</label>
          <input type="text" id="txtEmpName" name="txtEmpName" class="form-control mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
        </div>
        <div>
          <label for="txtEmpContact" class="block text-sm font-medium text-gray-700">Employee Mobile Number</label>
          <input type="text" id="txtEmpContact" name="txtEmpContact" class="form-control mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
        </div>
        <div>
          <label for="ddlDepartment" class="block text-sm font-medium text-gray-700">Employee Department</label>
          <select class="form-control mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md" id="ddlDepartment" name="ddlDepartment" onchange="populateJobs()" <%= JobID == 1 ? "" : "disabled" %>>
            <% datalayer.DALDepartments objDAL = new datalayer.DALDepartments(session.getServletContext()); ArrayList<beans.Departments> AL = objDAL.getDepartments(); if (JobID == 1) { for (beans.Departments x : AL) { int flag = 0; if (x.getDepartmentID() == 1) { continue; } %>
            <option value="<%=x.getDepartmentID()%>" <%=(flag==1)?"selected":""%>><%=x.getDepartmentName()%></option>
            <% } } %>
            <%
              if (JobID != 1) { beans.Departments dep = objDAL.getDepartmentByJobID(JobID); %>
            <option value="<%=dep.getDepartmentID()%>"><%=dep.getDepartmentName()%></option>
            <% } %>
          </select>
        </div>
        <div>
          <label for="ddlJob" class="block text-sm font-medium text-gray-700">Employee Job</label>
          <select class="form-control mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md" id="ddlJob" name="ddlJob" onchange="showJobID()">
          </select>
        </div>
        <div>
          <label for="txtJobID" class="block text-sm font-medium text-gray-700">Employee Job ID</label>
          <input type="text" class="form-control mt-1 focus:ring-blue-500 focus:border-blue-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md" id="txtJobID" name="txtJobID" readonly>
        </div>
        <div class="flex justify-end">
          <input type="submit" value="Add Employee" class="btn btn-primary" name="btnAddEmp">
        </div>
      </div>
    </form>
  </div>
</div>
<script src="../LatestJQuery.js"></script>
<script type="text/javascript">
    
    $(window).on('load', function() {
	populateJobs();
    });
    
    var ddl2= document.getElementById("ddlJob");
    var xhttp;
    var val;
    var ddl1= document.getElementById("ddlDepartment");
    val = ddl1.value;
    function populateJobs(){
	xhttp = new XMLHttpRequest();	
	for(var i=0;i < ddl2.options.length;){
	    ddl2.options[i]=null;
	}
	xhttp.onreadystatechange = subFunction;
	xhttp.open("post",("../EmpServlet?number="+ddl1.value),true);
	xhttp.send();
    }
    function subFunction(){
	if(xhttp.readyState===4){
		var passed = xhttp.responseText;
		var splitted = passed.split("#");
		var txtJobID = document.getElementById("txtJobID");
		txtJobID.value = splitted[0];
		for(var i = 0 ; i < (splitted.length ) -1 ; i+=2){
		    var test = document.createElement("option");
		    test.value = splitted[i];
		    test.text=splitted[i+1];
		    ddl2.options.add(test);
		}
	}
    }
    
    function showJobID(){
	var ddlJob = document.getElementById("ddlJob");
	var txtJobID = document.getElementById("txtJobID");
	txtJobID.value = ddlJob.value;
    }
</script>
<%@include file="Footer.html"%>
