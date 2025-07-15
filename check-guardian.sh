#!/bin/bash

# Check Guardian Status - Monitor and clean Chrome Guardian processes
# Author: For Ubuntu 22 LTS usage
# Usage: ./check-guardian.sh

echo "🛡️  Chrome Guardian Status Check"
echo ""

# Check for running guardian processes
GUARDIAN_PIDS=$(pgrep -f chrome-guardian.sh || true)
GUARDIAN_COUNT=$(echo "$GUARDIAN_PIDS" | grep -v '^$' | wc -l)

if [ -n "$GUARDIAN_PIDS" ] && [ "$GUARDIAN_COUNT" -gt 0 ]; then
    echo "📊 Guardian Status: RUNNING"
    echo "🔢 Number of guardians: $GUARDIAN_COUNT"
    
    if [ "$GUARDIAN_COUNT" -gt 1 ]; then
        echo "⚠️  WARNING: Multiple guardians detected!"
        echo ""
        echo "🔍 Guardian processes:"
        ps aux | grep chrome-guardian.sh | grep -v grep
        
        echo ""
        read -p "🧹 Kill all guardians and restart single instance? (y/N): " clean_guardians
        if [[ $clean_guardians =~ ^[Yy]$ ]]; then
            echo "🔄 Stopping all guardian processes..."
            pkill -f chrome-guardian.sh
            sleep 2
            
            echo "🚀 Starting single guardian instance..."
            SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
            nohup "$SCRIPT_DIR/chrome-guardian.sh" > "$SCRIPT_DIR/chrome-guardian.log" 2>&1 &
            sleep 2
            
            NEW_PID=$(pgrep -f chrome-guardian.sh || true)
            if [ -n "$NEW_PID" ]; then
                echo "✅ New guardian started successfully (PID: $NEW_PID)"
            else
                echo "❌ Failed to start new guardian"
            fi
        fi
    else
        echo "✅ Single guardian running correctly"
        echo "📋 Guardian PID: $GUARDIAN_PIDS"
    fi
else
    echo "📊 Guardian Status: STOPPED"
    echo ""
    read -p "🚀 Start Chrome Guardian? (y/N): " start_guardian
    if [[ $start_guardian =~ ^[Yy]$ ]]; then
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        nohup "$SCRIPT_DIR/chrome-guardian.sh" > "$SCRIPT_DIR/chrome-guardian.log" 2>&1 &
        sleep 2
        
        NEW_PID=$(pgrep -f chrome-guardian.sh || true)
        if [ -n "$NEW_PID" ]; then
            echo "✅ Guardian started successfully (PID: $NEW_PID)"
        else
            echo "❌ Failed to start guardian"
        fi
    fi
fi

echo ""
echo "🌐 Chrome Status:"
CHROME_COUNT=$(pgrep chrome | wc -l)
if [ "$CHROME_COUNT" -gt 0 ]; then
    echo "   📊 Chrome processes: $CHROME_COUNT"
else
    echo "   📊 Chrome: NOT RUNNING"
fi