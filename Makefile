.PHONY: all lib libevent2 clean distclean indent

#http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-dev/ntp-dev-4.2.7p431.tar.gz

VERSION:=0.0.1

MY_DIR:=${PWD}
EXTCMD_BASE:=ntp
NTP_VER:=dev-4.2.7p431
NTP_ARC:=ntp-$(NTP_VER).tar.gz
NTP_URL:=http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-dev/$(NTP_ARC)
NTP_SRC:=$(MY_DIR)/$(EXTCMD_BASE)/ntp-$(NTP_VER)
NTP_DST:=$(MY_DIR)/$(EXTCMD_BASE)/ntp-$(NTP_VER).d
NTP_MAK:=$(NTP_SRC)/Makefile
NTP_SBIN_DIR:=$(NTP_DST)/sbin
NTP_BIN:=$(NTP_SBIN_DIR)/ntpd

BNTP_APPLESCRIPT:=bntp.applescript

TARGET:=bntp.app

TARGET_RESOURCE_DIR:=$(TARGET)/Contents/Resources

all: $(TARGET)

$(EXTCMD_BASE)/$(NTP_ARC):
	@mkdir $(EXTCMD_BASE)
	@(cd $(EXTCMD_BASE); curl -O $(NTP_URL))

$(NTP_SRC): $(EXTCMD_BASE)/$(NTP_ARC)
	@(cd $(EXTCMD_BASE); tar xzf $(NTP_ARC))

$(NTP_MAK): $(NTP_SRC)
	echo $(NTP_SRC)
	echo $(NTP_MAK)
	@(cd $(NTP_SRC); ./configure --enable-ipv6 --prefix=$(NTP_DST))

$(NTP_BIN): $(NTP_MAK)
	@(cd $(NTP_SRC); make install)

$(NTP_DST):
	@mkdir -p $(NTP_DST)

$(TARGET): $(NTP_BIN) $(NTP_DST) $(BNTP_APPLESCRIPT) ntp.conf
	@rm -rf $(TARGET)
	@osacompile -s -o $(TARGET) $(BNTP_APPLESCRIPT)
	@cp -a $(NTP_SBIN_DIR) $(TARGET_RESOURCE_DIR)/
	@mkdir $(TARGET_RESOURCE_DIR)/etc
	@cp ntp.conf $(TARGET_RESOURCE_DIR)/etc

clean:
	@rm -rf $(TARGET)

distclean: clean
	@rm -rf $(EXTCMD_BASE) .DS_Store
