#!/bin/bash

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

clear
echo -e "${GREEN}========================================${RESET}"
echo -e "${GREEN}      Web App Launcher Generator        ${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo ""

# Ask user for inputs
read -p "Enter the Web App Name: " APP_NAME
read -p "Enter the Web App URL: " APP_URL
read -p "Enter the Icon URL: " ICON_URL
echo ""

# Browser selection menu
while true; do
    echo -e "${YELLOW}Choose the browser to use:${RESET}"
    echo "  1) Chromium"
    echo "  2) Brave"
    echo "  3) Cancel"
    echo ""
    read -p "Enter your choice (1-3): " BROWSER_CHOICE

    case $BROWSER_CHOICE in
        1)
            BROWSER="chromium"
            break
            ;;
        2)
            BROWSER="brave"
            break
            ;;
        3)
            echo -e "${RED}Operation cancelled.${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${RESET}"
            echo ""
            ;;
    esac
done

# Paths
APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_FILE="$APP_DIR/${APP_NAME,,}.desktop"
ICON_FILE="$ICON_DIR/${APP_NAME,,}.png"

echo ""
echo -e "${GREEN}Creating Web App Launcher...${RESET}"
echo ""

# Create directories
mkdir -p "$APP_DIR" "$ICON_DIR"

# Download icon
wget -q -O "$ICON_FILE" "$ICON_URL"

# Create desktop entry
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

echo -e "${GREEN}✔ Web app created successfully!${RESET}"
echo -e "${GREEN}✔ Launcher added to your applications menu.${RESET}"
echo -e "${GREEN}✔ Browser used: $BROWSER${RESET}"

