{
  description = "NixOS + Niri + Noctalia + Distrobox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          # Configurações globais do home-manager
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit noctalia; };   # ← LINHA ADICIONADA
          home-manager.users.john = import ./home.nix;           # ← import do home.nix

          # Configuração do Podman e Distrobox
          virtualisation.podman = {
            enable = true;
            dockerCompat = false;
          };
          environment.systemPackages = [ pkgs.distrobox ];
        }
      ];
    };
  };
}
