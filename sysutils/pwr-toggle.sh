#!/bin/bash
# Get the current governor
CURRENT=$(cpupower frequency-info -p | grep -oP '(?<=")[^"]+(?=")')

if [ "$CURRENT" = "performance" ]; then
  sudo cpupower frequency-set -g powersave
  notify-send "Energy Mode" "Switched to POWERSAVE - System running cool ❄️" -i appointment-soon
else
  sudo cpupower frequency-set -g performance
  notify-send "Energy Mode" "Switched to PERFORMANCE - DevOps mode active 🚀" -i performance
fi
