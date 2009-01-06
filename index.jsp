<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <jsp:directive.page import="java.io.IOException"/>
 <jsp:directive.page import="org.json.JSONException"/>
 <jsp:directive.page import="org.json.JSONObject"/>
 <jsp:directive.page import="org.json.JSONArray"/>
 <jsp:directive.page import="com.google.code.facebookapi.FacebookException"/>
 <jsp:directive.page import="com.google.code.facebookapi.FacebookJsonRestClient"/>
 <jsp:directive.page import="com.google.code.facebookapi.FacebookParam"/>
  <%
		//Application API Key and application secret from creating app in FB
		String appapikey = new String("8597758a2109f728b181d4a5083455b5");
		String appsecret = new String("86e--------------------------03b");
	
		FacebookJsonRestClient facebook;  // the facebook client, talks to REST Server
		// do authentication  
		String user =null;
		String sessionKey = request.getParameter(FacebookParam.SESSION_KEY.toString());  // Session Key passed as request parameter
		String profileKey = request.getParameter("fb_sig_profile_session_key");  // profile key passed when in tab

		//http://wiki.developers.facebook.com/index.php/New_Design_Tabbed_Profile
		//http://wiki.developers.facebook.com/index.php/Authorizing_Applications#Parameters_Passed_to_Your_Application
		//fb_sig_profile_user parameter. A session key is sent with the fb_sig_profile_session_key 
		//fb_sig_in_canvas: This parameter is true if the request is for your application's canvas page.
		//fb_sig_in_profile_tab: This parameter is sent if this request is for a user's tab for your application.
		//fb_sig_profile_user: The UID of the profile owner for the tab being requested.
		//fb_sig_profile_session_key: The session key for the profile owner, which you use to render this user's profile tab content

		
		if ((sessionKey==null)&& (profileKey==null)){ // If there is not session key, they user not logged in or this is in the profile tab
			%>
			          <jsp:include page="header.html" />
					  <jsp:include page="intro.html" />
					  <p><b>Please authorize the application.  Then you can add it to your profile:</b></p>
					  <form requirelogin=1>
					    <input type=submit value='Click to authorize'/>
					  </form>
					  <jsp:include page="footer.html" />
			<%
			}
			else{  // user is logged on
				try{
					// Get user id as parameter 
					if (sessionKey!=null){
						facebook = new FacebookJsonRestClient(appapikey, appsecret,sessionKey);  // create Facebook Json Rest Client
						user = request.getParameter("fb_sig_user");  // get user as a string.  User info passed as request parameter
					}else{
						facebook = new FacebookJsonRestClient(appapikey, appsecret,profileKey);  // create Facebook Json Rest Client
						user = request.getParameter("fb_sig_profile_user");  // get user as a string.  User info passed as request parameter
					}
					
					
					Long userLong = new Long(user); // need user as a long for  API calls
					
					JSONArray resultArray = (JSONArray) facebook.friends_get();

					int numFriends = resultArray.length();
					int rand = (int) (Math.random() * numFriends);
					int randomFriend = resultArray.getInt(rand);
					%>

				
<%
					String profileString = "You have <b>" + numFriends +" </b>friends!<br>";
					profileString += "One of them is: <br>";
					profileString += "<fb:profile-pic uid=\"" + randomFriend + "\" size=\"small\" linked=\"true\" /><br>";
					profileString += "<fb:name uid=\"" + randomFriend + "\" useyou=\"false\" linked=\"true\" capitalize=\"true\"/><br><br>";
					profileString += "<b><A href=\"http://apps.facebook.com/randomfriendapp/\"  > Try Random Friend</A></b>";
					
					
				    facebook.profile_setFBML(userLong, profileString, null, profileString,profileString);
					
%>
  		            <jsp:include page="header.html" />
					<b>You have <%=numFriends%> friends! </b>
					<br>
					One of them is: <br> 
					  <fb:profile-pic uid="<%=randomFriend%>"
					                   size="normal"
					                   linked="true" /><br>
					   <fb:name uid="<%=randomFriend%>"
					            useyou="false"
					            linked="true"
					            capitalize="true" />
<% 
					if (sessionKey!=null){
%>				            
					            
					<fb:if-is-app-user uid="loggedinuser">
					<br>
					<br>
					   <fb:add-section-button section='profile' />
					</fb:if-is-app-user>					
					<%
					}
%>
					<jsp:include page="footer.html" />
					<%
				} catch (FacebookException ex) {
					%>
					Error: Couldn't talk to Facebook <%=ex%>
					<%
		 		} 
				catch (JSONException ex) {
					 %>
					Error: JSON Exception <%=ex%>
					<%} %> 
					
							<%
				
			} //else user is logged in
	
   %>
 
	
 


