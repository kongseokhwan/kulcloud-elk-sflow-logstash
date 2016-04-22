#!/usr/bin/python
### udp_client.py
### to run the example: 
### and the output will show 
### each time the server spawn a different thread
### to handle client request.

#!/usr/bin/python
import socket
import sys
import time
import json, requests
import pdb

HOST, PORT = "10.1.100.21", 5000
url = 'http://127.0.0.1:8181/1.0/flowtable/all/flow'
data = {"results" : [{"id": "a1", "name": "hello"}, {"id": "a2", "name": "logstash"}]}

# Create a socket (SOCK_STREAM means a TCP socket)
#sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

try:
    while True:
	sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    	sock.connect((HOST, PORT))	
	resp_json = json.loads(requests.get(url=url).text)
	for flow in resp_json['flows'] :
		del flow['instructions']
		sock.sendall(json.dumps(flow))
	sock.close()
    	#sock.sendall(json.dumps(data))

    	# Receive data from the server and shut down
    	#received = sock.recv(1024)

	#print "Received: %s" % received
        
	time.sleep(10)

except KeyboardInterrupt:
    print 'interrupted!'
    sock.close()

