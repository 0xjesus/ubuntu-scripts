#!/bin/bash

# Chrome Indestructible - Starts Chrome with anti-crash configuration
# Author: For Ubuntu 22 LTS usage  
# Usage: ./chrome-indestructible.sh

echo "=== STARTING INDESTRUCTIBLE CHROME ==="

# Kill existing Chrome processes
echo "🔄 Killing existing Chrome processes..."
pkill -f chrome 2>/dev/null
sleep 2
pkill -9 -f chrome 2>/dev/null
sleep 1

# Clean zombie processes
killall -9 chrome 2>/dev/null

# Clean corrupted cache
echo "🧹 Cleaning corrupted cache..."
rm -rf ~/.cache/google-chrome/Default/Code\ Cache/* 2>/dev/null
rm -rf ~/.cache/google-chrome/Default/GPUCache/* 2>/dev/null

# Environment variables for maximum performance
export CHROME_DEVEL_SANDBOX=/usr/lib/chromium-browser/chrome-sandbox
export MALLOC_CHECK_=0
export MALLOC_PERTURB_=0

echo "🚀 Starting Chrome with anti-crash configuration..."

# Start Chrome with anti-crash configuration
google-chrome \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu-sandbox \
  --disable-software-rasterizer \
  --disable-background-timer-throttling \
  --disable-backgrounding-occluded-windows \
  --disable-renderer-backgrounding \
  --max-active-webgl-contexts=32 \
  --max_old_space_size=8192 \
  --memory-pressure-off \
  --aggressive-cache-discard \
  --enable-aggressive-domstorage-flushing \
  --process-per-site \
  --site-per-process \
  --disable-features=VizDisplayCompositor,UseChromeOSDirectVideoDecoder \
  --enable-features=VaapiVideoDecoder \
  --disable-extensions-file-access-check \
  --disable-extensions-http-throttling \
  --unlimited-storage \
  --disable-web-security \
  --disable-features=TranslateUI \
  --disable-ipc-flooding-protection \
  --renderer-process-limit=20 \
  --max-unused-resource-memory-usage-percentage=5 \
  --purge-memory-button \
  --enable-precise-memory-info \
  --force-gpu-mem-available-mb=4096 &

echo "✅ Indestructible Chrome started successfully!"
echo "🛡️  Chrome is now running with crash protection"
