<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.ws.rs.core.MediaType"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig"%>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig"%>
<%@ page import="org.json.*"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>TweetList</title>
      <!-- Bootstrap CSS -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   </head>
   <body>
      <script></script>
      <%-- gets parameters send by url and call service 2 to handle it --%>
      <%
         String Username = request.getParameter("selected");
         String json = getjson(Username);
         JSONArray jsonArray = getAuthor(json);
         JSONObject first  = jsonArray.getJSONObject(0);
         String name = first.get("author_name").toString();
         String author_image = first.get("author_image").toString();
         %>
      <div class="head">
         <img src=<%=author_image%> alt="Avatar" class="avatar">
         <h1><%=name%></h1>
      </div>
      <div class="container">
         <%
            for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject  = jsonArray.getJSONObject(i);
            String tweet_id = jsonObject.get("tweet_id").toString();
            String content = jsonObject.get("tweet_content").toString();
            String image = jsonObject.get("tweet_image").toString();
               %>
         <div class="border-top border-3"></div>
         <div class="row">
            <div class="col-md-7">
               <%=content%>
            </div>
            <div class="col-md-3">
               <img src=<%=image%> alt="Tweet Image" class="tweetIMG">
            </div>
            <div class="col-md-2">
               <a href="/Client/tweetDetails.jsp?tweet_id=<%= tweet_id %>">
               <button class="btn btn-primary">View Details</button>
               </a>
            </div>
         </div>
         <%
            }
            %>
      </div>
      <%!static final String REST_URI = "http://localhost:9987/webservice2";
         static final String LIST_URI = "Author/authorid";
         
         //Get json and save it in array
         
         private JSONArray getAuthor(String json){
         	try{
         		JSONArray jsonArray = new JSONArray(json);
         		return jsonArray;
         		}
         	catch(JSONException e){return null;}
         	}
         
         private String getOutputAsJson(WebResource service) {
             return service.accept(MediaType.APPLICATION_JSON).get(String.class);
         }
         
         // Call the value transferred from the previous page for database query
         
         private String getjson(String authorid) throws MalformedURLException {
                ClientConfig config = new DefaultClientConfig();
                Client client = Client.create(config);
                WebResource service = client.resource(REST_URI);
                WebResource AuthorList = service.path(LIST_URI).path(authorid);
                String jsontext = getOutputAsJson(AuthorList);
                return jsontext;
           	}              
         %>
   </body>
   <style type="text/css">
      body{
      background-color: #FFFFFF;
      width: 63%;
      margin: auto;
      }
      .head {
      text-align: center;
      }
      h1{
      font-size: 40px;
      margin-top: 1%;
      }
      .avatar{
      height: 240px;
      margin-top: 2%;
      }
      .container{
      margin-top: 3%;
      font-size: 25px;
      font-family: Arial, Helvetica, serif;
      }
      .tweetIMG{
      height: 200px;
      }
      div{
      padding-bottom: 1%;
      }
      .btnSubmit{
      margin-top: 2%;
      margin-bottom: 5%;
      text-align: center;
      }
   </style>
</html>