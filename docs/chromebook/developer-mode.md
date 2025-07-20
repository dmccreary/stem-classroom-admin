# Developer Mode on ChromeOS

**Standard mode and developer mode represent fundamentally different approaches to ChromeOS security and functionality, with developer mode offering expanded hardware access and system control at the cost of built-in security protections.**

## Standard Mode (Normal ChromeOS)

**Standard mode prioritizes security through strict system lockdown:**

### Security Features
- **Verified boot** - System integrity checked at every startup
- **Read-only root filesystem** - Core system files cannot be modified
- **Sandboxed applications** - All apps run in isolated containers
- **Automatic updates** - Security patches applied transparently
- **No root access** - Users cannot access system-level functions

### Hardware Limitations
- **Restricted USB access** - Only approved device types can connect
- **Limited terminal access** - Crosh terminal with basic commands only
- **Container-based Linux** - Crostini runs in isolated environment
- **Policy enforcement** - Administrator restrictions cannot be bypassed

### Your Current Situation
- Jump drive appears in Files but not accessible to Linux container
- `lsusb` shows no devices despite physical connections
- Chrome flags may be disabled by administrative policy
- USB sharing controlled by enterprise/education restrictions

## Developer Mode Capabilities

**Developer mode removes security restrictions to enable development and system modification:**

### Enhanced Access
- **Root shell access** - Full system control via VT-2 (Ctrl+Alt+F2)
- **Read-write filesystem** - Ability to modify system files
- **Custom firmware** - Can install alternative operating systems
- **Hardware debugging** - Direct access to system hardware
- **Unrestricted USB** - Full USB device access without policy restrictions

### Development Features
- **Native Linux installation** - Run full Linux distributions alongside ChromeOS
- **Kernel module loading** - Install custom drivers and system extensions
- **Cross-compilation** - Build software for different architectures
- **Hardware hacking** - Direct GPIO, SPI, I2C access on supported devices
- **Crouton support** - Install Ubuntu/Debian with chroot environments

### USB and Hardware Benefits
- **Bypass USB policies** - Administrative restrictions don't apply
- **Direct device access** - Hardware communicates without container isolation
- **Custom drivers** - Install specialized device drivers
- **Development tools** - Full access to debugging and development hardware

## Security Trade-offs and Risks

**Developer mode fundamentally compromises ChromeOS security model:**

### Removed Protections
- **No verified boot** - System integrity not enforced
- **Vulnerable to malware** - Root access enables system-level attacks
- **Physical security risk** - Anyone with device access can compromise system
- **Enterprise incompatibility** - Managed devices often prohibit developer mode

### Warning Implications
- **Persistent warning screen** - 30-second delay at every boot
- **Easy system wipe** - Pressing spacebar at warning erases everything
- **No enterprise support** - IT departments typically block or discourage use
- **Warranty considerations** - May affect support coverage

### Data Security Concerns
- **Encryption bypass** - Developer mode can access normally protected data
- **Network vulnerability** - Reduced protection against network-based attacks
- **Physical access risk** - Device compromise possible with brief physical access

## Enabling Developer Mode Process

**⚠️ WARNING: This process completely erases your Chromebook and voids enterprise management!**

### Prerequisites
- **Personal device ownership** - Must not be enterprise/education managed
- **Data backup** - Everything will be erased during transition
- **Time availability** - Process takes 30-60 minutes to complete
- **Understanding of risks** - Security implications must be accepted

### Step-by-Step Process
1. **Create recovery media** - Download ChromeOS recovery image first
2. **Enter recovery mode** - Hold Esc+Refresh, press Power button
3. **Enable developer mode** - Press Ctrl+D at recovery screen
4. **Confirm transition** - Press Enter to begin (erases everything)
5. **Wait for completion** - Process takes 15-30 minutes
6. **Configure system** - Set up ChromeOS without enterprise enrollment

### Post-Installation Setup
- **Skip enterprise enrollment** - Don't connect to managed networks initially
- **Enable developer features** - Access requires additional configuration
- **Install development tools** - Crouton, Linux distributions, development environments

## Would Developer Mode Solve Your USB Problem?

**Yes, developer mode would likely resolve your Raspberry Pi Pico connectivity issues:**

### Direct Benefits
- **Bypass USB policies** - Administrative restrictions no longer apply
- **Native hardware access** - USB devices connect without container limitations
- **Custom driver installation** - Install specialized USB/serial drivers if needed
- **Alternative development environments** - Use Crouton or native Linux for programming

### Alternative Solutions to Consider First
**Before enabling developer mode, try these safer approaches:**

1. **Request IT approval** - Ask for Raspberry Pi Pico USB ID (2e8a:0005) allowlisting
2. **Use personal device** - Borrow/use unmanaged Chromebook if available
3. **Web-based development** - Online MicroPython IDEs like BIPES
4. **Network programming** - Use Pico W with WiFi instead of USB

## Recommendation for Your Situation

**If this is a personal Chromebook:** Developer mode would solve your USB connectivity issues but consider the security trade-offs carefully.

**If this is a managed device:** Contact your IT department first - enabling developer mode may violate policies and could result in device confiscation or disciplinary action.

**Alternative consideration:** Many educational institutions have specific policies about developer mode. Check your acceptable use policy before proceeding.

The decision ultimately depends on your specific needs, device ownership status, and comfort with the security implications. Developer mode is powerful but comes with significant responsibilities.

## Single User Develper Mode

!!! prompt
    Can I put a single user into developer mode under Linux?

**No, you cannot put a single user into "developer mode" because developer mode is a system-wide ChromeOS setting that affects the entire Chromebook, not individual users or the Linux container.**

## Understanding the Distinction

### ChromeOS Developer Mode vs Linux User Permissions

**Developer mode operates at the ChromeOS firmware/hardware level:**
- Affects the entire Chromebook device
- Changes how the system boots and enforces security
- Cannot be enabled for individual users
- Requires physical access to the device and complete system wipe

**Linux user permissions operate within the container:**
- Affect only what users can do inside the Linux environment
- Can be modified per-user within the existing system
- Don't change ChromeOS hardware access policies
- Won't solve USB sharing restrictions from ChromeOS to Linux

## What You CAN Do Within the Linux Container

### Elevate User Privileges
```bash
# Add your user to sudo group (if not already)
sudo usermod -a -G sudo $USER

# Add to additional groups for hardware access
sudo usermod -a -G dialout,plugdev,audio,video $USER

# Log out and back in for changes to take effect
```

### Install Development Tools
```bash
# Install development packages
sudo apt update
sudo apt install build-essential git python3-dev nodejs npm

# Install USB/serial utilities
sudo apt install minicom screen picocom setserial

# Install clipboard tools
sudo apt install xclip wl-clipboard
```

### Configure USB Device Rules
```bash
# Create udev rules for your specific hardware
sudo nano /etc/udev/rules.d/99-raspberry-pi-pico.rules

# Add content:
SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0005", MODE="0666", GROUP="dialout"

# Reload rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Why This Won't Solve Your USB Problem

### The Real Issue: ChromeOS to Linux USB Sharing
Your problem exists at the **ChromeOS system level**, not within Linux:

1. **ChromeOS** can see your USB devices (jump drive appears in Files)
2. **ChromeOS policy** prevents sharing these devices with Linux container
3. **Linux container** never receives USB device access from ChromeOS
4. **Linux user permissions** are irrelevant if devices never reach Linux

### The USB Access Chain
```
Hardware → ChromeOS → USB Sharing Policy → Linux Container → User Permissions
                          ↑
                    Your bottleneck is here
```

No amount of Linux user configuration can bypass ChromeOS USB sharing restrictions.

## Alternative Approaches Within Current Constraints

### Web-Based Development
**Use browser-based MicroPython IDEs:**
- **BIPES** (https://bipes.net.br/) - Full web-based MicroPython environment
- **Online Python editors** with MicroPython simulators
- **Tinkercad Circuits** for electronics simulation

### Network-Based Programming
**If you have a Raspberry Pi Pico W (WiFi version):**
```python
# Configure Pico W for WiFi development
import network
import socket

wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect('your_wifi', 'password')

# Create web-based programming interface
# Upload code via web interface instead of USB
```

### Hybrid Development Approach
```bash
# Develop and test code in Linux container
nano my_pico_code.py

# Use web tools to transfer code to Pico
# Copy/paste through browser-based editors
```

### Request Hardware Alternatives
**Ask your institution for:**
- USB devices that are already allowlisted
- Raspberry Pi with network connectivity
- Development boards with browser-based programming
- Simulators that don't require physical hardware

## What About sudo Access?

### You Likely Already Have It
```bash
# Check if you have sudo access
sudo -l

# If you get output showing permissions, you already have developer-level access within Linux
```

### Verify Your Current Permissions
```bash
# Check your groups
groups

# Check USB device access (even though devices aren't shared)
ls -la /dev/ttyACM* /dev/ttyUSB*

# Check if you can install packages
sudo apt update
```

## The Bottom Line

**The limitation you're facing is administrative/policy-based, not technical or user permission-based.** Even with full root access within the Linux container, you cannot bypass ChromeOS USB sharing policies that prevent devices from reaching the container in the first place.

**Your options are:**
1. **Request IT approval** for USB device access
2. **Use web-based development tools** that don't require USB
3. **Switch to a personal/unmanaged device** for development
4. **Enable ChromeOS developer mode** (if allowed and you accept security risks)

Linux user permissions alone cannot solve USB hardware access restrictions imposed by ChromeOS system policies.