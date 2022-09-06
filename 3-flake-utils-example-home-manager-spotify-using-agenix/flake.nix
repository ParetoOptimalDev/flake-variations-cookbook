{
  description = "Very simple flake-utils-plus flake with home-manager";  

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
    home-manager = {
      url = github:nix-community/home-manager/release-21.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, utils, home-manager }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      # Modules shared between all hosts
      hostDefaults.modules = [
        home-manager.nixosModules.home-manager
        ./modules/sharedConfigurationBetweenHosts.nix
      ];

      hosts.Rick.modules = [
        ./hosts/Rick.nix
      ];

      sharedOverlays = [
        self.overlay
      ];

      overlay = import ./overlays;
    };
}
