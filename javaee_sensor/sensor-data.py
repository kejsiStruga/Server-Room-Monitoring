
#!/usr/bin/python

import paho.mqtt.client as mqtt
import ssl
import json,time
import sys
import Adafruit_DHT

sensor_args = { '11': Adafruit_DHT.DHT11,
 
                '22': Adafruit_DHT.DHT22,

                '2302': Adafruit_DHT.AM2302 }


sensor = sensor_args['2302']

pin = 4
#date=time.strftime("%m/%d/%y")

#called while client tries to establish connection with the server
def on_connect(mqttc, obj, flags, rc):
    if rc==0:
        print ("Subscriber Connection status code: "+str(rc)+" | Connection status: successful")
    elif rc==1:
        print ("Subscriber Connection status code: "+str(rc)+" | Connection status: Connection refused")

#called when a topic is successfully subscribed to


def on_subscribe(mqttc, obj, mid, granted_qos):
    print("Subscribed: "+str(mid)+" "+str(granted_qos)+"data"+str(obj))

#called when a message is received by a topic
def on_message(mqttc, obj, msg):
    print("Received message from topic: "+msg.topic+" | QoS: "+str(msg.qos)+" | Data Received: "+str(msg.payload))

#creating a client with client-id=raspberry-pi
mqttc = mqtt.Client(client_id="raspberry-pi")

mqttc.on_connect = on_connect
mqttc.on_subscribe = on_subscribe
mqttc.on_message = on_message

#Configure network encryption and authentication options. Enables SSL/TLS support.
#adding client-side certificates and enabling tlsv1.2 support as required by aws-iot service
mqttc.tls_set("/home/pi/Desktop/amazon_certs/root-ca.crt",
                certfile="/home/pi/Desktop/amazon_certs/d0d2de1176-certificate.pem.crt",
                keyfile="/home/pi/Desktop/amazon_certs/d0d2de1176-private.pem.key",
                tls_version=ssl.PROTOCOL_TLSv1_2,
                ciphers=None)


#connecting to aws-account-specific-iot-endpoint
mqttc.connect("a2yye602yte99c.iot.us-west-2.amazonaws.com", port=8883) #AWS IoT service hostname and portno

while True:

	humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
	state="Normal"

	if temperature < 0 or temperature > 50 or humidity < 20 or humidity > 90:
		state="Sensori nuk punon sakte"
	elif temperature >= 20 and temperature <= 25 :
        	if humidity >= 45 and humidity <= 55 :
            		state="Normal"
		else:
			if humidity:
				state="TEMP normale,RH shume e ulet"
			elif humidity>55:
				state="TEMP normale,RH shume e larte"
	elif temperature >= 0 and temperature <=20:
		if humidity >= 45 and humidity <=55:
			state="TEMP shumë e ulët, RH gjendje normale"
		elif humidity<45:
			state="TEMP shumë e ulët, RH shumë e ulët"
		elif humidity>55:
			state="TEMP shumë e ulët, RH shumë e lartë"
	elif temperature >= 25 and temperature<=50:
		if humidity >= 45 and humidity <= 55:
			state="TEMP shumë e lartë, RH gjendje normale"
		elif humidity <45:
			state="TEMP shumë e lartë, RH shumë e ulët"
		elif humidity > 55:
			state="TEMP shumë e lartë, RH shumë e larte"	 
	payload = json.dumps({

			"humidity" : humidity,
			"temperature" : temperature,
			"state" : state 
	})
	mqttc.publish("topic/sensordata",payload)
	#The topic to publish to
	print 'Temp: {0:0.1f} C  Humidity: {1:0.1f} %'.format(temperature, humidity)
	time.sleep(20)		

#To reconnect automcatically !
mqttc.loop_forever()
