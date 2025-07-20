#!/bin/bash
# This script installs Thonny and creates a desktop launcher icon for Chromebooks ChromeOS Linux (Crostini)
# Note that ChromeOS Linix must be installed
# Only tested on ChromOS running developer mode
# Script location: https://github.com/dmccreary/stem-classroom-admin/tree/main/tools
# To manuall install this run the following commands
#   wget -O ~/bin/install-thonny-on-chromeos.sh https://raw.githubusercontent.com/dmccreary/stem-classroom-admin/refs/heads/main/tools/install-thonny-on-chromeos.sh
#   chmod +x ~/bin/install-thonny-on-chromeos.sh

set -e  # Exit on error

echo "🔧 Starting Thonny installation script for ChomeOS Developer mode..."

# Define variables
INSTALL_DIR="$HOME/thonny-venv"
BIN_DIR="$HOME/bin"
DESKTOP_FILE="$HOME/.local/share/applications/thonny.desktop"
ICON_DIR="$HOME/.local/share/icons"
ICON_FILE="$ICON_DIR/thonny.png"
THONNY_EXEC="$INSTALL_DIR/bin/thonny"
SCRIPT_URL="https://raw.githubusercontent.com/dmccreary/stem-classroom-admin/main/tools/install-thonny-on-chromeos.sh"
SCRIPT_PATH="$BIN_DIR/install-thonny.sh"

# Ensure ~/bin exists and is on PATH

# create the ~/bin dir if it does not already exist
mkdir -p "$BIN_DIR"

# will this work if ~/bin is in the path?  Not sure.
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo "export PATH=\"\$HOME/bin:\$PATH\"" >> "$HOME/.bashrc"
  export PATH="$BIN_DIR:$PATH"
fi

# Save this install script to ~/bin
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "📥 Downloading install script to $SCRIPT_PATH"
  wget -qO "$SCRIPT_PATH" "$SCRIPT_URL"
  chmod +x "$SCRIPT_PATH"
else
  echo "✅ Install script already exists at $SCRIPT_PATH"
fi

# Update system packages and install dependencies
# note you must be able to run sudo to run these commands
echo "📦 Installing required packages..."
sudo apt update
sudo apt install -y python3-pip python3-venv python3-tk python3-dev desktop-file-utils wget

# Create virtual environment and install Thonny
if [ ! -d "$INSTALL_DIR" ]; then
  echo "🐍 Creating virtual environment for Thonny..."
  python3 -m venv "$INSTALL_DIR"
  source "$INSTALL_DIR/bin/activate"
  pip install --upgrade pip
  pip install thonny
  deactivate
  echo "✅ Thonny installed in virtual environment at $INSTALL_DIR"
else
  echo "🔁 Thonny environment already exists at $INSTALL_DIR"
fi

# Download Thonny icon
echo "🖼️ Setting up icon..."
mkdir -p "$ICON_DIR"
if [ ! -f "$ICON_FILE" ]; then
  wget -qO "$ICON_FILE" "https://github.com/thonny/thonny/blob/213f365128046893b72c092692fddeaa4a626af1/thonny/res/thonny.png"
  echo "✅ Icon downloaded to $ICON_FILE"
else
  echo "🔁 Icon already exists at $ICON_FILE"
fi

# Create .desktop launcher
echo "🧷 Creating desktop launcher..."
mkdir -p "$(dirname "$DESKTOP_FILE")"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Thonny
GenericName=Python IDE
Comment=Thonny IDE for MicroPython and Python development
Exec=env TK_USE_PLATFORM_MENUBAR=0 $THONNY_EXEC
Icon=$ICON_FILE
Terminal=false
Categories=Development;Education;IDE;
StartupNotify=true
X-GNOME-Autostart-enabled=false
EOF

chmod +x "$DESKTOP_FILE"
echo "✅ Desktop file created at $DESKTOP_FILE"

# Refresh desktop entries
echo "🔃 Updating desktop database..."
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$HOME/.local/share/applications" || true
else
  echo "⚠️  update-desktop-database not found. You may need to install desktop-file-utils."
fi

echo "🎉 Thonny installation complete!"
echo "👉 You can now launch Thonny from the Linux Apps menu."
