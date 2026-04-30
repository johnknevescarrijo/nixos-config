{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  home.stateVersion = "25.05";

  programs.noctalia-shell.enable = true;

  targets.genericLinux.enable = true;  
   
  services.swayidle = {
  enable = true;

  systemdTargets = [ "graphical-session.target"];

  timeouts = [
    {
      timeout = 300;
      command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
    }
  ];

  events = {
    before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
    lock = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
   };
 };

  # 🔑 Java fix
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

    # Instalação e configuração do Tmux
  programs.tmux = {
    enable = true;
    clock24 = true;    # Usa o formato de 24 horas
    # escapeTime = 0;  # Tempo de espera para detectar o prefixo (0 para nenhum delay)
    # mouse = true;    # Habilita suporte ao mouse (opcional)
    # shortcut = "a";  # Muda o prefixo para Ctrl+a (padrão é Ctrl+b)
    extraConfig = ''
              
       # Comandos personalizados do tmux vão aqui
      unbind C-b
      set -g prefix C-b
      bind C-b send-prefix
      
      # Split
       bind e split-window -h
       bind s split-window -v

        # Navegação estilo Vim
         bind h select-pane -L
         bind j select-pane -D
         bind k select-pane -U
         bind l select-pane -R

         # Trocar janelas
         bind n next-window
         bind p previous-window

         # Copy mode (mais fácil)
         bind m copy-mode

         # Colar
         bind v paste-buffer
       
       

      set -g status-right '#[fg=black,bg=colour15] %H:%M '
    '';
  };


  home.packages = [ ];
}
