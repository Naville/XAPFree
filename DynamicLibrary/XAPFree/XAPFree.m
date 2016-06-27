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

}
