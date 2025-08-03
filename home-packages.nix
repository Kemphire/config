{pkgs, ...}:
with pkgs; [
  bat
  zoxide
  fzf
  alacritty
  zathura
  vivaldi
  google-chrome
  fish
  kitty
  foot
  sioyek
  xremap # Have to set it up, first learn more about home-manager
  git
  lazygit
  openssh
  gh
  eza
  kdePackages.kdenlive
  pandoc
  haskellPackages.pandoc-crossref
  libreoffice-qt
  vesktop
  fastfetch
  neofetch
  neovim
  pokemon-colorscripts-mac
  # nodejs_24
  unzip
  zip
  python314
  alejandra
  nixd
  cargo
  imagemagickBig
  obsidian
  banana-cursor

  gnumake
  gopls

  telegram-desktop
  thunderbird

  zed-editor

  starship
  autotiling
  (flameshot.override {enableWlrSupport = true;})
  fuzzel

  devenv
]
