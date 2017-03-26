package com.validate;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Calendar;
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

public class DownloadData extends HttpServlet {

	private static final long serialVersionUID = 1L;
    private static final String PRESJE = ",";
    private static final String NEW_LINE = "\n";
    private static final String FILE_HEADER = "Date , Temperature (C) , Humidity (%) , State";		
	private String append_date = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());	
	private AmazonDynamoDBClient dynamoDBClient ;
    private DynamoDB dynamoDB;
    private String tableName = "serverRoomSensor";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		doPost(request, response);		
	}
	
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
	    AWSCredentials credentials = new ProfileCredentialsProvider("default").getCredentials();      
        dynamoDBClient = new AmazonDynamoDBClient(credentials);
        Region usWest2 = Region.getRegion(Regions.US_WEST_2);
        dynamoDBClient.setRegion(usWest2);
        dynamoDB = new DynamoDB(dynamoDBClient);
		
        //get user equest for start day and end day
        String start_date = request.getParameter("date");
        String end_date = request.getParameter("end_date");
              
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date_start, date_end;
		Calendar start_cal = Calendar.getInstance();
		Calendar end_cal = start_cal;
		try {
			date_start = dateFormat.parse(start_date);
			date_end = dateFormat.parse(end_date); 
			end_cal =start_cal;
		    start_cal.setTime(date_start);
		    end_cal.setTime(date_end);			
		    
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String lower_bound = String.valueOf(new Date(start_cal.getTimeInMillis()).toString());
		String upper_bound = String.valueOf(new Date(end_cal.getTimeInMillis()).toString());
		
		PrintWriter out = response.getWriter();
		response.setContentType("application/ms-excel");
		response.setHeader("Content-Disposition", "attachement; filename=sensor-data-"+append_date+".csv");
	
		//RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Copy/Dashboard1.jsp");
		//dispatcher.forward(request, response);
		
		Table table = dynamoDB.getTable(tableName);
        HashMap<String, String> nameMap = new HashMap<String, String>();
        nameMap.put("#key", "key");        
        nameMap.put("#timestamp", "timestamp");        
        HashMap<String, Object> valueMap = new HashMap<String, Object>();
        valueMap.put(":key", "sensordata");        
        valueMap.put(":start_date", lower_bound);        
        valueMap.put(":end_date", upper_bound);        
        QuerySpec spec=new QuerySpec();
        spec.withKeyConditionExpression("#key = :key and #timestamp BETWEEN :start_date AND :end_date");
        spec.withNameMap(nameMap);
        spec.withValueMap(valueMap);
	
        ItemCollection<QueryOutcome> items = table.query(spec);
        Iterator<Item> iterator = items.iterator();
		
        Item item = null;
        Gson gson = new Gson();
        
        out.print(FILE_HEADER.toString());
        out.print(NEW_LINE);

        
		 while (iterator.hasNext()) {
		        	
            item = iterator.next();
            String sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(new Date(Long.parseLong(item.getString("timestamp"))));
	        out.print(" "+sdf);
	        out.print(PRESJE);           
		  
		    //Convert the ordered map into an ordered string.
			String json = gson.toJson(item.get("payload"), LinkedHashMap.class);            
			JSONObject value;
			try {
				value = new JSONObject(json);
				//value.remove("createdAt");
				 Iterator<?> keys = value.keys();
				  while(keys.hasNext() ) {
				         String key = (String)keys.next();			            	
				            out.print(value.get(key));
				            out.print(PRESJE);			            	
				        }        
				  out.print("");
				  out.print(NEW_LINE); 
			
			} catch (JSONException e) {
				// TODO Auto-generated catch block
					e.printStackTrace();
				}                           
		}        
        
		out.flush();	
	}
	
}