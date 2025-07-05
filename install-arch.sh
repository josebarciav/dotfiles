#!/bin/bash

set -e  # Salir si algo falla

### CONFIGURACIÓN MANUAL ###
DISK="/dev/nvme0n1"
EFI_PART="${DISK}p1"
ROOT_PART="${DISK}p2"
MOUNT_POINT="/mnt"
BOOT_DIR="$MOUNT_POINT/boot"
###

echo ">> Estableciendo teclado en español..."
loadkeys es

echo ">> Activando sincronización de hora..."
timedatectl set-ntp true

echo ">> Verificando que las particiones no estén montadas..."

# Verifica si ya están montadas
if mount | grep -q "$MOUNT_POINT"; then
  echo "❌ $MOUNT_POINT ya está montado. Desmonta antes de continuar (umount -R $MOUNT_POINT)"
  exit 1
fi

if mount | grep -q "$BOOT_DIR"; then
  echo "❌ $BOOT_DIR ya está montado. Desmonta antes de continuar (umount $BOOT_DIR)"
  exit 1
fi

echo "✅ No hay conflictos de montaje."

echo ">> Formateando particiones..."

mkfs.fat -F32 "$EFI_PART"
mkfs.ext4 "$ROOT_PART"

echo ">> Montando particiones..."

mount "$ROOT_PART" "$MOUNT_POINT"
mkdir -p "$BOOT_DIR"
mount "$EFI_PART" "$BOOT_DIR"

echo "✅ Particiones montadas correctamente en $MOUNT_POINT"

echo ">> Instalando base de Arch Linux..."

pacstrap -K "$MOUNT_POINT" base linux linux-firmware nano vim networkmanager sudo git

echo ">> Generando fstab..."
genfstab -U "$MOUNT_POINT" >> "$MOUNT_POINT/etc/fstab"

echo "✅ Instalación base completada."
echo "➡️ Ahora ejecuta: arch-chroot /mnt y luego ./install-qtile.sh"
