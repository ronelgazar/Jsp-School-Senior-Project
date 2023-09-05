
package datalayer;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletContext;

public class DALDepartments extends DBOperations{
	private ServletContext app;
    public DALDepartments(ServletContext app){
	this.app = app;
	createConnection(app);
    }
    
    public ArrayList<beans.Departments> getDepartments(){
	ArrayList<beans.Departments> AD = new ArrayList<>();
	
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT * FROM Departments");
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()){
		beans.Departments d= new beans.Departments();
		
		d.setDepartmentID(Integer.parseInt(rs.getString("DepartmentID")));
		d.setDepartmentName(rs.getString("DepartmentName"));
		
		AD.add(d);
	    }
	} catch (Exception e) {
	    System.out.println(e);
	}
	return AD;
	
    }
    
    public beans.Departments getDepartmentByJobID(int x){
	beans.Departments d = new beans.Departments();
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT Departments.DepartmentID, Departments.DepartmentName FROM Jobs INNER JOIN Departments ON Jobs.DepartmentID = Departments.DepartmentID WHERE (Jobs.JobID=?)");
	    ps.setString(1, String.valueOf(x));
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()){
		d.setDepartmentID(Integer.parseInt(rs.getString("DepartmentID")));
		d.setDepartmentName(rs.getString("DepartmentName"));
	    }
	    closeConnection();
	} catch (Exception e) {
	    System.out.println(e);
	}
	return d;
    }
}
