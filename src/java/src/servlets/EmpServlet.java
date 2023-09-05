package servlets;

import beans.Employees;
import datalayer.DALTasks;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import javax.servlet.annotation.MultipartConfig;
import java.io.*;
import javax.servlet.http.Part;


@MultipartConfig
public class EmpServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	response.setContentType("text/html;charset=UTF-8");
	try (PrintWriter out = response.getWriter()) {
	    /* TODO output your page here. You may use following sample code. */
	    if(request.getParameter("btnLogin")!=null){
		datalayer.DALEmployees objDAL = new datalayer.DALEmployees(request.getServletContext());
		String uid = request.getParameter("txtEmployeeId");
		String pwd = request.getParameter("pwdPassword");
		beans.Employees e = objDAL.authenticateLogin(uid,pwd);
		if(e.getEmpID()>0){
		    request.getSession().setAttribute("LoggedEmpId",e.getEmpID());
		    request.getSession().setAttribute("LoggedEmpName",e.getEmpName());
		    request.getSession().setAttribute("LoggedJobID",e.getJobID());
		    if(e.getEmpEmailID().equals("@")){
			response.sendRedirect("LoggedIn/InitialDetail.jsp");
		    }
		    else{
			response.sendRedirect("LoggedIn/AddEmp.jsp" );
		    }
		    
		}
		else{
		    request.setAttribute("flag", 1);
		    request.getRequestDispatcher("Login.jsp").forward(request,response);
		}
	    }
	    else if(request.getParameter("btnSubmitDetails")!=null){
		beans.Employees emp = new beans.Employees();
		datalayer.DALEmployees objDAL = new datalayer.DALEmployees(request.getServletContext());
		emp.setEmpGender(request.getParameter("radioGender").charAt(0));
		emp.setEmpCity(request.getParameter("txtCity"));
		emp.setEmpEmailID(request.getParameter("txtEmail"));
		emp.setEmpPassword(request.getParameter("pwdPassword"));
		emp.setEmpID(Integer.parseInt(request.getSession().getAttribute("LoggedEmpId").toString()));
		
		objDAL.updateDetails(emp);
		objDAL.updatePassword(emp);
		out.println("Success");
		response.sendRedirect("LoggedIn/AddEmp.jsp" );
	    }
	    else if(request.getParameter("number")!=null){
		datalayer.DALJobs objDAL = new datalayer.DALJobs(request.getServletContext());
		int level =objDAL.getLevels(Integer.parseInt(request.getSession().getAttribute("LoggedJobID").toString()));
		ArrayList<beans.Jobs> AL = objDAL.getJobs(Integer.parseInt(request.getParameter("number")),level);
		String passable="";
		for(beans.Jobs x : AL){
		    passable += x.getJobID() + "#"+ x.getJobName()+"#";
		}
		out.println(passable);
	    }
	    else if(request.getParameter("btnAddEmp")!= null){
		datalayer.DALEmployees objDAL = new datalayer.DALEmployees(request.getServletContext());
		beans.Employees emp = new beans.Employees();
		
		emp.setEmpName(request.getParameter("txtEmpName"));
		emp.setEmpContactNumber(Long.parseLong(request.getParameter("txtEmpContact")));
		emp.setJobID(Integer.parseInt(request.getParameter("txtJobID")));
		emp.setManagerID(Integer.parseInt(request.getSession().getAttribute("LoggedEmpId").toString()));
		
		objDAL.addEmployee(emp);
		response.sendRedirect("LoggedIn/AddEmp.jsp");
	    }
	    else if(request.getParameter("btnAddTask")!=null){
		beans.Tasks task = new beans.Tasks();
		task.setTaskName(request.getParameter("txtTaskName"));
		task.setTaskDescription(request.getParameter("txtDescription"));
		task.setTaskPriority(request.getParameter("radioPriority").charAt(0));
		task.setLastDate(request.getParameter("txtLastDate"));
		String temp[] = request.getParameterValues("checkEmpSelect");
		for(String x : temp){
		    beans.Employees e = new Employees();
		    e.setEmpID(Integer.parseInt(x));
		    task.EmployeeList.add(e);
		}
		
		datalayer.DALTasks objDAL = new DALTasks(request.getServletContext());
		objDAL.AddTask(task);
		
		response.sendRedirect("LoggedIn/AddTask.jsp");
	    }
	    else if(request.getParameter("taskid")!=null){
		    int taskid = Integer.parseInt(request.getParameter("taskid"));
		    datalayer.DALTasks objDAL =  new datalayer.DALTasks(request.getServletContext());
		    String  output = objDAL.changeStatus(taskid , Integer.parseInt(request.getSession().getAttribute("LoggedEmpId").toString()));
		    out.println(output);
	    }
	    else if (request.getParameter("btnUpload")!=null){
		String strRealPath = request.getServletContext().getRealPath("/");
		
		strRealPath = strRealPath + "LoggedIn\\EmployeesImages\\"+"Img"+request.getSession().getAttribute("LoggedEmpId").toString()+".jpg";
		
		File file = new File(strRealPath);
		OutputStream os = new FileOutputStream(file);
		Part part = request.getPart("empimage");
		
		InputStream is = part.getInputStream();
		
		byte[] bytes = new byte[1024];
		int x =0;
		
		while((x = is.read(bytes))!=-1)
		{
		    os.write(bytes,0,x);
		}
		
		os.close();
		is.close();
		response.sendRedirect("LoggedIn/UploadImage.jsp");
	    }//btnUpload
	    
	    else if(request.getParameter("logout")!=null){
		if(request.getParameter("logout").equals("y")){
		    request.getSession().invalidate();
		    response.sendRedirect("Login.jsp");
		}
	    }
	    else if(request.getParameter("btnChngPwd")!=null){
		datalayer.DALEmployees objDAL = new datalayer.DALEmployees(request.getServletContext());
		beans.Employees e = objDAL.authenticateLogin(request.getSession().getAttribute("LoggedEmpId").toString(),request.getParameter("pwdCurrectPassword"));
		objDAL=null;
		objDAL=new datalayer.DALEmployees(request.getServletContext());
		e.setEmpPassword(request.getParameter("pwdNewPassword"));
		if(e.getEmpID()>0){		    
		    objDAL.updatePassword(e);
		    response.sendRedirect("LoggedIn/AddEmp.jsp");
		}
		else{
		    response.sendRedirect("LoggedIn/ChangePassword.jsp?fail=true");
		}
	    }
	    
	    else if(request.getParameter("btnReassign")!=null){
		datalayer.DALTasks objDAL = new DALTasks(request.getServletContext());
		beans.Tasks task = new beans.Tasks();
		task.setTaskID(Integer.parseInt(request.getParameter("txtTaskID")));
		task.setTaskName(request.getParameter("txtTaskName"));
		task.setTaskDescription(request.getParameter("txtDescription"));
		task.setTaskPriority(request.getParameter("radioPriority").charAt(0));
		task.setLastDate(request.getParameter("txtLastDate"));
		task.setMappingID(objDAL.getMappingID(task.getTaskID(), Integer.parseInt(request.getSession().getAttribute("LoggedEmpId").toString())));
		String temp[] = request.getParameterValues("checkEmpSelect");
		for(String x : temp){
		    beans.Employees e = new Employees();
		    e.setEmpID(Integer.parseInt(x));
		    task.EmployeeList.add(e);
		}
		objDAL.reassignTask(task);
		response.sendRedirect("LoggedIn/Tasks.jsp");
	    }
	    
	}
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
	return "Short description";
    }// </editor-fold>

}
