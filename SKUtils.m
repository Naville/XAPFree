#import "SKUtils.h"
@implementation SKUtils
+(instancetype)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
- (void)requestDidFinish:(SKRequest *)request{
	NSLog(@"SKUtils-requestDidFinish:%@",[(SKReceiptRefreshRequest*)request receiptProperties]);

}
-(void)RefreshReceipt{
	SKReceiptRefreshRequest* SKRR=[[SKReceiptRefreshRequest alloc] initWithReceiptProperties:nil];
	SKRR.delegate=self;
	[SKRR start];

}
@end