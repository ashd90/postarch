#!/bin/bash
# 3-create-webapp.sh

read -p "Enter App Name: " APP_NAME
read -p "Enter URL: " APP_URL
read -p "Enter Icon URL: " ICON_URL

echo "Select Browser: 1) Thorium  2) Brave"
read -p "Choice: " B_CHOICE
[[ $B_CHOICE == "1" ]] && BROWSER="thorium-browser" || BROWSER="brave"

ICON_FILE="$HOME/.local/share/icons/${APP_NAME,,}.png"
mkdir -p "$HOME/.local/share/icons"
wget -q -O "$ICON_FILE" "$ICON_URL"

cat <<EOF > "$HOME/.local/share/applications/${APP_NAME,,}.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$BROWSER --app="$APP_URL"
Icon=$ICON_FILE
Terminal=false
Categories=Network;WebBrowser;
EOF

update-desktop-database "$HOME/.local/share/applications"
echo "Web-app $APP_NAME created successfully!"
