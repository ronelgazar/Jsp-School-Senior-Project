
package datalayer;
import beans.Employees;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletContext;

public class DALEmployees extends DBOperations{
	private ServletContext app;
    public DALEmployees(ServletContext app){
	this.app = app;
	createConnection(app);
    }
    
    public beans.Employees authenticateLogin(String uid, String pwd){
	beans.Employees emp = new beans.Employees();
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT * FROM Employees WHERE EmpID=? AND EmpPassword=?");
	    
	    ps.setString(1, uid);
	    ps.setString(2, pwd);
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		emp.setEmpID(Integer.parseInt(rs.getString("EmpID")));
		emp.setEmpName(rs.getString("EmpName"));
		emp.setEmpPassword(rs.getString("EmpPassword"));
		emp.setEmpCity(rs.getString("EmpCity"));
		emp.setEmpContactNumber(Long.parseLong(rs.getString("EmpContactNumber")));
		emp.setEmpEmailID(rs.getString("EmpEmailID"));
		emp.setJobID(Integer.parseInt(rs.getString("JobID")));
		emp.setEmpImage(rs.getString("EmpImage"));
		emp.setManagerID(Integer.parseInt(rs.getString("ManagerID")));
		emp.setEmpGender(rs.getString("EmpGender").charAt(0));
	    }
	    closeConnection();
	    
	} catch (Exception e) {
	    System.out.println(e);
	}
	
	return emp;
    }
    
    public void addEmployee(beans.Employees empNew){
	try {
	    PreparedStatement ps = con.prepareStatement("INSERT INTO Employees (EmpName,EmpGender,EmpCity,EmpContactNumber,EmpEmailID,JobID,ManagerID) VALUES(?,?,?,?,?,?,?)");
	    
	    ps.setString(1, empNew.getEmpName());
	    ps.setString(2, "");
	    ps.setString(3, "");
	    ps.setString(4, Long.toString(empNew.getEmpContactNumber()));
	    ps.setString(5, "@");
	    ps.setString(6, Integer.toString(empNew.getJobID()));
	    ps.setString(7, Integer.toString(empNew.getManagerID()));
	    
	    ps.executeUpdate();
	    closeConnection();
	    
	} catch (Exception e) {
	    System.out.println(e);
	}
    }
    
    public ArrayList<beans.Employees> showEmpAdded(int ID){
	ArrayList<beans.Employees> AE = new ArrayList<beans.Employees>();
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT Employees.EmpID, Employees.EmpName, Employees.EmpContactNumber, Jobs.JobID, Jobs.JobName, Departments.DepartmentID, Departments.DepartmentName FROM Employees INNER JOIN Jobs ON Employees.JobID = Jobs.JobID INNER JOIN Departments ON Jobs.DepartmentID = Departments.DepartmentID WHERE(Employees.ManagerID = ?)");
//	    PreparedStatement ps = con.prepareStatement("SELECT Employees.EmpID, Employees.EmpName, Employees.EmpGender,Employees.EmpContactNumber, Employees.EmpEmailID,Jobs.JobID, Jobs.JobName, Departments.DepartmentID, Departments.DepartmentName FROM Employees INNER JOIN Jobs ON Employees.JobID = Jobs.JobID INNER JOIN Departments ON Jobs.DepartmentID = Departments.DepartmentID WHERE(Employees.ManagerID = ?)");
	    ps.setString(1, String.valueOf(ID));
	    ResultSet rs = ps.executeQuery();
	    
	    while(rs.next()){
		beans.Employees emp = new beans.Employees();
		emp.setEmpID(Integer.parseInt(rs.getString("EmpID")));
		emp.setEmpName(rs.getString("EmpName"));
		emp.setEmpContactNumber(Long.parseLong(rs.getString("EmpContactNumber")));
		emp.setJobID(Integer.parseInt(rs.getString("JobID")));
		emp.setJobName(rs.getString("JobName"));
		emp.setDepartmentID(Integer.parseInt(rs.getString("DepartmentID")));
		emp.setDepartmentName(rs.getString("DepartmentName"));
				
		AE.add(emp);
	    }
//	    closeConnection();
	} catch (Exception e) {
	    System.out.println(e);
	}
	return AE;
    }
    
    public beans.Employees getEmpByID(int x){
	beans.Employees emp = new beans.Employees();
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT * from Employees WHERE EmpID=?");
	    ps.setString(1, String.valueOf(x));
	    ResultSet rs = ps.executeQuery();
	    
	    while(rs.next()){
		emp.setEmpID(Integer.parseInt(rs.getString("EmpID")));
		emp.setEmpName(rs.getString("EmpName"));
		emp.setEmpContactNumber(Long.parseLong(rs.getString("EmpContactNumber")));
		emp.setJobID(Integer.parseInt(rs.getString("JobID")));
		emp.setEmpCity(rs.getString("EmpCity"));
		emp.setEmpEmailID(rs.getString("EmpEmailID"));
		emp.setManagerID(rs.getInt("ManagerID"));
		emp.setEmpGender(rs.getString("EmpGender").charAt(0));
				
	    }
	} catch (Exception e) {
	    System.out.println(e);
	}
	return emp;
    }
    
    public void updateDetails(beans.Employees emp){
	try {
	    PreparedStatement ps = con.prepareStatement("UPDATE Employees SET EmpGender=? , EmpCity=? , EmpEmailID=? WHERE EmpID=?");
	    ps.setString(1, String.valueOf(emp.getEmpGender()));
	    ps.setString(2, emp.getEmpCity());
	    ps.setString(3, emp.getEmpEmailID());
	    ps.setString(4, String.valueOf(emp.getEmpID()));
	    ps.executeUpdate();
	} catch (Exception e) {
	    System.out.println(e);
	}
    }
    public void updateAllDetails(beans.Employees emp){
	try {
	    
	} catch (Exception e) {
	    System.out.println(e);
	}
    }
    public void updatePassword(beans.Employees emp){
	try {
	    PreparedStatement ps = con.prepareStatement("UPDATE Employees SET EmpPassword=? WHERE EmpID=?");
	    ps.setString(1,emp.getEmpPassword());
	    ps.setString(2, String.valueOf(emp.getEmpID()));
	    ps.executeUpdate();
	} catch (Exception e) {
	    System.out.println(e);
	}
    }
    
}
