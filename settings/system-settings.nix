{
  lib,
  pkgs,
  ...
}: {
  # ...

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 6;
  # boot.loader.grub.configurationLimit = 10;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "hitmonlee"];
  };

  # for electron apps running on wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # for storing secrets
  services.gnome.gnome-keyring.enable = true;
}
