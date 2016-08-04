#import "XAPSKPaymentTransactionObserver.h"

#import "XAPSKDB.h"
@implementation  XAPSKPaymentTransactionObserver

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
#ifdef DEBUG
	NSLog(@"[XAPSKPaymentTransactionObserver paymentQueueRestoreCompletedTransactionsFinished:%@]",queue);
#endif	
	@autoreleasepool{
	NSMutableArray* GlobalArray=[NSMutableArray array];
	for (SKPaymentTransaction * SKPT in queue.transactions){
		NSMutableDictionary* PerTransactionDict=[NSMutableDictionary dictionary];
		SKPaymentTransaction * OriginalSKPT=nil;
		if(SKPT.transactionState==SKPaymentTransactionStatePurchased){
			OriginalSKPT=SKPT;
		}
		else if(SKPT.transactionState==SKPaymentTransactionStateRestored){
			OriginalSKPT=SKPT.originalTransaction;
		}
		if(OriginalSKPT!=nil){//Restored/Purchased. Save Receipts
		@try{
			[PerTransactionDict setObject:OriginalSKPT.transactionReceipt forKey:@"transactionReceipt"];
		}
		@catch (NSException *exception){
			NSData* ReceiptData=[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
			if(ReceiptData!=nil){
			[PerTransactionDict setObject:ReceiptData forKey:@"transactionReceipt"];
			}
		}
		[PerTransactionDict setObject:OriginalSKPT.transactionIdentifier forKey:@"transactionIdentifier"];
		[PerTransactionDict setObject:OriginalSKPT.transactionDate forKey:@"transactionDate"];
		[GlobalArray addObject:PerTransactionDict];

			}


		}//End For Loop
	[[XAPSKDB sharedInstance] SaveReceiptForBundleID:[[NSBundle mainBundle] bundleIdentifier] withInfoArray:GlobalArray];
	}//End AutoReleasePool

}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
	@autoreleasepool{
#ifdef DEBUG
	NSLog(@"[XAPSKPaymentTransactionObserver paymentQueue:%@ updatedTransactions:%@]",queue,transactions);
#endif	
	NSMutableArray* GlobalArray=[NSMutableArray array];
	for (SKPaymentTransaction * SKPT in transactions){
		NSMutableDictionary* PerTransactionDict=[NSMutableDictionary dictionary];
		SKPaymentTransaction * OriginalSKPT=nil;
		if(SKPT.transactionState==SKPaymentTransactionStatePurchased){
#ifdef DEBUG
	NSLog(@"[XAPSKPaymentTransactionObserver paymentQueue: updatedTransactions:] Status:SKPaymentTransactionStatePurchased");
#endif	
			OriginalSKPT=SKPT;
		}
		else if(SKPT.transactionState==SKPaymentTransactionStateRestored){
#ifdef DEBUG
	NSLog(@"[XAPSKPaymentTransactionObserver paymentQueue: updatedTransactions:] Status:SKPaymentTransactionStateRestored");
#endif	
			OriginalSKPT=SKPT.originalTransaction;
		}
		if(OriginalSKPT!=nil){//Restored/Purchased. Save Receipts
		[PerTransactionDict setObject:OriginalSKPT.transactionIdentifier forKey:@"transactionIdentifier"];
		[PerTransactionDict setObject:OriginalSKPT.transactionDate forKey:@"transactionDate"];
		if(OriginalSKPT.transactionReceipt!=nil){
		[PerTransactionDict setObject:OriginalSKPT.transactionReceipt forKey:@"transactionReceipt"];
		}
		else{
		[PerTransactionDict setObject:[NSData data] forKey:@"transactionReceipt"];
		}
		[GlobalArray addObject:PerTransactionDict];

			}


		}//End For Loop
	[[XAPSKDB sharedInstance] SaveReceiptForBundleID:[[NSBundle mainBundle] bundleIdentifier] withInfoArray:GlobalArray];
	}//End AutoReleasePool
}
/*- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{

}*/
+(instancetype)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}


@end