{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./imports/ignore/user.nix
      ./imports/waybar.nix
      ./imports/hyprland.nix
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = (with pkgs; [
      firefox
      (prismlauncher.override { jdks = [ jdk8 jdk17 jdk21 ]; })
      fastfetch
      libreoffice-fresh
      superTuxKart
      superTux
      gzdoom
      openttd
      lm_sensors
      ryzenadj
      qbittorrent
      htop
      texlive.combined.scheme-full
      lyx
      texstudio
      openrct2
      audacity
      discord
      gimp
      protontricks
      musescore
      lmms
      hydrogen
      teams-for-linux
      gnubg
      brightnessctl
      gammastep
      nwg-look
      keepassxc
      thunderbird
      gnome.dconf-editor
      pcmanfm-qt
      eww
      lxqt.lxqt-archiver
      networkmanagerapplet
      calibre
      wvkbd
      webcamoid
      praat
      wofi
      waybar
      pavucontrol
      avizo
      pamixer
      mako
      nwg-drawer
      wlogout
    ])
    ++
    (with pkgs.kdePackages; [
    breeze
    breeze-gtk
    breeze-icons
    qtstyleplugin-kvantum
    qt6ct
    konsole
    kate
    kcalc
    okular
    kolourpaint
    gwenview
]);
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
    ohmyZsh = {
        enable = true;
        theme = "tjkirch";
    };
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  services.gammastep = {
    enable = true;
    dawnTime = "08:00";
    duskTime = "22:00";
    temperature = {
      day = 6500;
      night = 3700;
    };
  };
programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  gtk = {
    enable = true;

    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    gtk3.extraConfig = {
        gtk-application-prefer-dark-theme=1;
    };

    gtk4.extraConfig = {
        gtk-application-prefer-dark-theme=1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };
  services.mako = {
    enable = true;
    defaultTimeout = 4000;
    backgroundColor = "#2a2e32";
    borderRadius = 20;
    font = "monospace 12";
    padding = "10";
    height = 300;
    width = 500;
  };
  programs.home-manager.enable = true;
}
