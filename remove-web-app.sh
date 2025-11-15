#!/bin/bash

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

clear
echo -e "${GREEN}========================================${RESET}"
echo -e "${GREEN}         Web App Removal Tool           ${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo ""

APP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"

# Find desktop files created by your launcher generator
APPS=($(grep -l "Exec=.*--app=" "$APP_DIR"/*.desktop 2>/dev/null))

if [ ${#APPS[@]} -eq 0 ]; then
    echo -e "${RED}No web apps found that were created by the launcher tool.${RESET}"
    exit 1
fi

echo -e "${YELLOW}Installed Web Apps:${RESET}"
echo ""

declare -A MENU
i=1
for FILE in "${APPS[@]}"; do
    NAME=$(grep -m1 "^Name=" "$FILE" | cut -d'=' -f2)
    echo "  $i) $NAME"
    MENU[$i]="$FILE"
    ((i++))
done

echo "  $i) Cancel"
CANCEL=$i
echo ""

# Ask for selection
while true; do
    read -p "Select a web app to remove (1-$i): " CHOICE

    if [[ "$CHOICE" -eq "$CANCEL" ]]; then
        echo -e "${RED}Operation cancelled.${RESET}"
        exit 0
    fi

    if [[ -n "${MENU[$CHOICE]}" ]]; then
        DESKTOP_FILE="${MENU[$CHOICE]}"
        APP_NAME=$(grep -m1 "^Name=" "$DESKTOP_FILE" | cut -d'=' -f2)
        ICON_FILE=$(grep -m1 "^Icon=" "$DESKTOP_FILE" | cut -d'=' -f2)
        break
    fi

    echo -e "${RED}Invalid choice. Try again.${RESET}"
done

echo ""
echo -e "${YELLOW}Removing $APP_NAME...${RESET}"

# Delete desktop file
rm -f "$DESKTOP_FILE"

# Delete associated icon if it exists
if [[ -f "$ICON_FILE" ]]; then
    rm -f "$ICON_FILE"
fi

echo -e "${GREEN}✔ Web app '$APP_NAME' removed successfully!${RESET}"

