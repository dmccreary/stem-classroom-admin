# Thonny Admin

Here are steps to configure Thonny on the Chromebook.  Note that you
must have the Chromebook to first be in [Developer Mode](developer-mode.md).

Due to security concerns, there is NO automatic way to allow a non-standard USB device
to be connected.  You MUST got to the Chromebook Setting and enable the USB device each time you plug
any non-standard USB devices into the USB port.

## Setup Process

### Step 1: Enable Linux Development Environment

[Go to the Setting up ChromeOS in Developer Mode](setting-up-developer-mode.md)

### Step 2: Thonny Installation

Instead of using `apt install thonny` (which often installs older versions of Thonny), the best practices is to use the official installer
that runs under pip directly from the Thonny website.

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


## Step-by-Step: Create a Thonny Launcher on ChromeOS

### 1. **Create a `.desktop` file**

Run this command in your Linux terminal:

```bash
nano ~/.local/share/applications/thonny.desktop
```

### 2. **Paste the following contents** (adjusting username if needed):

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Thonny
GenericName=Python IDE
Comment=Thonny IDE for MicroPython and Python development
Exec=env TK_USE_PLATFORM_MENUBAR=0 /home/urocdeveloper01/thonny-venv/bin/thonny
Icon=python3
Terminal=false
Categories=Development;Education;IDE;
StartupNotify=true
```

> Replace `/home/urocdeveloper01/` with the correct path if your username is different. You can check your username with `whoami`.

### 💾 3. **Save and exit** the editor:

* Press `Ctrl+O` to save
* Press `Enter` to confirm the file name
* Press `Ctrl+X` to exit Nano

### 4. **(Optional) Add a custom icon**

If you want a real Thonny icon:

```bash
mkdir -p ~/.local/share/icons
wget https://en.wikipedia.org/wiki/Thonny#/media/File:Thonny_logo.png -O ~/.local/share/icons/thonny.png
```

Then change the `Icon=` line in the `.desktop` file:

```ini
Icon=/home/urocdeveloper01/.local/share/icons/thonny.png
```

### 5. **Refresh the launcher**

Now restart your Linux container or run:

```bash
update-desktop-database ~/.local/share/applications
```

Then:

* Open your ChromeOS launcher
* Scroll down to **“Linux apps”**
* You should now see **Thonny** with a Python icon!

You can right-click it and pin it to the shelf for even faster access.
