package datalayer;
import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;



public class utils {
    
    public static String getDBString(ServletContext app) {

        String s = app.getRealPath("/");
        s = s.substring(0, s.indexOf("build"));
        s = s +"db/newDB.accdb";

        return s;
    }

}
