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

power_state:
 delay: "now"
 mode: reboot
 message: "reboot by cloud-init"
 timeout: 5
 condition: True

ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpAt98yXdJ0rB2V6zbYBDYkWBTTGlt/AJ3VL3zcmxRD4ia1uy/DLQY/qcWiq0Nyj6ip8WBa+PuWl1qT+OBQUBLjzvla840taaU6pqdZYRkCFs+HB/c71GbTDWYGAtCW+2GHsqM8lLJwRqjRUoq9+sFLGZ0jNgi6BY88FOhMD97sH21b26iuY923elznkEe63EafhHaz5TbCadk5Ok6YhM4EVHlsPyjV4Eb+pusDy3tdzXRkbRiyGGAH6HK+ebZ6C4NrOAXESC1eLfApnE0fUPa1EQ9k9HSoae9U0R+EYS/wkYjeKYLUCOcl5rH1ES4w3KRMPl5hIl+BVdzHEE3+fLR

