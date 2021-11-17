package webservice2;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/two")
public class webservice2 {
	
	public static final String propsFile = "..//Database2/src/jdbc.properties";
	
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
	
	 public static void findNames(String tweetid, Connection database)
  		   throws SQLException
  		  {
  		    Statement statement = database.createStatement();
  		    ResultSet results = statement.executeQuery(
  		     "SELECT * FROM authorlist WHERE tweet_id =1460411500703535107");
  		    while (results.next()) {
  		      String author_id = results.getString("author_id");
  		      String tweet_id = results.getString("tweet_id");
  		      String tweet_title = results.getString("tweet_title");
  		      String tweet_image = results.getString("tweet_image");
  		      System.out.println(author_id);
  		      System.out.println(tweet_id);
  		      System.out.println(tweet_image);		      
  		    }
  		    statement.close();
  		  }
	
	}
