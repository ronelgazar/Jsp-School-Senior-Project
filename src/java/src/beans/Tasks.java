package beans;
import java.util.*;

public class Tasks extends TaskMapping {
    protected int TaskID;
    private String Date;
    private String TaskName;
    private String TaskDescription;
    private String LastDate;
    private char TaskPriority;
    public ArrayList<Employees> EmployeeList =  new ArrayList<Employees>();

    public int getTaskID() {
	return TaskID;
    }

    public void setTaskID(int TaskID) {
	this.TaskID = TaskID;
    }

    public String getDate() {
	return Date;
    }

    public void setDate(String Date) {
	this.Date = Date;
    }

    public String getTaskName() {
	return TaskName;
    }

    public void setTaskName(String TaskName) {
	this.TaskName = TaskName;
    }

    public String getTaskDescription() {
	return TaskDescription;
    }

    public void setTaskDescription(String TaskDescription) {
	this.TaskDescription = TaskDescription;
    }

    public String getLastDate() {
	return LastDate;
    }

    public void setLastDate(String LastDate) {
	this.LastDate = LastDate;
    }

    public char getTaskPriority() {
	return TaskPriority;
    }

    public void setTaskPriority(char TaskPriority) {
	this.TaskPriority = TaskPriority;
    }

    public ArrayList<Employees> getEmployeeList() {
	return EmployeeList;
    }

    public void setEmployeeList(ArrayList<Employees> EmployeeList) {
	this.EmployeeList = EmployeeList;
    }

    public char getStatus() {
	return Status;
    }

    public void setStatus(char Status) {
	this.Status = Status;
    }

    
    
}
