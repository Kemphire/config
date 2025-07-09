{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.banana-cursor;
      name = "Banana";
    };
    cursorTheme.size = 40;
  };
}
