{pkgs, ...}: {
  imports = [
    ./sway.nix
    ./waybar.nix
    ./rofi.nix
  ];
}
