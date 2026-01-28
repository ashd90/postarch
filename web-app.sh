#!/bin/bash

# Colors for terminal output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

clear
echo -e "${GREEN}========================================${RESET}"
echo -e "${GREEN}      Web App Launcher Generator        ${RESET}"
echo -e "${GREEN}      (Optimized for Archcraft)         ${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo ""

# Ask user for inputs
read -p "Enter the Web App Name (e.g., Gemini): " APP_NAME
read -p "Enter the Web App URL: " APP_URL
read -p "Enter the Icon URL (or local path): " ICON_URL
echo ""

# Browser selection menu
while true; do
  echo -e "${YELLOW}Choose the browser to use:${RESET}"
  echo "  1) Thorium (Recommended for old computers)"
  echo "  2) Brave"
  echo "  3) Chromium"
  echo "  4) Cancel"
  echo ""
  read -p "Enter your choice (1-4): " BROWSER_CHOICE

  case $BROWSER_CHOICE in
  1)
    BROWSER="thorium-browser"
    break
    ;;
  2)
    BROWSER="brave"
    break
    ;;
  3)
    BROWSER="chromium"
    break
    ;;
  4)
    echo -e "${RED}Operation cancelled.${RESET}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice. Please try again.${RESET}"
    echo ""
    ;;
  esac
done

# Standard Linux paths for launchers and icons
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_FILE="$APP_DIR/${APP_NAME,,}.desktop"
ICON_FILE="$ICON_DIR/${APP_NAME,,}.png"

echo ""
echo -e "${GREEN}Creating Web App Launcher...${RESET}"

# Create directories if they don't exist
mkdir -p "$APP_DIR" "$ICON_DIR"

# Download icon (works for both URLs and local files via wget)
wget -q -O "$ICON_FILE" "$ICON_URL"

# Create the .desktop entry
cat <<EOF >"$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$BROWSER --app="$APP_URL"
Icon=$ICON_FILE
Terminal=false
Categories=Network;WebBrowser;
StartupWMClass=Thorium-browser
EOF

# Make the file executable
chmod +x "$DESKTOP_FILE"

# Refresh the application database so it shows in the menu
update-desktop-database "$APP_DIR" >/dev/null 2>&1

echo -e "${GREEN}SUCCESS: '$APP_NAME' has been created!${RESET}"
echo -e "You can now find it in your ${YELLOW}Applications Menu${RESET}."
echo ""
