sudo pacman -S rofi jq curl
chmod +x setup-waybar.sh
./setup-waybar.sh

# Custome rofi powermenu

# Replace your existing file:
~/.config/waybar/scripts/power-menu.sh


chmod +x ~/.config/waybar/scripts/power-menu.sh


# Create the Rofi theme file

# Path: ~/.config/rofi/power-menu.rasi

Optional: add blur with Hyprland

Add this to your ~/.config/hypr/hyprland.conf for a nice background blur when Rofi opens:

# Blur for rofi
windowrulev2 = blur, class:^(rofi)$
windowrulev2 = opacity 0.9, class:^(rofi)$

🌿 ~/.config/waybar/style.css — Jungle Theme



✅ 1. Desktop Entry — Install Web App

Create this file:

touch ~/.local/share/applications/webapp-install.desktop

Content:

[Desktop Entry]
[Desktop Entry]
Name=Install Web App
Comment=Run the web-app installation script
Exec=/mnt/data/web-app.sh
Icon=/home/$USER/.local/share/icons/webapp-install.png
Terminal=true
Type=Application
Categories=Utility;

Make it executable:

chmod +x ~/.local/share/applications/webapp-install.desktop

✅ 2. Desktop Entry — Remove Web App

Create this file:

touch ~/.local/share/applications/web-app-remove.desktop

Content:

[Desktop Entry]
[Desktop Entry]
Name=Remove Web App
Comment=Run the web-app removal script
Exec=/mnt/data/remove-web-app.sh
Icon=/home/$USER/.local/share/icons/webapp-remove.png
Terminal=true
Type=Application
Categories=Utility;

Make it executable:

chmod +x ~/.local/share/applications/web-app-remove.desktop

Option 1 — Use Your Own Icon Files

~/.local/share/icons/webapp-install.png
~/.local/share/icons/webapp-remove.png

