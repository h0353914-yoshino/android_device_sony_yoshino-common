PRODUCT_SOONG_NAMESPACES += $(COMMON_PATH)
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)

# Qualcomm FBE recovery 初始化與 HAL 服務
PRODUCT_PACKAGES += qcom_decrypt qcom_decrypt_fbe
