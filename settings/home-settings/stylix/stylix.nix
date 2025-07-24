{
  config,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.image = ../../../wallpapers/b-345.jpg;
  stylix.polarity = "dark";
  stylix.targets.starship.enable = false;
  stylix.targets.fish.enable = false;
  stylix.targets.zed.enable = false;
  stylix.targets.vscode.enable = false;

  stylix.cursor = {
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 48;
  };

  stylix.targets.zen-browser.profileNames = ["default"];

  stylix.opacity = {
    terminal = 0.6;
    desktop = 0.2;
  };
  stylix.fonts.sizes.terminal = 16;

  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
