#!/bin/bash
set -e 
set -x

# Make sure you are running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Install necessary packages
apt update
apt install -y mdadm cryptsetup

# Create RAID 10 array
umount /dev/nvme1n1p1 /dev/nvme2n1p1 /dev/nvme3n1p1 /dev/nvme4n1p1 /dev/nvme5n1p1 /dev/nvme6n1p1 /dev/nvme7n1p1 /dev/nvme8n1p1

# clear out past data that could mess up mdadm
for i in `seq 1 8`; do echo mdadm --zero-superblock /dev/nvme${i}n1; done
for i in `seq 1 8`; do dd if=/dev/zero of=/dev/nvme${i}n1 bs=1M count=100; done

mdadm --create --verbose /dev/md0 --level=10 --raid-devices=8 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1 /dev/nvme6n1 /dev/nvme7n1 /dev/nvme8n1
mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
nvim /etc/mdadm/mdadm.conf 
sudo update-initramfs -u

# Wait for RAID to finish building
echo "Waiting for RAID to finish building. This could take a while."
watch cat /proc/mdstat

# Set up LUKS encryption
echo -n "Enter the passphrase for the new encrypted volume: "
read -s passphrase
# DOESN't WORK, run it manually and type in pass
echo $passphrase | cryptsetup luksFormat /dev/md0 -

# Open the encrypted volume
echo $passphrase | cryptsetup luksOpen /dev/md0 crypthome -

# Create filesystem on the encrypted volume
mkfs.ext4 /dev/mapper/crypthome

# Backup old home data
mv /home /home_old


# Create mount point
mkdir /home

# Add the new filesystem to fstab with noauto option
echo '/dev/mapper/crypthome /home ext4 defaults,noauto 0 0' >> /etc/fstab

# Mount the new filesystem
mount /home

# Restore old home data
rsync -avh /home_old/ /home/

# Change the owner to the user who needs to use the ML workspace
# Replace username with the actual username
# chown -R username:username /home

echo "Done."


# create a shared dir 
# mkdir /home/shared
# chmod o+wrx /home/shared
# mkdir /mnt/data
# echo "/home/shared /mnt/data none bind 0 0" >> /etc/fstab
#
# make sure /dev/md0 comes back on launch
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
