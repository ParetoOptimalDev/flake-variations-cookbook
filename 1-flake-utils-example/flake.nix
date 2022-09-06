{
  description = "Very simple flake-utils-plus flake";  

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      # Modules shared between all hosts
      hostDefaults.modules = [
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
