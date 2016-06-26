//
//  RuntimeUtils.h
//  XAPFree
//
//  Created by Zhang Naville on 16/6/26.
//  Copyright © 2016年 NavilleZhang. All rights reserved.
//

#ifndef RuntimeUtils_h
#define RuntimeUtils_h
#import <objc/runtime.h>
Class FindClassForProtocal(Protocol* Proto);
void DumpObjcMethods(Class clz);
#endif /* RuntimeUtils_h */
