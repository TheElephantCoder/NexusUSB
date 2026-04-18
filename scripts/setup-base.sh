#!/bin/bash
# Setup base Debian/Ubuntu system

WORK_DIR=$1

echo "Downloading base system..."
debootstrap --arch=amd64 jammy "$WORK_DIR" http://archive.ubuntu.com/ubuntu/

echo "Configuring base system..."
cat > "$WORK_DIR/etc/apt/sources.list" << EOF
deb http://archive.ubuntu.com/ubuntu jammy main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu jammy-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu jammy-security main restricted universe multiverse
EOF

# Chroot and update
chroot "$WORK_DIR" apt update
chroot "$WORK_DIR" apt upgrade -y

echo "Base system setup complete"
