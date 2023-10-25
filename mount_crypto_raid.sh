#!/bin/bash
# Needs to be done on every boot

# Make sure you are running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi


# Set up LUKS encryption
echo -n "Enter the passphrase for the volume: "
read -s passphrase
echo $passphrase | cryptsetup luksOpen /dev/md0 crypthome -

# Add the new filesystem to fstab with noauto option
# echo '/dev/mapper/crypthome /home ext4 defaults,noauto 0 0' >> /etc/fstab

# Mount the new filesystem
mount /home
