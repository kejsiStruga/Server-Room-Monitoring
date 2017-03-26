<%
	request.setAttribute("authenticated", null);	
    request.getSession().invalidate();
 	HttpServletResponse httpResponse = (HttpServletResponse) response;
	httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	httpResponse.setHeader("Pragma", "no-cache"); 
	httpResponse.setDateHeader("Expires", 0);  
	response.sendRedirect(request.getContextPath());
%>