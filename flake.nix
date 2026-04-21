{
  description = "NixOS + Niri + Noctalia + Distrobox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Adicionando o Home Manager como entrada
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Adicionando o Noctalia como entrada
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
          # Configuração do Home Manager para o usuário 'john'
          home-manager.users.john = { config, pkgs, ... }: {
            home.stateVersion = "25.05";

            # Importando o módulo do Noctalia
            imports = [ noctalia.homeModules.default ];

            # Ativando e configurando o Noctalia
            programs.noctalia-shell = {
              enable = true;
              # settings = { ... }; // Suas configurações do Noctalia
            };
          };

          # Configuração do Podman e Distrobox (já existente)
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
