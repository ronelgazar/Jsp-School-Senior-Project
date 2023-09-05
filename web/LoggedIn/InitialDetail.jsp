<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Register</title>
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/bootstrap-theme.css">
	<link rel="stylesheet" type="text/css" href="../css/custom.css">
	<script src="../js/respond.js"></script>

</head>
<body>
	<div id="contain">
		<div class="container">
			<h1 class="logo"><img src="../img/logo.svg" width="80" height="60"></h1>
			<%
			    datalayer.DALEmployees objDAL1 = new datalayer.DALEmployees(session.getServletContext());
			    beans.Employees emp = objDAL1.getEmpByID(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
			    datalayer.DALDepartments objDAL2 = new datalayer.DALDepartments(session.getServletContext());
			    beans.Departments dep = objDAL2.getDepartmentByJobID(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
			    datalayer.DALJobs objDAL3 = new datalayer.DALJobs(session.getServletContext());
			    String jobName = objDAL3.getJobByJobID(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
			%>
			<form method="post" action="../EmpServlet" onsubmit="return validate()">
				<label class="f-element text-warning">Since this is your first login we would like you to complete some of your details</label>
				<input type="text" class="form-control f-element" value="<%=emp.getEmpID()%>" id="txtEmployeeId" name="txtEmployeeId" readonly>
				<input type="text" class="form-control f-element" value="<%=emp.getEmpName()%>" id="txtName" name="txtName" readonly>
				<label class="f-element">Gender : 
				    <label class="radio-inline"><input type="radio" name="radioGender" id="radioGenderM" value="M"> Male </label>
				    <label class="radio-inline"><input type="radio" name="radioGender" id="radioGenderF" value="F"> Female</label>
				</label>
				<div class="f-element text-danger" id="msgGender"></div>
				<input type="text" class="form-control f-element" placeholder="City" id="txtCity" name="txtCity">
				<div class="f-element text-danger" id="msgCity"></div>
				<input type="text" class="form-control f-element" value="<%=emp.getEmpContactNumber()%>" id="txtContact" name="txtContact" readonly>
				<input type="email" class="form-control f-element" placeholder="E-Mail" id="txtEmail" name="txtEmail">
				<div class="f-element text-danger" id="msgEmail"></div>
				<input type="text" class="form-control f-element" value="<%=dep.getDepartmentName()%>" id="txtDepartmentName" name="txtDepartmentName" readonly>

				<input type="text" class="form-control f-element" value="<%=jobName%>" id="txtJobDesignation" name="txtJobDesignation" readonly>

				<input type="password" class="form-control f-element" placeholder="New Password" id="pwdPassword" name="pwdPassword">
				<div class="f-element text-danger" id="msgPassword"></div>
				<input type="password" class="form-control f-element" placeholder="Confirm New Password" id="pwdCPassword" name="pwdCPassword">
				<div class="f-element text-danger" id="msgCPassword"></div>
				<input type="submit" name="btnSubmitDetails" value="Submit" class="f-element form-control btn">
				<br>
				<hr class="f-element">
			</form>
		</div>
	</div>
	<script src="../LatestJQuery.js"></script>
		<script>
	    function validate(){
		let ret = true;
		document.getElementById("msgGender").innerHTML="";
		document.getElementById("msgCity").innerHTML="";
		document.getElementById("msgEmail").innerHTML="";
		document.getElementById("msgPassword").innerHTML="";
		document.getElementById("msgCPassword").innerHTML="";
		let genderCheck = false;
		let genderRad = null;
		if(document.getElementById("radioGenderM").checked){
		    genderCheck = true;
		    genderRad = "M"; 
		}
		else if(document.getElementById("radioGenderF").checked){
		    genderCheck = true;
		    genderRad = "F";
		}
		if(!genderCheck){
		    document.getElementById("msgGender").innerHTML="Please select Gender";
		    ret = false;
		}
		if(document.getElementById("txtCity").value.trim().length === 0){
		    document.getElementById("msgCity").innerHTML="City can't be Empty";
		    ret = false;
		}
		if(document.getElementById("txtEmail").value.trim().length === 0){
		    document.getElementById("msgEmail").innerHTML="Email ID can't be empty";
		    ret = false;
		}
		if(document.getElementById("pwdPassword").value.length < 8){
		    document.getElementById("msgPassword").innerHTML="Password should be 8 characters or more";
		    ret = false;
		}
		if(document.getElementById("pwdPassword").value !== document.getElementById("pwdCPassword").value){
		    document.getElementById("msgCPassword").innerHTML = "Password Mismatch";
		    ret = false;
		}
		return ret;		
	    }
	</script>
	<script src="../js/bootstrap.min.js"></script>

</body>
</html>
