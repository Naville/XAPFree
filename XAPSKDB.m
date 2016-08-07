#import "XAPSKDB.h"
@implementation XAPSKDB
+(instancetype)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
-(NSArray*)LoadReceiptForBundleID:(NSString*)bundleID{
#pragma message ( "XAPSKDB LoadReceiptForBundleID: Unimplemented" )


#ifdef TARGET_OS_MAC

#elif defined TARGET_OS_IOS 

#endif	
return nil;//Undefined
}
-(void)SaveReceiptForBundleID:(NSString*)bundleID withInfoArray:(NSArray*)InfoArray{
	for (NSDictionary* Item in InfoArray){
    	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8000",@"192.168.0.108"]];
    	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    	[request setHTTPMethod:@"POST"];
    	[request setValue:@"CREATE TABLE IF NOT EXISTS Receipts (BundleID TEXT,RECEIPT TEXT,INFO TEXT)" forHTTPHeaderField:@"SQL-Command"];
    
    	[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    	[request setValue:[NSString stringWithFormat:@"INSERT INTO Receipts(BundleID,RECEIPT,INFO) VALUES(%@,%@,%@)",bundleID,[Item objectForKey:@"transactionReceipt"],Item] forHTTPHeaderField:@"SQL-Command"];
    	[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    	[request release];
    	[url release];
    }
    [InfoArray release];
}
@end