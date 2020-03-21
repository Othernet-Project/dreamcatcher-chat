#!/bin/env bash

CHAT_VERSION=0.0.2
GUI_VERSION=0.0.7
TMPD=/tmp/chat-installer

CHAT_URL="https://github.com/drsasa/Dreamcatcher-Packet-Tester/releases/download/${CHAT_VERSION}/chat"
GUI_URL="https://github.com/foxbunny/wschat/releases/download/${GUI_VERSION}/wschat-armv7"

mkdir "$TMPD"
cd "$TMPD"
wget "$CHAT_URL"
wget "$GUI_URL"
install -m755 chat /usr/local/bin/chat
install -m755 wschat-armv7 /usr/local/bin/wschat

echo "#!/bin/bash
ip_addr=\`ifconfig | grep 'inet ' | grep -v '127.0.0.1' | tr -s ' ' | cut -d ' ' -f 3\`
echo IP address \$ip_addr
wschat --addr=0.0.0.0:8080 chat" > /usr/local/bin/start-chat

chmod +x /usr/local/bin/start-chat

echo "[Unit]
Description=Dreamcatcher chat

[Service]
ExecStart=/bin/bash -c '/usr/local/bin/start-chat'

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/chat.service

systemctl daemon-reload

cd -
rm -rf "$TMPD"

# Make sure files persist
sync
sync

echo "

To start the chat server, type:

    start-chat

To start the server on boot:

    systemctl enable chat
"
