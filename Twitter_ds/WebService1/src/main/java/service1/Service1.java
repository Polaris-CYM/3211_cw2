package service1;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.PathParam;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@Path("/findAuthor")
public class Service1 {
	
	public static final String propsFile = ".//src//main//java//database1//jdbc.properties";

	@GET
    @Path("/tweetID/{tweet_id}")
    @Produces(MediaType.APPLICATION_JSON)
    public static String convertToJson(@PathParam("tweet_id") String tweet_id) {
        Connection connection = null;
        
        // Creates an arraylist to store the author information queried for each tweet ID
        ArrayList<String> author_info= new ArrayList<String>();
        
        // Creates a JSONArray to store the query result in json format
        JSONArray final_json = new JSONArray();
        
        // Creates an array to store all tweets ID entered by the user
        String[] input_tweet_id = tweet_id.split("#");
            
        // Queries the results according to user input and convert them into json format
        try {
        	for(int i = 0; i < input_tweet_id.length; i++) {
        		connection = getConnection();
        		author_info = findAuthors(input_tweet_id[i], connection);
        		for(int j = 0; j < author_info.size() ; j++){
        			String[] split_info = author_info.get(j).split("#"); 
        			JSONObject json_obj = new JSONObject();
        			for(int k =0; k < split_info.length ; k++){
        				json_obj.put("tweet_id", split_info[0]);
        				json_obj.put("author_id", split_info[1]);
        				json_obj.put("author_name", split_info[2]);
        				json_obj.put("img_link", split_info[3]);
        			}
        			final_json.add(json_obj);
        		}            
        	}
        }
        catch (Exception error) {
          error.printStackTrace();
        }
        return final_json.toString();
    }
	
	/**
	 * Creates a connection to the 3211cw2_cym database.
	 *
	 * @return Connection object representing the connection
	 * @throws IOException if properties file cannot be accessed
	 * @throws SQLException if connection fails
	 */
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

	    // Obtain access parameters and use them to create connection

	    String url = props.getProperty("jdbc.url");
	    String user = props.getProperty("jdbc.user");
	    String password = props.getProperty("jdbc.password");

	    return DriverManager.getConnection(url, user, password);
	}


	/**
	 * Queries the database to find corresponding author's information.
	 *
	 * @param tweet's ID to search for in database
	 * @param database connection to database
	 * @throws SQLException if query fails
	 */
	public static ArrayList<String> findAuthors(String tweet_id, Connection database) throws SQLException
	{
		Statement statement = database.createStatement();
		
		// Query the information of the author corresponding to all tweets selected by the user
		
	    ResultSet results = statement.executeQuery(
	    		"SELECT * FROM tweets_authors WHERE tweet_id = '" + tweet_id + "'");

	    // Create an arraylist to store query results
	    
	    ArrayList<String> selectResults = new ArrayList<>();
	    
	    while (results.next()) {
	    	String author_id = results.getString("author_id");
		    String author_name = results.getString("author_name");
		    String img_link = results.getString("img_link");
		    selectResults.add(tweet_id + "#" + author_id + "#" + author_name + "#" + img_link);
	    }
	    statement.close();
	    
	    return selectResults;
	}
	
//	public static void main(String[] argv)
//	{
//		System.out.println(convertToJson("1460255188128878593#1460462992374394881"));
//	}
}
