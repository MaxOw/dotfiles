# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let solarized = import ./misc/solarized.nix;
in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure GRUB 2 boot loader
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.device = "/dev/nvme0n1"

  # Network configuration
  networking.hostName = "raptor"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless via wpa_supplicant.
  #networking.wireless.userControlled.enable = true; # Allow wpa_cli & wpa_gui
  networking.dnsSingleRequest = true;
  networking.enableIPv6 = false;
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];
  # networking.extraHosts = ''
  #   127.0.0.1 local.1bios.co
  # '';

  # Select internationalisation properties.
  i18n.consoleUseXkbConfig = true;
  i18n.consoleColors = solarized.consoleColors;
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget neovim git
    libnotify

    haskellPackages.xmobar
    dmenu
  ];
  nixpkgs.config.allowUnfree = true;

  environment.etc."inputrc".source = lib.mkForce ./misc/inputrc;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  hardware.opengl.driSupport32Bit = true;
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

  # Postgres
  services.postgresql.enable  = true;
  services.postgresql.package = pkgs.postgresql96;
  # MongoDB
  # services.mongodb.enable  = true;
  # services.mongodb.package = import ./misc/mongodb268.nix;
  # Redis
  # services.redis.enable  = true;
  # services.redis.package = import ./misc/redis_2_8.nix;

  # Don't know about this, turning off for now...
  # systemd.user.services.powertop = {
  #   enable = true;
  #   description = "Powertop autotune service";
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.powertop ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune";
  #       # other powersaving options to add:
  #       #${pkgs.iw}/bin/iw dev wlp2s0 set power_save on
  #       #for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  #       #  echo powersave > $cpu
  #       #done
  #   };
  # };

  systemd.user.services.dunst = {
    enable = true;
    description = "Notification daemon";
    wantedBy = [ "default.target" ];
    path = [ pkgs.dunst ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
      ExecStart = "${pkgs.dunst}/bin/dunst";
    };
  };

  systemd.user.services.unclutter = {
    enable = true;
    description = "Hide mouse when idle";
    wantedBy = [ "default.target" ];
    path = [ pkgs.unclutter ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
      ExecStart = "${pkgs.unclutter}/bin/unclutter -root -idle 1";
    };
  };

  # This doesn't seem to work anyway
  #services.udev.path = [ pkgs.libnotify ];
  #services.udev.extraRules = ''
  #  SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-10]", RUN+="/run/current-system/sw/bin/notify-send --urgency=critical \"Battery critical\" \"The battery level is critical. Plug in your charger now.\""
  #'';

  services.nixosManual.showManual = true;
  #services.dbus.enable = true;
  #services.upower.enable = true;

  # Acpid: actions on different events like: lid, ac_adapter, mute button, etc.
  services.acpid.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.max = {
    name = "max";
    home = "/home/max";
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1337;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
