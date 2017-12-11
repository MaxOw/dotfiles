# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let secrets = import /etc/nixos/secrets.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use kernel version 3.14 becouse of nvidia
  # boot.kernelPackages = pkgs.linuxPackages_3_14;

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.firefox.enableAdobeFlash = true;
  #nixpkgs.config.chromium.enablePepperFlash = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "hovercraft"; # Define your hostname.
  #networking.interfaceMonitor.enable = true;
  #networking.wireless.enable = false;  # Enables wireless.
  #networking.networkmanager.enable = true;
  #networking.networkmanager.packages = [ pkgs.networkmanagerapplet ];
  networking.enableIPv6 = false;
  networking.extraHosts = import /etc/nixos/hosts.nix;

  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # tmux zsh
    wget vim git
    haskellPackages.ghc
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    haskellPackages.xmobar
    dmenu
  ];

  # Services
  # Postgres
  services.postgresql.enable  = true;
  services.postgresql.dataDir = "/var/db/postgresql/9.6";
  services.postgresql.package = pkgs.postgresql96;
  # MongoDB
  services.mongodb.enable  = true;
  services.mongodb.package = import /etc/nixos/mongodb268.nix;
  # Redis
  services.redis.enable  = true;
  services.redis.package = import /etc/nixos/redis_2_8.nix
        { stdenv = pkgs.stdenv; fetchurl = pkgs.fetchurl; };

  # Backup with Tarsnap
  services.tarsnap = {
    enable = true;
    # Default location of keyfile
    keyfile = secrets.tarsnap;
    archives.projects = {
      directories = [ "/home/max/Projects" ];
      excludes = [ "*/dist/*" ];
      # Once a day at that time (see format in systemd.time)
      period = "01:15";
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # services.openssh.permitRootLogin = "yes";
  # users.extraUsers.root.openssh.authorizedKeys.keyFiles = secrets.root_ssh;

  # Drivers
  hardware.opengl.driSupport32Bit = true;
  # Enable the X11 windowing system + XMonad
  services.xserver = {
    layout = "us";
    xkbOptions = "caps:escape";

    synaptics.enable = true;
    enable = true;
    #videoDrivers = [ "nvidiaLegacy304" ];
    videoDrivers = [ "nvidiaLegacy340" ];
    #videoDrivers = [ "nvidia" ];
    windowManager.xmonad.enable = true;
    # windowManager.xmonad.extraPackages = self: [ self.xmonadContrib ];
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.default = "xmonad";
    desktopManager.default = "none";

    displayManager.auto.enable = true;
    displayManager.auto.user = "max";
  };

  #services.virtualboxHost.enable = true;

  fonts = {
    fontconfig.enable = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      inconsolata
      source-han-sans-japanese
      source-han-sans-korean
      source-han-sans-simplified-chinese
      source-han-sans-traditional-chinese
      ubuntu_font_family
      unifont
    ];
  };

  security.sudo.enable = true;

  nix.trustedBinaryCaches = [
    "http://cache.nixos.org"
    "http://hydra.nixos.org"
    # "http://hydra.cryp.to"
  ];

  nix.binaryCaches = nix.trustedBinaryCaches;

  nix.requireSignedBinaryCaches = false;
  nix.binaryCachePublicKeys = [
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
  ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix ];

  # programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.guest = {
    name = "max";
    # uid = 1000;
    createHome = true;
    home = "/home/max";
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/bash";
    # shell = "/run/current-system/sw/bin/zsh";
  };
}
