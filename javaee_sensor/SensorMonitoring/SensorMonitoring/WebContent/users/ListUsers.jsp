<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>  
     <%@ page import="com.administration.model.User" %>
     <%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%  
		// retrieve your list from the request, with casting 
		List<User> list =(List<User>) request.getAttribute("users");
    %>
    <table border=1>
        <thead>
            <tr>
                <th>User Id</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th colspan=2>Action</th>
            </tr>
        </thead>
        <tbody>
        <%   	
        if(list != null) {
    	// print the information about every category of the list
    				for(User user : list) {
    					out.print("<tr>");
    					int id = user.getId();
    				    out.print("<td>"+id+"</td>");
    				    out.print("<td>"+user.getFname()+"</td>");
    				    out.print("<td>"+user.getLname()+"</td>");
    				    out.print("<td>"+user.getEmail()+"</td>");
    				    out.print("<td><a href=\"UserController?action=edit&id="+id+"\"/>Update</a></td>");
    				    out.print(" <td><a href=\"UserController?action=delete&id="+id+"\"/>Delete</a></td>");                  
    				}
        }
		
	   %>      
        </tbody>
    </table>
    <p><a href="/Copy/UserController?action=insert">Add User</a></p>
</body>
</html>