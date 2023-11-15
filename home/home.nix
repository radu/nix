{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
   imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home.username = "radu";
  home.homeDirectory = "/home/radu";

  home.packages = with pkgs; [
     silver-searcher
     ranger
     helix
     neovim
     ncdu
     bat
     dog
     neofetch
     eza

     file
     which
     tree
     gnused
     gnutar
     zstd

     nix-output-monitor

     hugo
     glow
     btop

     lsof
     htop

     curl
     du-dust
     ripgrep
     vault
     nixpkgs-fmt
     git-annex
   
     google-chrome
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.nushell.enable = true;

  programs.tmux.enable = true;

  programs.zellij.enable = true;

  programs.direnv.enable = true;

  programs.zsh = {
    enable = true;
    initExtra = "
       eval \"$(starship init zsh)\"
    ";
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    shellAliases = {
        ll = "ls -l";
        nixswitch = "sudo nixos-rebuild switch";
        homeswitch = "home-manager switch";
    };
  };

  programs.git = {
     enable = true;
     userName = "radu";
     userEmail = "radu@raduta.net";
     aliases = {
        st = "status";
     };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

}
