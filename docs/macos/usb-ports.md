# USB Port Administration on MacOS

#### Mac System Profiler

On MacOS we can use the ```system_profiler``` command:


```sh
system_profiler SPUSBDataType

USB:

    USB 3.1 Bus:

      Host Controller Driver: AppleT8112USBXHCI

    USB 3.1 Bus:

      Host Controller Driver: AppleT8112USBXHCI

        Board in FS mode:

          Product ID: 0x0005
          Vendor ID: 0x2e8a
          Version: 1.00
          Serial Number: e66141040396962a
          Speed: Up to 12 Mb/s
          Manufacturer: MicroPython
          Location ID: 0x00100000 / 1
          Current Available (mA): 500
          Current Required (mA): 250
          Extra Operating Current (mA): 0

```

Note that you can see both the Product ID, Vendor ID Manufacturer (MicroPython) and the mode (File System mode) that the device was connected.  The current available and current required are also listed, although these numbers might be somewhat conservative.  They are used for the estimation of current only.