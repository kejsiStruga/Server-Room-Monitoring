<%@page import="com.validate.LoginDAO"%>
<%@page import="com.administration.model.*" %>
<jsp:useBean id="loginBean" class="com.validate.LoginBean" scope="session"/>
<jsp:setProperty name="loginBean" property="*"/>
<%
	String result=LoginDAO.loginCheck(loginBean);	 
	if(result.equals("true")){
		
		User user = new User();
		user.email = loginBean.getEmail();
	    session.setAttribute("email",loginBean.getEmail());
	    session.setAttribute("authenticated", "true");
	    user.setEmail(loginBean.getEmail());
	    session.setAttribute("user",user);
	    response.sendRedirect("/SensorMonitoring/Dashboard.jsp");
	}
	if(result.equals("false")){
	    response.sendRedirect("/SensorMonitoring/?status=false");
	}
	if(result.equals("error")){
	    response.sendRedirect("/SensorMonitoring/?status=error");
	}
%>