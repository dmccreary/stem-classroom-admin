# Step by Step Guide for Setting Up Developer Mode

## How to Put a Chromebook into Developer Mode: Step-by-Step Guide

> ⚠️ **Warning:** Enabling Developer Mode will wipe all local data, including files, apps, and settings. Be sure to back up anything important before you begin.

## ✅ Step 0: Prepare

* **Backup your data** (Google Drive, USB stick, or external hard drive).
* Make sure your **Chromebook is charged or plugged in**.
* Know that Developer Mode **disables verified boot**, so you’ll see a scary screen every time you start up — this is expected.

## 🧑‍💻 Step 1: Enter Recovery Mode

1. Turn off your Chromebook.
2. Press and hold these keys simultaneously:

   * **Esc** + **Refresh (🔁)**, then press the **Power** button.
3. Release all keys when you see a **white screen with a yellow exclamation mark** or a message like "Chrome OS is missing or damaged."

## ⚙️ Step 2: Enable Developer Mode

1. On the recovery screen, press **Ctrl + D**.
2. You will be prompted:
   “To turn OS verification OFF, press ENTER.”
3. Press **Enter**.

## 🧹 Step 3: Wait for Powerwash (Device Reset)

* The system will reboot and begin the **transition to Developer Mode**.
* This takes **5 to 10 minutes**. You’ll see a screen that says:

  > "Preparing system for Developer Mode. This may take a while."

This process **erases all local data** (Powerwash), and once complete, the device will reboot again.

## ⚠️ Step 4: Startup Behavior in Developer Mode

Every time you boot, you’ll see a **“OS verification is OFF”** screen.

* To continue booting: press **Ctrl + D** or wait 30 seconds.
* To go back to normal mode: press **Spacebar**, then confirm.

## 🛠️ Step 5: Access the Linux Shell (Crosh and Bash)

1. Once booted, sign into Wi-Fi.
2. Press **Ctrl + Alt + T** to open **Crosh** (Chrome Shell).
3. Type `shell` and press Enter.
4. Now you are in a full Bash shell and can run commands like `sudo`, install dev tools, or run scripts.

## 🧯 Optional: Disable Root File System Verification

If you're doing root-level development:

```bash
sudo su
/usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification
```

Then reboot.

## 🔄 To Exit Developer Mode (Re-enable Verified Boot)

1. Reboot your Chromebook.
2. On the "OS verification is OFF" screen, press **Spacebar**.
3. Confirm when prompted — this will **Powerwash again** and return to normal mode.

## ✅ Developer Mode Enabled!

You’re now ready to:

* Install custom Linux distros
* Sideload APKs (on supported Chromebooks)
* Access full root shell
* Modify system files and services

## References

[YouTube Video Showing Steps to Put Chromebook into Developer Mode](https://youtu.be/q9PQDSwHPOI?si=epNp1VQfaP6SBy84)
