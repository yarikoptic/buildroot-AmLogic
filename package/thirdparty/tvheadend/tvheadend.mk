#############################################################
#
# tvheadend
#
##############################################################

TVHEADEND_VERSION           = hardware/tbsmoi
TVHEADEND_SITE              = git://github.com/tvheadend/tvheadend.git
TVHEADEND_LICENSE           = GPLv3+
TVHEADEND_LICENSE_FILES     = LICENSE
TVHEADEND_DEPENDENCIES      = host-pkgconf host-python openssl

# Configure options and dependencies
TVHEADEND_CONFIGURE_OPTS    = --enable-bundle --disable-libav

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

define TVHEADEND_CONFIGURE_CMDS
  (cd $(TVHEADEND_DIR); \
  ./support/changelog ./debian/changelog buildroot $(TVHEADEND_VERSION); \
   $(TARGET_CONFIGURE_OPTS) \
   $(TARGET_CONFIGURE_ARGS) \
   ./configure \
  --prefix=/usr \
  $(TVHEADEND_CONFIGURE_OPTS) \
  )
endef

#----------------------------------------------------------------------------
# To run tvheadend, we need:
#  - a startup script, and its config file
#  - a default DB with a tvheadend admin
define TVHEADEND_INSTALL_DB
 $(INSTALL) -D package/tvheadend/accesscontrol.1     \
               $(TARGET_DIR)/root/.hts/tvheadend/accesscontrol/1
endef
TVHEADEND_POST_INSTALL_TARGET_HOOKS  = TVHEADEND_INSTALL_DB

define TVHEADEND_INSTALL_INIT_SYSV
 $(INSTALL) -D $(TVHEADEND_DIR)/debian/tvheadend.default $(TARGET_DIR)/etc/default/tvheadend
 $(INSTALL) -D package/tvheadend/S99tvheadend $(TARGET_DIR)/etc/init.d/S99tvheadend
endef

#----------------------------------------------------------------------------
# tvheadend is not an autotools-based package, but it is possible to
# call its ./configure script as if it were an autotools one.
$(eval $(autotools-package))
