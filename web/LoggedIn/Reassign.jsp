<%@include file="Header.jsp"%>
<%
    datalayer.DALTasks objDAL2 = new datalayer.DALTasks(session.getServletContext());
    beans.Tasks task = objDAL2.getTaskByTaskID(Integer.parseInt(request.getParameter("reassign")), Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));   
%>
<div class="row">
    <%int JobID = Integer.parseInt(session.getAttribute("LoggedJobID").toString()); %>
    <div class="col-lg-12 content-custom">
	 <h1>Reassign Task</h1>
	 <form method="post" action="../EmpServlet">
	     <table class="table table-striped">
		 <tr>
		     <th>
			 Task Name
		     </th>
		     <td>
			 <input type="text" class="form-control" name="txtTaskName" id="txtTaskName" readonly value="<%=task.getTaskName()%>">
		     </td>
		 </tr>
		 <tr><th colspan="2">Description<br><br>
			 <textarea name="txtDescription" class="form-control text-area" rows="7" disabled><%=task.getTaskDescription()%></textarea>
		     </th>
		 </tr>
		 <tr>
		     <th>
			 Last Date
		     </th>
		     <td>
			 <div  class='input-group' id="dt-picker">
			     <input type="text" class="form-control" name="txtLastDate" id="txtLastDate" readonly value="<%=task.getLastDate()%>">
			    <span class="input-group-addon">
				<span class="glyphicon glyphicon-calendar"></span>
			    </span>
		     </td>
		 </tr>
		 <tr>
		     <th>
			 Priority
		     </th>
		     <td class="form-inline">
			 <input type="radio" name='radioPriority' id='radioPriority1' value='L' class="" <%=(task.getTaskPriority()=='L')? "checked":"disabled"%>> Low
			 <input type="radio" name='radioPriority' id='radioPriority2' value='M' class=""  <%=(task.getTaskPriority()=='M')? "checked":"disabled"%>> Medium
			 <input type="radio" name='radioPriority' id='radioPriority3' value='H' class=""  <%=(task.getTaskPriority()=='H')? "checked":"disabled"%>> High
		     </td>
		 </tr>
		 <tr>
		     <%
			datalayer.DALEmployees objDAL1 = new datalayer.DALEmployees(session.getServletContext());
			 ArrayList<beans.Employees> AL = objDAL1.showEmpAdded(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));		     
		    %>
		    
		    <table class="table table-hover table-condensed table-bordered">
			<tr>
			    <th><span class="glyphicon glyphicon-saved pad-left"></span></th>
			    <th>Employee ID</th>
			    <th>Employee Name</th>
			    <th>Employee Contact</th>	     
			    <th>Department Name</th>
			    <th>Job ID</th>			     
			    <th>Job Name</th>		     
			</tr>
			<%
			    for(beans.Employees x : AL){
			%>
			<tr>
			    <td><input	type='checkbox' class="big-check form-checkbox" name="checkEmpSelect" value="<%=x.getEmpID()%>"></td>
			    <td><%=x.getEmpID()%></td>
			    <td><%=x.getEmpName()%></td>
			    <td><%=x.getEmpContactNumber()%></td>
			    <td><%=x.getDepartmentName()%></td>
			    <td><%=x.getJobID()%></td>
			    <td><%=x.getJobName()%></td>
			</tr>
		     <%}%>
		    </table>
		 </tr>
		 <tr>
		     <td><input class="hidden" name="txtTaskID" type="text" value="<%=task.getTaskID()%>"></td>
		     <td><input type="submit" value="Reassign" class="btn  btn-primary pull-right" name="btnReassign"></td>
		 </tr>
	     </table>
	 </form>
     </div>
</div>
<script src="../LatestJQuery.js"></script>
<script type="text/javascript">
 
</script>		
<%@include file="Footer.html"%>