##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = 29b0bc74508995829dcf15b5087983228ae67690
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-Temidayo-icon.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	# Build finder-app utilities
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all

	# Build aesdsocket from server directory
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Create required directories
	$(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/init.d

	# Install finder-app binaries and scripts
	$(INSTALL) -m 0755 $(@D)/finder-app/writer \
		$(TARGET_DIR)/usr/bin/writer
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh \
		$(TARGET_DIR)/usr/bin/finder.sh
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh \
		$(TARGET_DIR)/usr/bin/finder-test.sh
	$(INSTALL) -m 0755 $(@D)/finder-app/conf/* \
		$(TARGET_DIR)/etc/finder-app/conf/

	# Install aesdsocket binary
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket \
		$(TARGET_DIR)/usr/bin/aesdsocket

	# Install startup script with correct S99 ordering
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop \
		$(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))

