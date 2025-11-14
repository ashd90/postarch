#!/bin/bash

# Ask user for inputs
read -p "Enter the Web App Name: " APP_NAME
read -p "Enter the Web App URL: " APP_URL
read -p "Enter the Icon URL: " ICON_URL

# Paths
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_FILE="$APP_DIR/${APP_NAME,,}.desktop"
ICON_FILE="$ICON_DIR/${APP_NAME,,}.png"

# Create directories
mkdir -p "$APP_DIR"
mkdir -p "$ICON_DIR"

# Download icon
echo "Downloading icon..."
wget -q "$ICON_URL" -O "$ICON_FILE"

if [ $? -ne 0 ]; then
    echo "Failed to download icon. Exiting."
    exit 1
fi

# Detect browser
if command -v firefox >/dev/null 2>&1; then
    BROWSER="firefox"
elif command -v chromium >/dev/null 2>&1; then
    BROWSER="chromium"
elif command -v brave >/dev/null 2>&1; then
    BROWSER="brave-browser"
else
    echo "No supported browser found (firefox/Chromium/Brave). Exiting."
    exit 1
fi

# Create desktop entry
echo "Creating desktop launcher..."

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$BROWSER --app="$APP_URL"
Icon=$ICON_FILE
Terminal=false
Categories=Network;WebBrowser;
EOF

chmod +x "$DESKTOP_FILE"

echo "Web app created successfully!"
echo "Launcher added to your applications menu."

