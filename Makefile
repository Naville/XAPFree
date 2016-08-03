include $(THEOS)/makefiles/common.mk

TWEAK_NAME = XAPFree
XAPFree_FILES = Tweak.xm StoreKit.xm XAPSKPaymentTransactionObserver.m XAPSKDB.m
ADDITIONAL_CFLAGS = -Wno-#warnings
include $(THEOS_MAKE_PATH)/tweak.mk


