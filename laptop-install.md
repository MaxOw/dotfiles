
# Procedure for laptop setup

## System installation

1. Boot

  The Cortechs USB Drive has NixOS 18.03 image boot from that or burn
  another one.

  Remember to turn of secure boot in BIOS
  Hold F2 on startup to go to bios on ZenBook (from what I remember)
  Pres F12 to go to boot menu on Dell Inspiron
  Select the image and boot from that.

  Follow the manual at: https://nixos.org/nixos/manual/
  You can also access manual at virtual console 8: Alt+F8 or by running
  nixos-help

2. Log-in as root with empty password

3. Setup network/wifi:

  > ip a # to check network interface name
  > wpa_supplicant -B -i interface -c <(wpa_passphrase 'SSID' 'key')

4. Disk formatting & partitioning

  > fdisk -l # To list partitions
  this should show
  lots of virtual ram partition
  /dev/sda # Usually the hard drive name
  /dev/sdb # Probably the boot usb name?
  (/dev/nvme0n1 on ZenBook ... newer naming convention?)

  Delete existing partitions on the hardrive (/dev/sda)

  > gdisk $DISK
  > Command: p # to print partitions

  > Command: d # to delete partition
  > # You will be prompted for partition numbers
  > # delete them all one by one

  > # Create EFI boot partition
  > Command: n
  > Partition number: 1
  > First sector: <enter for default>
  > Last sector: +500M
  > Hex code or GUID: ef00

  > # Create LVM partition
  > Command: n
  > Partition number: 1
  > First sector: <enter for default>
  > Last sector: <enter for default - rest of disk>
  > Hex code or GUID: 8e00 # Linux LVM type

  > Command: w # to save & exit

4a. Setting up encryption (optional)

  > cryptsetup luksFormat $LVM_PARTITION
  > # you will have to enter decryption pass phrase here
  > # (can be changed later)

  > cryptsetup luksOpen $LVM_PARTITION nixos-enc

  > # Create physical LVM volume using nixos-enc
  > pvcreate /dev/mapper/nixos-enc

  > # Create volume group containing swap and root partitions
  > vgcreate vg /dev/mapper/nixos-enc

4b. Without encryption do this instead:

  > pvcreate $LVM_PARTITION
  > vgcreate vg $LVM_PARTITION

5. Creating logical volumes

  > # Create swap volume sized ~1.5 of your ram size
  > lvcreate -L 12G -n swap vg

  > # Create root volume with all remaining free space
  > lvcreate -l 100%FREE -n root vg

6. Create filesystems

  > # $BOOT_PARTITION = EFI boot partition location
  > mkfs.vfat -n boot $BOOT_PARTITION

  > # ext4 for root partition
  > mkfs.ext4 -L nixos /dev/vg/root

  > # swap for swap partition
  > mkswap -L swap /dev/vg/swap

  > # turn on the swap
  > swapon /dev/vg/swap

7. Mount filesystems

  > mount /dev/vg/root /mnt
  > mkdir /mnt/boot
  > mount $BOOT_PARTITION /mnt/boot

8. Setup initial nixos configurations

  > # generate initial nixos config
  > nixos-generate-config --root /mnt

  > vim /mnt/etc/nixos/configuration.nix

  ```
  { config, pkgs, lib, ... }:

  {
    imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "<hostname>"; # Define your hostname.
    networking.wireless.enable = true;  # Enables wireless via
                                        # wpa_supplicant.

    environment.systemPackages = with pkgs; [
      wget neovim git
    ];

    # Uncomment this if you set up encryption in step 4a.
    # boot.initrd.luks.devices = [
    #   {
    #     name = "root";
    #     device = "$LVM_PARTITION"; # like: /dev/sda2
    #     preLVM = true;
    #   }
    # ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers.max = {
      name = "max";
      home = "/home/max";
      createHome = true;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      uid = 1337;
    };
  }
  ```

9. Grand finale!

  > nixos-install
  > reboot

## Environment setup

  > # Login to user
  > pwd # /home/max
  > git clone https://github.com/MaxOw/dotfiles
  > dotfiles/setup.sh

  > su # run as root
  > dotfiles/root-setup.sh
  > nixos-rebuild switch

  > reboot

## Basic Env installs

  > # It would be cool if user environments could also be setup
  > # declaratively...

  > # add nixpkgs channel
  > nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
  > nix-channel --update

  > nix-env -iA nixos.htop
  > nix-env -iA nixos.firefox-esr
  > nix-env -iA nixos.fd
  > nix-env -iA nixos.fzf
  > nix-env -iA nixos.ripgrep
  > nix-env -iA nixos.qbittorrent
  > nix-env -iA nixos.vlc
  > nix-env -iA nixos.wpa_gui
  > nix-env -iA nixos.xbacklight
  > nix-env -iA nixos.xdotool

# References

https://nixos.org/nixos/manual/
https://qfpl.io/posts/installing-nixos/

