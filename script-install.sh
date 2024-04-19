#!/bin/bash

# Asegúra tener las dependencias instaladas
sudo apt update -y
sudo apt install -y git curl kitty

# Instala oh-my-zsh y plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Copia y borrado de archivos de configuración
rm ~/.zshrc
rm ~/.p10k.zsh
rm ~/.config/kitty/kitty.conf
cp ~/Config-Zsh/zshrc ~/.zshrc
cp ~/Config-Zsh/p10k.zsh ~/.p10k.zsh
cp ~/Config-Zsh/kitty.conf ~/.config/kitty/kitty.conf

# Fuente de los archivos de configuración
source ~/.zshrc
source ~/.p10k.zsh

echo "\n\n[+] Instalación terminada\n"

