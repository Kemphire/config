{
  config,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ../../../wallpapers/mount_fuji.jpeg;
  stylix.polarity = "dark";
  stylix.targets.kde.enable = false;
  stylix.targets.starship.enable = false;
  stylix.targets.fish.enable = false;

  stylix.cursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 48;
  };

  stylix.fonts.sizes.terminal = 16;
}
