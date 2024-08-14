{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

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
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/daniel/etc/profile.d/hm-session-vars.sh
  #
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
    userName = "Jerdle-code";
    userEmail = "danielamdurer@gmail.com";
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor"=",preferred,auto,1";
      "$mod" = "SUPER";
      "$terminal" = "konsole";
      "$fileManager" = "pcmanfm-qt";
      "$menu" = "wofi --show drun";
      "$editor" = "kate";
      "$browser" = "firefox";
      general = {
        "gaps_out" = "0";
      };
      bind = [
        "$mod, T, exec, $terminal"
        "$mod, B, exec, $browser"
        "$mod, Return, exec, $terminal"
        "ALT, F4, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, F, exec, $fileManager"
        "$mod, E, exec, $editor"
        "$mod, V, togglefloating,"
        "$mod, G, togglegroup,"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo, # dwindle"
        "$mod, J, togglesplit, # dwindle"
        ",XF86AudioRaiseVolume, exec, volumectl -u up"
        ",XF86AudioLowerVolume, exec, volumectl -u down"
        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioMicMute, exec, volumectl -m toggle-mute"
        ",XF86MonBrightnessUp, exec, lightctl up"
        ",XF86MonBrightnessDown, exec, lightctl down"
        "ALT,Tab,cyclenext,"
        "ALT,Tab,bringactivetotop,"
        "ALT,Tab,changegroupactive,"
      ];
      bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      ];
      exec-once =
      [
        "lxqt-policykit-agent"
        "nm-applet"
        "keepassxc --keyfile /home/daniel/FDO /home/daniel/FDO.kdbx"
        "gammastep"
        "wvkbd-mobintl"
        "waybar"
        "avizo-service"
        "mako"
      ];
      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = true;
      };
      group = {
        groupbar = {
          font_size = 12;
          height = 20;
          "col.active" = "0xff3daee9";
          "col.inactive" = "0xff2a2e32";
        };
        "col.border_active" = "0xff3daee9";
        "col.border_inactive" = "0xff2a2e32";
      };
    };
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
    "height" = 30;
    "spacing" = 4;
    "modules-left" = [
        "custom/drawer"
    ];
    "modules-center" = [
        "clock"
    ];
    "modules-right" = [
        "pulseaudio"
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "battery"
        "tray"
        "custom/power"
    ];
    "keyboard-state" = {
        "numlock" = true;
        "capslock"= true;
        "format"= "{name} {icon}";
        "format-icons"= {
            "locked"= "";
            "unlocked"= "";
        };
    };
    "idle_inhibitor"= {
        "format"= "{icon}";
        "format-icons"= {
            "activated"= "";
            "deactivated"= "";
        };
    };
    "tray"= {
        "spacing"= 10;
    };
    "clock"= {
        "tooltip-format"= "<big><tt>{calendar}</tt></big>";
        "format-alt"= "{:%Y-%m-%d}";
    };
    "cpu"= {
        "format"= "{usage}% ";
        "tooltip"= true;
    };
    "memory"= {
        "format"= "{}% ";
    };
    "temperature"= {
        "critical-threshold"= 80;
        "format"= "{temperatureC}°C {icon}";
        "format-icons"= [
        ""
        ""
        ""
        ];
    };
    "backlight"= {
        "format"= "{percent}% {icon}";
        "format-icons"= [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ];
    };
    "battery"= {
        "states"= {
            "warning"= 20;
            "critical"= 10;
        };
        "format"= "{capacity}% {icon}";
        "format-full"= "{capacity}% {icon}";
        "format-charging"= "{capacity}% ";
        "format-plugged"= "{capacity}% ";
        "format-alt"= "{time} {icon}";
        "format-icons"= [
        ""
        ""
        ""
        ""
        ""
        ];
    };
    "power-profiles-daemon"= {
      "format"= "{icon}";
      "tooltip-format"= "Power profile= {profile}\nDriver= {driver}";
      "tooltip"= true;
      "format-icons"= {
        "default"= "";
        "performance"= "";
        "balanced"= "";
        "power-saver"= "";
      };
    };
    "network" = {
        "format-wifi"= "{essid} ({signalStrength}%) ";
        "format-ethernet"= "{ipaddr}/{cidr} ";
        "tooltip-format"= "{ifname} via {gwaddr} ";
        "format-linked"= "{ifname} (No IP) ";
        "format-disconnected"= "Disconnected ⚠";
        "format-alt"= "{ifname}= {ipaddr}/{cidr}";
    };
    "pulseaudio"= {
        "format"= "{volume}% {icon} {format_source}";
        "format-bluetooth"= "{volume}% {icon} {format_source}";
        "format-bluetooth-muted"= " {icon} {format_source}";
        "format-muted"= " {format_source}";
        "format-source"= "{volume}% ";
        "format-source-muted"= "";
        "format-icons"= {
            "headphone"= "";
            "hands-free"= "";
            "headset"= "";
            "phone"= "";
            "portable"= "";
            "car"= "";
            "default"= [
            ""
            ""
            ""
            ];
        };
        "on-click"= "pavucontrol";
    };
    "custom/drawer" = {
    "format"= "⮟";
    "tooltip"= false;
    "on-click"= "exec nwg-drawer";
        };
    "custom/power" = {
    "format"= "⏻";
    "tooltip"= false;
    "on-click"= "exec wlogout";
  };
};
  };
  style =
"
@define-color red #da4453;
@define-color orange #f67400;
@define-color yellow #f6e400;
@define-color green #27ae60;
@define-color blue #3daee9;
@define-color purple #6027ae;
@define-color dark #2a2e32;
@define-color light #eff0f1;

* {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
}

window#waybar {
    background-color: @dark;
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: @light;
    transition-property: background-color;
    transition-duration: .5s;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#custom-drawer,
#mpd {
    padding: 0 10px;
    color: @light;
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: @dark;
    color: @light;
}

#custom-drawer {
    background-color: @purple;
    color: @light;
}

#battery {
    background-color: @blue;
    color: @dark;
}
#battery.warning {
    background-color: @orange;
    color: @dark;
}
#battery.charging, #battery.plugged {
    color: @light;
    background-color: @green;
}

@keyframes blink {
    to {
    background-color: @light;
    color: @dark;
    }
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    background-color: @red;
    color: @light;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#power-profiles-daemon {
    padding-right: 15px;
}

#power-profiles-daemon.performance {
    background-color: @red;
    color: @light;
}

#power-profiles-daemon.balanced {
    background-color: @blue;
    color: @light;
}

#power-profiles-daemon.power-saver {
    background-color: @green;
    color: @dark;
}

label:focus {
    background-color: @dark;
}

#cpu {
    background-color: @yellow;
    color: @dark;
}

#memory {
    background-color: @yellow;
    color: @dark;
}

#disk {
    background-color: @yellow;
    color: @dark;
}

#backlight {
    background-color: @light;
    color: @dark;
}

#network {
    background-color: @blue;
}

#network.disconnected {
    background-color: @red;
}

#pulseaudio {
    background-color: @purple;
    color: @light;
}


#temperature {
    background-color: @orange;
    color: @dark;
}

#temperature.critical {
    background-color: @red;
}

#tray {
    background-color: @blue;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: @red;
}";
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
