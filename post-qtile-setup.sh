#!/bin/bash

# Zsh + Oh My Zsh
pacman -S zsh
chsh -s /bin/zsh jose

su - jose -c "
sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" --unattended
git clone https://github.com/romkatv/powerlevel10k.git \$HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions \$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
"

# AstroNvim
su - jose -c "
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim --headless +AstroUpdate +q
"

# Dev tools
pacman -S git lazygit nodejs npm yarn python python-pip docker docker-compose neofetch btop

# Añadir jose al grupo docker
usermod -aG docker jose
systemctl enable docker

# Crear archivo xrandr para usar monitor externo como principal (HDMI-1-0)
mkdir -p /home/jose/.config/qtile
cat <<EOF > /home/jose/.config/qtile/autostart.sh
#!/bin/bash
xrandr --output HDMI-1-0 --primary --mode 3440x1440 --rate 60 --output eDP-1 --off &
picom &
nitrogen --restore &
volumeicon &
EOF

chmod +x /home/jose/.config/qtile/autostart.sh

# Añadir hook en config.py (si existe)
echo -e "\n@hook.subscribe.startup_once\n"\
"def autostart():\n    subprocess.Popen(['~/.config/qtile/autostart.sh'])" >> /home/jose/.config/qtile/config.py
