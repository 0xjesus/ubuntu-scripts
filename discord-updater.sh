#!/bin/bash

# Discord Updater - Updates Discord to latest version
# Author: For Ubuntu 22 LTS usage
# Usage: ./discord-updater.sh

set -e  # Exit on any error
trap 'echo "❌ Script interrupted or failed at line $LINENO"' ERR

echo "🔄 Discord Updater - Updating to latest version..."
echo "📝 Verbose logging enabled"
echo ""

# Function to log with timestamp
log() {
    echo "[$(date '+%H:%M:%S')] $1"
}

# Check if Discord application is currently running (not this script)
log "Checking if Discord app is running..."
DISCORD_PIDS=$(pgrep -f "/opt/discord/Discord" || pgrep -f "/usr/bin/discord" || true)
if [ -n "$DISCORD_PIDS" ]; then
    log "Discord app processes found: $DISCORD_PIDS"
    echo "⚠️  Discord application is currently running"
    read -p "Close Discord to continue? (y/N): " close_discord
    if [[ $close_discord =~ ^[Yy]$ ]]; then
        log "User chose to close Discord app"
        echo "🔄 Closing Discord application..."
        
        # Kill specific Discord processes, not scripts with "discord" in name
        pkill -f "/opt/discord/Discord" || true
        pkill -f "/usr/bin/discord" || true
        
        log "Waiting for Discord app to close..."
        sleep 5
        
        # Verify Discord app is closed
        REMAINING_PIDS=$(pgrep -f "/opt/discord/Discord" || pgrep -f "/usr/bin/discord" || true)
        if [ -n "$REMAINING_PIDS" ]; then
            log "Force killing remaining Discord app processes: $REMAINING_PIDS"
            pkill -9 -f "/opt/discord/Discord" || true
            pkill -9 -f "/usr/bin/discord" || true
            sleep 2
        fi
        log "Discord application processes closed"
    else
        log "User chose not to close Discord"
        echo "❌ Cannot update while Discord is running. Exiting."
        exit 1
    fi
else
    log "No Discord application processes found"
fi

# Create temporary directory
TEMP_DIR="/tmp/discord-update-$(date +%s)"
log "Creating temporary directory: $TEMP_DIR"
rm -rf "$TEMP_DIR" 2>/dev/null || true
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

echo "📥 Downloading latest Discord version..."
log "Current directory: $(pwd)"

# Download latest Discord .deb package
DISCORD_URL="https://discord.com/api/download?platform=linux&format=deb"
log "Download URL: $DISCORD_URL"

log "Starting download..."
if wget --progress=bar:force -O discord-latest.deb "$DISCORD_URL" 2>&1; then
    log "Download completed successfully"
    FILE_SIZE=$(ls -lh discord-latest.deb | awk '{print $5}')
    log "Downloaded file size: $FILE_SIZE"
    echo "✅ Download completed ($FILE_SIZE)"
else
    log "Download failed with wget"
    echo "❌ Download failed"
    exit 1
fi

# Verify the file was downloaded and is not empty
if [ ! -f "discord-latest.deb" ] || [ ! -s "discord-latest.deb" ]; then
    log "Downloaded file is missing or empty"
    echo "❌ Downloaded file is invalid"
    exit 1
fi

echo "📦 Installing Discord update..."
log "Starting installation process"

# Install the package
log "Running: sudo dpkg -i discord-latest.deb"
if sudo dpkg -i discord-latest.deb 2>&1; then
    log "Installation completed successfully"
    echo "✅ Discord installed successfully"
else
    log "Installation failed, attempting to fix dependencies"
    echo "⚠️  Fixing dependencies..."
    
    log "Running: sudo apt-get install -f -y"
    if sudo apt-get install -f -y 2>&1; then
        log "Dependencies fixed, retrying installation"
        if sudo dpkg -i discord-latest.deb 2>&1; then
            log "Installation successful after fixing dependencies"
            echo "✅ Discord installed successfully after fixing dependencies"
        else
            log "Installation failed even after fixing dependencies"
            echo "❌ Installation failed"
            exit 1
        fi
    else
        log "Failed to fix dependencies"
        echo "❌ Failed to fix dependencies"
        exit 1
    fi
fi

# Clean up
echo "🧹 Cleaning up temporary files..."
log "Cleaning up: $TEMP_DIR"
cd /
rm -rf "$TEMP_DIR"

# Get installed version
log "Checking installed Discord version"
DISCORD_VERSION=$(dpkg -l | grep discord | awk '{print $3}' | head -1 || echo "Unknown")
log "Detected Discord version: $DISCORD_VERSION"

echo ""
echo "🎉 Discord update completed!"
echo "📦 Installed version: $DISCORD_VERSION"
echo ""
echo "🚀 You can now start Discord from:"
echo "   - Applications menu"
echo "   - Command: discord"
echo ""
echo "💡 Tip: Discord will auto-update itself in the future, but you can run this script anytime"
log "Discord update process completed successfully"