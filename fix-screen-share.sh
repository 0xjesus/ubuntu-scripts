#!/bin/bash

# Script to fix screen sharing without closing applications
# Author: For Ubuntu 22 LTS usage
# Usage: ./fix-screen-share.sh

echo "🔧 Fixing screen sharing safely..."
echo "📱 Zoom and other apps will NOT be closed"
echo ""

# Check if we're on Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "✅ Detected: Wayland (correct for Ubuntu 22)"
else
    echo "⚠️  Warning: Not on Wayland, this might not work"
fi

echo ""
echo "🔍 Checking current services..."

# Check current status
if systemctl --user is-active --quiet xdg-desktop-portal-gnome; then
    echo "✅ xdg-desktop-portal-gnome: RUNNING"
    GNOME_PORTAL_STATUS="running"
else
    echo "❌ xdg-desktop-portal-gnome: NOT RUNNING"
    GNOME_PORTAL_STATUS="stopped"
fi

if systemctl --user is-active --quiet xdg-desktop-portal; then
    echo "✅ xdg-desktop-portal: RUNNING"
    MAIN_PORTAL_STATUS="running"
else
    echo "❌ xdg-desktop-portal: NOT RUNNING"
    MAIN_PORTAL_STATUS="stopped"
fi

echo ""
echo "🛠️  Applying fixes..."

# Install portal if not installed
if ! dpkg -l | grep -q xdg-desktop-portal-gnome; then
    echo "📦 Installing xdg-desktop-portal-gnome..."
    sudo apt update -qq
    sudo apt install -y xdg-desktop-portal-gnome
    echo "✅ GNOME Portal installed"
fi

# Restart services safely (won't affect other apps)
echo "🔄 Restarting portal services..."

# Stop services
systemctl --user stop xdg-desktop-portal-gnome 2>/dev/null
systemctl --user stop xdg-desktop-portal 2>/dev/null

# Wait a moment
sleep 2

# Start services
systemctl --user start xdg-desktop-portal
systemctl --user start xdg-desktop-portal-gnome

echo ""
echo "🔍 Verifying fix..."

# Wait for services to start
sleep 3

if systemctl --user is-active --quiet xdg-desktop-portal-gnome && systemctl --user is-active --quiet xdg-desktop-portal; then
    echo "✅ SUCCESS! Portal se
# Backup del original
cp ~/fix-screen-share.sh ~/fix-screen-share.sh.backup

# Actualizar a inglés completo
cat > ~/fix-screen-share.sh << 'EOF'
#!/bin/bash

# Script to fix screen sharing without closing applications
# Author: For Ubuntu 22 LTS usage
# Usage: ./fix-screen-share.sh

echo "🔧 Fixing screen sharing safely..."
echo "📱 Zoom and other apps will NOT be closed"
echo ""

# Check if we're on Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "✅ Detected: Wayland (correct for Ubuntu 22)"
else
    echo "⚠️  Warning: Not on Wayland, this might not work"
fi

echo ""
echo "🔍 Checking current services..."

# Check current status
if systemctl --user is-active --quiet xdg-desktop-portal-gnome; then
    echo "✅ xdg-desktop-portal-gnome: RUNNING"
    GNOME_PORTAL_STATUS="running"
else
    echo "❌ xdg-desktop-portal-gnome: NOT RUNNING"
    GNOME_PORTAL_STATUS="stopped"
fi

if systemctl --user is-active --quiet xdg-desktop-portal; then
    echo "✅ xdg-desktop-portal: RUNNING"
    MAIN_PORTAL_STATUS="running"
else
    echo "❌ xdg-desktop-portal: NOT RUNNING"
    MAIN_PORTAL_STATUS="stopped"
fi

echo ""
echo "🛠️  Applying fixes..."

# Install portal if not installed
if ! dpkg -l | grep -q xdg-desktop-portal-gnome; then
    echo "📦 Installing xdg-desktop-portal-gnome..."
    sudo apt update -qq
    sudo apt install -y xdg-desktop-portal-gnome
    echo "✅ GNOME Portal installed"
fi

# Restart services safely (won't affect other apps)
echo "🔄 Restarting portal services..."

# Stop services
systemctl --user stop xdg-desktop-portal-gnome 2>/dev/null
systemctl --user stop xdg-desktop-portal 2>/dev/null

# Wait a moment
sleep 2

# Start services
systemctl --user start xdg-desktop-portal
systemctl --user start xdg-desktop-portal-gnome

echo ""
echo "🔍 Verifying fix..."

# Wait for services to start
sleep 3

if systemctl --user is-active --quiet xdg-desktop-portal-gnome && systemctl --user is-active --quiet xdg-desktop-portal; then
    echo "✅ SUCCESS! Portal services working correctly"
    echo ""
    echo "🎯 Now you can:"
    echo "   1. Go to Zoom"
    echo "   2. Click 'Share screen'"
    echo "   3. Authorize when the permissions popup appears"
    echo ""
    echo "💡 Tip: If using Zoom in browser, refresh the tab for better compatibility"
else
    echo "❌ Something went wrong. Trying plan B..."
    
    # Plan B: More aggressive but still safe
    echo "🔄 Applying advanced fix..."
    
    # Restart PipeWire too (just in case)
    systemctl --user restart pipewire 2>/dev/null
    systemctl --user restart wireplumber 2>/dev/null
    
    # Restart portals again
    systemctl --user restart xdg-desktop-portal
    systemctl --user restart xdg-desktop-portal-gnome
    
    sleep 3
    
    if systemctl --user is-active --quiet xdg-desktop-portal-gnome; then
        echo "✅ Plan B successful!"
    else
        echo "❌ Persistent problem. May need complete system restart."
        echo "💭 As last resort, you can try: sudo systemctl restart gdm3"
        echo "   (This will close your session but shouldn't close saved applications)"
    fi
fi

echo ""
echo "📊 Final service status:"
systemctl --user is-active xdg-desktop-portal-gnome && echo "✅ GNOME Portal: OK" || echo "❌ GNOME Portal: FAILED"
systemctl --user is-active xdg-desktop-portal && echo "✅ Main Portal: OK" || echo "❌ Main Portal: FAILED"
systemctl --user is-active pipewire && echo "✅ PipeWire: OK" || echo "❌ PipeWire: FAILED"

echo ""
echo "🎉 Script completed. Try screen sharing now!"
