//
//  XAPIPCHandler.h
//  XAPFreeDaemon
//
//  Created by Zhang Naville on 16/6/27.
//  Copyright © 2016年 NavilleZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <xpc/xpc.h>
#import <mach/mach.h>
#import <NotificationCenter/NotificationCenter.h>
#import <notify.h>
@interface XAPIPCHandler : NSObject
+(id)sharedInstance;
-(XAPIPCHandler*)init;
-(void)PostReceiptDataForBundleID:(NSNotification*)Notify;
@end
