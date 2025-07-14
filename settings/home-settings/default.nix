{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./theme-settings.nix
    ./vscode.nix
    ./wayland
  ];
}
