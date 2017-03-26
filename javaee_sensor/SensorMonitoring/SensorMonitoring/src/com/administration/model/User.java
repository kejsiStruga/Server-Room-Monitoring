package com.administration.model;

public class User {
	public int id;
	public String fname;
	public String lname;
	public String email;
	public String password;
	public boolean admin;
	
	public int getId(){
		return id;
	}
	
	public void setId(int userId) {
		id = userId;
	}
	
	public String getFname() {
		return fname;
	}
	
	public void setFname(String firstName) {
		fname = firstName;
	}
	
	public String getLname() {
		return lname;
	}
	
	public void setLname(String lastName) {
		lname = lastName;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String userEmail) {
		email =  userEmail;
	}
	
	public void setPassword(String pass) {
		password = pass;
	}
	public String getPassword() {
		return password;
	}
	
	public boolean isAdmin() {
		return admin;
	}
	
	public void setAdmin(boolean adminRole) {
		admin = adminRole;
	}
	
}
