{
  description = "";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs:
    let flakeContext = { inherit inputs; };
    in {
      darwinConfigurations = {
        mollie = import ./darwinConfigurations/mollie.nix flakeContext;
      };
      darwinModules = {
        default = import ./darwinModules/default.nix flakeContext;
      };
      homeConfigurations = {
        mollie-macos =
          import ./homeConfigurations/mollie-macos.nix flakeContext;
        mollie-ubuntu =
          import ./homeConfigurations/mollie-ubuntu.nix flakeContext;
      };
      homeModules = {
        default = import ./homeModules/default.nix flakeContext;
      };
    };
}
