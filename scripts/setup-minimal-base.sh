#!/bin/bash
# Setup minimal base system for smaller ISO

WORK_DIR=$1

echo "Downloading minimal base system..."
debootstrap --variant=minbase --arch=amd64 jammy "$WORK_DIR" http://archive.ubuntu.com/ubuntu/

echo "Configuring minimal system..."
cat > "$WORK_DIR/etc/apt/sources.list" << EOF
deb http://archive.ubuntu.com/ubuntu jammy main restricted universe
deb http://archive.ubuntu.com/ubuntu jammy-updates main restricted universe
deb http://security.ubuntu.com/ubuntu jammy-security main restricted universe
EOF

# Chroot and update
chroot "$WORK_DIR" apt update
chroot "$WORK_DIR" apt upgrade -y

# Install only essential packages
chroot "$WORK_DIR" apt install -y --no-install-recommends \
    linux-image-generic \
    live-boot \
    systemd-sysv

echo "Minimal base system setup complete"
