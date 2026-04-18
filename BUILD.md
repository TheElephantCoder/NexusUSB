# Building NexusUSB

## Prerequisites

- Linux system (Ubuntu 22.04+ recommended)
- 50GB free disk space
- Required packages: `grub-pc-bin`, `grub-efi-amd64-bin`, `xorriso`, `squashfs-tools`, `mtools`

## Install Dependencies

```bash
sudo apt update
sudo apt install -y grub-pc-bin grub-efi-amd64-bin xorriso squashfs-tools mtools isolinux syslinux-utils
```

## Build Process

```bash
# Clone the repository
git clone https://github.com/TheElephantCoder/NexusUSB.git
cd NexusUSB

# Run the build script
sudo ./build.sh

# Output will be in dist/NexusUSB.iso
```

## Customization

Edit `config/tools.conf` to add/remove tools
Edit `theme/` directory to customize the boot menu appearance

## Flashing to USB

### Using Ventoy (Recommended)
1. Install Ventoy on your USB drive
2. Copy the ISO to the USB drive
3. Boot and select NexusUSB

### Using Rufus
1. Open Rufus
2. Select your USB drive
3. Select the NexusUSB.iso
4. Click Start
