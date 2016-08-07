#import <StoreKit/StoreKit.h>
#import <objc/runtime.h>
#import "XAPSKPaymentTransactionObserver.h"
extern void init_ThirdPartyFWs();
static XAPSKPaymentTransactionObserver* Observer=nil;
#define DefaultValidReceipt [[NSData alloc] initWithBase64EncodedString:@"ewoJInNpZ25hdHVyZSIgPSAiQXBkeEpkdE53UFUyckE1L2NuM2tJTzFPVGsyNWZlREthMGFhZ3l5UnZlV2xjRmxnbHY2UkY2em5raUJTM3VtOVVjN3BWb2IrUHFaUjJUOHd5VnJITnBsb2YzRFgzSXFET2xXcSs5MGE3WWwrcXJSN0E3ald3dml3NzA4UFMrNjdQeUhSbmhPL0c3YlZxZ1JwRXI2RXVGeWJpVTFGWEFpWEpjNmxzMVlBc3NReEFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5USXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1YvcnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRkS1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNqQndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBnRVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERnUVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lCM1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNlVFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIwN2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FRVnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xvSHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5qK2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2JwMGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREV5TFRBM0xURXlJREExT2pVME9qTTFJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakV6TkRJd09UYzJOelU0T0RJaU93b0pJbTl5YVdkcGJtRnNMWFJ5WVc1ellXTjBhVzl1TFdsa0lpQTlJQ0l4TnpBd01EQXdNamswTkRrME1qQWlPd29KSW1KMmNuTWlJRDBnSWpFdU5DSTdDZ2tpWVhCd0xXbDBaVzB0YVdRaUlEMGdJalExTURVME1qSXpNeUk3Q2draWRISmhibk5oWTNScGIyNHRhV1FpSUQwZ0lqRTNNREF3TURBeU9UUTBPVFF5TUNJN0Nna2ljWFZoYm5ScGRIa2lJRDBnSWpFaU93b0pJbTl5YVdkcGJtRnNMWEIxY21Ob1lYTmxMV1JoZEdVdGJYTWlJRDBnSWpFek5ESXdPVGMyTnpVNE9ESWlPd29KSW1sMFpXMHRhV1FpSUQwZ0lqVXpOREU0TlRBME1pSTdDZ2tpZG1WeWMybHZiaTFsZUhSbGNtNWhiQzFwWkdWdWRHbG1hV1Z5SWlBOUlDSTVNRFV4TWpNMklqc0tDU0p3Y205a2RXTjBMV2xrSWlBOUlDSmpiMjB1ZW1Wd2RHOXNZV0l1WTNSeVltOXVkWE11YzNWd1pYSndiM2RsY2pFaU93b0pJbkIxY21Ob1lYTmxMV1JoZEdVaUlEMGdJakl3TVRJdE1EY3RNVElnTVRJNk5UUTZNelVnUlhSakwwZE5WQ0k3Q2draWIzSnBaMmx1WVd3dGNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhNaTB3TnkweE1pQXhNam8xTkRvek5TQkZkR012UjAxVUlqc0tDU0ppYVdRaUlEMGdJbU52YlM1NlpYQjBiMnhoWWk1amRISmxlSEJsY21sdFpXNTBjeUk3Q2draWNIVnlZMmhoYzJVdFpHRjBaUzF3YzNRaUlEMGdJakl3TVRJdE1EY3RNVElnTURVNk5UUTZNelVnUVcxbGNtbGpZUzlNYjNOZlFXNW5aV3hsY3lJN0NuMD0iOwoJInBvZCIgPSAiMTciOwoJInNpZ25pbmctc3RhdHVzIiA9ICIwIjsKfQ==" options:0]
static NSData* GenerateAppleVerifyResponse(NSURLRequest* Request){
#ifdef DEBUG
			NSLog(@"Start GenerateAppleVerifyResponse");
#endif	
	if(Request==nil){
		return nil;
	}
	@autoreleasepool{
		NSMutableDictionary* GeneratedDict=[NSMutableDictionary dictionary];
		NSError* Err=nil;
		[GeneratedDict setObject:[NSNumber numberWithInt:0] forKey:@"status"];
		[GeneratedDict setObject:@"Production" forKey:@"environment"];
		NSMutableDictionary* ReceiptDict=[NSMutableDictionary dictionary];
		[ReceiptDict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"bundle_id"];
#ifdef TARGET_OS_MAC
		[ReceiptDict setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"application_version"];
		[ReceiptDict setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"original_application_version"];
#elif defined TARGET_OS_IOS 
		[ReceiptDict setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] forKey:@"application_version"];
		[ReceiptDict setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] forKey:@"original_application_version"];
#endif

		[GeneratedDict setObject:ReceiptDict forKey:@"receipt"];

		if(Err!=nil){
#ifdef DEBUG
			NSLog(@"GenerateAppleVerifyResponse Error:%@",Err.localizedDescription);
#endif	
			return nil;
		}
		else{
#ifdef DEBUG
			NSLog(@"GenerateAppleVerifyResponse Successfully");
#endif	
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
#ifdef DEBUG
	NSLog(@"[NSURLConnection )sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse*)response error:]");
#endif
		NSData *origResult = %orig(request, response, Error);
		if([request.URL.absoluteString isEqualToString:@"https://buy.itunes.apple.com/verifyReceipt"]){
			NSData* GeneratedResponse=GenerateAppleVerifyResponse(request);
			if(GeneratedResponse==nil || GeneratedResponse.length==0){
#ifdef DEBUG
	NSLog(@"NSURLLevelHook-GeneratedResponse isEmpty");
#endif
				[GeneratedResponse release];
				return origResult;
			}
			else{
#ifdef DEBUG
	NSLog(@"NSURLLevelHook-Returning GeneratedResponse");
#endif	
				[origResult release];
				return GeneratedResponse;
			}
		}
		else{
#ifdef DEBUG
	NSLog(@"NSURLLevelHook- %@ Is Not Apple Verification Server",request.URL.absoluteString);
#endif
			return origResult;
		}
}
%end


%end
void init_StoreKit(BOOL Preferences){
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
	NSLog(@"init_StoreKit. Moving Old Receipt");
#endif	
	[[NSFileManager defaultManager] moveItemAtURL:[[NSBundle mainBundle] appStoreReceiptURL]
                toURL:[NSURL URLWithString:[[[NSBundle mainBundle] appStoreReceiptURL].path stringByAppendingString:@"XAPFreeBackup"]]
                 error:nil];
#ifdef DEBUG
	NSLog(@"init_StoreKit. Init Universal Hooks");
#endif	
	%init(UniversalSK);//Apply Receipt URL hooks before writing
	init_ThirdPartyFWs();
#ifdef DEBUG
	NSLog(@"init_StoreKit. Writing DefaultValidReceipt");
#endif	
	GenerateAppleVerifyResponse(nil);//Because Compiler Won't shut up
	[DefaultValidReceipt writeToURL:[[NSBundle mainBundle] appStoreReceiptURL] atomically:YES];
	}

}
