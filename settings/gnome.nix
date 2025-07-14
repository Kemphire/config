{
  pkgs,
  lib,
  ...
}: {
  # Enable the gnome
  services.desktopManager.gnome.enable = true;
  # Exclude unnecessary GNOME applications
  environment.gnome.excludePackages = with pkgs; [
    # Games
    gnome-sudoku
    gnome-mahjongg
    gnome-mines
    quadrapassel
    iagno
    hitori
    atomix
    lightsoff
    five-or-more
    four-in-a-row
    gnome-klotski
    gnome-nibbles
    gnome-robots
    gnome-taquin
    gnome-tetravex
    swell-foop
    tali

    # Other apps you might not need
    epiphany # GNOME Web browser
    gnome-music
    gnome-photos
    totem # Video player
    simple-scan
    gnome-contacts
    gnome-maps
    gnome-weather
    gnome-clocks
    gnome-calendar
    cheese # Webcam app

    # Documentation
    yelp # Help viewer
    gnome-user-docs
  ];

  # Essential packages for proper GNOME functionality
  environment.systemPackages = with pkgs; [
    # System tray support
    gnomeExtensions.appindicator

    # Essential GNOME tools
    gnome-tweaks
    dconf-editor

    # File manager essentials
    nautilus
    file-roller # Archive manager

    # System utilities
    gnome-system-monitor
    gnome-disk-utility
    gnome-calculator

    # Text editor
    gnome-text-editor

    # Terminal
    gnome-terminal

    # Settings and control
    gnome-control-center

    # Keyring GUI
    seahorse
  ];

  # Enable essential services
  services.gnome = {
    gnome-keyring.enable = true;
    glib-networking.enable = true;
    gnome-online-accounts.enable = true;
  };

  # Enable dconf for settings
  programs.dconf.enable = true;

  # UDev packages for hardware support
  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];

  # Optional: Enable profiling tools
  services.sysprof.enable = true;

  # Enable GDM auto-login (optional)
  # services.xserver.displayManager.gdm.autoLogin = {
  #   enable = true;
  #   user = "yourusername";
  # };

  # to avoid conflict between kde and gnome
  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  # polkit service
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
