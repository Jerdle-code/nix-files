{ config, pkgs, lib, ... }:
{
wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor"=",preferred,auto,1";
      "$mod" = "SUPER";
      "$terminal" = "konsole";
      "$fileManager" = "pcmanfm-qt";
      "$menu" = "wofi --show drun";
      "$run" = "wofi --show run";
      "$editor" = "kate";
      "$browser" = "vivaldi";
      general = {
        "gaps_out" = "0";
        "gaps_in" = "0";
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
        "$mod SHIFT, F, fullscreen,"
        "ALT, F2, exec, $run"
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
        "keepassxc --keyfile $HOME/FDO $HOME/FDO.kdbx"
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
      windowrulev2 = [
      "suppressevent maximize, class:.*"
      "suppressevent fullscreen, class:.*"
    ];
  };
  };
}
