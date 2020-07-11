{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/misc/common.nix
      /etc/nixos/misc/xserver.nix
    ];

  virtualisation.docker.enable = true;
  users.users.max.extraGroups = [ "wheel" "docker" ];

  networking.hostName = "felis";
  system.stateVersion = "18.03";
}
