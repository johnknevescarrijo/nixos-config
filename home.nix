{ config, pkgs, noctalia, ... }:

{
  # Importa o módulo do Noctalia
  imports = [ noctalia.homeModules.default ];

  # Versão do estado do home-manager
  home.stateVersion = "25.05";

  # Ativa o Noctalia
  programs.noctalia-shell = {
    enable = true;
  };

  # 🔒 Lock por inatividade (simples e funcional)
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    timeouts = [
      {
        timeout = 300; # 5 minutos
        command = "swaylock -f";
      }
    ];
  };

  # Pacotes do usuário (pode deixar vazio)
  home.packages = [ ];
}
