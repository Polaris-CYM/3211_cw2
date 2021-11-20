package database1;

import java.io.*;
import java.sql.*;
import java.util.*;


/**
 * Create and populate a table using JDBC.
 *
 * @author Yumeng Chen
 * @version 1.2 [2021-11-12]
 */

public class CreateDB {
	
	public static final String propsFile = ".//src//main//java//database1//jdbc.properties";

    /**
     * Establishes a connection to the database.
     *
     * The parameters required for the connection are provided
     * via a properties file, rather than being hard-coded.
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
     * Creates the table "tweets_authors"
     *
     * @param database connection to database
     * @throws SQLException if table creation fails
     */

    public static void createTable(Connection database) throws SQLException
    {
    	// Create a Statement object with which we can execute SQL commands

    	Statement statement = database.createStatement();

    	// Drop existing table, if present

    	try {
    		statement.executeUpdate("DROP TABLE tweets_authors");
    	}
    	catch (SQLException error) {
    	}

    	// Create a fresh table

    	statement.executeUpdate("CREATE TABLE tweets_authors ("
    					  + "id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,"
                          + "tweet_id VARCHAR(30) NOT NULL UNIQUE,"
                          + "username VARCHAR(50) NOT NULL,"
                          + "author_name VARCHAR(50) NOT NULL,"
                          + "img_link VARCHAR(200) NOT NULL)");

    	statement.close();
    }


    /**
     * Adds data in data.txt to the table.
     *
     * @param in source of data
     * @param database connection to database
     * @throws IOException if there is a problem reading from the file
     * @throws SQLException if insertion fails for any reason
     */

    public static void addData(BufferedReader in, Connection database)
    		throws IOException, SQLException
    {
    	// Prepare statement used to insert data

    	PreparedStatement statement =
    		database.prepareStatement("INSERT INTO tweets_authors"
						+ "(tweet_id,username,author_name,img_link)"
						+ "VALUES"
						+ "(?,?,?,?)");

    	// Loop over input data, inserting it into table...
 
    	while (true) {

    		// Obtain tweet ID, author's username and author's name and the link of author's avatar from input file

    		String line = in.readLine();
    		if (line == null)
    			break;
    		StringTokenizer parser = new StringTokenizer(line,",");
    		String tweet_id = parser.nextToken();
    		String username = parser.nextToken();
    		String author_name = parser.nextToken();
    		String img_link = parser.nextToken();

    		// Insert data into table

    		statement.setString(1, tweet_id);
    		statement.setString(2, username);
    		statement.setString(3, author_name);
    		statement.setString(4, img_link);
    		statement.executeUpdate();
    	}
    	statement.close();
    	in.close();
    }


    /**
     * Main program.
     * @throws IOException 
     */

    public static void main(String[] argv) throws IOException
    {  	
    	if (argv.length != 0) {
    		System.err.println("No arguments required.");
    		System.exit(1);
    	}
	  
    	Connection database = null;
 
    	try {
    		BufferedReader input = new BufferedReader(new FileReader(".//src//main//java//database1//data.txt"));
    		database = getConnection();
    		createTable(database);
    		addData(input, database);
    	}
    	catch (Exception error) {
    		error.printStackTrace();
    	}
    	finally {
    		if (database != null) {
    			try {
    				database.close();
    			}
    			catch (Exception error) {}
    		}
    	}
    }
}
