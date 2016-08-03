#import <StoreKit/StoreKit.h>
@interface XAPSKPaymentTransactionObserver:NSObject<SKPaymentTransactionObserver>
+(instancetype)sharedInstance;
@end