#!/bin/env bash

CHAT_VERSION=0.0.1
GUI_VERSION=0.0.1

CHAT_URL="https://github.com/drsasa/Dreamcatcher-Packet-Tester/releases/download/${CHAT_VERSION}/chat"
GUI_URL="https://github.com/foxbunny/wschat/releases/download/${GUI_VERSION}/wschat-armv7"

mkdir /tmp/chat-installer
cd /tmp-chat-installer
wget "$CHAT_URL"
wget "$GUI_URL"
install -m755 chat /usr/local/bin/chat
install -m755 wschat-armv7 /usr/local/bin/wschat

echo "
#!/bin/bash

wschat --addr=0.0.0.0:8080 chat
" > /usr/local/bin/start-chat

echo "

To start the chat server, type:

    start-chat

"
