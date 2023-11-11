sudo apt update -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo mv zshrc ~/.zshrc
sudo mv p10k.zsh ~/.p10k.zsh
sudo mv zshrc.pre-oh-my-zsh ~/.zshrc.pre-oh-my-zsh
sudo mv kitty.conf ~/.config/kitty/kitty.conf
sudo mv oh-my-zsh.sh ~/.oh-my-zsh/oh-my-zsh.sh
source .zshrc
echo "Instalacion Terminada"
