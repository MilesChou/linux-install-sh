#!/bin/bash
# 判斷是否為 root 身份
if [ "`whoami`" != "root" ]; then
    echo "You may use root permission!"
    exit 1
fi

add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer
