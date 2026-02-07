#!/bin/bash

# Thresholds (For your ThinkPad BAT0)
EXT_MONITOR_LIMIT=80
MOBILE_LIMIT=100

# Get number of monitors from hyprctl
MONITOR_COUNT=$(hyprctl monitors -j | jq '. | length')

if [ "$MONITOR_COUNT" -gt 1 ]; then
  # External monitor detected: Limit to 80%
  sudo tlp setcharge 75 $EXT_MONITOR_LIMIT BAT0
  notify-send "⚡ Power: Office Mode" "Battery limited to 80% for health." -i battery-charging
else
  # Laptop only: Charge to 100%
  sudo tlp setcharge 75 $MOBILE_LIMIT BAT0
  notify-send "🔋 Power: Mobile Mode" "Battery limit removed (100%)." -i battery
fi
