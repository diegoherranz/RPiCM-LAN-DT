RPiCM-LAN-DT
============

Device Tree for Raspberry Pi Compute Module and LAN951X.

Target
------
For designers using Raspberry Pi Compute Module and LAN951x (e.g. LAN9512 or LAN9514)

Introduction
------------
Raspberry Pi models B and B+ control the reset of LAN951X chip using a GPIO pin. Different versions of Raspberry Pi use different GPIO pins.

The information of which GPIO pin is being used for that purpose on each Raspberry Pi version is described on a [Device Tree](http://en.wikipedia.org/wiki/Device_tree) and included on the [Raspberry Pi firmware](https://github.com/raspberrypi/firmware).

In case of Raspberry Pi Compute Module, the default firmware Device Tree, doesn't include information about which pin is used for LAN reset because each designer can choose whatever gpio they want (or even doesn't use LAN at all).

Thus, it's necessary to modify the default device tree if you want the Raspberry Pi Compute Module firmware to take care of LAN951X reset pin.

Requirements
------------
 - Raspberry firmware newer than 15th July 2014. Check with `vcgencmd version`.
 - Device tree compiler (`sudo apt-get install device-tree-compiler`).

Chosen GPIO pin
---------------
On this repository, like the Raspberry Pi B, GPIO 6 (BCM numbering) has been chosen. If you want to use another GPIO, take a look at [this commit](https://github.com/diegoherranz/RPiCM-LAN-DT/commit/8fd1b25e71f0dd1fdaaa424efa5ac7d270eaba5b) to have an idea of what to change.

LAN951X oscillator
------------------
LAN951X needs a 25 MHz clock. From the [LAN951X datasheet](http://ww1.microchip.com/downloads/en/DeviceDoc/9512.pdf):

> LAN9512/LAN9512i can accept either a 25MHz crystal (preferred)
> or a 25MHz single-ended clock oscillator (+/- 50ppm) input.

Raspberry Pi B uses a crystal and B+ uses a clock output from BCM SoC. Since datasheet recommends a crystal, this repository assumes you'll use one.
If you want to use a clock output from BCM SoC, some modifications must be done to `dt-blob.dts`. See "Clock Configuration" [here](http://www.raspberrypi.org/documentation/configuration/pin-configuration.md).

Usage
-----
If **inside Raspberry Pi:**

    $ git clone https://github.com/diegoherranz/RPiCM-LAN-DT
    $ cd RPiCM-LAN-DT
    $ sudo make install
And reboot. Firmware will take care of LAN reset line from now on.


If **not on the raspberry Pi:**

    $ git clone https://github.com/diegoherranz/RPiCM-LAN-DT
    $ cd RPiCM-LAN-DT
    $ make
And copy the generated file (`dt-blob.bin`) to the boot partition of Raspberry Pi Compute module. From the next boot, firmware will take care of LAN reset line.

More information
----------------
 - [Changing Raspberry Pi Default Pin Configuration] (http://www.raspberrypi.org/documentation/configuration/pin-configuration.md)

Collaboration
-------------
Any kind of collaboration like corrections, comments, etc. is very welcome. Feel free to open an issue or fork and pull request.
