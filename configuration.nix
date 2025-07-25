# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  userName,
  inputs,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./settings/system-settings.nix
    ./settings/gnome.nix
    ./settings/system-apps.nix

    # xremap
    inputs.xremap-flakes.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "kapil"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  services.timesyncd.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.xserver = {
    enable = false;
    windowManager.qtile.enable = false;
    displayManager.sessionCommands = ''
      xwallpaper --zoom /mnt/yummy/Pictures/wallpapers_many/b-846.jpg
      xset r rate 200 35 &
      xrandr --output eDP-1 --scale 0.75x0.75
    '';
  };

  # to enable kde-plasma
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.ly = {
      enable = false;
      package = pkgs.ly;
      settings = {
        greeter_msg = "Welcome to my linux machine";
      };
    };

    displayManager = {
      sddm = {
        wayland.enable = true;
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm;

        theme = "sddm-astronaut-theme";

        extraPackages = [sddm-astronaut];
      };
      autoLogin = {
        enable = false;
        user = userName;
      };
      sessionPackages = [pkgs.swayfx];

      # displayManager.sddm.enable = true;
      #
      # displayManager.sddm.wayland.enable = true;
    };
  };

  # mounting my old data
  fileSystems."/mnt/yummy" = {
    device = "/dev/disk/by-uuid/23f9823f-d6e0-4eaa-8d8f-8f70b686be4c";
    fsType = "btrfs";
    options = ["defaults" "user" "rw"];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hitmonlee = {
    isNormalUser = true;
    description = "Kartikey";
    extraGroups = ["wheel" "video" "networkmanager"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    home = "/home/hitmonlee";
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;

  # temporary solution to run binaries in nix-os
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glibc
      zlib
      openssl
      libgcc
    ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages =
    import ./packages.nix {inherit pkgs;}
    ++ [
      sddm-astronaut
      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default # Wayland
    ];

  # for fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code-symbols
    font-awesome
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

  # All the custom thing go here from now

  documentation.dev.enable = true;

  # environment.extraOutputsToInstall = [ "dev" ];
  #
  # environment.variables.C_INCLUDE_PATH = "${pkgs.expat.dev}/include";

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  services.xremap = {
    # enable = true;
    # withHypr = false;
    # withKDE = true;
    # withWlroots = false;
    # userName = userName;
    # serviceMode = "user";

    yamlConfig = ''
      modmap:
        - name: main remaps
          remap:
            CapsLock:
              held: leftctrl
              alone: esc
              alone_timeout_millis: 250

      keymap:
        - name: caps revival
          remap:
            SHIFT-KEY_ESC: CapsLock
    '';
  };

  programs.light.enable = true;
  security = {
    polkit.enable = true;

    pam.services = {
      login.enableGnomeKeyring = true;
      passwd.enableGnomeKeyring = true;
      sddm.enableGnomeKeyring = true; # if using SDDM
      swaylock = {};
    };
  };

  # to avoid getting stuck for minutes in building mach-caches
  documentation.man.generateCaches = false;

  # security.pam.services.swaylock = {};

  # to enable xdg portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
