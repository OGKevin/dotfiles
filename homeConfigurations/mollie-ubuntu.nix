{ inputs, ... }@flakeContext:
let
  homeModule = { config, lib, pkgs, ... }: {
    imports = [ inputs.self.homeModules.default ];
    config = {
      xsession = { windowManager = { awesome = { enable = true; }; }; };
    };
  };
  nixosModule = { ... }: { home-manager.users.mollie-ubuntu = homeModule; };
in ((inputs.home-manager.lib.homeManagerConfiguration {
  modules = [ homeModule ];
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
}) // {
  inherit nixosModule;
})
