
package com.validate;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class validim_rregjistrimi extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String fname = request.getParameter("firstname");
		String lname = request.getParameter("lastname");
		String email = request.getParameter("email");
		try {
			String password = PasswordHash.SHA1(request.getParameter("password"));
			
			final String jdbc_driver = "com.mysql.jdbc.Driver";
			final String conn_url = "jdbc:mysql://localhost:3306/server_room";
			
			final String username = "root";
			final String sql = "Select * from users";
			final String pass = ""; 		
        try{
             
 	         //loading drivers for mysql
 	         Class.forName(jdbc_driver);
 		     //creating connection with the database 
 	         Connection con = DriverManager.getConnection(conn_url,username,pass);
 	       
 	         Statement st = con.createStatement();
 	         ResultSet rs = st.executeQuery("SELECT count(*) from users where email =  ' "+ email + "' "); 	        
  	         //String password1 = PasswordHash.SHA1("ghghg");
  	         
 	         if(rs.next()) {
 	        	// out.println("this user exists");
 	           //RequestDispatcher view = request.getRequestDispatcher("/regjistrimi.jsp");
 	           request.getSession().setAttribute("message", "User Already Exists");
 	           response.sendRedirect("/Copy/regjistrimi.jsp");
 	           //view.forward(request, response);
 	         }
 	         String sql1 = "INSERT INTO users (fname, lname, email, password)" +
 	    	        "VALUES (?, ?, ?, ?)";
 	         
 	         java.sql.PreparedStatement preparedStatement = con.prepareStatement(sql1);
	 	     preparedStatement.setString(1, fname);
	 	     preparedStatement.setString(2, lname);
	 	     preparedStatement.setString(3, email);
	 	     preparedStatement.setString(4, password);
	 	     
	 	     preparedStatement.executeUpdate();                
	         
	 	     response.setContentType("text/html;charset=UTF-8");
	         response.getWriter().write("True");
         }
         catch(Exception se) {
             se.getMessage();
         } 
		}catch (NoSuchAlgorithmException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
        
	}
}
