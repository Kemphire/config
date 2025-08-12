{...}: {
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "image/png" = ["oculante.desktop"];
      "image/gif" = ["oculante.desktop"];
      "image/jpeg" = ["oculante.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/mp3" = ["mpv.desktop"];
      "audio/mp4" = ["mpv.desktop"];
      "audio/vnd.wave" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "video/mkv" = ["mpv.desktop"];
      # Text (neovim)
      "application/xml" = ["nvim.desktop"];
      "text/plain" = ["nvim.desktop"];
      "text/x-csrc" = ["nvim.desktop"];
      # Browser
      "text/html" = ["zen-twilight.desktop"];
      "x-scheme-handler/http" = ["zen-twilight.desktop"];
      "x-scheme-handler/https" = ["zen-twilight.desktop"];
      "x-scheme-handler/about" = ["zen-twilight.desktop"];
      "x-scheme-handler/unknown" = ["zen-twilight.desktop"];
    };
  };
}
