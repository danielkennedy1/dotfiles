#!/usr/bin/env bash
# toggle-active-alpha.sh
low_alpha=${1:-0.8}

# Check if alpha property exists (meaning it's not 1.0)
if hyprctl activewindow | grep -q "alpha:"; then
    # Alpha exists, set back to opaque
    echo "setting to opaque"
    hyprctl setprop active alpha 1.0
else
    # No alpha property, window is opaque, set to low alpha
    hyprctl setprop active alpha $low_alpha
fi
