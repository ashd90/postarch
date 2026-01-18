#!/bin/bash
# 2-dev-packages.sh

echo "Step 2: Installing DevOps, LazyVim, and GRUB Theme..."

# 1. DevOps & Core Tools
sudo pacman -S --needed --noconfirm \
    base-devel git go rust nodejs npm python-pip python-setuptools \
    docker docker-compose kubectl minikube terraform ansible \
    aws-cli github-cli lazydocker lazygit btop eza fzf jq ripgrep starship zoxide \
    alacritty mpv

# 2. LazyVim Dependencies
# Includes Neovim, Nerd Fonts, and clipboard tools
sudo pacman -S --needed --noconfirm \
    neovim fd unzip luarocks xclip wl-clipboard \
    ttf-jetbrains-mono-nerd ttf-font-awesome

# 3. Enable Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# 4. AUR Apps & GRUB Theme
yay -S --noconfirm \
    brave-bin thorium-browser-bin visual-studio-code-bin obsidian-bin \
    grub-theme-vimix

# 5. FIX: Apply GRUB Theme (Forcing config)
sudo sed -i 's|^#GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/Vimix/theme.txt"|' /etc/default/grub
sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/Vimix/theme.txt"|' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 6. MPV GPU Acceleration Config
# Optimized for Intel UHD 630
mkdir -p ~/.config/mpv
cat <<EOF > ~/.config/mpv/mpv.conf
# Use GPU-accelerated video output
vo=gpu
hwdec=vaapi
profile=gpu-hq
scale=box
EOF

# 7. Initial LazyVim Setup (Cloning)
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
fi

echo "Packages, LazyVim, and GRUB setup complete."
