#!/bin/bash
# 1-initial-setup.sh

echo "Step 1: Optimizing Hardware & Security..."

# 1. Update Mirrors and System
sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu --noconfirm

# 2. Intel Graphics Optimization (UHD 630)
sudo pacman -S --needed --noconfirm intel-media-driver libva-intel-driver libva-utils

# 3. Security (Firewall)
sudo pacman -S --needed --noconfirm ufw
sudo systemctl enable --now ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# 4. Bluetooth & SSD Maintenance
sudo systemctl enable --now bluetooth
sudo systemctl enable --now fstrim.timer

echo "Hardware and Security setup complete."
