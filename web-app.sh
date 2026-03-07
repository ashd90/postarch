#!/bin/bash

# Colors for terminal output
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

clear
echo -e "${GREEN}========================================${RESET}"
echo -e "${GREEN}      Web App Launcher Generator        ${RESET}"
echo -e "${GREEN}      (Optimized for Archcraft/KDE)     ${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo ""

# Ask user for inputs
read -p "Enter the Web App Name (e.g., YouTube): " APP_NAME
read -p "Enter the Web App URL: " APP_URL
read -p "Enter the Icon URL (or local path): " ICON_URL
echo ""

# Extract the domain to use as the dynamic WMClass (e.g., youtube.com)
# This fixes the "generic icon" issue in KDE Task Manager
DOMAIN=$(echo "$APP_URL" | awk -F[/:] '{print $4}')

# Browser selection menu
while true; do
  echo -e "${YELLOW}Choose the browser to use:${RESET}"
  echo "  1) Thorium"
  echo "  2) Brave"
  echo "  3) Chromium"
  echo "  4) Cancel"
  echo ""
  read -p "Enter your choice (1-4): " BROWSER_CHOICE

  case $BROWSER_CHOICE in
  1)
    BROWSER="thorium-browser"
    WM_CLASS="thorium-browser" # Thorium standard
    break
    ;;
  2)
    BROWSER="brave"
    # For Brave Web-Apps, the window class usually matches the domain
    WM_CLASS="$DOMAIN"
    break
    ;;
  3)
    BROWSER="chromium"
    WM_CLASS="chromium-browser"
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
echo -e "${GREEN}Creating Web App Launcher for $APP_NAME...${RESET}"

# Create directories if they don't exist
mkdir -p "$APP_DIR" "$ICON_DIR"

# Download icon
wget -q -O "$ICON_FILE" "$ICON_URL"

# Create the .desktop entry with the DYNAMIC WM_CLASS
cat <<EOF >"$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$BROWSER --app="$APP_URL"
Icon=$ICON_FILE
Terminal=false
Categories=Network;WebBrowser;
StartupWMClass=$WM_CLASS
EOF

# Make the file executable
chmod +x "$DESKTOP_FILE"

# Refresh the application database
update-desktop-database "$APP_DIR" >/dev/null 2>&1

echo -e "${GREEN}SUCCESS: '$APP_NAME' has been created!${RESET}"
echo -e "StartupWMClass set to: ${YELLOW}$WM_CLASS${RESET}"
echo ""
