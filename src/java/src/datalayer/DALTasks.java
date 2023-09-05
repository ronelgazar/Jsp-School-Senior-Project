package datalayer;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletContext;
public class DALTasks extends DBOperations{
    private ServletContext app;
    public DALTasks(ServletContext app){
    this.app = app;
	createConnection(app);
    }
    
    public void AddTask(beans.Tasks t){

	try
	{
	    
	    CallableStatement cs = con.prepareCall("{call sp_AddTask(?,?,?,?,?)}");
	    
	    cs.registerOutParameter(1, java.sql.Types.INTEGER);
	    cs.setString(2, t.getTaskName() );
	    cs.setString(3, t.getTaskDescription() );
	    cs.setString(4, t.getLastDate() );
	    cs.setString(5, String.valueOf(t.getTaskPriority() ));
	    
	    cs.executeUpdate();
	    
	    int taskid = cs.getInt(1);
	    
	    Statement st = con.createStatement();
	    String query="";
	    
	    for(beans.Employees e : t.getEmployeeList())
	    {
		query = "Insert into TaskMapping values("+taskid+","+e.getEmpID()+",'O',NULL)";
		st.execute(query);
	    }
	    
	}
	catch(Exception ex)
	{
	    System.out.println(ex);
	}
	
    }
    
    public ArrayList<beans.Tasks> getTasksOpenForYou(int ID){
	ArrayList<beans.Tasks> AL = new ArrayList<beans.Tasks>();
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT Tasks.Date, Tasks.TaskName, Tasks.TaskDescription, Tasks.LastDate, Tasks.TaskPriority, TaskMapping.TaskID, TaskMapping.Status FROM Tasks INNER JOIN TaskMapping ON Tasks.TaskID = TaskMapping.TaskID WHERE (TaskMapping.EmpID = ?) ORDER BY LastDate, CASE TaskPriority WHEN 'H' THEN 1 WHEN 'M' THEN 2 WHEN 'L' THEN 3 END");
	    ps.setString(1,String.valueOf(ID));
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()){
		beans.Tasks t = new beans.Tasks();
		t.setTaskName(rs.getString("TaskName"));
		t.setDate(rs.getString("Date"));
		t.setLastDate(rs.getString("LastDate"));
		t.setTaskDescription(rs.getString("TaskDescription"));
		t.setTaskID(Integer.parseInt(rs.getString("TaskID")));
		t.setTaskPriority(rs.getString("TaskPriority").charAt(0));
		t.setStatus(rs.getString("Status").charAt(0));
		
		AL.add(t);
		
	    }
		
	}
	catch (Exception e) {
	    System.out.println(e);
	}
	return AL;
    }
    
        public ArrayList<beans.Tasks> getTasksAssignedByYou(int ID){
	ArrayList<beans.Tasks> AL = new ArrayList<beans.Tasks>();
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT Tasks.Date, TaskMapping.TaskID, Tasks.TaskName, Tasks.TaskDescription, Tasks.LastDate, Tasks.TaskPriority, TaskMapping.Status, Employees.EmpID, Employees.ManagerID FROM TaskMapping INNER JOIN Tasks ON TaskMapping.TaskID = Tasks.TaskID INNER JOIN Employees ON TaskMapping.EmpID = Employees.EmpID WHERE (Employees.ManagerID = ?)");
	    ps.setString(1,String.valueOf(ID));
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()){
		beans.Tasks t = new beans.Tasks();
		t.setTaskName(rs.getString("TaskName"));
		t.setDate(rs.getString("Date"));
		t.setLastDate(rs.getString("LastDate"));
		t.setTaskDescription(rs.getString("TaskDescription"));
		t.setTaskID(Integer.parseInt(rs.getString("TaskID")));
		t.setTaskPriority(rs.getString("TaskPriority").charAt(0));
		t.setStatus(rs.getString("Status").charAt(0));
		datalayer.DALEmployees objDAL = new datalayer.DALEmployees(this.app);
		beans.Employees emp = objDAL.getEmpByID(Integer.parseInt(rs.getString("EmpID")));
		t.EmployeeList.add(emp);
		AL.add(t);
		
	    }
		
	}
	catch (Exception e) {
	    System.out.println(e);
	}
	return AL;
    }

    public String changeStatus(int TaskID , int EmpID){
	String status="";
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT * FROM TaskMapping WHERE TaskID=? AND EmpID=?");
	    ps.setString(1, String.valueOf(TaskID));
	    ps.setString(2, String.valueOf(EmpID));
	    ResultSet rs = ps.executeQuery();
	    beans.TaskMapping tm = new beans.TaskMapping();
	    while(rs.next()){
		tm.setStatus(rs.getString("Status").charAt(0));
	    }
	    ps = con.prepareStatement("UPDATE TaskMapping SET Status=? WHERE TaskID=? AND EmpID=?");
	    
	    if(tm.getStatus() == 'O'){
		status="Work In Progress";
		ps.setString(1,"W");
		ps.setString(2,String.valueOf(TaskID));
		ps.setString(3,String.valueOf(EmpID));
		ps.executeUpdate();
	    }
	    else if (tm.getStatus() == 'W'){
		status="Closed";
		ps.setString(1,"C");
		ps.setString(2,String.valueOf(TaskID));
		ps.setString(3,String.valueOf(EmpID));
		ps.executeUpdate();
	    }
	    else if(tm.getStatus() == 'C'){
		status="Closed";
	    }
	} catch (Exception e) {
	    System.out.println(e);
	}
	return status;
    }
    
    public beans.Tasks getTaskByTaskID(int TaskID , int EmpID){
	beans.Tasks task = new beans.Tasks();
	try {
	    PreparedStatement ps =  con.prepareStatement("SELECT Tasks.TaskID, Tasks.Date, Tasks.TaskName, Tasks.TaskDescription, Tasks.LastDate, Tasks.TaskPriority, TaskMapping.MappingID, TaskMapping.EmpID,TaskMapping.Status, TaskMapping.ParentTaskID FROM Tasks INNER JOIN TaskMapping ON Tasks.TaskID = TaskMapping.TaskID WHERE(Tasks.TaskID = ?) AND (TaskMapping.EmpID = ?)");
	    ps.setString(1 , String.valueOf(TaskID));
	    ps.setString(2 , String.valueOf(EmpID));
	    
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()){
		task.setTaskID(TaskID);
		task.setDate(rs.getString("Date"));
		task.setLastDate(rs.getString("LastDate"));
		task.setTaskDescription(rs.getString("TaskDescription"));
		task.setTaskPriority(rs.getString("TaskPriority").charAt(0));
		task.setTaskName(rs.getString("TaskName"));
	    }
	} catch (Exception e) {
	    System.out.println(e);
	}
	return task;
    }
    public int getMappingID(int taskID , int empID){
	int mappingID=0;
	try {
	    PreparedStatement ps = con.prepareStatement("SELECT * FROM TaskMapping WHERE TaskID=? AND EmpID=?");
	    ps.setString(1, String.valueOf(taskID));
	    ps.setString(2, String.valueOf(empID));
	    ResultSet rs = ps.executeQuery();
	    while(rs.next()){
		mappingID=rs.getInt("MappingID");
	    }
	    
	} catch (Exception e) {
	    System.out.println(e);
	}
	return mappingID;
    }
public void reassignTask(beans.Tasks t) {
    try {
        PreparedStatement ps = con.prepareStatement("UPDATE TaskMapping SET emp_id = ?, status = 'O' WHERE task_id = ? AND mapping_id = ?");
        for (beans.Employees e : t.getEmployeeList()) {
            ps.setInt(1, e.getEmpID());
            ps.setInt(2, t.getTaskID());
            ps.setInt(3, t.getMappingID());
            ps.executeUpdate();
        }
    } catch (Exception e) {
        System.out.println(e);
    }
}
    
}





