package com.validate;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.ItemCollection;
import com.amazonaws.services.dynamodbv2.document.QueryOutcome;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.document.spec.QuerySpec;
import com.google.gson.Gson;

public class DownloadFile extends HttpServlet {	
	
	private static final long serialVersionUID = 1L;
	private String append_date = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());
	static AmazonDynamoDBClient dynamoDBClient ;
    static DynamoDB dynamoDB;
    static String tableName = "serverRoomSensor";
    static final String COMMA_DELIMITER = ",";
    static final String NEW_LINE_SEPARATOR = "\n";
    static final String FILE_HEADER = "Date , Temperature , Humidity , State";	
    
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		doPost(request, response);
	}
	
	public void doPost (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
	    AWSCredentials credentials = new ProfileCredentialsProvider("default").getCredentials();      
        dynamoDBClient = new AmazonDynamoDBClient(credentials);
        Region usWest2 = Region.getRegion(Regions.US_WEST_2);
        dynamoDBClient.setRegion(usWest2);
        dynamoDB = new DynamoDB(dynamoDBClient);
		
		PrintWriter out = response.getWriter();
		response.setContentType("application/ms-excel"); // or you can use text/csv
		response.setHeader("Content-Disposition", "attachment;  filename=sensor-data-"+append_date+".csv"); 
		
		PrintWriter pw = new PrintWriter(new File("C:\\Users\\not-output.csv"));
        StringBuilder sb = new StringBuilder();

        Table table = dynamoDB.getTable(tableName);
        HashMap<String, String> nameMap = new HashMap<String, String>();
        nameMap.put("#key", "key");        
        HashMap<String, Object> valueMap = new HashMap<String, Object>();
        valueMap.put(":key", "sensordata");        
        QuerySpec spec=new QuerySpec();
        spec.withKeyConditionExpression("#key = :key");
        spec.withNameMap(nameMap);
        spec.withValueMap(valueMap);
        
        ItemCollection<QueryOutcome> items = table.query(spec);

        Iterator<Item> iterator = items.iterator();
        
        Item item = null;
        Gson gson = new Gson();
        
        out.print(FILE_HEADER.toString());
        out.print(NEW_LINE_SEPARATOR);

        while (iterator.hasNext()) {
        	
            item = iterator.next();
            String sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(new Date(Long.parseLong(item.getString("timestamp"))));
            out.print(" "+sdf);
            out.print(COMMA_DELIMITER);           
      
            //Convert the ordered map into an ordered string.
            String json = gson.toJson(item.get("payload"), LinkedHashMap.class);            
            JSONObject value;
			try {
				value = new JSONObject(json);
				 Iterator<?> keys = value.keys();
		            while(keys.hasNext() ) {
		                String key = (String)keys.next();
		               // System.out.println(value.get(key));
		                out.print(value.get(key));
		                out.print(COMMA_DELIMITER); 
		            }        
		            out.print("");
		            out.print(NEW_LINE_SEPARATOR);
		            
		            pw.write(sb.toString());
		            pw.flush();
		            pw.close();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}                           
        }         
        out.flush();
	}
	
	public static void getTemperatureAndHumidityCSV() 
			throws FileNotFoundException, JSONException {
    	
        Table table = dynamoDB.getTable(tableName);
        HashMap<String, String> nameMap = new HashMap<String, String>();
        nameMap.put("#key", "key");        
        HashMap<String, Object> valueMap = new HashMap<String, Object>();
        valueMap.put(":key", "sensordata");        
        QuerySpec spec=new QuerySpec();
        spec.withKeyConditionExpression("#key = :key");
        spec.withNameMap(nameMap);
        spec.withValueMap(valueMap);
        
        ItemCollection<QueryOutcome> items = table.query(spec);
   
        System.out.println("\nDynamoDB sensorData table results:");

        Iterator<Item> iterator = items.iterator();
        
        PrintWriter pw = new PrintWriter(new File("C:\\Users\\test.csv"));
        StringBuilder sb = new StringBuilder();
        Item item = null;
        Gson gson = new Gson();
        
        sb.append(FILE_HEADER.toString());
        sb.append(NEW_LINE_SEPARATOR);

        while (iterator.hasNext()) {
        	
            item = iterator.next();
            String sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(new Date(Long.parseLong(item.getString("timestamp"))));
            sb.append(" "+sdf);
            sb.append(COMMA_DELIMITER);           
      
            //Convert the ordered map into an ordered string.
            String json = gson.toJson(item.get("payload"), LinkedHashMap.class);            
            JSONObject value =new JSONObject(json);
            Iterator<?> keys = value.keys();
            while(keys.hasNext() ) {
                String key = (String)keys.next();
                System.out.println(value.get(key));
                sb.append(value.get(key));
                sb.append(COMMA_DELIMITER); 
            }                        
            sb.append("");
            sb.append(NEW_LINE_SEPARATOR);
        }  
        
        pw.write(sb.toString());
        pw.flush();
        pw.close();
    }   
}