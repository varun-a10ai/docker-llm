mdadm --create --verbose /dev/md0 --level=10 --raid-devices=16  /dev/nvme0n1  /dev/nvme1n1   /dev/nvme2n1   /dev/nvme3n1   /dev/nvme4n1   /dev/nvme5n1   /dev/nvme6n1   /dev/nvme7n1   /dev/nvme9n1   /dev/nvme10n1  /dev/nvme11n1  /dev/nvme12n1  /dev/nvme13n1  /dev/nvme14n1  /dev/nvme15n1  /dev/nvme16n1  
mkfs.ext4 /dev/md0
mkdir -p /mnt/raid
mount /dev/md0 /mnt/raid


echo 1
echo 2
