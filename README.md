# Server-Room-Monitoring
System that shows in real time sensor data retrieved from RaspberryPI in a Web Application build with J2EE technology.

## This System is made up of 3 technologies:

  	1. RasperryPI and Sensor DHT22 (HARDWARE COMPONENTS)
 
	2. AWS Services 
  
        i. SNS
        
        ii. IoT
        
        iii. DynamoDB
  
	3. J2EE Web App -> Java Web Application that uses the AWS SDK to show data in 2 graphs, one for each parameter of sensor

## Work-Flow of the monitoring system is described below:


  	1. **RaspberryPI 3 Model B** receives data from *DHT22* which is a digital temperature and humidity sensor using the AdaFruit Library
  
	2. This data is sent on real time via the MQTT protocol using SSL/TLS to AWS, in particular to the **AWS IoT service**, that
	acts as a Broker, in which case the Raspberry will be considered the publisher
  
	3. While data is published on IoT the system filters the temperature and humidity , if some alarming values of each these parameteres
	is found, then an e-mail will be sent to all specified end-points configured on **AWS SNS service**.
  
  	4. Afterwards using the AWS Rules Engine each sensor data is stored in **DynamoDB** NoSQL database in JSON format.
  
	5. Meanwhile the web application uses asynchronuous javascript to query the 10 last values stored in the DynamoDB database using the
	SDK available for Javascript, therefore both graphs are shown on real-time. 
	
	

*The project folder has all the components of the software including here: programm to retrieve sensor data in Raspberry 
which is a Python script where the Adafruit library is used, also the Java Project that shows the graphs to authenticated users (role-based app)*
	
