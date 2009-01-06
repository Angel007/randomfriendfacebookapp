<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
  <title>Random Friend</title>
</head>
<body>
  
  <script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php"
    type="text/javascript">
  </script>

  <script type="text/javascript">
   FB_RequireFeatures(["XFBML"], function()
    {
       FB.Facebook.init("8597758a2109f728b181d4a5083455b5", "xd_receiver.htm", {"ifUserNotConnected":"connect.jsp"});
    });
  </script>



<script type="text/javascript">
function publish_story(friend) {
   var target = new Array();
   target[0] = friend;
   FB.Connect.showFeedDialog(53126803199, null, target, null, null, FB.RequireConnect.promptConnect);
}


function update_user_box() {

      FB.Facebook.get_sessionState().waitUntilReady(function()
      {
        FB.Facebook.apiClient.friends_get(null, function(friendlist, ex) 
        {

	numFriends= friendlist.length;
	randomNumber= Math.floor(numFriends*Math.random());
	randomFriend= friendlist[randomNumber];


 	var user_box = document.getElementById("user"); 
  			user_box.innerHTML = " <span style='font-family:arial'> " 
				//+ "<fb:profile-pic uid=loggedinuser  size='normal'></fb:profile-pic> <br>" 
				+ "<fb:name uid=loggedinuser useyou='false'></fb:name>" 
				//+ friendlist +"<br>"
				+ " you have <b>" +numFriends +"</b> friends! "
				+ "One of them is:<br> "


				//+ randomFriend +"<br>"

				+ "<fb:profile-pic uid='"+randomFriend+"' size='normal' linked='true'></fb:profile-pic><br>" 
				+ "<fb:name uid='"+randomFriend+"' useyou='false'></fb:name><br/>"
				+ "<A HREF='javascript:publish_story(randomFriend) ' >Publish on your Facebook Profile!</A> "
	
				+ "</span>"; 
				
				
				// because this is XFBML, we need to tell Facebook to re-process the document 
				FB.XFBML.Host.parseDomTree(); 




        });
      });
    



} 

  </script>

<br>
  		            <jsp:include page="header.html" />
<div id="user" ><br/>
</div>
  		            <jsp:include page="footer.html" />


<script type="text/javascript">
update_user_box()
</script>


</body>


</html>
