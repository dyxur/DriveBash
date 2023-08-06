# DriveBash
Script for write bashing a drive to test it's durability.

The script takes two arguments 1:`/path/to/drive` 2: `NameOfLog`.

This is a very long and time intensive script, since even flash can sustain from 10k to 100k writes without a problem!
There are two factors that will increase the time it takes by a lot:
- Size of the drive to test
- Speed of the drive to test

This script should be used on a seperate device that can execute the script uninterupted until the drive fails.
I'm using an old cheap NUC with [DietPi](https://dietpi.com/). But this can be done on anything you want, like a RPi0, MangoPi, an old Router, etc.
All you really need is access to:
- To a few commands: `badblocks`, `shred`, `echo`, `touch`, `tail`, `grep`
- A way to hook up a drive: `USB`, `SD Slot`, `SATA`, `M.2`
- Access to a terminal / way to start the script
- And a way to access the log

Be aware that this scirpt tests for bad blocks on every 100th write. This is therefore the given accuracy!

# Disclaimer!
This script is provided as is! Please make sure you select the correct drive as this process is destructive. If you decide to use this on your main machine especially, make sure that you do not select any drive with data that you don't want to lose!
