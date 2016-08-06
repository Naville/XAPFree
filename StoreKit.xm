#import <StoreKit/StoreKit.h>
#import <objc/runtime.h>
#import "XAPSKPaymentTransactionObserver.h"
static XAPSKPaymentTransactionObserver* Observer=nil;
#define DefaultValidReceipt [[NSData alloc] initWithBase64EncodedString:@"ewoJInNpZ25hdHVyZSIgPSAiQXBkeEpkdE53UFUyckE1L2NuM2tJTzFPVGsyNWZlREthMGFhZ3l5UnZlV2xjRmxnbHY2UkY2em5raUJTM3VtOVVjN3BWb2IrUHFaUjJUOHd5VnJITnBsb2YzRFgzSXFET2xXcSs5MGE3WWwrcXJSN0E3ald3dml3NzA4UFMrNjdQeUhSbmhPL0c3YlZxZ1JwRXI2RXVGeWJpVTFGWEFpWEpjNmxzMVlBc3NReEFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5USXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1YvcnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRkS1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNqQndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBnRVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERnUVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lCM1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNlVFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIwN2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FRVnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xvSHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5qK2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2JwMGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREV5TFRBM0xURXlJREExT2pVME9qTTFJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakV6TkRJd09UYzJOelU0T0RJaU93b0pJbTl5YVdkcGJtRnNMWFJ5WVc1ellXTjBhVzl1TFdsa0lpQTlJQ0l4TnpBd01EQXdNamswTkRrME1qQWlPd29KSW1KMmNuTWlJRDBnSWpFdU5DSTdDZ2tpWVhCd0xXbDBaVzB0YVdRaUlEMGdJalExTURVME1qSXpNeUk3Q2draWRISmhibk5oWTNScGIyNHRhV1FpSUQwZ0lqRTNNREF3TURBeU9UUTBPVFF5TUNJN0Nna2ljWFZoYm5ScGRIa2lJRDBnSWpFaU93b0pJbTl5YVdkcGJtRnNMWEIxY21Ob1lYTmxMV1JoZEdVdGJYTWlJRDBnSWpFek5ESXdPVGMyTnpVNE9ESWlPd29KSW1sMFpXMHRhV1FpSUQwZ0lqVXpOREU0TlRBME1pSTdDZ2tpZG1WeWMybHZiaTFsZUhSbGNtNWhiQzFwWkdWdWRHbG1hV1Z5SWlBOUlDSTVNRFV4TWpNMklqc0tDU0p3Y205a2RXTjBMV2xrSWlBOUlDSmpiMjB1ZW1Wd2RHOXNZV0l1WTNSeVltOXVkWE11YzNWd1pYSndiM2RsY2pFaU93b0pJbkIxY21Ob1lYTmxMV1JoZEdVaUlEMGdJakl3TVRJdE1EY3RNVElnTVRJNk5UUTZNelVnUlhSakwwZE5WQ0k3Q2draWIzSnBaMmx1WVd3dGNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhNaTB3TnkweE1pQXhNam8xTkRvek5TQkZkR012UjAxVUlqc0tDU0ppYVdRaUlEMGdJbU52YlM1NlpYQjBiMnhoWWk1amRISmxlSEJsY21sdFpXNTBjeUk3Q2draWNIVnlZMmhoYzJVdFpHRjBaUzF3YzNRaUlEMGdJakl3TVRJdE1EY3RNVElnTURVNk5UUTZNelVnUVcxbGNtbGpZUzlNYjNOZlFXNW5aV3hsY3lJN0NuMD0iOwoJInBvZCIgPSAiMTciOwoJInNpZ25pbmctc3RhdHVzIiA9ICIwIjsKfQ==" options:0]
static NSData* GenerateAppleVerifyResponse(NSURLRequest* Request){
	@autoreleasepool{
		NSMutableDictionary* GeneratedDict=[NSMutableDictionary dictionary];
		NSError* Err;
		NSDictionary* POSTBody=[NSJSONSerialization JSONObjectWithData:Request.HTTPBody options:0 error:&Err];
		[GeneratedDict setObject:[NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithBase64EncodedString:[POSTBody objectForKey:@"receipt-data"] options:0] options:0 error:&Err] forKey:@"receipt"];
		[GeneratedDict setObject:[NSNumber numberWithInt:0] forKey:@"status"];
		if(Err!=nil){
#ifdef DEBUG
			NSLog(@"GenerateAppleVerifyResponse Error:%@",Err.localizedDescription);
#endif	
			return nil;
		}
		else{
			return [NSJSONSerialization dataWithJSONObject:GeneratedDict
                                                      options:0
                                                        error:nil];
		}
	}//End AutoReleasePOOL
}


%group UniversalSK
%hook SKPaymentTransaction
-(SKPaymentTransactionState)transactionState{
	return SKPaymentTransactionStatePurchased;
}
-(NSData *)transactionReceipt{
	return DefaultValidReceipt;
}
-(NSDate*)transactionDate{
	return [NSDate date];

}
-(NSString *)transactionIdentifier{
	return @"SheisMyWiFi";
}
%end
%hook NSURLConnection
+(NSData*)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse*)response error:(NSError **)Error{
	@autoreleasepool{
		if([request.URL.absoluteString isEqualToString:@"https://buy.itunes.apple.com/verifyReceipt"]){
			NSData* GeneratedResponse=GenerateAppleVerifyResponse(request);
			if(GeneratedResponse==nil || GeneratedResponse.length==0){
				return %orig;
			}
			else{
				return GeneratedResponse;
			}
		}
		else{
			return %orig;
		}
	}
}
%end
//This won't take care of hardcoded paths.
//Moving Files instead

/*%hook NSBundle
-(NSURL *)appStoreReceiptURL{//So We Won't overwrite legit receipts
	return [NSURL URLWithString:[%orig.path stringByAppendingString:@"XAPFree"]];
}
%end*/
%end
void init_StoreKit(BOOL Preferences){
		/*NSMutableArray* ClassNameList=FindClassForProtocal(objc_getProtocol("SKPaymentTransactionObserver"));
	NSLog(@"Found Observer List:%@",ClassNameList);
	for (NSString* SKTO in ClassNameList){
		NSLog(@"XAPFree---------Found SKPaymentTransactionObserver:%@",SKTO);
    	%init(SKObserver,PaymentTransactionObserverClass=NSClassFromString(SKTO));
	}
	[ClassNameList release];*/
	if(Preferences==YES){
#ifdef DEBUG
	NSLog(@"init_StoreKit. Dumping Receipts Only");
#endif		
		//Init Legit-Receipt Dumps
		Observer=[XAPSKPaymentTransactionObserver sharedInstance];
		[[SKPaymentQueue defaultQueue] addTransactionObserver:Observer];
		return ;
	}
	else{
#ifdef DEBUG
	NSLog(@"init_StoreKit. Init Hooks");
#endif	
	[[NSFileManager defaultManager] moveItemAtURL:[[NSBundle mainBundle] appStoreReceiptURL]
                toURL:[NSURL URLWithString:[[[NSBundle mainBundle] appStoreReceiptURL].path stringByAppendingString:@"XAPFreeBackup"]]
                 error:nil];
	%init(UniversalSK);//Apply Receipt URL hooks before writing
	[DefaultValidReceipt writeToURL:[[NSBundle mainBundle] appStoreReceiptURL] atomically:YES];
	}

}
