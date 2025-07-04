#!/usr/bin/env bash
# Script de instalación automatizada de Arch Linux con Qtile para Acer Nitro V 15
# Variables a configurar:
DISK="/dev/nvme0n1"       # Disco principal (ajusta si es necesario)
EFI_SIZE="512MiB"          # Tamaño de la partición EFI
HOSTNAME="nitro-v15"       # Nombre del equipo
USERNAME="tuusuario"       # Nombre de tu usuario

set -euo pipefail
export PS4='+ [${BASH_SOURCE##*/}:${LINENO}] '

# 1. Sincronizar hora
timedatectl set-ntp true

# 2. Particionado GPT
sgdisk --zap-all "$DISK"
sgdisk -n1:0:+$EFI_SIZE -t1:ef00 -c1:"EFI System" "$DISK"
sgdisk -n2:0:0      -t2:8300 -c2:"Linux Root"  "$DISK"

# 3. Formateo de particiones
echo "Formateando EFI y raíz..."
mkfs.fat -F32 "${DISK}p1"
mkfs.ext4 "${DISK}p2"

# 4. Montaje de sistemas de archivos
mount "${DISK}p2" /mnt
mkdir -p /mnt/efi
mount "${DISK}p1" /mnt/efi

# 5. Instalación base
echo "Instalando sistema base..."
pacstrap /mnt \
    base linux linux-firmware intel-ucode \
    grub efibootmgr dosfstools os-prober mtools \
    networkmanager vim sudo xorg-server xorg-xinit xorg-apps \
    nvidia nvidia-utils lib32-nvidia-utils nvidia-settings \
    qtile python-cairocffi alacritty feh rofi polkit-gnome \
    ttf-dejavu ttf-liberation noto-fonts

# 6. Generar fstab
echo "Generando fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# 7. Configuración dentro de chroot
arch-chroot /mnt /bin/bash <<EOF
  set -e
  # Zona horaria
  ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
  hwclock --systohc

  # Locales
  sed -i 's/^#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
  sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
  locale-gen
  echo "LANG=es_ES.UTF-8" > /etc/locale.conf

  # Hostname y hosts
echo "$HOSTNAME" > /etc/hostname
echo -e "127.0.0.1\tlocalhost" >> /etc/hosts
echo -e "::1\tlocalhost" >> /etc/hosts
echo -e "127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" >> /etc/hosts

  # Contraseña de root
  echo "Establece la contraseña de root:"; passwd root

  # Usuario y sudo
  useradd -m -G wheel,video,audio,optical,storage -s /bin/bash $USERNAME
  echo "Establece la contraseña para $USERNAME:"; passwd $USERNAME
  sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

  # Initramfs (DRM y módulos NVIDIA)
  sed -i 's/^MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
  mkinitcpio -P

  # GRUB en UEFI
  grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
  grub-mkconfig -o /boot/grub/grub.cfg

  # Servicios
  systemctl enable NetworkManager
  # Optional: systemctl enable bluetooth
EOF

# 8. Desmontar y reiniciar
echo "Desmontando y reiniciando..."
umount -R /mnt
reboot
