#!/bin/bash
# 判斷是否為 root 身份
if [ "`whoami`" != "root" ]; then
    echo "You may use root permission!"
    exit 1
fi
 
# 安裝必要軟體
apt-get update 
apt-get install -y pidgin git build-essential
apt-get install -y libpurple-dev libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev
 
# 安裝 Apache thirft
cd /tmp
mkdir purpleline
cd purpleline
git clone https://github.com/apache/thrift thrift
cd thrift
git checkout 0.9.1
./bootstrap.sh
./configure
make
make install
ln -s /usr/local/lib/libthrift-0.9.1.so /usr/lib/libthrift-0.9.1.so
cd ..
 
# 安裝 purple_line
git clone http://altrepo.eu/git/purple-line.git/ purple-line
git clone http://altrepo.eu/git/line-protocol.git/ line-protocol
cp line-protocol/line_main.thrift purple-line/
cp line-protocol/line.thrift purple-line/
cd purple-line
make
# ubuntu 在 sudo 下使用 make instll 一樣能保持預設路徑正常，Debian 用 su 不行
# make install
 
# Copy file 使用者輸入
read -p "** Input your username [ default: /usr/lib/pidgin/ ] **: " target

if [ "$target" == "" ]; then
    cp libline.so "/usr/lib/pidgin/"
else
    mkdir -p "/home/$target/.purple/plugins"
    cp libline.so "/home/$target/.purple/plugins"
fi

# ldconfig
ldconfig
