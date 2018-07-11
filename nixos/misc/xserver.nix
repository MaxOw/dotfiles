{ config, pkgs, lib, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape"; # CapsLock -> Escape
    videoDrivers = [ "intel" ]; # Is this even needed?
    synaptics.enable = true;    # Enable touchpad

    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;

    desktopManager.default = "none";
    displayManager.auto.enable = true;
    displayManager.auto.user = "max";
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset r rate 250 15
      ${pkgs.xorg.xbacklight}/bin/xbacklight -set 50
    '';
  };
}
