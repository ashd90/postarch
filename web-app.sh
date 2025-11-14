#!/bin/bash

echo "=== Web App Creator ==="

# Ask for details
read -p "Enter the name of the web app: " APP_NAME
read -p "Enter the URL of the web app: " APP_URL
read -p "Enter the icon path (PNG/SVG): " ICON_PATH

# Choose Browser (Chrome by default)
BROWSER="chromium"

if ! command -v $BROWSER &> /dev/null
then
    echo "Chrome not found! Trying chromium..."
    BROWSER="chromium"
fi

if ! command -v $BROWSER &> /dev/null
then
    echo "Chromium not found! Trying brave..."
    BROWSER="brave"
fi
if ! command -v $BROWSER &> /dev/null
then
    echo "Brave not found! Trying firefox..."
    BROWSER="firefox"
fi
if ! command -v $BROWSER &> /dev/null
then
    echo "No supported browser found! Install firefox/Chromium/Brave."
    exit 1
fi

# Desktop file location
DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME// /_}.desktop"

# Create launcher
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=$APP_NAME
Exec=$BROWSER --app="$APP_URL"
Icon=$ICON_PATH
Type=Application
Categories=WebApp;
EOF

# Fix permissions
chmod +x "$DESKTOP_FILE"

echo "Web App '$APP_NAME' created successfully!"
echo "Launcher saved at: $DESKTOP_FILE"

