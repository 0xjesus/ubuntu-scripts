
# Ubuntu Scripts

Practical scripts for Ubuntu 22 LTS that actually work and solve real problems.

## What's included

### 🛡️ Chrome Guardian System
**chrome-guardian.sh** - Monitors Chrome and automatically restarts it when it crashes. Because Chrome crashes a lot.

**chrome-indestructible.sh** - Restarts Chrome with anti-crash settings. Kills all Chrome processes first and cleans cache.

**check-guardian.sh** - Check guardian status and clean up duplicate processes.

### 🖥️ System Fixes
**fix-screen-share.sh** - Fixes screen sharing in Ubuntu 22 when it stops working (especially in Wayland). Doesn't close your apps.

### 💬 App Updaters
**discord-updater.sh** - Updates Discord to the latest version automatically.

### ⚙️ Setup & Management
**install.sh** - Automated installer that sets up everything and configures aliases.

## Quick Installation

```bash
git clone https://github.com/0xjesus/ubuntu-scripts.git
cd ubuntu-scripts
./install.sh
source ~/.zshrc
```

## Available Commands

After installation, these commands are available from anywhere:

bash

```bash
fix-screen      # Fix screen sharing issues
restart-chrome  # Restart Chrome with crash protection
start-guardian  # Start Chrome crash monitor
stop-guardian   # Stop Chrome crash monitor
check-guardian  # Check guardian status and clean duplicates
update-discord  # Update Discord to latest version
```

## Updating Scripts

To get the latest version of scripts:

bash

```bash
cd ubuntu-scripts
git pull origin main
```

## How we use them

-   **Chrome Guardian**: Runs in background monitoring Chrome crashes and auto-restarts
-   **Screen Share Fix**: Essential for Zoom/Teams meetings when sharing stops working
-   **Discord Updater**: Keep Discord up to date without manual downloads
-   **Guardian Checker**: Prevent duplicate guardians from running

## Features

-   ✅ **Smart Installation** - Detects your shell (bash/zsh) and configures automatically
-   ✅ **Syntax Testing** - All scripts are tested before installation
-   ✅ **No Duplicates** - Guardian checker prevents multiple instances
-   ✅ **Verbose Logging** - Know exactly what's happening
-   ✅ **Safe Operations** - Won't close your apps unexpectedly

## Requirements

-   Ubuntu 22 LTS (primary target)
-   Works with bash or zsh
-   Some scripts require sudo for system operations

## Troubleshooting

-   If aliases don't work: `source ~/.zshrc` (or `~/.bashrc`)
-   If guardian isn't working: `check-guardian` to diagnose
-   If screen sharing fails: `fix-screen` and restart your meeting app
-   Check logs in the repo directory for detailed information

Works best on Ubuntu 22 LTS with Wayland. Your mileage may vary on other distros.