{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  home.stateVersion = "25.05";

  programs.noctalia-shell = {
    enable = true;
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    timeouts = [
      {
        timeout = 300;
        command = "noctalia-shell ipc call lockScreen lock";
      }
    ];
  };

  home.packages = [ ];
}
