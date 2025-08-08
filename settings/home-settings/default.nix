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
    ./btop.nix
    ./stylix
    ./envVars.nix
  ];
}
