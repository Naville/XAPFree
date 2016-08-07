#!/usr/bin/python
import json
import base64
from sys import argv
import sys
import requests
import plistlib
def VerifyReceipt(Receipt):
	Request=dict()
	Request["receipt-data"]=base64.b64encode(Receipt)
	HTTPBody=json.dumps(Request)
	rEQ = requests.post('https://buy.itunes.apple.com/verifyReceipt', data=HTTPBody)
	if(int(rEQ.json()["status"])==0):
		return True
	else:
		return False