#cloud-config

# Install additional packages on first boot
#
# Default: none
#
# if packages are specified, this apt_update will be set to true
#
# packages may be supplied as a single package name or as a list
# with the format [<package>, <version>] wherein the specifc
# package version will be installed.

packages:
 - tree
 - emacs

write_files:
 - content: |
     127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
     ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
     10.10.10.11 node1.user01.com node1
     10.10.10.21 chef-server.user01.com chef-server
   path: /etc/hosts
   permissions: '0644'
