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

  services.swayidle = {
  enable = true;
  systemdTargets = [ "graphical-session.target" ];

  events = [
    {
      event = "before-sleep";
      command = "noctalia-shell ipc call lockScreen lock";
    }
  ];

  timeouts = [
    {
      timeout = 300;
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
