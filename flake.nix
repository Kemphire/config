{
  description = "flake config for my machines";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flakes = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ...
    self.submodules = true;
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    hostname = "kapil";
    userName = "hitmonlee";
  in {
    nixosConfigurations = {
      ${hostname} = lib.nixosSystem {
        inherit system;

        specialArgs = {inherit userName inputs;};

        modules = [
          ./configuration.nix
          # {
          #   _module.args = {inherit userName;};
          # }

          {
            environment.extraOutputsToInstall = ["dev"];

            environment.variables.C_INCLUDE_PATH = "${pkgs.expat.dev}/include";
          }
        ];
      };
    };
    homeConfigurations = {
      ${userName} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
          inherit userName;
        };
      };
    };
  };
}
