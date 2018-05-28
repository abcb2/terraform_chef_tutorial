#!/bin/bash

LOCAL_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
TEMPLATE=$(cat <<EOF
NETWORKING=yes
NOZEROCONF=yes
HOSTNAME=
EOF
)

if [ $LOCAL_IP = "10.20.10.11" ]; then
  echo "$${TEMPLATE}node1.user02.com" > /etc/sysconfig/network
elif [ $LOCAL_IP = "10.20.10.21" ]; then
  echo "$${TEMPLATE}chef-server.user02.com" > /etc/sysconfig/network
fi

chown root:root /etc/sysconfig/network
chmod 644 /etc/sysconfig/network

SSH_KEY=$(cat <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAqQLffMl3SdKwdles22AQ2JFgU0xpbfwCd1S983JsUQ+Imtbsvwy0GP6nFoqt
Dco+oqfFgWvj7lpdak/jgUFAS4875WvONLWmlOqanWWEZAhbPhwf3O9Rm0w1mBgLQlvthh7KjPJS
ycEao0VKKvfrBSxmdIzYIugWPPBToTA/e7B9tW9uormPdt3pc55BHutxGn4R2s+U2wmnZOTpOmIT
OBFR5bD8o1eBG/qbrA8t7Xc10ZG0YshhgB+hyvnm2eguDazgFxEgtXi3wKZxNH1D2tREPZPR0qGn
vVNEfhGEv8JGI3imC1AjnJeax9REuMNykTD5eYSJfgVXcxxBN/ny0QIDAQABAoIBAB9T/QEwhwAU
IcmN7uirIfRC3kwSeeh9MifUeXFK4HEWJAgvlqrDPA72BRrUkcdgmcOkvaOD0Dg6X954+H7ZDYX0
AvI/zXVPxpUL96T9UFEKi38zz2QwqDvVIIoUyuF+EMUvp/QAZwAm3z0sdtcIJXRMCqHICbhOtPCO
y7GxM9NFUn7DSllyl5HsW29HT+vj3aZea9gIGBxKvV0w1dafeJ01okKnrV85QJtoSlyxzBtkX+/g
Vx7LD9r+xjSyBgn6/5a8ABmWAhFi7PUl8GE70xANgpeHh9uqiWCMxO1MtNzVClw+e/d0IM1On85k
C9TdjPHXQ0qVOe0hmEwsjbDtGAECgYEA3l8R8P7fNkQiCd8SD1eN8qDB7S9MkNew87GRbfWEEb+f
XbZhKXFjE72n4kZO/QwSd5w7B9R3WfcZf40N9iqlod/NfMzUvDi/wcq9nLWlpMydcACBrh7wuJDT
Ei2nykA86MXHxUzFWjZvSW2rK2yCYoAQBPVojMMfrPmGxk3byqECgYEAwpIB7KOqHGlblNHFcl1U
BUxiJ7y1gS5cSqwHzmTfCIls0rbQtaGWsjj2TQ8tgMQMlf613N/d6abkjz6s6kc4Ow1YCWZC4/O5
aspEwyX+DZExzMx+eEPzlq9HhSGYd0ibC5LyXqNlxsF1rQrX4IyKh1r3NLV+maKhcTPFUdUR6jEC
gYAdMMevJhXxDrKVLyY0w16L2hR66TmYzeeZpdacY51JoyjtaVKJ2SuTXNMb/fTCfQIzl1ucZISi
V7COMNsDVIfXnwRffJf0eVKawt1vI90xq/aCzF45mDArWj+K5FlhUFtuhv/5Y2GIvRqQvge5NI5N
FdiEfh6SU87lqv/JKlFO4QKBgHzuAw5OiAt2GreTeZPVGP3N7bhWErS/b8MCcoCzhAGXO6iQebIl
7vzAVmVkOXNUbkBhK6SGmZZM8rSHKb/DuvcvujdO0eRLueI3va8P1fAgKjm1k/7koqM+KE3zJFJy
7BqiX70kbVURIt3Y+IPVuZzva4sMfh1nrwFgnHHOvZIBAoGBAMgYCjepOwrN6jfFnmuBvxnWJXqe
weyuGZP+nwdiHKBND7qM3Jzhgq+T8zQsPl4urZobAiaMcVqCCaApcLZe07DSj17IWlR75DsyTglU
A94exv7eW5mIlmckFl16k5VUDfO6kXQovw2II0pijYgq5DCxKViLmfNpB9DHn3/+3mf+
-----END RSA PRIVATE KEY-----
EOF
)

echo "$${SSH_KEY}" > /root/.ssh/chef_sample.pem
echo "$${SSH_KEY}" > /home/ec2-user/.ssh/chef_sample.pem
chown root:root /root/.ssh/chef_sample.pem
chown ec2-user:ec2-user /home/ec2-user/.ssh/chef_sample.pem
chmod 600 /root/.ssh/chef_sample.pem
chmod 600 /home/ec2-user/.ssh/chef_sample.pem

exit 0
