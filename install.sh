#!/bin/bash

echo "🚀 Installing Ubuntu Scripts..."

# Get the absolute path of the repo directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📍 Repo detected at: $REPO_DIR"

# Make all scripts executable
chmod +x "$REPO_DIR"/*.sh

echo "🧪 Testing script syntax..."
# Test all scripts for syntax errors
for script in "$REPO_DIR"/*.sh; do
    if [ "$(basename "$script")" != "install.sh" ]; then
        if bash -n "$script"; then
            echo "✅ $(basename "$script") - Syntax OK"
        else
            echo "❌ $(basename "$script") - SYNTAX ERROR"
            echo "⚠️  Installation aborted due to syntax errors"
            exit 1
        fi
    fi
done

# Detect user's actual shell from environment
USER_SHELL=$(basename "$SHELL")
echo "🐚 User shell: $USER_SHELL"

# Function to completely clean and setup aliases
setup_aliases() {
    local rc_file="$1"
    
    # Create the file if it doesn't exist
    touch "$rc_file"
    
    # Remove ANY existing Ubuntu Scripts configuration
    sed -i '/# Ubuntu Scripts from repo/,/alias check-guardian/d' "$rc_file" 2>/dev/null
    sed -i '/alias fix-screen/d' "$rc_file" 2>/dev/null
    sed -i '/alias restart-chrome/d' "$rc_file" 2>/dev/null
    sed -i '/alias start-guardian/d' "$rc_file" 2>/dev/null
    sed -i '/alias stop-guardian/d' "$rc_file" 2>/dev/null
    sed -i '/alias update-discord/d' "$rc_file" 2>/dev/null
    sed -i '/alias check-guardian/d' "$rc_file" 2>/dev/null
    
    # Add fresh aliases with correct absolute paths
    echo '' >> "$rc_file"
    echo '# Ubuntu Scripts from repo' >> "$rc_file"
    echo "alias fix-screen=\"$REPO_DIR/fix-screen-share.sh\"" >> "$rc_file"
    echo "alias restart-chrome=\"$REPO_DIR/chrome-indestructible.sh\"" >> "$rc_file"
    echo "alias start-guardian=\"nohup $REPO_DIR/chrome-guardian.sh > $REPO_DIR/chrome-guardian.log 2>&1 &\"" >> "$rc_file"
    echo "alias stop-guardian=\"pkill -f chrome-guardian\"" >> "$rc_file"
    echo "alias update-discord=\"$REPO_DIR/discord-updater.sh\"" >> "$rc_file"
    echo "alias check-guardian=\"$REPO_DIR/check-guardian.sh\"" >> "$rc_file"
    
    echo "✅ Aliases configured in $rc_file"
}

# Configure based on detected shell
case "$USER_SHELL" in
    zsh)
        echo "📝 Configuring for ZSH..."
        setup_aliases "$HOME/.zshrc"
        ;;
    bash)
        echo "📝 Configuring for Bash..."
        setup_aliases "$HOME/.bashrc"
        ;;
    *)
        echo "⚠️  Unknown shell ($USER_SHELL), configuring both"
        setup_aliases "$HOME/.bashrc"
        setup_aliases "$HOME/.zshrc"
        ;;
esac

echo ""
echo "🎯 Installation complete!"
echo "📁 Scripts location: $REPO_DIR"
echo ""
echo "🔄 To activate aliases, run:"
echo "   source ~/.zshrc"
echo ""
echo "📋 Available commands:"
echo "   fix-screen     - Fix screen sharing issues"
echo "   restart-chrome - Restart Chrome with crash protection"
echo "   start-guardian - Start Chrome crash monitor"
echo "   stop-guardian  - Stop Chrome crash monitor"
echo "   check-guardian - Check guardian status and clean duplicates"
echo "   update-discord - Update Discord to latest version"
echo ""
echo "🎉 Setup complete! Use 'check-guardian' to manage Chrome monitoring."