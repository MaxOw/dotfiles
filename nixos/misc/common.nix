{ config, pkgs, lib, ... }:

let solarized = import ./solarized.nix;
in {

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
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

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;

  sound.enable = true;

  # Select internationalisation properties.
  i18n.consoleUseXkbConfig = true;
  i18n.consoleColors = solarized.consoleColors;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget neovim git
    libnotify

    haskellPackages.xmobar
    dmenu
  ];
  nixpkgs.config.allowUnfree = true;

  environment.etc."inputrc".source = lib.mkForce ./inputrc;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  hardware.opengl.driSupport32Bit = true;

  # Postgres
  services.postgresql.enable  = true;
  services.postgresql.package = pkgs.postgresql96;

  # Don't know about this, turning off for now...
  systemd.user.services.powertop = {
    enable = true;
    description = "Powertop autotune service";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.powertop ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune";
        # other powersaving options to add:
        #${pkgs.iw}/bin/iw dev wlp2s0 set power_save on
        #for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        #  echo powersave > $cpu
        #done
    };
  };

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
  services.dbus.enable = true;
  services.upower.enable = true;

  # Acpid: actions on different events like: lid, ac_adapter, mute button, etc.
  services.acpid.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.max = {
    name = "max";
    home = "/home/max";
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8WxqAzwGXUCZst2XYY0kc1D/AWcnsVyOZF4UrZnP8zbNP1ZSvL6g2GO93tqKZIOKHLy6avjEbMXWTyZN859kmbINZx/vdlUUKT/ujk1WUHAR/2AwZUnh4g9ZYhoFTx0t64C6N6u5gnxn4LQg1Nb1su+fz3aaGjOTtS8k1mRL0/jUsqUKYx+eNTrCXjJqPC0A4+NL90UNce/zqsA2KHU/9IhG5b7qJt2TkObbROHlitvZgqGq9qpdfhXfeD7UaJcdL6JjrRohmi98MVyR/Z5YhYoOfw+FG2zCSkgDgGVd3Kz+ZiSF6JSjgQLltshgWyXPtO8lf1XKvbMMFOgIQIHGJ max@raptor"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5g/5HLz4lqFEZm+dW1cVVFgPg038U6Z1h/mm4vS8ZuI9hyww4g/kDbeAuzpQJzhpU6+mtb8aDjpVc9SeaOndFvqTCPH0v3RTn0I7BOA3g+qCSIABvbDKq1IdwonXOGNr7f+FmLb2Q5P1u+yghB4q3w4z3mpO0y2OIq3wJBt/mwsWogBQuMZyYpc8fYm5+AlwaDteySexW2cjAdrDPO+HnP4j+pm42CjMJ7rcKPra7q+O8bJt9JD3hjLK4A5qyuILxpnaO37ePf84AypYGM3EuOld/QkxR6NPqsVSzkX2ReDxDe/gvalugwwqrisBMBsUTCrd2RncffF+tSFcXqZIJ max@felis"
      ];
    uid = 1337;
  };
}
