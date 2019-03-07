{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/misc/common.nix
      /etc/nixos/misc/xserver.nix
    ];

  # services.xserver.enable = false;
  networking.hostName = "raptor";
  system.stateVersion = "17.09";
}
