#!/bin/bash

# Chrome Guardian - Monitors Chrome and restarts it if it crashes
# Author: For Ubuntu 22 LTS usage
# Usage: ./chrome-guardian.sh &

echo "🛡️  Chrome Guardian started - Monitoring Chrome processes..."
echo "📅 Started at: $(date)"
echo ""

while true; do
    CHROME_PROCS=$(pgrep chrome | wc -l)
    
    if [ $CHROME_PROCS -eq 0 ]; then
        echo "$(date): Chrome is DEAD - RESURRECTING..."
        ~/chrome-indestructible.sh
        sleep 10
    else
        echo "$(date): Chrome is ALIVE - $CHROME_PROCS processes running"
    fi
    
    # Check for OOM (Out of Memory) kills in system logs (with sudo)
    if sudo dmesg 2>/dev/null | tail -50 | grep -q "chrome.*killed"; then
        echo "$(date): OOM kill detected - Restarting Chrome..."
        pkill -9 chrome
        sleep 3
        ~/chrome-indestructible.sh
        # Clear OOM logs
        sudo dmesg -c > /dev/null 2>&1
    fi
    
    sleep 30
done
