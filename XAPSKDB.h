#import <Foundation/Foundation.h>
@interface XAPSKDB:NSObject
+(instancetype)sharedInstance;
-(NSArray*)LoadReceiptForBundleID:(NSString*)bundleID;
-(void)SaveReceiptForBundleID:(NSString*)bundleID withInfoArray:(NSArray*)InfoArray;
@end