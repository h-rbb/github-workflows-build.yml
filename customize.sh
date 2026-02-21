#!/bin/bash
set -e

# 修改默认 IP 为 192.168.100.1
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名
sed -i 's/OpenWrt/JDCloud-AX1800Pro/g' package/base-files/files/bin/config_generate

# 添加 iStore opkg 源
cat >> package/base-files/files/etc/opkg/distfeeds.conf << 'EOF'
src/gz istore_packages https://istore.linkease.com/repo/all/store
EOF

# 安装 quectel-CM（5G 拨号工具）
if [ ! -d "package/luci-app-qmodem" ]; then
  git clone https://github.com/lysgwl/openwrt-package.git --depth=1 --filter=blob:none --sparse _tmp_pkg
  cd _tmp_pkg
  git sparse-checkout set luci-app-qmodem
  cp -r luci-app-qmodem ../package/
  cd ..
  rm -rf _tmp_pkg
fi
