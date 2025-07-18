{pkgs, ...}:
with pkgs; [
  vim
  wget
  gcc
  kitty
  fish
  bluetui
  bluez
  bluetuith
  nautilus
  xwallpaper
  clipse
  yazi
  mpv
  qalculate-qt
  libqalculate

  # kde utils
  # kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
  kdePackages.kcalc # Calculator
  kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
  kdePackages.kcolorchooser # A small utility to select a color
  kdePackages.kdeconnect-kde
  kdePackages.kolourpaint # Easy-to-use paint program
  kdePackages.ksystemlog # KDE SystemLog Application
  kdePackages.sddm-kcm # Configuration module for SDDM
  kdiff3 # Compares and merges 2 or 3 files or directories
  kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
  kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
  kdePackages.plasma-browser-integration
  hardinfo2 # System information and benchmarks for Linux systems
  haruna # Open source video player built with Qt/QML and libmpv
  wayland-utils # Wayland utilities
  wl-clipboard # Command-line copy/paste utilities for Wayland

  man-pages
  man-pages-posix

  ripgrep

  # workaround for using linux the normal way
  distrobox

  pavucontrol
]
