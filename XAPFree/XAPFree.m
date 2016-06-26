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
/*ZKSwizzleInterface(XAPFreeSKPaymentTransactionObserver,RDSparkleAppDelegate, NSObject)
@implementation XAPFreeSKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    NSLog(@"XAPFree---------Swizzled paymentQueue:updatedTransactions:");
    for (SKPaymentTransaction* SKPT in transactions){
        if(SKPT.transactionState== SKPaymentTransactionStateFailed){
            NSLog(@"XAPFree---------Intercepting Transaction Status");
            //[SKPT setValue:[NSNumber numberWithInteger:SKPaymentTransactionStatePurchased] forKey:@"transactionState"];
            NSLog(@"XAPFree---------Intercepted Transaction Status");
            
            
        }
        
    }
    ZKOrig(void,queue,transactions);
    
    
}
- (void)paymentQueue:(SKPaymentQueue *)queue
 removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    NSLog(@"XAPFree---------Swizzled paymentQueue:removedTransactions:");
    for (SKPaymentTransaction* SKPT in transactions){
        if(SKPT.transactionState== SKPaymentTransactionStateFailed){
            NSLog(@"XAPFree---------Intercepting Transaction Status");
           //[SKPT setValue:[NSNumber numberWithInteger:SKPaymentTransactionStatePurchased] forKey:@"transactionState"];
            
            NSLog(@"XAPFree---------Intercepted Transaction Status");
            //  SKPT.transactionState=SKPaymentTransactionStatePurchased;
        }
        
    }
    ZKOrig(void,queue,transactions);
    
    
}
@end*/

ZKSwizzleInterface(XAPFreeSKPaymentTransaction,SKPaymentTransaction, NSObject)
@implementation XAPFreeSKPaymentTransaction
-(SKPaymentTransactionState)transactionState{
    NSLog(@"XAPFree---------Intercepted transactionState");
    return SKPaymentTransactionStatePurchased;
}

@end

PSInitialize {
    
Class clsToHook= FindClassForProtocal(objc_getProtocol("SKPaymentTransactionObserver"));
    NSLog(@"XAPFree---------Found SKPaymentTransactionObserver:%@",NSStringFromClass(clsToHook));
    //ZKSwizzle(CLASS_NAME, TARGET_CLASS)
    
  //  ZKSwizzle(XAPFreeSKPaymentTransactionObserver,clsToHook);
    ZKSwizzle(XAPFreeSKPaymentTransaction,objc_getClass("SKPaymentTransaction"));
}
