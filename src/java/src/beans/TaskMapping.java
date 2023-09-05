
package beans;


public class TaskMapping {
    private int MappingID;
    protected char Status; 
    private int ParentTaskID;
    

    public int getMappingID() {
	return MappingID;
    }

    public void setMappingID(int MappingID) {
	this.MappingID = MappingID;
    }

    public char getStatus() {
	return Status;
    }

    public void setStatus(char Status) {
	this.Status = Status;
    }

    public int getParentTaskID() {
	return ParentTaskID;
    }

    public void setParentTaskID(int ParentTaskID) {
	this.ParentTaskID = ParentTaskID;
    }

   
    
}
