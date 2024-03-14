{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  imports = [
    ../dotfiles/ssh/default.nix
    ../dotfiles/config/default.nix
    ../scripts/default.nix
  ];
  config = {
    home = {
      packages = [
        pkgs.google-cloud-sdk
        pkgs.httpie
        pkgs.fzf
        pkgs.git-branchless
        pkgs.diff-so-fancy
        pkgs._1password
        pkgs._1password-gui
        pkgs.nb
        pkgs.nnn
        pkgs.nodejs_20
      ];
      sessionVariables = {
        AQUA_ROOT_DIR = "$HOME/.aqua";
        AQUA_GLOBAL_CONFIG = "$HOME/.config/aqua/aqua.yaml";
        AQUA_POLICY_CONFIG = "$HOME/.config/aqua/policy.yaml";
        SSH_AUTH_SOCK = "$HOME/.1passowrd/agent.sock";
        NB_AUTO_SYNC = "1";
      };
      shellAliases = { ll = "ls -halt"; };
      stateVersion = "23.11";
      sessionPath = [ "$HOME/.aqua/bin" "$HOME/.asdf/shims" "$HOME/bin" ];
    };
    nixpkgs = { config = { allowUnfree = true; }; };
    programs = {
      direnv = { enable = true; };
      git = {
        enable = true;
        extraConfig = {
          pull = { rebase = "merges"; };
          diff = { tool = "vscode"; };
          merge = { tool = "vscode"; };
          diftool = {
            vscode = {
              cmd = "code --wait --diff --new-window $LOCAL $REMOTE";
              keepBackup = false;
            };
          };
          mergetool = {
            vscode = {
              cmd = "code --wait --new-window $MERGED";
              keepBackup = false;
            };
          };
          init = { defaultBnranch = "main"; };
          gpg = {
            format = "ssh";
            ssh = { allowedSignersFile = "~/.ssh/allowed_signers"; };
          };
          rerere = { enabled = true; };
          interactive = { diffFilter = "diff-so-fancy --patch"; };
          core = {
            excludesFile = "~/.config/git/ignore";
            pager = "diff-so-fancy | less --tabs=4 -RF";
          };
        };
        ignores = [ ".terraform" ];
        signing = {
          key =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYZPvNNABS+x1ueJd8zOCN4txpXYbpUG9zNy0fsVAAj";
          signByDefault = true;
        };
        userEmail = "17928966+OGKevin@users.noreply.github.com";
        userName = "Kevin Hellemun";
      };
      gitui = { enable = true; };
      helix = {
        defaultEditor = true;
        enable = true;
        extraPackages = [ pkgs.nil pkgs.yaml-language-server pkgs.marksman ];
        languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
            }
            {
              name = "yaml";
              auto-format = true;
              formatter = {
                command = "${pkgs.yamlfmt}/bin/yamlfmt";
                args = [ "-" ];
              };
            }
          ];
        };
        settings = {
          theme = "github_dark";
          editor = {
            line-number = "relative";
            lsp.display-messages = true;
          };
          keys.normal = {
            space.space = "file_picker";
            space.w = ":w";
            space.q = ":q";
            esc = [ "collapse_selection" "keep_primary_selection" ];
            "C-/" = "toggle_comments";
          };
        };
      };
      home-manager = { enable = true; };
      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          git_metrics = {
            added_style = "bold blue";
            format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
            disabled = false;
          };
          kubernetes = {
            format = "on [⛵ $context ($namespace)](dimmed green) ";
            disabled = false;
            context_aliases = {
              "dev.local.cluster.k8s" = "dev";
              "gke_.*_(?P<var_cluster>[w-]+)" = "gke-$var_cluster";
              "admin@og" = "HomeLab";
            };
          };
          sudo = {
            style = "bold green";
            symbol = "👩‍💻 ";
            disabled = false;
          };
        };
      };
      zsh = {
        enable = true;
        initExtra = "unalias grm";
        oh-my-zsh = {
          enable = true;
          plugins = [ "sudo" "fzf" "git" "terraform" "z" "httpie" "kubectl" ];
          theme = "robbyrussell";
        };
      };
    };
  };
}
