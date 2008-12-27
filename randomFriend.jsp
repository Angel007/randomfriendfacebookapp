<%@ page language="java"
   contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
%>
<strong>Random Friend App</strong>
<br>



<br>
<b>You have ${numFriends} friends! </b>
<br>
One of them is: <br> 
  <fb:profile-pic uid="${randomFriend}"
                   size="small"
                   linked="true" /><br>
   <fb:name uid="${randomFriend}"
            useyou="false"
            linked="true"
            capitalize="true" />



<fb:if-is-app-user uid="loggedinuser">
<br>
<br>
   <fb:add-section-button section='profile' />
<fb:else>
  <p>You must authorize this application before adding it to your profile:</p>
  <form requirelogin=1>
    <input type=submit value='Click to authorize'/>
  </form>
</fb:else>
</fb:if-is-app-user>



 


