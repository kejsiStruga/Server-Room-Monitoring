package com.administration.controller;

import java.sql.*;
import java.io.*;
import java.security.NoSuchAlgorithmException;

import com.administration.model.User;
import com.administration.connection.ConnectDb;

import java.util.ArrayList;
import java.util.List;

public class Crud {
	private Connection connection;
	
	public Crud() {
		connection = ConnectDb.getConnection();
	}
	
	public void addUser(User user) {
		try {
			
			PreparedStatement preparedStatement = connection
						.prepareStatement("insert into users(fname,lname,email,password) values (?, ?, ?, ? )");
			preparedStatement.setString(1, user.getFname());
			preparedStatement.setString(2, user.getLname());
			preparedStatement.setString(3, user.getFname());
			preparedStatement.setString(4, user.getEmail());
			preparedStatement.setString(5, PasswordHash.SHA1(user.getPassword()));
		} catch(SQLException e) {
			e.getSQLState();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deleteUser(int id) {
		try {
			
			PreparedStatement preparedStatement = connection
					.prepareStatement("DELETE FROM users where id = ?");
			preparedStatement.setInt(1, id);
			preparedStatement.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateUser(User user) {
		try {
			
			PreparedStatement preparedStatement = connection
					.prepareStatement("update users set fname = ? , lname = ? , email = ?, password = ? where id = ?");
			preparedStatement.setString(1, user.getFname());
			preparedStatement.setString(2, user.getLname());
			preparedStatement.setString(3, user.getEmail());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setInt(5, user.getId());
            preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<User> getUsers() {
		List<User> users = new ArrayList<User>();
		
		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("select * from users");
			while(rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setFname(rs.getString("fname"));
				user.setLname(rs.getString("lname"));
				user.setEmail(rs.getString("email"));
				users.add(user);
			}
			
		}catch(SQLException e) {
			e.getSQLState();
		}

		return users;		
	}

	public User getIdByEmail(String email) {
		User user = new User();
		
		try {
			PreparedStatement preparedStatement = ConnectDb.getConnection()
					.prepareStatement("select * from users where email = ?");
			preparedStatement.setString(1, email);			
			ResultSet rs = preparedStatement.executeQuery();			
			if(rs.next()) {
				user.setId(rs.getInt("id"));
				user.setFname(rs.getString("fname"));
				user.setLname(rs.getString("lname"));
				user.setEmail(rs.getString("email"));
				user.setPassword(PasswordHash.SHA1(rs.getString("password")));
			}
		}catch(SQLException | NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return user;
	}
	public User getUserById(int id) {
		User user = new User();
		
		try {		
			PreparedStatement preparedStatement = ConnectDb.getConnection()
					.prepareStatement("select * from users where id = ?");
			preparedStatement.setInt(1, id);			
			ResultSet rs = preparedStatement.executeQuery();			
			if(rs.next()) {
				user.setId(rs.getInt("id"));
				user.setFname(rs.getString("fname"));
				user.setLname(rs.getString("lname"));
				user.setEmail(rs.getString("email"));
				user.setPassword(PasswordHash.SHA1(rs.getString("password")));
			}
		}catch(SQLException | NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return user;
	}
	public static void main(String[] args) {
		Crud crudUser = new Crud();
				List<User> l = crudUser.getUsers();
				User u = crudUser.getUserById(24);
		System.out.println(u.getEmail());
	}
	
}


	










