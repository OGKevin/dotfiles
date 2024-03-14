{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    environment = {
      shellAliases = {
        dprune = "docker system prune --all -f";
        gui = "gitui";
        lg = "lazygit";
        update = ''
          darwin-rebuild switch --flake $HOME/projects/github.com/OGKevin/nix-darwin-config && \
          skhd -r && \
          # sketchybar --reload
          aqua i -a -l
        '';
      };
      systemPackages = [
        pkgs.crane
        pkgs.git
        pkgs.neovim
        pkgs.zsh
        pkgs.asdf-vm
        pkgs.ripgrep
        pkgs.jq
        pkgs.go
        pkgs.vscode
        pkgs.tmux
        pkgs.cachix
        pkgs.skhd
        pkgs.rustup
        pkgs.crane
      ];
      systemPath = [
        "$HOME/.aqua/bin"
        "$HOME/.asdf/shims"
        "$HOME/bin"
        "/Applications/kdiff3.app/Contents/MacOS/"
        "/opt/homebrew/bin"

      ];
    };
    homebrew = {
      brews = [ { name = "aqua"; } { name = "devcontainer"; } ];
      casks = [ { name = "font-hack-nerd-font"; } { name = "kdiff3"; } ];
      enable = true;
      taps = [{ name = "aquaproj/aqua"; }];
    };
    nixpkgs = { config = { allowUnfree = true; }; };
    programs = {
      zsh = {
        enable = true;
        enableFzfCompletion = true;
        enableFzfGit = true;
        enableFzfHistory = true;
        enableSyntaxHighlighting = true;
      };
    };
    security = { pam = { enableSudoTouchIdAuth = true; }; };
    services = {
      nix-daemon = { enable = true; };
      skhd = { enable = true; };
      yabai = {
        config = { layout = "bsp"; };
        enable = true;
      };
    };
    system = {
      defaults = {
        NSGlobalDomain = { _HIHideMenuBar = true; };
        dock = {
          autohide = true;
          mru-spaces = false;
        };
        finder = {
          AppleShowAllExtensions = true;
          FXPreferredViewStyle = "Nlsv";
        };
      };
    };
  };
}
