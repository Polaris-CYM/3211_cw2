<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="javax.ws.rs.core.MediaType"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig"%>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig"%>
<%@ page import="java.net.*"%>

<%@ page import="com.alibaba.fastjson.JSONArray"%>
<%@ page import="com.alibaba.fastjson.JSONObject"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>HOME</title>
      <!-- Bootstrap CSS -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   </head>
   <script>
      // gets the value of the checkbox(es) selected by the user and connect them to a string
      function connect(){
          var rdo=document.getElementsByName('rdo'); 
          var result='';
      
          for(var i=0; i<chk.length; i++){ 
              if(rdo[i].checked){
              	result=rdo[i].value;
              }
          } 
      
          // sets value to hidden input
      	  document.getElementById("hidden_id").value=result;
          
          console.log(result);
      } 
      
   </script>
   <body>
   	  <%-- gets parameters send by url and call service 1 to handle it --%>
      <%
         String tweets_selected = request.getParameter("selected");
         String str_result = getStrResult(tweets_selected);
         JSONArray json_result = convertStrToJson(str_result);
         %>

      <%-- guide for users --%>
      <h1>Author's Information List</h1>
      <div class="guide">
         <p>Please choose your interested author: </p>
      </div>
           
      <form action="AuthorInfo.jsp" method="GET">
         <div>
         	<%-- uses a table to display a list of the queried author information --%>
            <table class="table">
               <thead>
                  <tr>
                     <th scope="col">#</th>
                     <th scope="col">Tweet ID</th>
                     <th scope="col">Author ID</th>
                     <th scope="col">Author Name</th>
                     <th scope="col">Author's Avatar</th>
                  </tr>
               </thead>
               <tbody>
                  <%-- uses the for loop to get the author information corresponding to all the user's choices --%>
                  <%
                     for (int i = 0; i < json_result.size(); i++) {
                     	JSONObject obj = json_result.getJSONObject(i);
                     	String tweet_id = obj.get("tweet_id").toString();
                     	String author_id = obj.get("author_id").toString();
                     	String author_name = obj.get("author_name").toString();
                     	String img_link = obj.get("img_link").toString();
                     %>
                  <tr>
                     <th scope="row">
                        <div>
                           <input onclick="connect()" type="radio" name=rdo class="form-check-input mt-0" value=<%=author_id%>>
                        </div>
                     </th>
                     <td>
                        <div>
                           <%=tweet_id%>
                        </div>
                     </td>
                     <td>
                        <div>
                           <%=author_id%>
                        </div>
                     </td>
                     <td>
                        <div>
                           <%=author_name%>
                        </div>
                     </td>
                     <td>
                        <div class="profile">
                           <img src=<%=img_link%> alt="profile">
                        </div>
                     </td>
                  </tr>
                  <%
                     }
                     %>
               </tbody>
            </table>
         </div>
         <div class="btnSubmit">
            <input type="submit" value="Submit" class="btn btn-primary">
         </div>
         <%-- uses GET method to send user's choice to the page to jump to --%>
         <input type="hidden" name="selected" id="hidden_id">
      </form>
      
      <%-- Call service1 to get the author(s) info of the selected tweet(s) in json format --%>
      <%!static final String REST_URI = "http://localhost:3105/service1";
         static final String SERVICE1_PATH = "findAuthor/tweetID";
         
      	 // calls web service 1 and the result obtained is a string in Json format
         
      	 private String getOutputAsJSON(WebResource service) {
         	return service.accept(MediaType.APPLICATION_JSON).get(String.class);
         }
         
         private String getStrResult(String tweet_id) {
        	// declares the client object
         	ClientConfig clientConfig = new DefaultClientConfig();
         	Client client = Client.create(clientConfig);
         	
         	WebResource service1 = client.resource(REST_URI);
         	WebResource findAuthorInfo = service1.path(SERVICE1_PATH).path("/" + tweet_id);
         	
         	//WebTarget target = client.target(serverUri + "/users");
         	
         	String result = getOutputAsJSON(findAuthorInfo);
         	return result;
         }        
         
         // converts string result to JSON format
         private JSONArray convertStrToJson(String str) {
         	
         	//try{
         		JSONArray resultArray = JSONArray.parseArray(str);
         		return resultArray;
         	//}
         	//catch(JSONException e){
         		//e.printStackTrace(); 
         		//return null;
         	//}
         	
         	
         }%>
   </body>
   <style type="text/css">
      body{
      	text-align: center;
      	background-color: #FFFFFF;
      	width: 50%;
      	margin: auto;
      }
      h1{
      	margin-top: 5%;
      	font-size: 40px;
      }
      .guide{
      	text-align: left;
      	margin-top: 5%;
      	margin-bottom: 4%;
      	font-size: 30px;
      }
      img {
      	height: 200px;
      }
      .btnSubmit{
      	margin-top: 2%;
      	margin-bottom: 5%;
      	text-align: center;
      }
   </style>
</html>