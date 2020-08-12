# run as user

home=/home/max
dotfiles=${home}/dotfiles
firefox_profile=$(ls -d1 ${home}/.mozilla/firefox/*/ | grep default)

if [ $(echo $firefox_profile | wc -l) = "1" ]; then
  echo Firefox profile: $firefox_profile
  ln -sv ${dotfiles}/firefox/user.js ${firefox_profile}/user.js
  ln -sv ${dotfiles}/firefox/userChrome.css ${firefox_profile}/chrome/userChrome.css
else
  echo There is no one default firefox profile. Select one by hand.
fi

ln -sv ${dotfiles}/xterm/init ${home}/.Xresources
ln -sv ${dotfiles}/vimperator/init ${home}/.vimperatorrc
ln -sv ${dotfiles}/git/gitconfig ${home}/.gitconfig

mkdir -p ${home}/.config
ln -sv ${dotfiles}/nvim/ ${home}/.config/nvim

mkdir -p ${home}/.xmonad
ln -sv ${dotfiles}/xmonad/xmonad.hs ${home}/.xmonad/xmonad.hs
ln -sv ${dotfiles}/xmonad/xmobarrc ${home}/.xmonad/xmobarrc

ln -sv ${dotfiles}/bashrc ${home}/.bashrc

ln -sv ${dotfiles}/haskeline ${home}/.haskeline

ln -sv ${dotfiles}/tridactyl/ ${home}/.config/tridactyl

# mkdir -p .config/alacritty
# ln -sv ${dotfiles}/alacritty ${home}/.config/alacritty

mkdir -p ${home}/.config/dunst
ln -sv ${dotfiles}/dunstrc ${home}/.config/dunst/dunstrc

mkdir -p ${home}/.config/htop
ln -sv ${dotfiles}/htop/htoprc ${home}/.config/htop/htoprc
