
# ✅ 1. Desktop Entry — Install Web App

# Create this file

touch ~/.local/share/applications/webapp-install.desktop

# Content

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

# ✅ 2. Desktop Entry — Remove Web App

# Create this file

touch ~/.local/share/applications/web-app-remove.desktop

# Content

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

# Option 1 — Use Your Own Icon Files

~/.local/share/icons/webapp-install.png
~/.local/share/icons/webapp-remove.png
