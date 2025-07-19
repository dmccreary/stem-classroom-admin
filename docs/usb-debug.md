# Raspberry Pi Pico USB Issues on ChromeOS Crostini: Complete Troubleshooting Guide

**The "MicroPython board in FS Mode" showing in lsusb after disconnection indicates a USB device caching issue in ChromeOS/Crostini, not a hardware problem with the Pico.** This comprehensive guide provides systematic solutions to restore proper USB connectivity for your Raspberry Pi Pico and Thonny IDE on ChromeOS Linux containers.

## Understanding the core issue

**Critical insight**: "MicroPython board in FS Mode" is the normal, expected state when MicroPython firmware is running properly on your Pico. The problem isn't a "stuck" Pico, but rather ChromeOS/Crostini's USB subsystem not properly detecting the disconnection. This creates phantom device entries that prevent new connections from working correctly.

**Device identification**: Your Pico appears with USB ID `2E8A:0005` in MicroPython mode and shows as a serial device at `/dev/ttyACM0`. The persistent lsusb listing suggests the Crostini container hasn't updated its USB device cache after disconnection.

## Immediate diagnostic steps

Start with these commands to assess the current state:

```bash
# Check current USB device status
lsusb | grep -E "(MicroPython|2e8a)"
ls -la /dev/ttyACM* 2>/dev/null
dmesg | grep -i usb | tail -10

# Monitor for real disconnection events  
dmesg -w | grep -i usb &
# Now physically disconnect/reconnect the Pico and observe output
```

If dmesg shows no disconnect events when unplugging, the issue is confirmed as container-level USB caching.

## Step-by-step resolution procedures

### Method 1: Container restart (recommended first attempt)

ChromeOS Crostini uses a layered architecture where USB devices are forwarded from the host through the Termina VM to your Penguin container. Restarting the container often clears cached USB device state.

```bash
# From ChromeOS: Right-click Terminal icon in shelf → "Shut down Linux"
# Wait 30 seconds, then reopen Terminal
# Verify device cache is cleared:
lsusb | grep -E "(MicroPython|2e8a)"
```

**Alternative container restart via crosh**:
```bash
# Press Ctrl+Alt+T to open crosh terminal
crosh> vmc stop termina
crosh> vmc start termina
# Exit crosh and restart Terminal
```

### Method 2: USB subsystem reset within container

If container restart doesn't resolve the issue, force a USB subsystem refresh:

```bash
# Reset USB device enumeration
sudo systemctl restart systemd-udevd

# Reload and trigger udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=usb

# Clear any cached device listings
sudo modprobe -r usbserial
sudo modprobe usbserial
```

### Method 3: ChromeOS USB device management

ChromeOS requires explicit USB device sharing with Linux containers. Reset the sharing configuration:

1. Navigate to: **ChromeOS Settings → Advanced → Developers → Linux development environment → Manage USB devices**
2. If "Board in FS Mode" or similar Pico device is listed, toggle it OFF then ON
3. If no Pico device appears, physically reconnect while holding BOOTSEL button
4. The Pico should appear as "RPI-RP2" drive first, then as "MicroPython board" after releasing BOOTSEL

**Enable advanced USB support via Chrome flags**:
```
chrome://flags/#crostini-usb-allow-unsupported
```
Set to "Enabled" and restart Chrome.

### Method 4: Complete VM restart

For persistent issues, restart the entire Termina VM:

```bash
# In crosh (Ctrl+Alt+T):
crosh> vmc list              # Verify termina is running  
crosh> vmc stop termina
crosh> vmc start termina --enable-audio-capture
```

This performs a complete reset of the USB forwarding layer between ChromeOS and your container.

## Thonny IDE connectivity restoration

Once USB device caching is resolved, configure Thonny for reliable Pico connectivity:

### Install Thonny correctly on ChromeOS

```bash
# Update system and install dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install python3-tk python3-pip wget curl -y

# Install Thonny using official installer (recommended)
bash <(wget -O - https://thonny.org/installer-for-linux)

# Installation path: ~/apps/thonny/bin/thonny
```

### Configure serial port permissions

```bash
# Add user to dialout group for serial access
sudo usermod -a -G dialout $USER
sudo usermod -a -G plugdev $USER

# Remove brltty conflicts (common on Ubuntu 22.04+)
sudo apt purge brltty -y

# Reboot to apply group changes
sudo reboot
```

### Set up Thonny interpreter

1. Launch Thonny: `~/apps/thonny/bin/thonny`
2. Go to **Run → Select interpreter**
3. Choose **MicroPython (Raspberry Pi Pico)** or **MicroPython (generic)**
4. If using generic, manually select port: `/dev/ttyACM0`
5. Test connection:
```python
print("Hello from Pico!")
help()
```

## Advanced troubleshooting for persistent issues

### Fix udev rules and permissions

Create comprehensive USB permission rules:

```bash
# Create universal USB permissions rule
sudo tee /etc/udev/rules.d/99-pico-permissions.rules << 'EOF'
# Raspberry Pi Pico permissions
KERNEL=="ttyACM[0-9]*", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0005", MODE="0666", GROUP="dialout"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0005", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666", GROUP="plugdev"
EOF

# Apply rules immediately
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### Hardware-level Pico reset procedures

If the Pico appears genuinely unresponsive (rare), perform a hardware reset:

**Method 1 - BOOTSEL reset**:
1. Hold BOOTSEL button on Pico
2. Connect USB cable (or press/release reset button if available)
3. Release BOOTSEL button
4. Pico appears as "RPI-RP2" drive
5. Install fresh MicroPython firmware from https://micropython.org/download/rp2-pico/

**Method 2 - Software reset from MicroPython**:
```python
# In Thonny or Python REPL:
import machine
machine.bootloader()  # Forces Pico into BOOTSEL mode
```

### Comprehensive system verification

Create a verification script to check all components:

```bash
#!/bin/bash
echo "=== ChromeOS Crostini Pico Diagnostics ==="
echo "USB devices:"
lsusb | grep -E "(2e8a|MicroPython)" || echo "No Pico devices found"

echo -e "\nSerial devices:"
ls -la /dev/ttyACM* 2>/dev/null || echo "No ACM devices"

echo -e "\nUser groups:"
groups $USER | grep -E "(dialout|plugdev)" || echo "Missing required groups"

echo -e "\nCrOS USB sharing status:"
ls -la /mnt/chromeos/removable/ | grep -i pico || echo "No shared devices"

echo -e "\nRecent USB events:"
dmesg | grep -i usb | tail -5

echo -e "\nThonny installation:"
test -f ~/apps/thonny/bin/thonny && echo "Thonny installed correctly" || echo "Thonny not found"
```

## Prevention and monitoring

### Set up USB monitoring

Monitor USB events to catch future issues early:

```bash
# Real-time USB event monitoring
udevadm monitor --subsystem-match=usb &
dmesg -w | grep -i usb &
```

### Disable problematic power management

USB autosuspend can cause connectivity issues:

```bash
# Disable autosuspend for Pico devices
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTR{power/autosuspend}="-1"' | sudo tee -a /etc/udev/rules.d/50-usb-autosuspend.rules

sudo udevadm control --reload-rules
sudo udevadm trigger
```

## When all else fails

### Alternative development approaches

**Web-based development**: If USB continues to fail, use web-based MicroPython IDEs:
- BIPES (https://bipes.net.br/) - Full web-based MicroPython IDE
- BeagleTerm Chrome extension for REPL access

**Network-based solutions**: Configure MicroPython for WiFi connectivity (Pico W) and use network-based development tools.

### Enterprise/school Chromebook considerations

Managed ChromeOS devices may have USB restrictions:
- Contact IT administrator to whitelist Raspberry Pi Pico devices
- Request addition of USB ID `2e8a:0005` to approved device list
- Alternative: Use web-based development tools that don't require USB access

## Resolution verification checklist

After implementing fixes, verify resolution:

- [ ] `lsusb` shows correct USB device state when connected/disconnected
- [ ] `/dev/ttyACM0` appears when Pico is connected, disappears when unplugged
- [ ] dmesg shows proper connect/disconnect events
- [ ] Thonny can connect to Pico and access REPL
- [ ] User is member of dialout and plugdev groups
- [ ] ChromeOS USB sharing is properly configured
- [ ] No phantom devices persist after physical disconnection

**Success indicators**: When working correctly, connecting your Pico should show connection messages in dmesg, create `/dev/ttyACM0`, and allow Thonny to immediately detect and connect to the device. Disconnection should remove the device from `/dev/` and clear it from active USB listings.

The root cause of "MicroPython board in FS Mode" persisting in lsusb output is ChromeOS/Crostini USB device caching, not a hardware problem with your Pico. Following this systematic troubleshooting approach should restore proper USB connectivity for your development workflow.
