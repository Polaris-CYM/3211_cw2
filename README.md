# **Twitter_ds**
***
## **Introduction**

The home page of the application lets users select one or more tweet(s) that they interested in and web service 1 uses tweet ID(s) to find corresponding author information. Then users can select one author and web service 2 gets selected author's username and displays all the tweets of that author. Finally, users can choose a tweet and web service 3 uses twitter API to show the detailed information of the selected tweet.
 
## **Instructions for Use**
  
### Configuration Environment

1. install and configure `tomcat-8.5`
2. In addition to `java-json.jar` and `gson-2.8.5.jar`, add all `.jar` files in the `twitter_ds/jar` to the build path of `WebService1`, `WebService2` and the lib folder of `Client`.
3. add `gson-2.8.5.jar` to the build path of `WebService2` and add `java-json.jar` to the lib folder of `Client`

### Create Tables in Mysql Database

1. use mysql to create a database.
2. modify the `url`, `user`, and `password` in the `jdbc.properties` in `WebService1/src/main/java/database1` and `WebService2/src/createDB2`
3. change the following files according to the path in your computer: 

* `WebService1/src/main/java/database1/CreateDB.java`
  * `Jdbc.properties` path in command line `17`.
  * `Data.txt` path in command line `150` .

* `WebService2/src/createDB2/CreateDB.java` 
  * `Jdbc.properties` path in command line `22`.
  * `Authorlist.txt` path in command line `168` .

4. run the above two `CreateDB.java` to create tables `tweets_authors` and `authorlist`.
 
### Run Webservices

1. change the following files according to the path in your computer: 

* `WebService1/src/main/java/service1/Service1.java`
  * `Jdbc.properties` path in command line `24` . 
  
* WebService2/src/webservice2/webservice2.java` 
  * `Jdbc.properties` path in command line `16` .

2. run `WebService1/src/main/java/service1/Service1StartUp.java` and `WebService2/src/webservice2/webservice2startup.java` as java application.

### Start the Client

1. Using IDE
   *  run the tomcat.
   * enter `127.0.0.1:8080/Client/HomePage.jsp` in the browser to go to the homepage of the client.
2. Using war package
   * put war package `Client.war` which in folder `3211_cw2/` under tomcat.
   * run the tomcat.
   * enter `127.0.0.1:8080/Client/HomePage.jsp` in the browser to go to the homepage of the client.

### Using Client
1. enter `127.0.0.1:8080/Client/HomePage.jsp` in the browser, and the homepage will show a tweet list.
2. select one or more of them and click `Submit`, the `127.0.0.1:8080/Client/AuthorInfo.jsp` will show the the corresponding author(s) information of the selected tweet(s). If users select nothing, they will see the prompt and will not jump to the next page.
3. choose an author and click `Submit`, the `127.0.0.1:8080/Client/tweetlist.jsp` will show all tweets of the selected author. If users select nothing, they will see the prompt and will not jump to the next page.
4. select a tweet and click `View Details`, and the `127.0.0.1:8080/Client/tweetDetails.jsp` will display detailed information about this tweet, such as (posting time, number of likes, etc.)
