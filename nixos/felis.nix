{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/misc/common.nix
      /etc/nixos/misc/xserver.nix
    ];

  networking.hostName = "felis";
  system.stateVersion = "18.03";
}
