THEOS_PACKAGE_SCHEME = rootless
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

# Chỉ để tên gốc, tuyệt đối không có chữ .plist ở đây
TWEAK_NAME = CC-Color-IOS-15

# Tên biến phải khớp y hệt TWEAK_NAME ở trên
CC-Color-IOS-15_FILES = Tweak.xm
CC-Color-IOS-15_CFLAGS = -fobjc-arc
CC-Color-IOS-15_LIBRARIES = sparkcolourpicker

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += ccslidercolorsprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
