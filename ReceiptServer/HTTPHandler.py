import sqlite3
import json
import ReceiptValidation
from SimpleHTTPServer import SimpleHTTPRequestHandler
class HTTPHandler(SimpleHTTPRequestHandler):
	Connection=None
	def __init__(self,req,client_addr,server):
		SimpleHTTPRequestHandler.__init__(self,req,client_addr,server)
	def do_POST(self):
		print "Received POST Request"
		SQL = self.headers.getheader('SQL-Command', 0)
		BundleID=self.headers.getheader('BundleID', 0)
		Receipt=self.headers.getheader('Receipt', 0)
		if(ReceiptValidation.VerifyReceipt(Receipt)==False):
			print "Receipt Not Valid. Ignored"
			return;

		Info=self.headers.getheader('Info', 0)
		if(self.Connection==None):
			self.Connection=sqlite3.connect("XAPFree.db")
		self.Connection.cursor().execute(str(SQL))
		DeleteSQL="DELETE FROM Receipts WHERE BundleID=\"{0}\" AND Receipt=\"{1}\"".format(BundleID,Receipt)
		self.Connection.cursor().execute(str(DeleteSQL))
		InsertSQL="INSERT INTO Receipts(BundleID,Receipt,Info) VALUES(\"{0}\",\"{1}\",\"{2}\")".format(BundleID,Receipt,Info)
		self.Connection.cursor().execute(str(InsertSQL))
		self.Connection.commit()
	def do_GET(self):
		print "Received GET Request"
		bundleID=self.headers.getheader('BundleID', 0)
 		if(self.Connection==None):
			self.Connection=sqlite3.connect("XAPFree.db")
		ResultList=list()
		SQL = self.headers.getheader('SQL-Command', 0)
		self.Connection.cursor().execute(str(SQL))

		SQLQuery='SELECT * from Receipts WHERE BundleID=\"'+bundleID+"\""
		for item in self.Connection.cursor().execute(str(SQLQuery)):
			TempDict=dict()
			TempDict["Receipt"]=item[1]
			TempDict["Info"]=item[2]
			ResultList.append(TempDict)
		self.send_response(200)
		self.send_header("Content-type", "text/html")
		self.end_headers()
		self.wfile.write(json.dumps(ResultList))
		   	