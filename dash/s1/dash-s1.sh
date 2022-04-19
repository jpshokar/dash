ln -sf /usr/share/zoneinfo/America/Toronto  /etc/localtime
echo "en_US ISO-8859-1" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
HOSTNAME=archy
echo HOSTNAME >> /etc/hostname
mkinitcpio -P
echo "Please enter a password:"
passwd

echo "Installing the GRUB bootloader."
grub-mkconfig > /boot/grub/grub.cfg
grub-install --efi-directory=/boot/efi --target=x86_64-efi /dev/sda

echo "Finished - Starting services"
systemctl enable --now NetworkManager
echo "Done. Thanks for being patient :)"


