#!/usr/bin/env bash
# Generate random date between Jan 1 2015 and Jan 1 2025
start_date=$(date -d "2015-01-01" +%s)
end_date=$(date -d "2025-01-01" +%s)
range=$((end_date - start_date))
random_offset=$(( (RANDOM << 15 | RANDOM) % range ))
random_date=$((start_date + random_offset))
formatted_date=$(date -d "@$random_date" +%y%m%d)

# Fetch APOD page
temp_html="/tmp/apod.html"
apod_url="https://apod.nasa.gov/apod/ap${formatted_date}.html"
wget -qO "$temp_html" "$apod_url"

# Extract image URL - APOD pages have the main image in an <a> tag
image_url=$(grep -oP 'href="image/[^"]+\.(jpg|png|gif)"' "$temp_html" | head -1 | sed 's/href="//;s/"$//')

# Clean up HTML file
rm -f "$temp_html"

if [ -z "$image_url" ]; then
  echo "No image URL found for date: $(date -d "@$random_date" +%Y-%m-%d)"
  exit 1
fi

# APOD images are relative paths, prepend base URL
full_image_url="https://apod.nasa.gov/apod/${image_url}"

# Download image
temp_file="/tmp/apod_image.jpg"
wget -q "$full_image_url" -O "$temp_file"

sleep 3

swww img "$temp_file"
echo "Wallpaper set to APOD from $(date -d "@$random_date" +%Y-%m-%d): $full_image_url"
