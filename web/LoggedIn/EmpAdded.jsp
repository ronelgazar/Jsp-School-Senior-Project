<%@include file="Header.jsp"%>
 <div class="row">
    
    <div class="col-lg-12 content-custom">
	 <h1>Employees Added By You</h1>
	     <%
		     datalayer.DALEmployees objDAL = new datalayer.DALEmployees(session.getServletContext());
		     ArrayList<beans.Employees> AL = objDAL.showEmpAdded(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));		     
	     %>
	     <table class="table table-striped ">
		 <tr>
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
		     <td><%=x.getEmpID()%></td>
		     <td><a href="EmpProfile.jsp?ID=<%=x.getEmpID()%>"><button class="btn btn-default"><%=x.getEmpName()%></button></a></td>
		     <td><%=x.getEmpContactNumber()%></td>
		     <td><%=x.getDepartmentName()%></td>
		     <td><%=x.getJobID()%></td>
		     <td><%=x.getJobName()%></td>
		 </tr>
		 <%}%>
	     </table>
     </div>
</div>
<script type="text/javascript">

</script>			 
<%@include file="Footer.html" %>