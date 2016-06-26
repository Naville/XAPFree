//
//  XAPFree.m
//  XAPFree
//
//  Created by Zhang Naville on 16/6/22.
//  Copyright © 2016年 NavilleZhang. All rights reserved.
//

#import <ParasiteRuntime/ParasiteRuntime.h>
#import "RuntimeUtils.h"
#import <StoreKit/StoreKit.h>
#import <objc/runtime.h>
#define ReceiptFolderPath @"~/Documents/XAPFree"
#define DefaultReceiptFolderPath @"~/Documents/XAPFree/DefaultReceipt"
#define SavedReceiptPath @"~/Desktop/"
static NSData* GetReceipt(){
    if(![[NSFileManager defaultManager] fileExistsAtPath:ReceiptFolderPath]){
        //CreateDirectory
        
        [[NSFileManager defaultManager] createDirectoryAtPath:ReceiptFolderPath withIntermediateDirectories:NO attributes:nil error:nil];
        return nil;
    }
    else if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",ReceiptFolderPath,[[NSBundle mainBundle]bundleIdentifier]]]){
        
        return [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",ReceiptFolderPath,[[NSBundle mainBundle]bundleIdentifier]]];
        
    }
    else{
        
        return [NSData dataWithContentsOfFile:DefaultReceiptFolderPath];
    }
    
}

ZKSwizzleInterface(XAPFreeSKPaymentTransaction,SKPaymentTransaction, NSObject)
@implementation XAPFreeSKPaymentTransaction
-(SKPaymentTransactionState)transactionState{
    NSLog(@"XAPFree---------Intercepted transactionState");
    return SKPaymentTransactionStatePurchased;
}
-(NSError*)error{
    
    return nil;
}

@end

PSInitialize {
    
    Class clsToHook= FindClassForProtocal(objc_getProtocol("SKPaymentTransactionObserver"));
    NSLog(@"XAPFree---------Found SKPaymentTransactionObserver:%@",NSStringFromClass(clsToHook));
    ZKSwizzle(XAPFreeSKPaymentTransaction,objc_getClass("SKPaymentTransaction"));
    NSURL* appStoreReceiptPath=[[NSBundle mainBundle] appStoreReceiptURL];
    if(![[NSFileManager defaultManager] fileExistsAtPath:appStoreReceiptPath.absoluteString]){
        //Put A Fake Receipt
        //Can Be Extracted From Legit Purchase, or, Completely Bullshit
        [[NSFileManager defaultManager] createFileAtPath:appStoreReceiptPath.absoluteString contents:GetReceipt() attributes:nil];
        
        
    }
    else{
        [[NSFileManager defaultManager] moveItemAtPath:appStoreReceiptPath.absoluteString toPath:[NSString stringWithFormat:@"%@/%@",SavedReceiptPath,[[NSBundle mainBundle] bundleIdentifier]] error:nil];
        //Exists. Back Up So User Can Extract And Share it
        
    }
}
