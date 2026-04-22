{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  home.stateVersion = "25.05";

  programs.noctalia-shell.enable = true;

  targets.genericLinux.enable = true;

  # 🔐 LOCK ANTES DE SUSPENDER (CORRETO)
  services.swayidle = {
  enable = true;

  systemdTarget = "graphical-session.target";
  
  events = {
    before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
  };

  timeouts = [
    {
      timeout = 300;
      command = "${pkgs.swaylock}/bin/swaylock -f";
     }
   ];
 };  

  # 🔑 Java fix
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.packages = [ ];
}
