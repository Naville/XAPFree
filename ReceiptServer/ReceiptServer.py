#!/usr/bin/python
import SimpleHTTPServer
import SocketServer
import HTTPHandler

PORT = 8000

Handler = HTTPHandler.HTTPHandler

print "XAPFree ReceiptServer Loading"

httpd = SocketServer.TCPServer(("", PORT), Handler)
httpd.serve_forever()