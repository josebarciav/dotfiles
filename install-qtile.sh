#!/bin/bash

# Zona horaria e idioma
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=es_ES.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf

# Hostname
echo "joselokus-pc" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 joselokus-pc.localdomain joselokus-pc" >> /etc/hosts

# Usuario
passwd
useradd -m -G wheel jose
passwd jose
echo "%wheel ALL=(ALL:ALL) ALL" | EDITOR=nano visudo

# Bootloader
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Interfaz gráfica y Qtile
pacman -S xorg xorg-xinit qtile alacritty picom nitrogen lxappearance dmenu rofi

# Red, audio, fuentes
pacman -S networkmanager pulseaudio pavucontrol alsa-utils volumeicon \
    ttf-dejavu ttf-liberation ttf-font-awesome noto-fonts

systemctl enable NetworkManager

# Drivers Intel + NVIDIA
pacman -S nvidia nvidia-utils nvidia-prime mesa lib32-mesa xf86-video-intel

# Gestor de login
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm
