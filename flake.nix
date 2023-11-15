{
  description = "default flake";

      nixConfig = {
        # Adapted From: https://github.com/divnix/digga/blob/main/examples/devos/flake.nix#L4
        extra-substituters = "https://cache.nixos.org https://nix-community.cachix.org https://sylvorg.cachix.org https://cuda-maintainers.cachix.org";
        extra-trusted-public-keys = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= sylvorg.cachix.org-1:xd1jb7cDkzX+D+Wqt6TemzkJH9u9esXEFu1yaR9p8H8= cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E=";
  };

  inputs = {
    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, anyrun, NixOS-WSL, ... }@inputs: 
  {
    nixosConfigurations = let 
      base-args = {
        inherit home-manager;
        nixpkgs = nixpkgs;
      }; 
      in {
      "lap" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
 
        modules = [
          ./configuration-nixos.nix
          
          {
            programs.hyprland = {
              enable = true;
              enableNvidiaPatches = true;
              xwayland = {
                enable = true;
             };
            };
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.radu = import ./home/home.nix;
          }
        ];
      };
      radu-p14s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nix.registry.nixpkgs.flake = nixpkgs; }
          ./configuration-wsl.nix
          NixOS-WSL.nixosModules.wsl
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.radu = import ./home/home.nix;
          }
        ];
      }; 
    };
  };
}
