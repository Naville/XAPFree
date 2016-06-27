//
//  main.m
//  XAPFreeDaemon
//
//  Created by Zhang Naville on 16/6/27.
//  Copyright © 2016年 NavilleZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAPIPCHandler.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [XAPIPCHandler sharedInstance];
        
        
        
        CFRunLoopRun();
    }
    return 0;
}
