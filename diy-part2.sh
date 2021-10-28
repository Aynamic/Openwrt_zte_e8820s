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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改主机名字，把E8820S修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/E8820S/g' package/base-files/files/bin/config_generate

# 修改开源驱动wifi名称
sed -i 's/OpenWrt/ZTE-E8820S-$/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改闭源驱动2G wifi名称
 sed -i 's/OpenWrt_2G/ZTE-E8820S/g' package/lean/mt/drivers/mt_wifi/files/mt7603.dat

# 修改闭源驱动5G wifi名称
 sed -i 's/OpenWrt_5G/ZTE-E8820S-5G/g' package/lean/mt/drivers/mt_wifi/files/mt7612.dat

# 更改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# Add zte_e8820s part in mt7621.mk and e8820s dts file
cd ../
cat mt7621.mk_zte_e8820s >> openwrt/target/linux/ramips/image/mt7621.mk
cp mt7621_zte_e8820s.dts  openwrt/target/linux/ramips/dts/mt7621_zte_e8820s.dts
cp 01_leds_zte_e8820s openwrt/target/linux/ramips/mt7621/base-files/etc/board.d/01_leds
