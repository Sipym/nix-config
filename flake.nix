{
  description = "My simple Nix + Home Manager setup";

  nixConfig = {
    extra-substituters = [
      "https://cache.m7.rs"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    # Nix ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-circt1-62-0.url = "github:nixos/nixpkgs/9ed792777ae7967fee22dae2e88fdb6cb965b193";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-circt1-62-0,
    home-manager,
    ...
  } @ inputs: let
    system = "aarch64-linux";
    # 导入指定的nixpkgs版本
    pkgs-circt = import nixpkgs-circt1-62-0 {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        (final: prev: {
          circt = pkgs-circt.circt;
        })
      ];
    };
  in {

    # Standalone home-manager config
    homeConfigurations = {
      "awjl@ubuntu-nix" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs; # Home-manager requires 'pkgs' instance
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
