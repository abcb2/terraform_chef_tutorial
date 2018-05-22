#!/bin/bash

cat << EOT > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.10.10.11 node1.user01.com
10.10.10.21 chef.user01.com
EOT

