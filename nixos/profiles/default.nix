# Install using `./profile-env-setup`, from then on use `update-profile`.
{ pkgs ? import <nixpkgs> {}
, name ? "user-env"
}: with pkgs;

let firefoxTri = firefox.override {
      # libpulseaudio = pkgs.libpressureaudio;
      cfg.enableTridactylNative = true;
    };

in buildEnv {
  inherit name;
  extraOutputsToInstall = ["out" "bin" "lib"];
  # config.firefox.enableTridactylNative = true;
  paths = [

    ncpamixer
    htop
    fzf fd ripgrep
    pass
    wpa_supplicant
    wpa_supplicant_gui
    vlc
    tealdeer
    xdotool

    xclip # Clipboard access from command line in X
    # xclip -o -sel clip # print clipboard content

    # firefox.override {
    firefoxTri

    (writeShellScriptBin "update-profile" ''
      nix-env --set -f ~/dotfiles/nixos/profiles/default.nix \
              --argstr name "$(whoami)-user-env-$(date -I)"
    '')

    (writeShellScriptBin "toggle-touchpad" ''
      ${builtins.readFile ./toggle-touchpad.sh}
    '')

    (writeShellScriptBin "pkill-firefox" ''
      pkill -f firefox
    '')

    # Manifest to make sure imperative nix-env doesn't work (otherwise
    # it will overwrite the profile, removing all packages other than
    # the newly-installed one).
    (writeTextFile {
      name = "break-nix-env-manifest";
      destination = "/manifest.nix";
      text = ''
        throw ''\''
          Your user environment is a buildEnv which is incompatible with
          nix-env's built-in env builder. Edit your home expression and run
          update-profile instead!
        ''\''
      '';
    })
    # To allow easily seeing which nixpkgs version the profile was built
    # from, place the version string in ~/.nix-profile/nixpkgs-version
    (writeTextFile {
      name = "nixpkgs-version";
      destination = "/nixpkgs-version";
      text = lib.version;
    })

    # Add command to display nixpkgs-version of current env
    (writeScriptBin "nixpkgs-version" ''
      #!${stdenv.shell}
      cat ~/.nix-profile/nixpkgs-version
    '')
  ];
}

# Other:

# acpi
# cabal2nix
# cachix
# calibre
# evince
# file
# gnupg
# gnuplot
# google-chrome
# highlight
# imagemagick
# libnotify
# nix-prefetch-git
# nix-repl
# openssl
# powertop
# qbittorrent
# slack
# tree
# unzip
# xbacklight
