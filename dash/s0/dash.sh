# D(eploy) Arch
# Simple script for deploying arch on UEFI-based systems. Please check out the following configurations before running this script: 

BOOT=/dev/sda1
SWAP=/dev/sda2
ROOT=/dev/sda3
PACKAGES="base linux linux-firmware broadcom-wl networkmanager grub efibootmgr"

echo "Before progressing I encourage you to validate the currently configured settings by viming into this shell script."
echo "After you have done so. Please press any key to continue."




read -n 1 -r -s -p $'?> '
echo "With the use of the script, you free the creator of this script from all damages that may occur."
read -n 1 -r -s -p $'?> '

echo "We have agreed upon the following configuration:"
echo "ROOT" $ROOT
echo "BOOT" $BOOT
echo "SWAP" $SWAP
echo "Packages to be installed: " $PACKAGES
echo "Press any key to continue."
read -n 1 -r -s -p $'?> '

echo "Setting NTP to true."
timedatectl set-ntp true


echo "Formatting the partitions"

echo "EXT4 Journaling System for " $ROOT
mkfs.ext4 $ROOT
echo "FAT32 for " $BOOT
mkfs.fat -F 32 $BOOT
echo "Partitioning SWAP (" $SWAP")"
mkswap $SWAP

echo "Mounting the file systems"

mount $ROOT /mnt
mount --mkdir $BOOT /mnt/boot/efi
swapon $SWAP


echo "An internet connection will now be required for this step."
echo "Installing necessary packages."

pacstrap /mnt $PACKAGES
echo "Creating FSTAB file."
genfstab -U /mnt >> /mnt/etc/fstab

echo "Stage 01 of the script has completed, we now suggest you to run the stage two of this script."
cp -v ../s1/dash-s1.sh /mnt/root/
arch-chroot /mnt



