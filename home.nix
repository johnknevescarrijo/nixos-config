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
  
  targets.genericLinux.enable = true;

  # 🔒 Lock por inatividade (simples e funcional)
  services.swayidle = {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];

    timeouts = [
      {
        timeout = 300; # 5 minutos
        command = "swaylock -f";
      }
    ];
  };
  #Abrir APPS Java
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };  

  # Pacotes do usuário (pode deixar vazio)
  home.packages = [ ];
}
