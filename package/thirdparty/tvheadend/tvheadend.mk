TVHEADEND_VERSION = 5e7950275daca9a58b6c94a51565cb1c205e4100
TVHEADEND_SITE_METHOD = git
TVHEADEND_SITE = git://github.com/tvheadend/tvheadend.git
TVHEADEND_INSTALL_STAGING = YES
TVHEADEND_INSTALL_TARGET = YES
TVHEADEND_DEPENDENCIES = v4lutils openssl \
                         $(if $(BR2_PACKAGE_TVHEADEND_AVAHI),avahi)

$(eval $(call AUTOTARGETS,package/thirdparty,tvheadend))
