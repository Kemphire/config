{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = lib.mkForce "dmenu";
  };
}
