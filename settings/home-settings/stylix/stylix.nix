{
  config,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.image = ../../../wallpapers/b-061.jpg;
  stylix.polarity = "dark";
  stylix.targets.starship.enable = false;
  stylix.targets.fish.enable = false;
  stylix.targets.zed.enable = false;

  stylix.cursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 48;
  };

  stylix.targets.zen-browser.profileNames = ["default"];

  stylix.opacity.terminal = 0.6;
  stylix.fonts.sizes.terminal = 16;
}
