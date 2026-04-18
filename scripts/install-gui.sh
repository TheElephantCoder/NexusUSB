#!/bin/bash
# Install professional GUI components

WORK_DIR=$1

echo "Installing GUI components..."

# Install Python GTK for GUI
chroot "$WORK_DIR" apt install -y \
    python3-gi \
    python3-gi-cairo \
    gir1.2-gtk-3.0 \
    gir1.2-gdkpixbuf-2.0

# Install icon theme and fonts
chroot "$WORK_DIR" apt install -y \
    papirus-icon-theme \
    fonts-dejavu \
    fonts-liberation \
    imagemagick \
    wget

# Create icons directory
mkdir -p "$WORK_DIR/usr/share/nexus-usb/icons/tools"

# Run icon creation script
echo "Downloading and creating tool logos..."
if [ -f "assets/download-logos.sh" ]; then
    chmod +x assets/download-logos.sh
    ./assets/download-logos.sh
else
    echo "Warning: Logo download script not found, using fallbacks"
fi

# Copy GUI application
mkdir -p "$WORK_DIR/usr/share/nexus-usb"
cp -r gui/* "$WORK_DIR/usr/share/nexus-usb/"
chmod +x "$WORK_DIR/usr/share/nexus-usb/nexus-gui.py"

# Copy icons
if [ -d "assets/icons" ]; then
    cp -r assets/icons/* "$WORK_DIR/usr/share/nexus-usb/icons/"
else
    echo "Warning: Icons directory not found"
fi

# Create desktop entry
cat > "$WORK_DIR/usr/share/applications/nexus-usb.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Nexus-USB Toolkit
Comment=Professional System Rescue & Recovery
Exec=/usr/share/nexus-usb/nexus-gui.py
Icon=/usr/share/nexus-usb/icons/nexus-icon.png
Terminal=false
Categories=System;Utility;
Keywords=rescue;recovery;malware;disk;network;
EOF

# Set GUI to auto-start
mkdir -p "$WORK_DIR/etc/xdg/autostart"
cp "$WORK_DIR/usr/share/applications/nexus-usb.desktop" \
   "$WORK_DIR/etc/xdg/autostart/"

# Configure Openbox to launch GUI
mkdir -p "$WORK_DIR/etc/xdg/openbox"
cat > "$WORK_DIR/etc/xdg/openbox/autostart" << 'EOF'
# Set wallpaper
feh --bg-scale /usr/share/nexus-usb/icons/background.png &

# Launch Nexus-USB GUI
/usr/share/nexus-usb/nexus-gui.py &
EOF

echo "Professional GUI installed"
