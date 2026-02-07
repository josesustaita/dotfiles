#!/bin/bash

# Tell TLP to ignore thresholds for this charge cycle
sudo /usr/bin/tlp fullcharge BAT0

# Send notification
notify-send "🔋 Battery: Full Charge Enabled" "Charging to 100% for this session." -i battery-full
