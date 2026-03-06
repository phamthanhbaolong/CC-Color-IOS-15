THEOS_PACKAGE_SCHEME = rootless
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCSliderColors

CCSliderColors_FILES = Tweak.xm
CCSliderColors_CFLAGS = -fobjc-arc
# Báo cho hệ thống biết chúng ta dùng thư viện màu
CCSliderColors_LIBRARIES = sparkcolourpicker 

include $(THEOS_MAKE_PATH)/tweak.mk

# Dòng này để gọi thư mục Menu Cài đặt (chúng ta sẽ tạo ở Bước 2)
SUBPROJECTS += ccslidercolorsprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
