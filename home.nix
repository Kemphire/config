{
  config,
  pkgs,
  inputs,
  lib,
  userName,
  ...
}: let
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  imports = [
    # inputs.zen-browser.homeModules.beta
    inputs.zen-browser.homeModules.twilight

    # stylix
    inputs.stylix.homeModules.stylix

    # or inputs.zen-browser.homeModules.twilight-official
    ./settings/home-settings
  ];

  # find alternative for it
  # home.backupFileExtension = "backup";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = import ./home-packages.nix {inherit pkgs;};

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
    # ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink (builtins.toString "${configDir}/.config/nvim");
  };

  # a good workaround but not the best
  # xdg.configFile."nvim" = {
  #   source = ./dotfiles_imper/.config/nvim;
  #   recursive = true;
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hitmonlee/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    # MANPAGER = "nvim +Man!";
  };

  home.pointerCursor = lib.mkDefault {
    enable = true;
    name = "Banana";
    package = pkgs.banana-cursor;
    x11 = {
      enable = true;
      defaultCursor = "Banana";
    };
    size = 48;
    gtk.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix btw";
      ls = "eza -lah --icons";
    };
    shellAbbrs = {
      nrs = "sudo nixos-rebuild switch";
      n = "nvim";
      gs = "git status";
      ga = "git add -A";
      gc = "git commit";
      gp = "git push";
      gco = "git checkout";
      lg = "lazygit";
    };
    plugins = with pkgs.fishPlugins; [
      # {
      #   name = "pure";
      #   src = pure.src;
      # }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
    ];
    shellInit = ''
      function fish_default_key_bindings
      	fish_vi_key_bindings
      end
      function ls
      	eza -lah --icons $argv
      end
    '';
    interactiveShellInit = ''
      if test -d "$HOME/.bun/bin"
      	 fish_add_path "$HOME/.bun/bin"
      end
      set fish_greeting
    '';
  };
  programs.kitty = {
    enable = true;
    settings = lib.mkAfter {
      scrollback_lines = 10000;
      disable_ligatures = "never";
      cursor_shape = "beam";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      background_blur = 5;
      cursor_trail = 1;
    };
    extraConfig = ''
      scrollback_pager nvim -u ${./dotfiles_imper/.config/nvim/kitty+page.lua} -R -M -
    '';
    shellIntegration.enableFishIntegration = true;
  };

  programs.alacritty = lib.mkDefault {
    enable = true;
    settings = {
      window.opacity = 0.8;
      font = {
        size = 16;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
      };
    };
  };

  programs.vivaldi.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.zoxide.enableFishIntegration = true;
  programs.fzf.enableFishIntegration = true;

  programs.sioyek = lib.mkDefault {
    enable = true;
    config = {
      "should_launch_new_window" = "1";
      "default_dark_mode" = "1";
      "show_doc_path" = "1";
    };
  };

  programs.git = {
    enable = true;
    userName = "Kartikey Shahi";
    userEmail = "kartikeyshahi@hotmail.com";
    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };

  programs.lazygit.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 30;
    addKeysToAgent = "confirm";

    # matchBlocks = {
    #   "github.com" = {
    #     identityFile = "~/.ssh/id_ed25519";
    #   };
    # };
  };

  programs.gh.enable = true;
  programs.vesktop.enable = true;
  programs.fastfetch.enable = true;

  # thunderbird configuration
  programs.thunderbird = lib.mkDefault {
    enable = true;

    profiles = {
      personal = {
        isDefault = true;
        settings = {
          "mail.identity.id1.fullName" = "Kartikey";
          "mail.identity.id1.useremail" = "kartikeyshahi@hotmail.com";
        };
      };

      work = {
        isDefault = false;
        settings = {
          "mail.identity.id1.fullName" = "Kartikey Shahi";
          "mail.identity.id1.useremail" = "kartikey.23558@sscbs.du.ac.in";
          "withPrivateBrowsing" = true;
        };
      };
    };
  };

  # zen-browser
  programs.zen-browser = {
    enable = true;
    policies = {
      FirefoxHome = {
        Search = true;
      };
      Preferences = {
        "zen.tabs.vertical.right-side" = {
          "value" = true;
          "Status" = "locked";
        };
        "zen.urlbar.behavior" = {
          "value" = "floating-on-type";
          "Status" = "locked";
        };
        "zen.view.compact.hide-toolbar" = {
          "value" = true;
          "Status" = "locked";
        };
      };
    };
  };

  programs.foot = lib.mkDefault {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        font = "FiraCode Nerd Font:size=16";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };

      colors = {
        alpha = 0.7;
      };
    };
  };

  programs.zed-editor = {
    enable = true;
  };

  programs.fuzzel.settings = {
    main = {
      terminal = "${pkgs.foot}/bin/foot";
      layer = "overlay";
    };
  };

  # configure services here
  services = {
    ssh-agent.enable = true;
    kdeconnect.indicator = true;
  };
}
