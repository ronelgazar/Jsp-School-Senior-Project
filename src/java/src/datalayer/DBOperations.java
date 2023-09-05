
package datalayer;
import java.sql.*;
import javax.servlet.ServletContext;


public class DBOperations {
    protected Connection con;
    
    protected void createConnection(ServletContext app){
	try {
		Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
				String dbURL = "jdbc:ucanaccess://" + utils.getDBString(app);
				System.out.println(dbURL);
				con = DriverManager.getConnection(dbURL);
	} catch (ClassNotFoundException | SQLException ex) {
	    System.out.println(ex);
	}
    }
    
    protected void closeConnection(){
	if(con!=null){
	    try{
		con.close();
	    }
	    catch(SQLException ex){
		System.out.println(ex);
	    }
	}
    }
}
