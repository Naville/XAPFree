
#import <Foundation/Foundation.h>
#define preferenceFilePath @"/var/mobile/Library/Preferences/naville.xapfree.plist"
extern void init_StoreKit(BOOL Preferences);
/*
NSMutableArray* FindClassForProtocal(Protocol* Proto){
	@autoreleasepool{
	NSMutableArray* NSClassList=[NSMutableArray array];
    int ClassCount=objc_getClassList(NULL, 0);
  
    Class *classList = (Class*)malloc( ClassCount * sizeof(Class));
    objc_getClassList( classList, ClassCount );
    for (int Index=0;Index<ClassCount;Index++){
        Class currentClass=classList[Index];
        if(class_conformsToProtocol(currentClass,Proto)){
            NSLog(@"Found Class:%@ Conforms To Protocal:%@",NSStringFromClass(currentClass),NSStringFromProtocol(Proto));
            [NSClassList addObject:NSStringFromClass(currentClass)];
        }
    }
    
    free(classList);
    return NSClassList;
	}
}*/
BOOL getBoolFromPreferences(NSString *preferenceValue) {
    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferenceFilePath];
    id value = [preferences objectForKey:preferenceValue];
    if (value == nil) {
        return NO; // default to YES
    }
    [preferences release];
    BOOL retVal=[value boolValue];
    [value release];
    return retVal;
}

%ctor{
#ifdef DEBUG
#pragma message ("XAPFree: Building For DEBUG")
#endif
    BOOL StoreKit=getBoolFromPreferences(@"StoreKit");
    BOOL ReceiptDump=getBoolFromPreferences(@"ReceiptDump");
    if(StoreKit){
	init_StoreKit(ReceiptDump);
#ifdef DEBUG
    NSLog(@"XAPFree Constructor Finished Executing");
#endif
    }



}
%dtor{
    //[[NSBundle mainBundle] appStoreReceiptURL]
    [[NSFileManager defaultManager] moveItemAtURL:[NSURL URLWithString:[[[NSBundle mainBundle] appStoreReceiptURL].path stringByAppendingString:@"XAPFreeBackup"]]
                toURL:[[NSBundle mainBundle] appStoreReceiptURL]
                 error:nil];
                 //Put it back

}

