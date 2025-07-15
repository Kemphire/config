{
  pkgs,
  config,
  lib,
  ...
}: {
  wayland = {
    windowManager = {
      sway = {
        enable = true;
        package = pkgs.sway;
        xwayland = true;
        wrapperFeatures.gtk = true;
        # there is a bug in swayfx for which we have to make it false
        checkConfig = true;
        config = rec {
          modifier = "Mod4";
          terminal = "kitty";
          startup = [
            {
              command = "kdeconnectd";
              always = true;
            }
            {
              command = "--no-startup-id gnome-keyring-daemon --start --components=pkcs11,secrets,ssh";
              always = false;
            }
            {
              command = "sway-audio-idle-inhibit";
              always = true;
            }
            {
              command = "swaync";
              always = true;
            }
            {
              command = "autotiling";
              always = true;
            }
            {
              command = "clipse -listen";
              always = true;
            }
          ];
          up = "k";
          down = "j";
          left = "h";
          right = "l";
          menu = "${pkgs.fuzzel}/bin/fuzzel";
          gaps = {
            inner = 5;
            outer = 2;
            smartGaps = true;
            smartBorders = "on";
          };
          bindkeysToCode = true;
          seat = {
            "*" = {
              hide_cursor = "when-typing enable";
            };
          };
          keybindings = let
            pactl = "${pkgs.wireplumber}/bin/wpctl";
            brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
            playerctl = "${pkgs.playerctl}/bin/playerctl";
          in {
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+d" = "exec ${menu}";
            "${modifier}+c" = "kill";
            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

            "${modifier}+${left}" = "focus left";
            "${modifier}+${down}" = "focus down";
            "${modifier}+${up}" = "focus up";
            "${modifier}+${right}" = "focus right";

            "${modifier}+Shift+${left}" = "move left";
            "${modifier}+Shift+${down}" = "move down";
            "${modifier}+Shift+${up}" = "move up";
            "${modifier}+Shift+${right}" = "move right";

            "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

            "XF86MonBrightnessDown" = "exec ${brightnessctl} set 5%-";
            "XF86MonBrightnessUp" = "exec ${brightnessctl} set 5%+";

            "XF86AudioPlay" = "exec ${playerctl} play-pause";
            "XF86AudioPause" = "exec ${playerctl} play-pause";
            "XF86AudioNext" = "exec ${playerctl} next";
            "XF86AudioPrev" = "exec ${playerctl} previous";
            "XF86AudioStop" = "exec ${playerctl} stop";
            "XF86Search" = "exec ${pkgs.wofi}/bin/wofi";

            "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | wl-copy'';
            "Ctrl+Print" = "exec ${pkgs.grim}/bin/grim - | wl-copy";

            "${modifier}+g" = "gaps inner all plus 10";
            "${modifier}+Shift+g" = "gaps inner all minus 10";
            "${modifier}+Control+g" = "gaps outer all plus 10";
            "${modifier}+Control+Shift+g" = "gaps outer all minus 10";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";

            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+f" = "fullscreen";
            # "${modifier}+Shift+h" = "splith";
            # "${modifier}+v" = "splitv";

            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";

            "${modifier}+space" = "focus mode_toggle";
            "${modifier}+Shift+minus" = "move scratchpad";
            "${modifier}+minus" = "scratchpad show";
            "${modifier}+r" = "mode \"resize\"";

            "${modifier}+Shift+v" = "exec kitty --class clipse -e 'clipse'";

            "${modifier}+b" = "exec kitty --class clipse -e 'bluetuith'";

            "${modifier}+n" = "exec foot --app-id nmtui -e nmtui";
          };
          floating = {
            border = 0;
            titlebar = false;
          };
          bars = [
            {
              command = "waybar";
              position = "top";
            }
          ];
          window = {
            border = 2;
            titlebar = false;
            commands = [
              {
                command = "floating enable, resize set width 400 px height 225px, sticky on, dim_inactive 0.0";
                criteria = {
                  title = "Picture-in-Picture";
                };
              }
            ];
          };
          modes = {
            resize = {
              Down = "resize grow height 10 px";
              Escape = "mode default";
              Left = "resize shrink width 10 px";
              Return = "mode default";
              Right = "resize grow width 10 px";
              Up = "resize shrink height 10 px";
              h = "resize shrink width 10 px";
              j = "resize grow height 10 px";
              k = "resize shrink height 10 px";
              l = "resize grow width 10 px";
            };
          };
          colors = lib.mkDefault {
            focused = {
              border = "#ffaa99";
              background = "#000000";
              text = "#eeeeec";
              indicator = "#000000";
              childBorder = "#000000";
            };
            focusedInactive = {
              border = "#1d2021";
              background = "#1d2021";
              text = "#babdb6";
              indicator = "#323232";
              childBorder = "#323232";
            };
            unfocused = {
              border = "#1d2021";
              background = "#1d2021";
              text = "#babdb6";
              indicator = "#323232";
              childBorder = "#323232";
            };
            urgent = {
              border = "#000000";
              background = "#000000";
              text = "#eeeeec";
              indicator = "#323232";
              childBorder = "#323232";
            };
            placeholder = {
              border = "#1d2021";
              background = "#1d2021";
              text = "#babdb6";
              indicator = "#323232";
              childBorder = "#323232";
            };
          };
          output = {
            eDP-1 = {
              scale = "1.3";
            };
          };
        };
        extraConfigEarly = ''
          exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1

          input "10182:480:DELL09EC:00_27C6:01E0_Touchpad" {
          dwt enabled
          tap enabled
          natural_scroll disabled
          middle_emulation enabled
          }


          set $width 824
          set $height 652


          # for setting clipse as a menu in kitty and calling it with a hotkey
          for_window [app_id="clipse"] floating enable,sticky enable, border pixel 5, resize set $width $height
          # size for sway-launcher-desktop

          # for setting nmtui as a menu in kitty and calling it with a hotkey
          for_window [app_id="nmtui"] floating enable,sticky enable, border pixel 5, resize set $width $height


          # for setting blutuith as a menu in kitty and calling it with a hotkey
          for_window [app_id="bluetuith"] floating enable,sticky enable,border pixel 10, resize set $width $height


          for_window [app_id="launcher"] floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 10

          exec swayidle -w \
          timeout 300 '${pkgs.libnotify}/bin/notify-send "Locking in 5 seconds" -t 5000' \
          timeout 350 'swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2' \
          timeout 400 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
          timeout 500 'systemctl suspend' \
          before-sleep 'swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2' \
          after-resume 'swaymsg "output * power on"' \
          lock 'swaymsg "output * power off"; swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2' \
          unlock 'swaymsg "output * power on"'
        '';
        extraConfig = let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in ''
          # shadows enable
          # shadow_color #f9fc3f
          # smart_corner_radius enable
          # corner_radius 5
          # shadow_blur_radius 3
          # blur enable
          # blur_radius 3
          # blur_passes 3
          # blur_noise 0.08
          # shadows_on_csd enable
          # blur_xray enable
          # focus_follows_mouse yes
          #
          # layer_effects "wofi" blur enable; shadows disable; corner_radius 13
          # layer_effects "fuzzel" blur enable; shadows enable; corner_radius 13

          set $exit "Chose anyone option of exit: [s]leep, [p]oweroff, [r]eboot, [l]ogout"

          mode $exit {
          bindsym --to-code {
          s exec systemctl suspend, mode "default"
          p exec systemctl poweroff
          r exec systemctl reboot
          l exec swaymsg exit

          Return mode "default"
          Escape mode "default"
          ${modifier}+x mode "default"
          }
          }

          bindsym --to-code ${modifier}+x mode $exit

          bindgesture {
          swipe:right workspace prev
          swipe:left workspace next
          }

          # Allow container movements by pinching them
          bindgesture {
          pinch:inward+up move up
          pinch:inward+down move down
          pinch:inward+left move left
          pinch:inward+right move right
          }
        '';
      };
    };
  };

  services.swayidle = let
    # Lock command
    lock = ''      ${pkgs.swaylock-effects}/bin/swaylock --screenshots \
      	--clock \
      	--indicator \
      	--indicator-radius 100 \
      	--indicator-thickness 7 \
      	--effect-blur 7x5 \
      	--effect-vignette 0.5:0.5 \
      	--ring-color bb00cc \
      	--key-hl-color 880033 \
      	--line-color 00000000 \
      	--inside-color 00000088 \
      	--separator-color 00000000 \
      	--grace 2 \
      	--fade-in 0.2'';
    # TODO: modify "display" function based on your window manager
    # Sway
    display = status: "swaymsg 'output * power ${status}'";
    # Hyprland
    # display = status: "hyprctl dispatch dpms ${status}";
    # Niri
    # display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    # this is enabled througout the system so not enable it and just use it directly
    enable = false;
    timeouts = [
      {
        timeout = 300; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 350;
        command = lock;
      }
      {
        timeout = 400;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 500;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        # adding duplicated entries for the same event may not work
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
      {
        event = "unlock";
        command = display "on";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
    };
  };

  programs.wofi = {
    enable = true;
    package = pkgs.wofi;

    settings = {
      mode = "drun";
      allow_images = true;
      term = "kitty";
      width = "70%";
      insensitivity = true;
      prompt = "Hello my grace!";
    };

    style = ''
      			* {
      	border-radius: 0.5em;
      }
      window{
      	font-size: 32px;
      	font-family: "JetBrains Mono Nerd Medium";
      	background-color: rgba(50, 50, 50, 0.4);
      	color: crimson;
      	border-radius: 1em;
      }

      #entry:selected {
      	background-color: #da8fd2;
      }

      #text:selected {
      	color: #3f7d20;
      }

      #input {
      	background-color: rgba(EA, 34, 36, 0.5);
      	color: #f6f5ae;
      	padding: 0.3em;
      }

      #entry {
      	padding: 0.3em;
      }

      image {
      	margin-left: 0.2em;
      	margin-right: 0.2em;
      }

    '';
  };
  services.clipse = {
    enable = true;
    imageDisplay.type = "kitty";
    package = pkgs.clipse;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  home.packages = [pkgs.swaynotificationcenter pkgs.sway-audio-idle-inhibit pkgs.swayidle pkgs.libsecret];
}
