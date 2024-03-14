{ inputs, ... }@flakeContext:
let
  homeModule = { config, lib, pkgs, ... }: {
    imports = [ inputs.self.homeModules.default ];
    config = {
      home = { homeDirectory = lib.mkForce "/Users/kevinhellemun"; };
    };
  };
  nixosModule = { ... }: { home-manager.users.mollie-macos = homeModule; };
in ((inputs.home-manager.lib.homeManagerConfiguration {
  modules = [ homeModule ];
  pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
}) // {
  inherit nixosModule;
})
