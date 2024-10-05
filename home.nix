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
      vivaldi
      (prismlauncher.override { jdks = [ jdk8 jdk17 jdk21 ]; })
      fastfetch
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
      dconf-editor
      pcmanfm-qt
      lxqt.lxqt-archiver
      networkmanagerapplet
      calibre
      wvkbd
      webcamoid
      praat
      pavucontrol
      avizo
      pamixer
      mako
      pandoc
    ])
    ++
    (with pkgs.kdePackages; [
    breeze
    breeze-gtk
    breeze-icons
    qtstyleplugin-kvantum
    qt6ct
    konsole
    yakuake
    kcalc
    okular
    kolourpaint
    gwenview
    filelight
    kate
    calligra
]);
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
    oh-my-zsh = {
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
    QT_QPA_PLATFORMTHEME = "kde";
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
