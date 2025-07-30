{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = lib.mkAfter (pkgs.lib.importTOML ../../dotfiles_imper/.config/starship.toml);
  };
}
