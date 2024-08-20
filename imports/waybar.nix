{ config, pkgs, lib, ... }:
{
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
}
