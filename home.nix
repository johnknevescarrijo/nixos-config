{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  home.stateVersion = "25.05";

  programs.noctalia-shell.enable = true;

  targets.genericLinux.enable = true;

  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "swaylock -f";
      }
    ];
  };

  # 🔥 ESSENCIAL: garantir que swayidle inicia
  systemd.user.services.swayidle = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Java fix (ok manter)
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.packages = [ ];
}
