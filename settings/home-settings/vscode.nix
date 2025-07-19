{pkgs, ...}: let
  extensions = with pkgs.vscode-extensions; [
    ms-toolsai.jupyter
    ms-python.python
    ms-python.vscode-pylance
    wakatime.vscode-wakatime
  ];
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles = {
      "hitmonlee" = {
        enableUpdateCheck = false;
        userSettings = {
          "github.copilot.enable" = {
            "*" = false;
            "plaintext" = false;
            "markdown" = false;
            "scminput" = false;
            "chat.editor.fontFamily" = "FiraCode Nerd Font";
          };
          "files.autoSave" = "afterDelay";
          "editor.fontFamily" = "FiraCode Nerd Font Propo";
        };
        extensions = extensions;
      };
      "default" = {
        enableUpdateCheck = false;
        userSettings = {
          "github.copilot.enable" = {
            "*" = false;
            "plaintext" = false;
            "markdown" = false;
            "scminput" = false;
            "chat.editor.fontFamily" = "FiraCode Nerd Font";
          };
          "files.autoSave" = "on";
        };
        extensions = extensions;
      };
    };
  };
}
