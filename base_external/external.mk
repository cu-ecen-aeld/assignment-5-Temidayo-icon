# This file allows Buildroot to find and include your external packages
include $(sort $(wildcard $(BR2_EXTERNAL_PROJECT_BASE_PATH)/package/*/*.mk))

