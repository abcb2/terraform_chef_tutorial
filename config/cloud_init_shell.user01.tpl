#!/bin/bash

LOCAL_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
TEMPLATE=$(cat <<EOF
NETWORKING=yes
NOZEROCONF=yes
HOSTNAME=
EOF
)

if [ $LOCAL_IP = "10.10.10.11" ]; then
  echo "$${TEMPLATE}node1.user01.com" > /etc/sysconfig/network
elif [ $LOCAL_IP = "10.10.10.21" ]; then
  echo "$${TEMPLATE}chef-server.user01.com" > /etc/sysconfig/network
fi

chown root:root /etc/sysconfig/network
chmod 644 /etc/sysconfig/network
exit 0
