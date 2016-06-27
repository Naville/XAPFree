//
//  XAPIPCHandler.m
//  XAPFreeDaemon
//
//  Created by Zhang Naville on 16/6/27.
//  Copyright © 2016年 NavilleZhang. All rights reserved.
//

#import "XAPIPCHandler.h"
#define ReceiptFolderPath [NSString stringWithFormat:@"%@/Documents/XAPFree/",NSHomeDirectory()]
#define DefaultReceiptFolderPath [NSString stringWithFormat:@"%@/Documents/XAPFree/DefaultReceipt",NSHomeDirectory()]
#define SavedReceiptPath [NSString stringWithFormat:@"%@/Desktop/",NSHomeDirectory()]


#define NotifyNamePrefix @"com.naville.XAPFree"
#define NotifyRequestReceiptData @"com.naville.XAPFree.RequestReceipt"


static NSData* GetReceipt(NSString* bundleID){
    if(![[NSFileManager defaultManager] fileExistsAtPath:ReceiptFolderPath]){
        //CreateDirectory
        NSError* Error;
        [[NSFileManager defaultManager] createDirectoryAtPath:ReceiptFolderPath withIntermediateDirectories:NO attributes:nil error:&Error];
        if(Error!=nil){
            NSLog(@"XAPFree---------CreatingDirectoryError:%@",Error.localizedDescription);
            
        }
        else{
            NSLog(@"XAPFree---------ReceiptFolderCreatedAt:%@",ReceiptFolderPath);
        }
        return nil;
    }
    else{
        NSLog(@"XAPFree---------ReceiptFolderExistsAt:%@",ReceiptFolderPath);
        
        
    }
    if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",ReceiptFolderPath,bundleID]]){
        NSLog(@"XAPFree---------TryingToLoadCustomReceipt");
        
        return [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",ReceiptFolderPath,bundleID]];
        
    }
    else{
        NSLog(@"XAPFree---------TryingToLoadDefaultReceipt");
        return [NSData dataWithContentsOfFile:DefaultReceiptFolderPath];
    }
    
}
@implementation XAPIPCHandler{
    NSNotificationCenter *notifyCenter;
}
+(id)sharedInstance{
    static XAPIPCHandler* SI=nil;
    static dispatch_once_t Token;
    dispatch_once(&Token, ^{
        SI = [[self alloc] init];
    });
    return SI;
    
}
-(XAPIPCHandler*)init{
    self=[super init];
    self->notifyCenter=[NSNotificationCenter defaultCenter];
    //Insert Observers
    [self->notifyCenter addObserver:self selector:@selector(PostReceiptDataForBundleID:) name:NotifyRequestReceiptData object:nil];
    
    
    return self;
    
}
-(void)PostReceiptDataForBundleID:(NSNotification*)Notify{
    NSString* bundleID=[Notify.userInfo objectForKey:@"bundleID"];
    NSData* ReceiptData=GetReceipt(bundleID);
    NSNotification* ReceiptDataNotifi=[NSNotification notificationWithName:[NSString stringWithFormat:@"%@.%@",NotifyNamePrefix,bundleID] object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:ReceiptData,@"Receipt",nil]];
    [self->notifyCenter postNotification:ReceiptDataNotifi];
    
}

@end
