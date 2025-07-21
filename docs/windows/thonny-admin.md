# Installing Thonny

Here are some of the most common problems installing Thonny
on Windows computers.

## **Missing or Corrupted Installer**

**Description:**
Sometimes the Thonny installer file is not completely downloaded, becomes corrupted, or is flagged incorrectly by antivirus software.

**Solution:**

* Re-download the installer directly from the official website: [https://thonny.org](https://thonny.org)
* Make sure the file is not blocked by antivirus software or Windows Defender.
* Right-click the installer, select “Properties,” and check for a message at the bottom saying “This file came from another computer…” and click “Unblock” if present.
* Run the installer as an administrator.

---

## **Insufficient Permissions**

**Description:**
Thonny may fail to install or run properly if the user account lacks administrative privileges, especially when trying to write to system directories.

**Solution:**

* Right-click the installer and select **"Run as administrator."**
* If you're in a managed environment (e.g., school or work PC), contact your IT admin for permissions or install in your local user directory.

---

## **Thonny Not Launching After Installation**

**Description:**
After a successful installation, Thonny may not start due to misconfigured environments or missing dependencies.

**Solution:**

* Try launching Thonny from the command line (`cmd`) with:

  ```sh
  "C:\Program Files (x86)\Thonny\thonny.exe"
  ```
* If it doesn't open, reinstall Thonny with the **"Just for me"** option instead of **"All users"**.
* Check your antivirus logs to see if it's blocking Thonny.

---

## **Python Not Found or Wrong Version**

**Description:**
Although Thonny includes its own Python interpreter, some installations can conflict with system-installed Python, especially if PATH is misconfigured.

**Solution:**

* Use the bundled version of Thonny that includes Python (recommended).
* Avoid modifying the PATH manually unless you're managing multiple Python versions.
* Check the `Tools → Options → Interpreter` setting in Thonny to verify which interpreter is being used.

---

## **Serial Port Not Found (for MicroPython/PyBoard)**

**Description:**
When trying to use Thonny with a microcontroller like Raspberry Pi Pico or ESP32, the serial port may not appear.

**Solution:**

* Install the correct USB drivers (e.g., [CH340](https://sparks.gogo.co.nz/ch340.html) or [CP210x](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers)).
* Try a different USB cable (many are power-only).
* Restart the computer after driver installation.
* Use **Device Manager** to check if the device is recognized and assigned a COM port.

---

## **Thonny Crashes or Freezes**

**Description:**
Thonny can crash or become unresponsive due to plugin issues, corrupted user settings, or insufficient memory on older machines.

**Solution:**

* Reset Thonny’s configuration:
  Run the following command in a terminal:

  ```sh
  thonny --reset
  ```
* Alternatively, delete or rename the Thonny configuration folder:
  `C:\Users\<YourName>\AppData\Roaming\Thonny`
* Update Thonny to the latest version, or try installing a previous stable version.

---

## **Thonny Plugin Installation Fails**

**Description:**
When trying to install additional packages or plugins via Thonny’s `Tools → Manage Packages`, the installation may fail.

**Solution:**

* Ensure you're using the bundled Thonny Python interpreter.
* Use the **“Simple”** interface when prompted for installation options.
* If needed, install the package manually in the command line using:

  ```sh
  C:\Users\<YourName>\AppData\Local\Programs\Thonny\python.exe -m pip install <package-name>
  ```

---

## **Windows Defender SmartScreen Blocking Thonny**

**Description:**
The SmartScreen filter may prevent Thonny from running by showing a warning message.

**Solution:**

* Click **"More info"** and then **"Run anyway."**
* Consider whitelisting Thonny in your security software if this becomes recurring.

---

Would you like this in PDF format or integrated into an install guide?
