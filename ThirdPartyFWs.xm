%group TPFW
%hook IAPManager
- (BOOL)hasPurchased:(NSString *)productID{
	return YES;
}
%end
%end





void init_ThirdPartyFWs(){

	%init(TPFW);
}