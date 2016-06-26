//
//  RuntimeUtils.m
//  XAPFree
//
//  Created by Zhang Naville on 16/6/26.
//  Copyright © 2016年 NavilleZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuntimeUtils.h"
Class FindClassForProtocal(Protocol* Proto){
    int ClassCount=objc_getClassList(NULL, 0);
    Class *classList = (Class*)malloc( ClassCount * sizeof(Class));
    objc_getClassList( classList, ClassCount );
    for (int Index=0;Index<ClassCount;Index++){
        Class currentClass=classList[Index];
        if(class_conformsToProtocol(currentClass,Proto)){
            
            return currentClass;
        }
        
    }
    
    
    return  NULL;
}
void DumpObjcMethods(Class clz) {
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(clz, &methodCount);
    
    printf("Found %d methods on '%s'\n", methodCount, class_getName(clz));
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        printf("\t'%s' has method named '%s' of encoding '%s'\n",
               class_getName(clz),
               sel_getName(method_getName(method)),
               method_getTypeEncoding(method));
        
        /**
         *  Or do whatever you need here...
         */
    }
    
    free(methods);
}