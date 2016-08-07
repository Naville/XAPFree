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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8000",@"localhost"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"CREATE TABLE IF NOT EXISTS Receipts (BundleID TEXT,Receipt TEXT,Info TEXT)" forHTTPHeaderField:@"SQL-Command"];
    [request setValue:bundleID forHTTPHeaderField:@"BundleID"];
    NSData* ReplyData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSArray* RetVal=[NSJSONSerialization JSONObjectWithData:ReplyData options:0 error:nil];
    
    
    [request release];
    [url release];
    return RetVal;
    return nil;
}
-(void)SaveReceiptForBundleID:(NSString*)bundleID withInfoArray:(NSArray*)InfoArray{
	for (NSDictionary* Item in InfoArray){
    	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8000",@"localhost"]];
    	NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    	[request setHTTPMethod:@"POST"];
    	[request setValue:@"CREATE TABLE IF NOT EXISTS Receipts (BundleID TEXT,Receipt TEXT,Info TEXT)" forHTTPHeaderField:@"SQL-Command"];
        [request setValue:bundleID forHTTPHeaderField:@"BundleID"];
        [request setValue:[(NSData*)[Item objectForKey:@"transactionReceipt"] base64EncodedStringWithOptions:0] forHTTPHeaderField:@"Receipt"];
        
        NSMutableDictionary* InfoDict=[NSMutableDictionary dictionaryWithDictionary:Item];
        [InfoDict removeObjectForKey:@"transactionReceipt"];
        NSString* JSON=[[NSJSONSerialization dataWithJSONObject:InfoDict options:NSJSONWritingPrettyPrinted error:nil] base64EncodedStringWithOptions:0];
        [request setValue:JSON forHTTPHeaderField:@"Info"];
    	[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    	[request release];
        [JSON release];
        [InfoDict release];
    	[url release];
    }
    [InfoArray release];
}
@end