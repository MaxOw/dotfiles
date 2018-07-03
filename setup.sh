# run as user

home=/home/max
dotfiles=${home}/dotfiles

ln -sv ${dotfiles}/xterm/init ${home}/.Xresources
ln -sv ${dotfiles}/vimperator/init ${home}/.vimperatorrc
ln -sv ${dotfiles}/git/gitconfig ${home}/.gitconfig

mkdir -p ${home}/.config
ln -sv ${dotfiles}/nvim/ ${home}/.config/nvim

ln -sv ${dotfiles}/xmonad/ ${home}/.xmonad

ln -sv ${dotfiles}/bashrc ${home}/.bashrc

ln -sv ${dotfiles}/haskeline ${home}/.haskeline

# mkdir -p .config/alacritty
# ln -sv ${dotfiles}/alacritty ${home}/.config/alacritty

mkdir -p ${home}/.config/dunst
ln -sv ${dotfiles}/dunstrc ${home}/.config/dunst/dunstrc

mkdir -p ${home}/.config/htop
ln -sv ${dotfiles}/htop/htoprc ${home}/.config/htop/htoprc
