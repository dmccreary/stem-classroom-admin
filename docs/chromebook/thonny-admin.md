# Thonny Admin

Based on your situation without Education Upgrade, here are streamlined steps to configure each Chromebook more efficiently:

## Faster Setup Process

### Step 1: Enable Linux Development Environment
1. Open **Settings** (click time, then gear icon)
2. Scroll to **About ChromeOS** → **Developers**
3. Click **Set up** next to "Linux development environment"
4. Follow prompts (allocate at least 10GB disk space)
5. Wait for installation (5-10 minutes)

### Step 2: Efficient Thonny Installation
Instead of using `apt install thonny` (which gives older versions), use the official installer:

```bash
# Update system first
sudo apt update

# Install latest Thonny with Python bundle
bash <(wget -O - https://thonny.org/installer-for-linux)
```

This method installs the current version (3.3.10+) rather than the outdated Debian package version, avoiding compatibility issues.

### Step 3: Configure USB Access
1. Go to **Settings** → **About ChromeOS** → **Developers** → **Linux development environment**
2. Click **Manage USB devices**
3. Connect your USB device (Arduino, Raspberry Pi Pico, etc.)
4. **Enable** the device in the list
5. Add user to dialout group: `sudo usermod -a -G dialout $USER`
6. **Restart** the Linux container (Settings → Developers → Linux → Advanced → Restart)

### Step 4: Create Desktop Launcher
Make Thonny easily accessible:

```bash
# Create desktop file for launcher
cat > ~/.local/share/applications/thonny.desktop << EOF
[Desktop Entry]
Name=Thonny
Comment=Python IDE for beginners
Exec=thonny %F
Icon=thonny
Terminal=false
Type=Application
Categories=Development;IDE;
MimeType=text/x-python;
EOF

# Make executable
chmod +x ~/.local/share/applications/thonny.desktop
```

## Time-Saving Tips

### Use Container Backup/Restore
After configuring one Chromebook completely, you can back up the Linux container and restore it to other devices:

**Create backup on first device:**
1. Open **Terminal**
2. Run: `vmc export termina`
3. This creates a backup file in Downloads folder
4. Copy this file to a USB drive

**Restore on other devices:**
1. Enable Linux development environment
2. Copy backup file to Downloads
3. Run: `vmc import termina [backup-filename]`
4. Restart Linux container

### Batch Script Approach
Create a setup script to automate the software installation:

```bash
#!/bin/bash
# Save as setup_thonny.sh

echo "Setting up Thonny development environment..."

# Update system
sudo apt update

# Install Thonny
bash <(wget -O - https://thonny.org/installer-for-linux)

# Add user to dialout group
sudo usermod -a -G dialout $USER

# Create desktop launcher
cat > ~/.local/share/applications/thonny.desktop << EOF
[Desktop Entry]
Name=Thonny
Comment=Python IDE for beginners
Exec=thonny %F
Icon=thonny
Terminal=false
Type=Application
Categories=Development;IDE;
MimeType=text/x-python;
EOF

chmod +x ~/.local/share/applications/thonny.desktop

echo "Setup complete! Please restart Linux container and connect USB devices."
echo "Go to Settings > Developers > Linux > Manage USB devices to enable your hardware."
```

Run with: `bash setup_thonny.sh`

## Guest Account Limitations

**Important consideration:** If Chromebooks are managed by your school, Linux development environment might be disabled for guest accounts. You may need to:

- Use individual student accounts instead of guest accounts
- Check with your IT department about Linux policies
- Consider using web-based Python IDEs as an alternative

This approach should reduce your setup time from several hours to about 15-20 minutes per device, especially if you use the container backup/restore method after setting up the first one.