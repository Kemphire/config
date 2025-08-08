{pkgs, ...}: {
  home.sessionVariables = {
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
  };
}
