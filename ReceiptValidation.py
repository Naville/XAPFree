#!/usr/bin/python
import json
import base64
from sys import argv
import sys
import requests
import plistlib
if len(argv)!=2:
	print "ReceiptValidation.py /PATH/TO/RECEIPT"
	sys.exit(0)
print "Loading Receipt From :",argv[1]
Receipt=open(argv[1],"r").read()
Request=dict()
Request["receipt-data"]=base64.b64encode(Receipt)
HTTPBody=json.dumps(Request)
rEQ = requests.post('https://buy.itunes.apple.com/verifyReceipt', data=HTTPBody)
plistlib.writePlist(rEQ.json(), "/Users/Naville/Desktop/AppStoreReceiptVerifyReply.plist")
