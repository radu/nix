{ config, pkgs, ... }:

{
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
     exa

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
    enableSyntaxHighlighting = true;
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
