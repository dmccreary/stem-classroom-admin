#!/bin/bash
# Script location: https://github.com/dmccreary/stem-classroom-admin/tree/main/tools
# To manuall install this run the following commands
#   wget -O ~/bin/install-thonny-on-chromeos.sh https://raw.githubusercontent.com/dmccreary/stem-classroom-admin/refs/heads/main/tools/install-thonny-on-chromeos.sh
#   chmod +x ~/bin/install-thonny-on-chromeos.sh

# Automatically install Thonny and create a launcher for ChromeOS Linux (Crostini)
# Safe for all usernames – uses $HOME and whoami dynamically

set -e  # Exit immediately if a command exits with a non-zero status

# Define variables
INSTALL_DIR="$HOME/thonny-venv"
BIN_DIR="$HOME/bin"
DESKTOP_FILE="$HOME/.local/share/applications/thonny.desktop"
ICON_DIR="$HOME/.local/share/icons"
ICON_FILE="$ICON_DIR/thonny.png"
THONNY_EXEC="$INSTALL_DIR/bin/thonny"

# Ensure ~/bin exists and is on PATH
mkdir -p "$BIN_DIR"
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo "export PATH=\"\$HOME/bin:\$PATH\"" >> "$HOME/.bashrc"
  export PATH="$HOME/bin:$PATH"
fi

# Save this install script to ~/bin
SCRIPT_PATH="$BIN_DIR/install-thonny-on-chromeos.sh"
if [ ! -f "$SCRIPT_PATH" ]; then
  wget -qO "$SCRIPT_PATH" https://raw.githubusercontent.com/dmccreary/stem-classroom-admin/main/tools/install-thonny-on-chromeos.sh
  chmod +x "$SCRIPT_PATH"
  echo "Install script saved to $SCRIPT_PATH"
fi

# Update packages and install pip
sudo apt update && sudo apt install -y python3-pip python3-venv python3-tk python3-dev

# Create virtual environment and install Thonny
if [ ! -d "$INSTALL_DIR" ]; then
  python3 -m venv "$INSTALL_DIR"
  source "$INSTALL_DIR/bin/activate"
  pip install --upgrade pip
  pip install thonny
  deactivate
  echo "Thonny installed in virtual environment at $INSTALL_DIR"
else
  echo "Thonny virtual environment already exists at $INSTALL_DIR"
fi

# Download icon
mkdir -p "$ICON_DIR"
wget -qO "$ICON_FILE" "https://upload.wikimedia.org/wikipedia/commons/f/f9/Thonny_logo.png"

# Create .desktop launcher
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
EOF

echo "Desktop launcher created at $DESKTOP_FILE"

# Optionally refresh desktop database
update-desktop-database ~/.local/share/applications || true

echo "✅ Thonny installation complete. You can now launch it from the Linux Apps menu."
