#!/bin/bash

# Attempt to install zsh using popular package managers.
printf "\nInstalling zsh...\n"
sudo apt install -y zsh
sudo pacman -Syu --noconfirm zsh

printf "\nInstalling zsh configuration...\n"

# Clone Z Shell Launchpad to home directory.
mv -v ~/.zshrc ~/.zshrc-backup-$(date +%s)
git clone https://github.com/marlonrichert/zsh-launchpad.git
rm -rvf zsh-launchpad/.git
rm -rvf zsh-launchpad/README.md
rm -rvf zsh-launchpad/LICENSE
cp -rv zsh-launchpad/. ~
rm -rvf zsh-launchpad

# # Install Scott Stanfield's sensible, minimal .zshrc.
# curl -o ~/.zshrc -L git.io/sensible-zshrc

# Install the latest kitty binary.
printf "\nInstalling kitty...\n"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

# Install CaskaydiaCove Nerd Font.
printf "\nInstalling CaskaydiaCove Nerd Font...\n"
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip
sudo mkdir -v /usr/share/fonts/truetype/caskaydiacove-nerd
sudo unzip -o CascadiaCode.zip -d /usr/share/fonts/truetype/caskaydiacove-nerd
sudo fc-cache -fv
rm -v CascadiaCode.zip

# Install kitty configuration.
printf "\nInstalling kitty configuration...\n"
cp -rv config/kitty ~/.config

printf "\ndaru installed.\n"
