# run as root

path=/home/max/dotfiles
nixos=/etc/nixos

ln -sv ${path}/nixos/configuration.nix ${nixos}/configuration.nix
ln -sv ${path}/nixos/misc ${nixos}/misc
