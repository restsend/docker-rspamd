#!/bin/sh

SECURE_IP=${SECURE_IP:-"127.0.0.1"}
PASSWORD=${PASSWORD:-"rspamd"}
ENABLE_PASSWORD=${ENABLE_PASSWORD:-$PASSWORD}

cat << EOF > /etc/rspamd/local.d/worker-controller.inc
bind_socket = "0.0.0.0:11334";
secure_ip = "${SECURE_IP}";
password = "${PASSWORD}";
enable_password = "${PASSWORD}";
EOF

rspamd -f -u rspamd -g rspamd