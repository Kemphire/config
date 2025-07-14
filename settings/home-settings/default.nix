{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./starship.nix
    ./theme-settings.nix
    ./vscode.nix
    ./wayland
    ./stylix
  ];
}
