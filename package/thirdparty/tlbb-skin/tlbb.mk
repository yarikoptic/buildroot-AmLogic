TLBB_VERSION = c924bd7a59d20057e0658576d5bde1cb234627de
TLBB_SITE_METHOD = git
TLBB_SITE = git://github.com/j1nx/TLBB.git
TLBB_INSTALL_STAGING = YES
TLBB_INSTALL_TARGET = YES
TLBB_DEPENDENCIES = xbmc
TEXTURE_PACKER=$(XBMC_DIR)/tools/TexturePacker/TexturePacker

define TLBB_BUILD_CMDS
	$(TEXTURE_PACKER) -use_none -i $(@D)/media -o $(@D)/media/Textures.xbt
endef

define TLBB_INSTALL_STAGING_CMDS
        mkdir -p $(STAGING_DIR)/usr/share/xbmc/addons/skin.tlbb
        cp -rf $(@D)/* $(STAGING_DIR)/usr/share/xbmc/addons/skin.tlbb/
endef

define TLBB_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/xbmc/addons/skin.tlbb/media
	cd $(@D); cp -rf `ls -I media -1` $(TARGET_DIR)/usr/share/xbmc/addons/skin.tlbb
	cp -f $(@D)/media/Textures.xbt $(TARGET_DIR)/usr/share/xbmc/addons/skin.tlbb/media
endef

$(eval $(call GENTARGETS,package/thirdparty,tlbb))
