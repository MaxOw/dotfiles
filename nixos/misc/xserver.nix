{ config, pkgs, lib, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape"; # CapsLock -> Escape
    videoDrivers = [ "intel" ]; # Is this even needed?
    synaptics.enable = true;    # Enable touchpad

    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;

    displayManager.defaultSession = "none+xmonad";
    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin.enable = true;
    displayManager.lightdm.autoLogin.user = "max";
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset r rate 220 25
      ${pkgs.xorg.xbacklight}/bin/xbacklight -set 50
    '';
  };
}
