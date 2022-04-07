#!/bin/bash

set -e

CHAT_VERSION=0.0.3
GUI_VERSION=0.0.7
TMPD=/tmp/chat-installer

CHAT_URL="https://github.com/Tysonpower/Dreamcatcher-Packet-Tester/releases/download/${CHAT_VERSION}/chat"
GUI_URL="https://github.com/foxbunny/wschat/releases/download/${GUI_VERSION}/wschat-armv7"

error () {
  echo "[ERROR]" "$@"
  exit 1
}

dl () {
  wget -q --no-check-certificate $1
}

echo "[INFO ] Installing Dreamcatcher chat
--------------------------------
chat version: v$CHAT_VERSION
GUI version:  v$GUI_VERSION
--------------------------------"

rm -rf "$TMPD"
mkdir -p "$TMPD"
cd "$TMPD"
echo "[INFO ] Downloading chat programs"
dl "$CHAT_URL" >/dev/null || error "Could not download programs"
dl "$GUI_URL" >/dev/null  || error "Could not download programs"
echo "[INFO ] Installing chat programs"
install -m755 chat /usr/local/bin/chat \
  || error "Could not install the chat app"
install -m755 wschat-armv7 /usr/local/bin/wschat \
  || error "Could not install the chat app"

echo "[INFO ] Creating chat script"
echo "#!/bin/bash
ip_addr=\`ifconfig | grep 'inet ' | grep -v '127.0.0.1' | tr -s ' ' | cut -d ' ' -f 3\`
echo IP address \$ip_addr
wschat --addr=0.0.0.0:8080 chat" > /usr/local/bin/start-chat \
  || error "Could not install the chat app"

chmod +x /usr/local/bin/start-chat || error "Could not install the chat app"

echo "[INFO ] Installing system service"
echo "[Unit]
Description=Dreamcatcher chat

[Service]
ExecStart=/bin/bash -c '/usr/local/bin/start-chat'

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/chat.service \
  || error "Could not install the chat service"

echo "[INFO ] Reloading daemon list"
systemctl daemon-reload \
  || error "Could not reload the daemon list. Please reboot"

echo "[INFO ] Removing temporary install files"
cd - >/dev/null
rm -rf "$TMPD"

# Make sure files persist
sync
sync

echo "[INFO ] Done

To start the chat server, type:

    start-chat

To start the server on boot:

    systemctl enable chat
"
