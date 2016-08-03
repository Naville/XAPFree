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
#ifdef DEBUG
	NSLog(@"[XAPSKDB SaveReceiptForBundleID:%@ withInfoArray:%@]",bundleID,InfoArray);
#endif
#pragma message ( "XAPSKDB SaveReceiptForBundleID: Unimplemented" )
#ifdef TARGET_OS_MAC

#elif defined TARGET_OS_IOS 

#endif	
	
}
@end