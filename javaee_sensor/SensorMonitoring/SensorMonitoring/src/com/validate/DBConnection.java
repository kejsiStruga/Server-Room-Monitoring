package com.validate;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {

	private static Connection connection;
	private final static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private final static String CONN_URL = "jdbc:mysql://localhost:3306/server_room";		
	private final static String PASS = "";
	private final static String USERNAME = "root";
	
	public static Connection getConnection() {
		if(connection != null) {
			return connection;
		} else {
			
			try {
				Class.forName(JDBC_DRIVER);
				connection = DriverManager.getConnection(CONN_URL,USERNAME,PASS);
				
			}catch(SQLException | ClassNotFoundException e){
				e.printStackTrace();
			}
			return connection;
		}
	}
		
}
