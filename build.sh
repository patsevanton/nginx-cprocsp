#!/bin/bash

list_dependencies=(gcc gcc-c++ rpm-build rpmdevtools openssl-devel zlib-devel pcre-devel mock)

for i in ${list_dependencies[*]}
do
    if ! rpm -qa | grep -qw $i; then
        echo "__________Dont installed '$i'__________"
        #yum -y install $i
    fi
done

rm -rf ~/rpmbuild/
mkdir -p ~/rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS}
spectool -g -R nginx.spec
cd ~/nginx-gost/SOURCES
cp COPYRIGHT logrotate nginx.check-reload.sh nginx.conf nginx-debug.service nginx-debug.sysconf nginx_conf.patch \
nginx.init.in nginx.service nginx.suse.logrotate nginx.sysconf nginx.upgrade.sh nginx.vh.default.conf ~/rpmbuild/SOURCES
cd ..
rpmbuild -ba nginx.spec
