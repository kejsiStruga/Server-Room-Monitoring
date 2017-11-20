<%@ include file="/includes/header.html" %>
<link href="css/login.css" rel="stylesheet" type="text/css">
<title>Server Room Login</title>
</head>
<body>
<%
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	if(session.getAttribute("authenticated")!=null) {
		response.sendRedirect("/SensorMonitoring/Dashboard.jsp");
	}
	else {
		if(request.getParameter("status")!=null){
			%>
				<script>
					$(document).ready(function(){
						   sweetAlert("Login Failed!", "Please try again !", "error");
					}); 
				</script>
			<%
		} 	
%>
<div class="logo"></div>
<div class="login-block">
    <h1>Login</h1>
    <form action="loginRequestHandler.jsp" method ="post">
	    <input type="text" required placeholder="Email" name="email" id="email" />
	    <input type="password" required placeholder="Password" name="password" id="password" />
	  <button type="submit" id="button-login" class="btn btn-danger btn-default pull-left" >Log In</button>
    </form>
</div>
</body>
<% 
} 
%>
</html>
