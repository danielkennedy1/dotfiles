#!/bin/bash

notify-send "Lid" "toggle is running"

# ~/scripts/lid-toggle.sh
if hyprctl monitors | grep -q "eDP-1.*disabled"; then
    # Lid opening - enable internal, move some workspaces back
    hyprctl keyword monitor "eDP-1,1920x1080@120,0x0,1"
    for ws in 1 2 3; do
        hyprctl dispatch moveworkspacetomonitor "$ws eDP-1"
    done
else
    # Lid closing - disable internal, move all workspaces to external
    for ws in {1..10}; do
        hyprctl dispatch moveworkspacetomonitor "$ws HDMI-A-1"
    done
    hyprctl keyword monitor "eDP-1,disable"
fi
