#############################################################
#
# tvheadend
#
##############################################################

TVHEADEND_VERSION = babe15958e235ee9ec7b12bf455a908b95532936
TVHEADEND_SITE_METHOD = git
TVHEADEND_SITE = git://github.com/tvheadend/tvheadend.git
TVHEADEND_INSTALL_STAGING = YES
TVHEADEND_INSTALL_TARGET = YES
TVHEADEND_DEPENDENCIES = v4lutils openssl

ifeq ($(BR2_PACKAGE_AVAHI),y)
TVHEADEND_DEPENDENCIES     += avahi
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
TVHEADEND_DEPENDENCIES     += zlib
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
TVHEADEND_DEPENDENCIES     += curl
else
TVHEADEND_CONFIGURE_OPTS   += --disable-imagecache
endif

define TVHEADEND_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/root/.hts/tvheadend
        mkdir -p $(TARGET_DIR)/root/.hts/tvheadend/accesscontrol
	$(INSTALL) -D package/thirdparty/tvheadend/accesscontrol.1 $(TARGET_DIR)/root/.hts/tvheadend/accesscontrol/1
	$(INSTALL) -D package/thirdparty/tvheadend/S55tvheadend $(TARGET_DIR)/etc/init.d/S55tvheadend
endef

$(eval $(call AUTOTARGETS,package/thirdparty,tvheadend))
