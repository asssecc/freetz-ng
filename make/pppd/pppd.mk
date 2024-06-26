$(call PKG_INIT_BIN, 2.4.7)
$(PKG)_SOURCE:=ppp-$($(PKG)_VERSION).tar.gz
$(PKG)_HASH:=02e0a3dd3e4799e33103f70ec7df75348c8540966ee7c948e4ed8a42bbccfb30
$(PKG)_SITE:=@SAMBA/ppp
$(PKG)_STARTLEVEL=81

$(PKG)_BINARY:=$($(PKG)_DIR)/pppd/pppd
$(PKG)_TARGET_BINARY:=$($(PKG)_DEST_DIR)/usr/sbin/pppd
$(PKG)_CHAT_BINARY:=$(PPPD_DIR)/chat/chat
$(PKG)_CHAT_TARGET_BINARY:=$($(PKG)_DEST_DIR)/usr/sbin/chat
ifneq ($(strip $(FREETZ_PACKAGE_PPPD_CHAT)),y)
$(PKG)_EXCLUDED += $($(PKG)_CHAT_TARGET_BINARY)
endif

$(PKG)_MAKE_OPTS := -C $(PPPD_DIR)
$(PKG)_MAKE_OPTS += CC="$(TARGET_CC)"
$(PKG)_MAKE_OPTS += COPTS="$(TARGET_CFLAGS)"
$(PKG)_MAKE_OPTS += STAGING_DIR="$(TARGET_TOOLCHAIN_STAGING_DIR)"

$(PKG)_REBUILD_SUBOPTS += FREETZ_TARGET_IPV6_SUPPORT
ifeq ($(strip $(FREETZ_TARGET_IPV6_SUPPORT)),y)
$(PKG)_MAKE_OPTS += FREETZ_USE_INET6=y
endif

$(PKG)_REBUILD_SUBOPTS += FREETZ_PACKAGE_PPPD_WITH_EAPTLS
ifeq ($(strip $(FREETZ_PACKAGE_PPPD_WITH_EAPTLS)),y)
$(PKG)_MAKE_OPTS += FREETZ_USE_EAPTLS=y
$(PKG)_REBUILD_SUBOPTS += FREETZ_OPENSSL_SHLIB_VERSION
$(PKG)_DEPENDS_ON += openssl
endif

$(PKG_SOURCE_DOWNLOAD)
$(PKG_UNPACKED)
$(PKG_CONFIGURED_CONFIGURE)

$($(PKG)_BINARY) $($(PKG)_CHAT_BINARY): $($(PKG)_DIR)/.configured
	$(SUBMAKE) $(PPPD_MAKE_OPTS) all

$($(PKG)_TARGET_BINARY): $($(PKG)_BINARY)
	$(INSTALL_BINARY_STRIP)

$($(PKG)_CHAT_TARGET_BINARY): $($(PKG)_CHAT_BINARY)
	$(INSTALL_BINARY_STRIP)

$(pkg):

$(pkg)-precompiled: $($(PKG)_TARGET_BINARY) $(if $(FREETZ_PACKAGE_PPPD_CHAT),$($(PKG)_CHAT_TARGET_BINARY))

$(pkg)-clean:
	-$(SUBMAKE) $(PPPD_MAKE_OPTS) clean

$(pkg)-uninstall:
	$(RM) $(PPPD_TARGET_BINARY) $(PPPD_CHAT_TARGET_BINARY)

$(PKG_FINISH)
