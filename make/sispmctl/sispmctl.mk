$(call PKG_INIT_BIN, 2.6)
$(PKG)_SOURCE:=sispmctl-$($(PKG)_VERSION).tar.gz
$(PKG)_SITE:=http://mesh.dl.sourceforge.net/sourceforge/sispmctl
$(PKG)_BINARY:=$($(PKG)_DIR)/src/sispmctl
$(PKG)_TARGET_BINARY:=$($(PKG)_TARGET_DIR)/root/usr/sbin/sispmctl

$(PKG)_DEPENDS_ON += libusb

$(PKG_SOURCE_DOWNLOAD)
$(PKG_UNPACKED)
$(PKG_CONFIGURED_CONFIGURE)

$($(PKG)_BINARY): $($(PKG)_DIR)/.configured
	PATH="$(TARGET_PATH)" \
		$(MAKE) -C $(SISPMCTL_DIR)

$($(PKG)_TARGET_BINARY): $($(PKG)_BINARY)
	$(INSTALL_BINARY_STRIP)

$(pkg):

$(pkg)-precompiled: $($(PKG)_TARGET_BINARY)

$(pkg)-clean:
	-$(MAKE) -C $(SISPMCTL_DIR) clean

$(pkg)-uninstall:
	rm -f $(SISPMCTL_TARGET_BINARY)

$(PKG_FINISH)
