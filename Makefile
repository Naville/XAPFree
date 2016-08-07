include $(THEOS)/makefiles/common.mk
export ARCHS=armv7 armv7s arm64
export CFLAGS=-Wp,"-DHostName=@\"$(hostname -s).local\""
TWEAK_NAME = XAPFree
SUBSTRATE ?= yes
XAPFree_FILES = Tweak.xm StoreKit.xm XAPSKPaymentTransactionObserver.m XAPSKDB.m ThirdPartyFWs.xm SKUtils.m
ADDITIONAL_CFLAGS = -Wno-#warnings,-Wno-unused-function
XAPFree_USE_SUBSTRATE =  $(SUBSTRATE)
include $(THEOS_MAKE_PATH)/tweak.mk


