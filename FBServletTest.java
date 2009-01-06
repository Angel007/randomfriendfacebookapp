import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.*; 
import java.io.PrintWriter;
import com.google.code.facebookapi.FacebookException;
import com.google.code.facebookapi.FacebookJsonRestClient;
import com.google.code.facebookapi.FacebookParam;
import org.json.JSONArray;
import org.json.JSONException;
import java.net.*;


public class FBServletTest extends HttpServlet {

	String appapikey = new String("c5065....................5963");
	String appsecret = new String("b1842....................2918b1");
	String defaultLoginPage = "http://www.facebook.com/login.php?api_key="+ "c5065....................5963" + "&v=1.0";
	FacebookJsonRestClient facebook;
	PrintWriter servletOutput;
	String myAppPage = "http://apps.facebook.com/hellojavaworld/";
	int safety = 0;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		Long userLong = new Long("-1");
		String user = null;

		servletOutput = res.getWriter(); // response is sent to ServletOutput
		res.setContentType("text/html");
		servletOutput.println("Hello this is the POST Method");

		String sessionKey = req.getParameter(FacebookParam.SESSION_KEY.toString());
		if (sessionKey == null) { // not logged in
			servletOutput.println("redirect page is " + defaultLoginPage);
			servletOutput.println("<fb:redirect url=" + defaultLoginPage + "/>"); // Facebook Redirect to login page
		} else {
			user = req.getParameter("fb_sig_user"); // get user as a string
			servletOutput.println("User is " + user);
			userLong = new Long(user); // need user as a long for  API calls
			facebook = new FacebookJsonRestClient(appapikey, appsecret,	sessionKey); // create Facebook Json Rest Client
			servletOutput.println("Facebook Client created");
			servletOutput.println("Facebook " + facebook);
		}
	
		try {
			/*
			public boolean profile_setFBML(
					java.lang.Long userId,
                    java.lang.String profileFbml,
                    java.lang.String actionFbml,
                    java.lang.String mobileFbml,
                    java.lang.String profileMain)
         */

			
			JSONArray resultArray = (JSONArray) facebook.friends_get();
			servletOutput.println(resultArray);

			int len = resultArray.length();
			int rand = (int) (Math.random() * len);
			int oneFriend = resultArray.getInt(rand);
			servletOutput.println(len);

			String profileString = "The Random Friend APP is Fun";
            facebook.profile_setFBML(userLong, profileString, null, profileString,profileString);
			
			
			req.setAttribute("numFriends", len);
			req.setAttribute("randomFriend", oneFriend);
			req.setAttribute("user", user);
			req.getRequestDispatcher("/randomFriend.jsp").forward(req,res);
			
		} catch (FacebookException ex) {
			servletOutput.println(">Error: Couldn't talk to Facebook " + ex);

  
 		} 
		catch (JSONException ex) {
			servletOutput.println(">Error: JSON Exception " + ex);
		} 
		servletOutput.close();
	} // end doPost()
}
