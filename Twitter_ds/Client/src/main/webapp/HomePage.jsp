<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import="javax.ws.rs.core.MediaType"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig"%>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig"%>
<%@ page import="java.net.*"%>

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
          var chk=document.getElementsByName('chk'); 
          var result='';
      
          for(var i=0; i<chk.length; i++){ 
              if(chk[i].checked && result == ''){
              	result=chk[i].value;
              }
              else if(chk[i].checked){
              	result+='*'+chk[i].value;
              }
          } 
      
          // sets value to hidden input
      	  document.getElementById("hidden_id").value=result;
          
          console.log(result);
      } 
      
   </script>
   <body>
      <%-- guide for users --%>
      <div class="guide">
         <p>Please choose your interested tweet(s): </p>
      </div>
      <form action="AuthorInfo.jsp" method="GET">
         <div>
            <table class="table">
               <thead>
                  <tr>
                     <th scope="col">#</th>
                     <th scope="col">Tweet ID</th>
                     <th scope="col">Tweet Content</th>
                     <th scope="col">Included Image</th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <th scope="row">
                        <div>
                           <input onclick="connect()" type="checkbox" name=chk class="form-check-input mt-0" value="1460462992374394881">
                        </div>
                     </th>
                     <td>
                        <div>
                           1460462992374394881
                        </div>
                     </td>
                     <td>
                        <div>my expectation of what i'll wake up to tomorrow morning</div>
                     </td>
                     <td>
                        <div>
                           <img src="https://pbs.twimg.com/media/FESbWhIVkAA-YID?format=jpg&name=medium" alt="image">
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">
                        <div>
                           <input onclick="connect()" type="checkbox" name=chk class="form-check-input mt-0" value="1460255188128878593">
                        </div>
                     </th>
                     <td>
                        <div>
                           1460255188128878593
                        </div>
                     </td>
                     <td>
                        <div>Whose ready for the puppies?? We're getting very close!</div>
                     </td>
                     <td>
                        <div>
                           <img src="https://pbs.twimg.com/media/FEPeWqhWUAQGQOo?format=jpg&name=medium" alt="image">
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <th scope="row">
                        <div>
                           <input onclick="connect()" type="checkbox" name=chk class="form-check-input mt-0" value="1445761724884287501">
                        </div>
                     </th>
                     <td>
                        <div>
                           1445761724884287501
                        </div>
                     </td>
                     <td>
                        <div>Hotel Transylvania: Transformania will be releasing worldwide on @PrimeVideo January 14th!</div>
                     </td>
                     <td>
                        <div>
                           <img src="https://pbs.twimg.com/media/FBBgnkEVIBM2Wio?format=jpg&name=medium" alt="image">
                        </div>
                     </td>
                  </tr>
               </tbody>
            </table>
         </div>
         <div class="btnSubmit">
            <input type="submit" value="Submit" class="btn btn-primary">
         </div>
         <%-- uses GET method to send user's choice to the page to jump to --%>
         <input type="hidden" name="selected" id="hidden_id">
      </form>
   </body>
   <style type="text/css">
      body{
      	text-align: center;
      	background-color: #FFFFFF;
      	width: 50%;
      	margin: auto;
      }
      .guide{
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