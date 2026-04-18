#!/bin/bash
# Apply custom theme to boot menu

ISO_DIR=$1

echo "Copying theme files..."
cp theme/grub.cfg "$ISO_DIR/boot/grub/"
cp -r theme/nexus "$ISO_DIR/boot/grub/themes/"

echo "Theme applied successfully"
