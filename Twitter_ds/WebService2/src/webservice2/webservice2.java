package webservice2;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import com.google.gson.*;

@Path("/Author")
public class webservice2 {
	
	public static final String propsFile = "..//WebService2/src/createDB2/jdbc.properties";
	
	public static Connection getConnection() throws IOException, SQLException
	  {
	    // Load properties

	    FileInputStream in = new FileInputStream(propsFile);
	    Properties props = new Properties();
	    props.load(in);

	    // Define JDBC driver

	    String drivers = props.getProperty("jdbc.drivers");
	    if (drivers != null)
	      System.setProperty("jdbc.drivers", drivers);
	      // Setting standard system property jdbc.drivers
	      // is an alternative to loading the driver manually
	      // by calling Class.forName()

	    // Obtain access parameters and use them to create connection

	    String url = props.getProperty("jdbc.url");
	    String user = props.getProperty("jdbc.user");
	    String password = props.getProperty("jdbc.password");

	    return DriverManager.getConnection(url, user, password);
	  }
	
	 public static String findNames(String username, Connection database)
  		   throws SQLException
  		  {	 
  		    Statement statement = database.createStatement();
  		    ResultSet results = statement.executeQuery(
  		     "SELECT * FROM authorlist WHERE username ='" + username + "'");
  		    List<Map<String,String>> list = new ArrayList<Map<String,String>>();
  		    while (results.next()) {
  		    	Map<String,String> map = new HashMap<String,String>();
  		    	map.put("id",results.getString(1));
  		    	map.put("username",results.getString(2));
  		    	map.put("author_name",results.getString(3));
  		    	map.put("author_image",results.getString(4));
  		    	map.put("tweet_id",results.getString(5));
  		    	map.put("tweet_content",results.getString(6));
  		    	map.put("tweet_image",results.getString(7));
  		        list.add(map);	      
  		    }
  		    statement.close();
  		    Gson gson = new Gson();
            String jsonstr = null;
            jsonstr = gson.toJson(list);
            return jsonstr;
  		  }
	 
	    @GET
	    @Path("/authorid/{username}")
	    @Produces(MediaType.APPLICATION_JSON)
	    public static String addJSON(@PathParam("username") String username) {
	        Connection connection = null;
	        String result= null;
	        try {
				connection = getConnection();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        try {
	        	result = findNames(username, connection);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        return result;
	    }
	    public static void main(String[] argv)
		  {
			 System.out.println(addJSON("BillyM2k"));
		  }

	}

