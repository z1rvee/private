THEOS ?= $(HOME)/theos
export THEOS

ARCHS = arm64
#Add arm64e if it needed
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
THEOS_PACKAGE_SCHEME = rootless
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ESP

ESP_FRAMEWORKS = IOKit  UIKit Foundation Security QuartzCore CoreGraphics \
                 CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController


ESP_LDFLAGS += ESP/API/libAPIClient.a ESP/JRMemory.framework/JRMemory -Wl,-rpath,@executable_path/Frameworks

ESP_CCFLAGS = -w -std=gnu++14 -fno-rtti -fno-exceptions -DNDEBUG -Wno-module-import-in-extern-c


ESP_CFLAGS = -w -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

ESP_FILES =  ESP/custom.cpp ESP/Dolphins.mm \
            ESP/BLOCK/AppDelegate.m ESP/BLOCK/ZXHttpIPGet.m \
            ESP/BLOCK/EtcHostsURLProtocol.m ESP/BLOCK/ZXURLProtocol.m \
            ESP/BLOCK/main.m ESP/BLOCK/NSEtcHosts.m \
            ESP/BLOCK/NSURL+hook.m ESP/BLOCK/FCFileManager.m \
            ESP/BLOCK/DBLOCKRASHID.m ESP/BLOCK/NSURLSession+ZXHttpProxy.m \
            $(wildcard ESP/Hide/*.m) $(wildcard Menu/*.mm) \
            $(wildcard Menu/XC6/*.mm) $(wildcard Module/*.mm) \
            $(wildcard CustomView/*.m) $(wildcard utils/*.cpp) \
            $(wildcard utils/*.m) $(wildcard AEScrypt/*.m) \
            $(wildcard ESP/imgui/*.mm) $(wildcard ESP/imgui/*.cpp) \
            $(wildcard ESP/*.mm) $(wildcard ESP/*.cpp) \
            $(wildcard SDK/*.cpp) ESP/privateanti.xm

#Dolphins_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk
