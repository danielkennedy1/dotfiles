#!/usr/bin/env bash
# Fetch RSS feed
temp_rss="/tmp/nasa_rss.xml"
wget -qO "$temp_rss" https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss

line_number=${1:-1}

# Extract image URL matching the pattern
image_url=$(grep -o 'https://www\.nasa\.gov/wp-content/uploads/[^"]*\.jpg' "$temp_rss" | head -"$line_number" | tail -1)

# Clean up RSS file
rm -f "$temp_rss"

if [ -z "$image_url" ]; then
  echo "No image URL found"
  exit 1
fi

# Download image
temp_file="/tmp/nasa_image.jpg"
wget -q "$image_url" -O "$temp_file"

# Wait before setting wallpaper
sleep 3

# Set wallpaper
swww img "$temp_file"
echo "Wallpaper set to: $image_url"
