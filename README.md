# **Tiwtter_ds**
***
## **Introduction**

This project uses the id of multiple tweets to find authors, and select the author to display all the Tweets of the author, as well as the detailed information of the tweet.
 
## **Instructions for Use**
  
### Configuration Environment

1. install and configure `tomcat-8.5`
2. add the `.jar` file in the `jar` folder to the bliud path of `WebService1`, `WebService2` and `Client` projects.

### Create Tables in Mysql Database

1. use mysql to create a database.
2. modify the `url`, `user`, and `password` in the `jdbc.properties` in `WebService1` and `WebService2`
3. change the following files according to the path in your computer: 

* `WebService1/CreateDB.java`
  * `Jdbc.properties` path in command line `17`.
  * `Data.txt` path in command line `150` .

* `WebService2/createDB2.java` 
  * `Jdbc.properties` path in command line `22`.
  * `Authorlist.txt` path in command line `168` .

4. run `CreateDB1` and `CreateDB2` to create tables `tweets_authors` and `authorlist`.
 
### Run Webservices

1. change the following files according to the path in your computer: 

* `WebService1/Service1.java`
  * `Jdbc.properties` path in command line `24` . 
  
* `WebService2/webservice2.java` 
  * `Jdbc.properties` path in command line `16` .

2. run `Service1StartUp.java` and `webservice2startup.java` with java application.

### Start the Client

1. Using IDE
   *  run the tomcat.
   * enter `127.0.0.1:8080/Clinet/HomePage.jsp` in the browser to start using client.
2. Using war package
   * put war package `Client.war` which in folder `Twitter_ds/` under tomcat.
   * run the tomcat.
   * enter `127.0.0.1:8080/Clinet/HomePage.jsp` in the browser to start using client.

### Using Client
1. enter `127.0.0.1:8080/Clinet/HomePage.jsp` in the browser, and the homepage will show three tweets.
2. select one or more of them and click `Submit`, the `127.0.0.1:8080/Clinet/AuthorInfo.jsp` will show the corresponding author.
3. choose an author and click `Submit`, the `127.0.0.1:8080/Clinet/tweetlist.jsp` will show all his/her tweets
4. select a tweet and click `View Details`, and the `127.0.0.1:8080/Clinet/tweeDetails.jsp` will display detailed information about this tweet, such as (posting time, number of likes, etc.)
