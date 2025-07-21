# Generating Customized Images for the Raspberry Pi

The best tool for generating images for a Raspberry Pi is 
a tool called [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

Setting up Raspberry Pi systems for educational environments requires reliable, efficient tools for creating and deploying customized operating system images. This chapter explores the essential software tools, storage options, and best practices for generating and deploying Raspberry Pi images in STEM classroom environments.

## Raspberry Pi Imager: The Official Solution

### Overview and Features

Raspberry Pi Imager is the quick and easy way to install Raspberry Pi OS and other operating systems to a microSD card, ready to use with your Raspberry Pi. This official tool has evolved significantly since its introduction and now offers comprehensive customization options perfect for classroom deployment.

Raspberry Pi Imager 1.9.4 has been released as the latest stable version, bringing various UI improvements, new translations, and bug fixes. The current version includes several features that make it particularly valuable for educational environments:

**Advanced OS Customization**: The OS customisation menu lets you set up your Raspberry Pi before first boot. You can preconfigure hostname, username and password, wireless LAN settings, locale settings, and SSH access.

**Multi-Platform Support**: The imager runs on Windows, macOS, and Linux, making it accessible regardless of your institution's preferred operating system. The minimum supported Ubuntu version for the DEB version is Ubuntu 22.04 LTS, but the AppImage build may run on older versions.

**Enhanced Security Features**: In the OS customisation settings there's an Enable SSH tab that now uses "regex to perform some light validation" of public keys to avoid boot failures.

### Installation and Setup

The Raspberry Pi Imager can be downloaded from the official Raspberry Pi website at https://www.raspberrypi.com/software/. The tool automatically detects your operating system and provides the appropriate download, though you can manually select versions for different platforms.

**Key Installation Points:**
- Windows versions support both 32-bit and 64-bit architectures
- macOS versions include both Intel and Apple Silicon support
- Linux users can choose between DEB packages and AppImage formats
- Wayland client support in the Raspberry Pi Imager AppImage build has been disabled for stability reasons

### Advanced Configuration Options

For classroom deployments, the advanced configuration features are particularly valuable:

**Network Pre-configuration**: If your network does not broadcast an SSID publicly, you should enable the "Hidden SSID" setting. By default, Imager uses the country you're currently in as the "Wireless LAN country".

**User Account Setup**: The username and password option defines the username and password of the admin user account on your Raspberry Pi, with Imager now defaulting to using the username of the logged-in user instead of 'pi'.

**SSH Configuration**: Choose Allow public-key authentication only to preconfigure your Raspberry Pi for passwordless public-key SSH authentication using a private key from the computer you're currently using.

## BalenaEtcher: Cross-Platform Alternative

### Why Consider BalenaEtcher?

BalenaEtcher (commonly referred to and formerly known as Etcher) is a free and open-source utility used for writing image files such as .iso and .img files, as well as zipped folders onto storage media to create live SD cards and USB flash drives.

While Raspberry Pi Imager is the official tool, BalenaEtcher offers several advantages in certain scenarios:

**Broader Format Support**: The possibilities balenaEtcher offers are enormous and it supports the following formats: ISO, IMG, ZIP, DMG, DSK, RAW, XZ, BZ2, HDDIMG, GZ, and ETCH.

**Cross-Platform Consistency**: BalenaEtcher is a great cross-platform solution that can be downloaded on Windows, macOS, and Linux. It is especially helpful if you regularly switch between operating systems and need a tool that supports various environments.

**Enhanced Safety Features**: BalenaEtcher prioritizes the safety and security of users' data and devices. It prevents accidental flashing of important storage devices like internal hard drives or system partitions.

### Installation and Usage

BalenaEtcher can be downloaded from https://etcher.balena.io/. The installation process is straightforward across all platforms:

**System Requirements:**
- Etcher works on Microsoft Windows 10 and later, Linux (most distros) and macOS 10.10 (Yosemite) and later
- For Windows 7, 8 or 32 bits, the latest compatible version of Etcher is v7.9.0

**Key Features for Educational Use:**
- Balena Etcher incorporates a built-in image validation feature. During the flashing process, the tool checks the integrity and authenticity of the selected OS image
- Smart Device Selection: Balena Etcher simplifies the process of choosing the correct target device for flashing
- Live Feedback and Progress Monitoring: Balena Etcher provides live feedback during the flashing process, keeping users informed of the progress

### Recent Updates and Privacy

As of 2025-05-07, balenaEtcher has removed analytics features, focusing on privacy improvements. This makes it even more suitable for educational environments where data privacy is a concern.

## MicroSD Cards: Benefits, Limitations, and Reliability

### Benefits of MicroSD Cards

MicroSD cards have been the traditional storage solution for Raspberry Pi devices since the beginning. They offer several advantages for educational deployments:

**Accessibility and Cost**: MicroSD cards are widely available and relatively inexpensive, making them ideal for large classroom deployments where budget constraints are important.

**Portability**: The small form factor makes it easy to swap between different Pi units or create backup copies of working configurations.

**Simplicity**: All Raspberry Pi consumer models since the Raspberry Pi 1 Model A+ feature a microSD slot. Your Raspberry Pi automatically boots from the microSD slot when the slot contains a card.

### Limitations and Reliability Concerns

However, MicroSD cards come with significant limitations that educators should understand:

**Performance Limitations**: SD cards are inherently slower compared to other storage options like USB drives or solid-state drives (SSDs). As the Raspberry Pi writes and deletes data on the SD card over time, the performance may degrade.

**Durability Issues**: In applications where the Raspberry Pi writes data frequently, such as logging or databases, the constant read/write operations can significantly shorten the lifespan of the SD card.

**Corruption Risks**: SD cards are prone to corruption, especially in scenarios where the Raspberry Pi experiences sudden power loss or improper shutdowns. Users report frequent issues such as data corruption and unexpected failures, particularly when cards are subjected to the constant read-write cycles typical in SBC applications.

**Capacity Constraints**: SD cards typically offer limited storage capacity compared to alternative storage solutions like USB drives or SSDs.

### Performance Expectations

Understanding realistic performance expectations helps in project planning:

**Basic Performance**: In practice, you'll get about 100MB/s out of an SD card in a Pi

**Raspberry Pi 5 Improvements**: The SD card interface on the Pi5 has doubled in speed over the Pi 4 so that is a pretty good improvement

### Best Practices for MicroSD Reliability

To maximize MicroSD card reliability in classroom environments:

**Choose Quality Cards**: Cards that are "A" rated are compliant with the SD Association Application Performance Class standard and are optimized for running applications as well as storing data.

**Proper Power Supply**: The Raspberry Pi also needs a very good USB power supply, especially the Pi 3 and Pi 4. The official power supplies are great. With good quality storage and a good quality power supply like we can get these days, the Raspberry Pi is very reliable.

**Regular Backups**: Given the potential for failure, implementing a regular backup strategy is essential for educational deployments.

## Official Raspberry Pi MicroSD Cards

### Introduction and Features

Raspberry Pi launched official microSD cards, working on command queuing within the Raspberry Pi OS for improved performance. These cards are specifically optimized for Raspberry Pi hardware.

**Performance Optimization**: At the moment, the Official Raspberry Pi SD Card is definitely the one you need. This SD card ranked first in all tests, often well ahead of others.

**Command Queuing Support**: Command queuing support for microSD cards allows the microSD card to queue commands/tasks and perform them in the most efficient way possible, allowing it to perform many tasks faster than it would without it.

### Availability and Specifications

The official Raspberry Pi microSD cards are available at https://www.raspberrypi.com/products/sd-cards/ in multiple capacities. Initially, distributors were offering 32/64GB variants, often with Raspberry Pi OS pre-installed.

**Performance Benefits**: The 32GB Raspberry Pi microSD card sees the most benefit from command queuing, but when we move up to the 64 and 128GB capacities, we're already seeing them perform close to their limits.

### Cost Considerations

The 128GB microSD card purchased from BERRYBASE was around $15.70 including taxes, and the 256GB Raspberry Pi NVMe SSD was around $37 including taxes. When you throw in the performance gains, it's worth the investment for demanding applications.

## NVMe Drives and Raspberry Pi 5: The Next Generation

### Introduction to NVMe on Raspberry Pi 5

The new external PCIe port makes it possible to boot the standard Pi 5 model B directly off NVMe storage—an option which is much faster and more reliable than standard microSD storage.

The Raspberry Pi 5's PCIe interface opens up new possibilities for high-performance storage in educational computing environments.

### Performance Benefits

**Dramatic Speed Improvements**: Its PCIe speeds are limited to the point where you'll get around 700-800 MB/s out of an NVME when reading data, and about half that when writing data.

**Real-World Performance**: A simple speed test showed the NVME HAT on my Pi5 is roughly 18x faster than a good uSD card on the old Pi4.

**Boot Time Improvements**: Similar to microSD, around 6-8 seconds with Pi OS. The boot time is highly optimized, and the NVMe's speed advantage isn't as great there as other storage-related tasks like file copies, installs, launching heavy apps.

### Enhanced Reliability

**Durability Advantages**: It's not just about speed, though. NVMe storage is also more durable than MicroSD cards. MicroSD cards can wear out quickly under heavy use, while NVMe drives are built to handle consistent data loads over time.

**Better Error Handling**: NVMe drives typically include more sophisticated wear leveling and error correction capabilities compared to MicroSD cards.

### Setup Requirements

**Hardware Prerequisites**: To use NVMe with Raspberry Pi 5, you'll need:
- A Raspberry Pi 5 (older models don't support PCIe)
- An M.2 HAT or adapter (various manufacturers available)
- A compatible NVMe SSD

**Software Configuration**: Enabling NVMe boot is pretty easy, you add a line to /boot/firmware/config.txt, modify the BOOT_ORDER in the bootloader configuration, and reboot!

**PCIe Speed Considerations**: You can double the speed of NVMe by adding "dtparam=pciex1_gen=3" to config.txt, with hdparm reporting 749.57 MB/sec, though the Pi is only officially rated for PCIe Gen 2 speeds.

### Cost Analysis

**Economic Considerations**: The difference in price per GB when comparing an A2 SD card with 512GB storage to an NVMe SSD of the same capacity isn't earth-shattering. For 256GB models, there is a $10 difference, but the benefits outweigh the cost.

**Long-term Value**: While the initial investment is higher, the improved reliability and performance can reduce maintenance overhead in classroom environments.

## Storage Comparison: MicroSD vs NVMe Drives

### Performance Comparison Table

| Specification | MicroSD Card | NVMe SSD (Pi 5) |
|--------------|--------------|------------------|
| **Read Speed** | ~100 MB/s | 700-800 MB/s |
| **Write Speed** | ~50-70 MB/s | 350-450 MB/s |
| **Random Read (IOPS)** | 2,000-4,000 | 18,000-30,000 |
| **Random Write (IOPS)** | 500-1,000 | 17,000-50,000 |
| **Boot Time** | 8-12 seconds | 6-8 seconds |
| **Capacity Range** | 16GB-1TB | 256GB-2TB+ |
| **Form Factor** | Integrated slot | Requires HAT |
| **Power Consumption** | Very Low | Moderate |
| **Durability (Write Cycles)** | 10,000-100,000 | 100,000-1,000,000+ |
| **Cost (256GB)** | $15-25 | $35-50 |
| **Failure Rate** | Higher | Lower |
| **Data Recovery** | Difficult | Better options |

### Performance Impact Analysis

**Application Loading**: Chromium browser loads a full 38% faster with an SSD than with the microSD card on the Pi 4. The LibreOffice Calc spreadsheet app showed a 42% speed boost when moving from microSD to SSD.

**File Operations**: The NVMe generates a jaw dropping 3,300% improvement over microSD for certain file system operations.

**System Responsiveness**: The move to a NVMe SSD via a Pimoroni BASE made things noticeably snappier compared to USB 3.0 attached SSD.

### Use Case Recommendations

**Choose MicroSD When:**

- Budget is extremely limited
- Projects involve minimal write operations
- Easy swappability between devices is required
- Power consumption must be minimized
- Simple setup is prioritized

**Choose NVMe When:**

- Performance is critical for the application
- System will be under continuous heavy use
- Reliability is paramount for mission-critical deployments
- Working with large files or databases
- Running multiple concurrent applications

## Implementation Recommendations for Educational Environments

### For Basic Computing Labs
- Start with high-quality A1/A2 rated microSD cards from reputable manufacturers
- Implement proper power supply standards across all units
- Establish regular backup procedures
- Consider gradual migration to NVMe for high-use systems

### For Advanced Programming and Development
- Invest in NVMe solutions for development workstations
- Use microSD for basic stations and NVMe for teacher/advanced student systems
- Implement network storage for project sharing and backup

### For Long-term Deployments
- Budget for NVMe drives in systems expected to run continuously
- Plan for storage expansion as projects grow
- Consider hybrid approaches with NVMe for OS and network storage for data

## Conclusion

The choice between storage options for Raspberry Pi in educational environments depends on balancing performance, reliability, cost, and ease of management. While microSD cards remain viable for basic applications, the Raspberry Pi 5's NVMe support represents a significant leap forward in performance and reliability.

Getting an NVMe drive could be the key to a Pi setup that feels less like a hobbyist gadget and more like a minicomputer. For educational institutions planning long-term deployments or performance-critical applications, the investment in NVMe storage technology will provide substantial benefits in system responsiveness, reliability, and student experience.

The imaging tools discussed—both Raspberry Pi Imager and BalenaEtcher—provide robust solutions for deploying customized systems at scale, with Raspberry Pi Imager offering the most integrated experience for Pi-specific deployments and BalenaEtcher providing broader format compatibility for diverse hardware environments.
## References


## References

1. [Raspberry Pi software – Raspberry Pi](https://www.raspberrypi.com/software/) - 2025 - Raspberry Pi Foundation - Official download page for Raspberry Pi Imager with installation instructions and feature descriptions for the latest imaging utility

2. [balenaEtcher - Flash OS images to SD cards & USB drives](https://www.balena.io/etcher) - 2025 - Balena - Official website for balenaEtcher cross-platform imaging tool with download links and comprehensive feature documentation

3. [Raspberry Pi OS downloads – Raspberry Pi](https://www.raspberrypi.com/software/operating-systems/) - 2025 - Raspberry Pi Foundation - Official Raspberry Pi OS download page with various system images and installation guidance

4. [NVMe SSD boot with the Raspberry Pi 5 | Jeff Geerling](https://www.jeffgeerling.com/blog/2023/nvme-ssd-boot-raspberry-pi-5) - 2023 - Jeff Geerling - Comprehensive guide to setting up NVMe SSD boot on Raspberry Pi 5 with performance benchmarks and configuration steps

5. [Best microSD Cards for Raspberry Pi 2025 | Tom's Hardware](https://www.tomshardware.com/best-picks/raspberry-pi-microsd-cards) - 2025 - Tom's Hardware - Detailed testing and comparison of microSD cards for Raspberry Pi with performance benchmarks and reliability analysis

6. [Official Raspberry Pi microSD Card Review - bret.dk](https://bret.dk/official-raspberry-pi-microsd-card-review/) - October 17, 2024 - Bret Samoyloff - In-depth review and benchmarking of official Raspberry Pi microSD cards with command queuing performance testing

7. [Does Your Raspberry Pi 5 Need an NVMe Drive?](https://www.howtogeek.com/does-your-raspberry-pi-5-need-an-nvme-drive/) - November 15, 2024 - How-To Geek - Analysis of NVMe benefits for Raspberry Pi 5 with speed comparisons and use case recommendations

8. [Getting started - Raspberry Pi Documentation](https://www.raspberrypi.com/documentation/computers/getting-started.html) - 2025 - Raspberry Pi Foundation - Official documentation covering storage options, OS customization, and initial setup procedures for Raspberry Pi systems

9. [Raspberry Pi products/sd-cards](https://www.raspberrypi.com/products/sd-cards/) - 2025 - Raspberry Pi Foundation - Official product page for Raspberry Pi microSD cards with specifications and availability information

10. [Raspberry Pi 4 With an SSD: Dramatic Speed Improvements, Higher Price | Tom's Hardware](https://www.tomshardware.com/news/raspberry-pi-4-ssd-test,39811.html) - June 8, 2020 - Tom's Hardware - Performance comparison testing showing speed improvements when using SSD storage versus microSD cards with real-world application benchmark

11. [Introducing rpi-image-gen: build highly customized Raspberry Pi software images](https://www.raspberrypi.com/news/introducing-rpi-image-gen-build-highly-customised-raspberry-pi-software-images/)