ARCHS = arm64
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Avanza


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoUpdateRequiredAvanza

NoUpdateRequiredAvanza_FILES = Tweak.x
NoUpdateRequiredAvanza_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
