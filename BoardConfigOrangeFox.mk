# Yoshino 系列的 OrangeFox recovery 共用板級設定
COMMON_PATH := device/sony/yoshino-common

# 平台與架構
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := msm8998
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a73
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a73
TARGET_NO_BOOTLOADER := true
TARGET_COPY_OUT_VENDOR := vendor

# Kernel 與分割區
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom msm_rtb.filter=0x37 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 sched_enable_power_aware=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1 swiotlb=2048 androidboot.configfs=true
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a800000.dwc3 loop.max_part=7
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_VERSION := 4.19
TARGET_KERNEL_SOURCE := kernel/sony/msm8998
TARGET_KERNEL_CONFIG := vendor/msm8998-perf_defconfig sony/yoshino.config
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 398458880
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 5242880000
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736
BOARD_ROOT_EXTRA_FOLDERS := metadata
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# FBE 與 recovery 資料掛載
# 與已驗證解密的 OrangeFox 12.1 QTI keymaster 版本設定一致
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOARD_USES_QCOM_FBE_DECRYPTION := true
RECOVERY_SDCARD_ON_DATA := true
OF_UNBIND_SDCARD_F2FS := 1
TW_INCLUDE_CRYPTO := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_NEW_ION_HEAP := true

# USB mass storage
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TARGET_RECOVERY_DEVICE_MODULES += init.recovery.usb.rc

# Recovery UI 與診斷工具
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone4/temp"
TW_BRIGHTNESS_PATH := /sys/class/leds/wled/brightness
TW_MAX_BRIGHTNESS := 4095
TW_DEFAULT_BRIGHTNESS := 1600
TW_THEME := portrait_hdpi
TW_USE_TOOLBOX := true
TW_USE_LEGACY_BATTERY_SERVICES := true
TW_EXTRA_LANGUAGES := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TWRPAPP := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_RECOVERY_DEVICE_MODULES += libxml2 libicuuc libion android.hardware.weaver@1.0 debuggerd strace
TW_RECOVERY_ADDITIONAL_RELINK_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicuuc.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.weaver@1.0.so
RECOVERY_BINARY_SOURCE_FILES += \
    $(TARGET_OUT_EXECUTABLES)/debuggerd \
    $(TARGET_OUT_EXECUTABLES)/strace

# 使用 Android16 checkout 內已提供的 Clang 預編譯版本
TARGET_KERNEL_CLANG_VERSION := r522817
# 4.19 legacy Qualcomm driver 對較新 Clang 的 packed-member 診斷不應阻擋建置
TARGET_KERNEL_ADDITIONAL_FLAGS += KCFLAGS=-Wno-error=address-of-packed-member

# poplar 使用已驗證的 recovery fstab，保留其他機型的分割區設定
ifeq ($(TARGET_DEVICE),poplar)
# 裝置 BoardConfig 在 include 後仍有賦值，使用 override 確保採用此版本
override TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/recovery/recovery.fstab
endif
