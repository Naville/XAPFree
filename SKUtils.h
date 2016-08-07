#import <StoreKit/StoreKit.h>
@interface SKUtils:NSObject<SKRequestDelegate>
+(instancetype)sharedInstance;
-(void)RefreshReceipt;
@end