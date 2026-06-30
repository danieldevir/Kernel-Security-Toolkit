#!/bin/bash
# setup_env.sh – Install required tools for kernel analysis

echo "🔧 Installing required tools for kernel analysis..."

# Detect OS and install packages
if [ -f /etc/debian_version ]; then
    echo "📦 Debian/Ubuntu detected. Installing packages..."
    sudo apt update
    sudo apt install -y build-essential git grep findutils coccinelle vim nano curl wget
elif [ -n "$(command -v termux-info)" ]; then
    echo "📱 Termux detected. Installing packages..."
    pkg update
    pkg install -y build-essential git grep findutils coccinelle vim nano curl wget
else
    echo "⚠️ Unknown OS. Please install the following tools manually:"
    echo "  - build-essential (gcc, make, etc.)"
    echo "  - git"
    echo "  - grep, findutils"
    echo "  - coccinelle"
    echo "  - vim or nano"
fi

echo "✅ All tools installed successfully!"
