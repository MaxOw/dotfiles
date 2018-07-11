# run as root

machine=$1
path=/home/max/dotfiles
nixos=/etc/nixos

ln -sv ${path}/nixos/${machine}.nix ${nixos}/configuration.nix
ln -sv ${path}/nixos/misc ${nixos}/misc
