ARCHS = arm64 arm64e
TARGET = iphone:clang:14.5:15.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CCSliderColorsPrefs

CCSliderColorsPrefs_FILES = CCSliderColorsRootListController.m
CCSliderColorsPrefs_FRAMEWORKS = UIKit
CCSliderColorsPrefs_PRIVATE_FRAMEWORKS = Preferences
CCSliderColorsPrefs_INSTALL_PATH = /Library/PreferenceBundles
CCSliderColorsPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
