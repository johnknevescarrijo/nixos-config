{
  description = "NixOS + Niri + Distrobox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        {
          # Configuração do Distrobox e Podman
          virtualisation.podman = {
            enable = true;
            dockerCompat = false;  # opcional: permite usar comando 'docker'
          };
          environment.systemPackages = [ nixpkgs.legacyPackages.${system}.distrobox ];
        }
      ];
    };
  };
}
