#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 删除软件包
rm -rf feeds/luci/applications/luci-app-zerotier
#rm -rf feeds/luci/applications/luci-app-socat
#rm -rf package/lean/luci-app-easymesh
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-msd_lite
rm -rf package/lean/luci-app-vlmcsd
rm -rf package/lean/vlmcsd
rm -rf package/lean/luci-app-aliyundrive-webdav
rm -rf package/lean/aliyundrive-webdav
rm -rf package/lean/luci-app-unblockmusic
rm -rf package/lean/UnblockNeteaseMusic-Go
rm -rf package/lean/luci-app-pushbot
rm -rf feeds/packages/net/zerotier
rm -rf feeds/packages/net/smartdns

# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate
# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-836'' package/lean/default-settings/files/zzz-default-settings
# 版本号里显示一个自己的名字
sed -i "s/OpenWrt /sec_an build $(TZ=UTC-8 date "+%y.%m.%d") @/g" package/lean/default-settings/files/zzz-default-settings
# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 添加额外软件包
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-timewol package/apps/luci-app-control-timewol
#svn co https://github.com/kiddin9/openwrt-packages/trunk/wol package/apps/wol
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-weburl package/apps/luci-app-control-weburl
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-rebootschedule package/apps/luci-app-rebootschedule
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat package/apps/luci-app-socat
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-dnsfilter package/apps/luci-app-dnsfilter
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-pppoe-server package/apps/luci-app-pppoe-server
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-pptp-server package/apps/luci-app-pptp-server
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-pushbot package/apps/luci-app-pushbot
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-ipsec-server package/apps/luci-app-ipsec-server
git clone https://github.com/rufengsuixing/luci-app-zerotier package/apps/luci-app-zerotier
git clone -b packages --single-branch https://github.com/xiaorouji/openwrt-passwall package/apps/passwall
git clone -b luci --single-branch https://github.com/xiaorouji/openwrt-passwall package/apps/luci-app-passwall
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-msd_lite package/apps/luci-app-msd_lite

./scripts/feeds update -a
./scripts/feeds install -a
