<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.*"%>
<%@ page import="org.apache.http.HttpEntity"%>
<%@ page import="org.apache.http.HttpResponse"%>
<%@ page import="org.apache.http.NameValuePair"%>
<%@ page import="org.apache.http.client.HttpClient"%>
<%@ page import="org.apache.http.client.config.CookieSpecs"%>
<%@ page import="org.apache.http.client.config.RequestConfig"%>
<%@ page import="org.apache.http.client.methods.HttpGet"%>
<%@ page import="org.apache.http.client.utils.URIBuilder"%>
<%@ page import="org.apache.http.impl.client.HttpClients"%>
<%@ page import="org.apache.http.message.BasicNameValuePair"%>
<%@ page import="org.apache.http.util.EntityUtils"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.URISyntaxException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.alibaba.fastjson.JSONArray"%>
<%@ page import="com.alibaba.fastjson.JSONObject"%>
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
      	 // Access token of twitter API
         String access_token = "AAAAAAAAAAAAAAAAAAAAADlHVwEAAAAAQfogiSLPB%2BMnRWEvQ8QMstm2bRY%3D2fLmSwBDQfaP3MBBGUNu6auSgXYlvJixAV2KfVnl5eLdPlZz4J";
         
         // Gets the parameter passed by the GET method
         String tweet_id = request.getParameter("tweet_id");
		 
         // Uses api to get the detailed information of selected tweet
         String str_result = getTweets(tweet_id, access_token);
         str_result = str_result.replace("[", "");
         str_result = str_result.replace("]", "");
         
         // Converts obtained information from string to json format
         JSONObject jsonObject = JSONObject.parseObject(str_result);
         JSONObject data = jsonObject.getJSONObject("data");
         
         // Gets the time when the tweet was created and process the format as "yyyy-mm-dd HH:MM:SS"
         String created_at = data.getString("created_at");
         String[] created_arr1 = created_at.split("T");
         String date = created_arr1[0];
         String[] created_arr2 = created_arr1[1].split("\\.");
         String time = created_arr2[0];
         String datetime = date + " " + time;
         
         // Gets ID and text of the selected tweet
         String id = data.getString("id");
         String text = data.getString("text");
         
         // Gets the number of retweets, replies, likes and quotes of selected tweet
         JSONObject public_metrics = data.getJSONObject("public_metrics");
         String retweet_count = public_metrics.getString("retweet_count");
         String reply_count = public_metrics.getString("reply_count");
         String like_count = public_metrics.getString("like_count");
         String quote_count = public_metrics.getString("quote_count");
            %>
      <div class="container">
      <h1>Tweet Details</h1>
         <table class="table">
            <tbody>
               <tr>
                  <th scope="row">
                     ID:
                  </th>
                  <td>
                     <%=id%>
                  </td>
               </tr>
               <tr>
                  <th scope="row">
                     Text:
                  </th>
                  <td>
                     <%=text%>
                  </td>
               </tr>
               <tr>
                  <th scope="row">
                     Created at:
                  </th>
                  <td>
                     <%=datetime%>
                  </td>
               </tr>
               <tr>
                  <th scope="row">
                     Retweets:
                  </th>
                  <td>
                     <%=retweet_count%>
                  </td>
               </tr>
               <tr>
                  <th scope="row">
                     Replies:
                  </th>
                  <td>
                     <%=reply_count%>
                  </td>
               </tr>
               <tr>
                  <th scope="row">
                     Likes:
                  </th>
                  <td>
                     <%=like_count%>
                  </td>
               </tr>
               <tr>
                  <th scope="row">
                     Quotes:
                  </th>
                  <td>
                     <%=quote_count%>
                  </td>
               </tr>
            </tbody>
         </table>
      </div>
      <%!
         private static String getTweets(String ids, String bearerToken) throws IOException, URISyntaxException {
           String tweetResponse = null;
         
           HttpClient httpClient = HttpClients.custom()
               .setDefaultRequestConfig(RequestConfig.custom()
                   .setCookieSpec(CookieSpecs.STANDARD).build())
               .build();
           
           // Uses twitter api v2
           URIBuilder uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets");
           
           // Gets detailed information of selected tweet
           ArrayList<NameValuePair> queryParameters;
           queryParameters = new ArrayList<>();
           queryParameters.add(new BasicNameValuePair("ids", ids));
           queryParameters.add(new BasicNameValuePair("tweet.fields", "public_metrics,created_at,text,id"));
           uriBuilder.addParameters(queryParameters);
         
           HttpGet httpGet = new HttpGet(uriBuilder.build());
           httpGet.setHeader("Authorization", String.format("Bearer %s", bearerToken));
           httpGet.setHeader("Content-Type", "application/json");
         
           HttpResponse response = httpClient.execute(httpGet);
           HttpEntity entity = response.getEntity();
           if (null != entity) {
             tweetResponse = EntityUtils.toString(entity, "UTF-8");
           }
           return tweetResponse;
         }
            %>
   </body>
   <style type="text/css">
      body{
      background-color: #FFFFFF;
      width: 50%;
      margin: auto;
      }
      h1{
      	margin-bottom: 5%;
      	font-size: 40px;
      }
      th{
      width: 20%;
      }
      .container{
      margin-top: 10%;
      font-size: 25px;
      font-family: Arial, Helvetica, serif;
      }
      div{
      padding-bottom: 1%;
      }
   </style>
</html>