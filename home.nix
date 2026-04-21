{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  home.stateVersion = "25.05";

  programs.noctalia-shell = {
    enable = true;
  };

  # ⏱️ Lock por inatividade
  services.swayidle = {
  enable = true;
  systemdTarget = "graphical-session.target";

  events = [
     {
      event = "before-sleep";
      command = "swaylock -f";
     }
   ];

  timeouts = [
    {
      timeout = 300;
      command = "swaylock -f";
     }
   ];
 };
  home.packages = [ ];
}
