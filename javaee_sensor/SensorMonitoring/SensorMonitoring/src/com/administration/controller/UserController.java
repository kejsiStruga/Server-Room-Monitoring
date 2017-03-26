package com.administration.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.administration.model.*;
import com.administration.connection.*;

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String INSERT_OR_EDIT = "/users/User.jsp";
	private static String LIST_USER = "/users/ListUsers.jsp";
	private Crud crudUser;
	private Connection connection;
	
	public UserController() {
	        crudUser = new Crud();
			connection = ConnectDb.getConnection();
	    }

	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String forward = "";
		String action = request.getParameter("action");
		if(action.equalsIgnoreCase("delete")) {
			int id = Integer.parseInt(request.getParameter("id"));
			crudUser.deleteUser(id);
            forward = LIST_USER;
            request.setAttribute("users", crudUser.getUsers());   
		}else if (action.equalsIgnoreCase("edit")){
            forward = INSERT_OR_EDIT;
            int id = Integer.parseInt(request.getParameter("id"));
            User user = crudUser.getUserById(id);
            request.setAttribute("user", user);
        } else if (action.equalsIgnoreCase("listUsers")){
            forward = LIST_USER;
            request.setAttribute("users", crudUser.getUsers());
        } else {
            forward = INSERT_OR_EDIT;
        }	
		RequestDispatcher view = request.getRequestDispatcher(forward);
	    view.forward(request, response);			
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String id_s = request.getParameter("id").replaceAll("\\s","");
			int id = Integer.parseInt(id_s);
			PreparedStatement preparedStatement;
			try {
				preparedStatement = connection
						.prepareStatement("update users set fname = ? , lname = ? , email = ?, password = ? where id = ?");

				preparedStatement.setString(1, request.getParameter("fname"));
				preparedStatement.setString(2, request.getParameter("lname"));
				preparedStatement.setString(3, request.getParameter("email"));
				preparedStatement.setString(4, PasswordHash.SHA1(request.getParameter("password")));
				preparedStatement.setInt(5, id);
	            preparedStatement.executeUpdate();
			} catch (SQLException | NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
     
}	
