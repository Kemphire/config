{
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 7;
        spacing = 3;
        bar_id = "bar-0";
        ipc = true;
        modules-left = [
          "tray"
          "sway/workspaces"
          "sway/scratchpad"
          "sway/window"
        ];
        modules-center = [
          "sway/mode"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "memory"
          "temperature"
          "backlight"
          "battery"
          "clock"
          "custom/power"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "5" = " ";
          };
        };

        "sway/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = ["" ""];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "sway/window" = {
          format = "{title}";
          max-length = 50;
        };

        "keyboard-state" = {
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        "tray" = {
          spacing = 5;
          icon-size = 16;
        };

        "clock" = {
          timezone = "Asia/Kolkata";
          format = "{:%H:%M:%p}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "cpu" = {
          format = "{usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = "{}% ";
        };

        "temperature" = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "${pkgs.kitty}/bin/kitty -e nmtui";
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        "custom/power" = {
          format = "⏻";
          tooltip = true;
          on-click = "${pkgs.wlogout}/bin/wlogout";
        };
      };
    };

    # Corrected GTK CSS for Waybar
    style = lib.mkBefore ''
      /* Universal selector for default styles */
      * {
        font-family: monospace, "Font Awesome 6 Free"; /* Added Font Awesome as a fallback for icons */
        font-size: 12px;
        min-height: 0;
        border: none;
        border-radius: 0;
        padding: 0 8px;
        margin: 0 2px;
      }

      /* Main bar styling */
      window#waybar {
        background-color: rgba(0, 0, 0, 0.8); /* Use background-color for better compatibility */
        color: #ffffff;
      }

      /* Workspaces module styling */
      #workspaces button {
        padding: 0 5px;
        color: #ffffff;
        background-color: transparent;
        border: none; /* Explicitly remove border from buttons */
      }

      #workspaces button.focused {
        background-color: #64727d;
      }

      #workspaces button.urgent {
        background-color: #f53c3c;
      }

      /* General styling for most modules */
      #mode, #scratchpad, #window, #memory, #temperature, #backlight, #battery, #network, #pulseaudio, #clock, #custom-power {
        padding: 0 8px;
        color: #ffffff;
      }

      /* Specific styling for the system tray */
      #tray {
        padding: 0 10px;
      }

      /* Hide the tray module when it is empty by making it take up no space */
      #tray.tray-empty {
        padding: 0;
        margin: 0;
        min-width: 0;
      }

      /* Hover effect for the power button */
      #custom-power:hover {
        background-color: rgba(255, 85, 85, 0.5); /* Use background-color */
      }
    '';
  };
}
