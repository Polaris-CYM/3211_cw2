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

<%@ page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TweetList</title>
</head>
<body>
<script>

</script>
	<div class="title">Tweet List</div>
	<div class="out-container">
	<%
	String Authorid = request.getParameter("selected");
	String json = getjson(Authorid);
	JSONArray jsonArray = getInfoOfChannels(json);
	%>
	</div>
	<div>
	<%
	for (int i = 0; i < jsonArray.length(); i++) {
		JSONObject jsonObject  = jsonArray.getJSONObject(i);
		String name = jsonObject.get("author_name").toString();
		String title = jsonObject.get("tweet_title").toString();
		String image = jsonObject.get("tweet_image").toString();
		out.println(name);
		out.println(title);%>
		<img src=<%=image%>>
         <%}%>

	</div>
	
  	<%!
	  	static final String REST_URI = "http://localhost:9987/webservice2";
  		static final String LIST_URI = "Author/authorid";
	    
  		private String getjson(String authorid) throws MalformedURLException {
  	        ClientConfig config = new DefaultClientConfig();
  	        Client client = Client.create(config);
  	        WebResource service = client.resource(REST_URI);
  	        WebResource videoListService = service.path(LIST_URI).path(authorid);
  	        String jsontext = getOutputAsJson(videoListService);
  	        return jsontext;
      	}
  		
  		private String getOutputAsJson(WebResource service) {
  	        return service.accept(MediaType.APPLICATION_JSON).get(String.class);
  	    }
  		
	    private JSONArray getInfoOfChannels(String json){
	    	try{
	    		JSONArray jsonArray = new JSONArray(json);
	    		return jsonArray;
	    		}
	    	catch(JSONException e){return null;}
	    	}
    %>
    
</body>
</html>