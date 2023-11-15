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
    ./anyrun.nix
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

     kitty
   
     google-chrome

     wlogout
     waybar

     xfce.thunar 
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.nushell.enable = true;

  programs.tmux.enable = true;

  programs.zellij.enable = true;

  programs.direnv.enable = true;

  fonts.fontconfig.enable = true;

  # hyprland configs, based on https://github.com/notwidow/hyprland
  home.file.".config/hypr" = {
    source = ./hypr-conf;
    # copy the scripts directory recursively
    recursive = true;
  };


  home.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";

    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
  };

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
