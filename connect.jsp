<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
  <title>Random Friend</title>
</head>
<body>
  		            <jsp:include page="header.html" />
  		            <jsp:include page="intro.html" />
 <span style='font-family:arial'> 		            
 Use the Facebook Login Button to Connect to Random Friend
 </span>
 <br/>
 
     <fb:login-button ></fb:login-button>
      <jsp:include page="footer.html" />
  
  <script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php"
    type="text/javascript">
  </script>

  <script type="text/javascript">
   FB_RequireFeatures(["XFBML"], function()
    {
       FB.Facebook.init("8597758a2109f728b181d4a5083455b5", "xd_receiver.htm", {"ifUserConnected":"showfriend.jsp"});
    });
  </script>
</body>
</html>
