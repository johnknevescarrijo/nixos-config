{ config, pkgs, noctalia, ... }:

{
  # Importa o módulo do Noctalia
  imports = [noctalia.homeModules.default ];

  # Versão do estado do home-manager
  home.stateVersion = "25.05";

  # Ativa o Noctalia
  programs.noctalia-shell = {
    enable = true;
    # Futuras configurações do Noctalia (tema, widgets, etc.) vão aqui
  };

  # 🔒 Configuração do swayidle para bloquear a tela ao suspender
  services.swayidle = {
    enable = true;
    events = [
      {
        # Trava a tela antes de suspender (fechar a tampa, por exemplo)
        event = "before-sleep";
        command = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
      }
    ];
    # Opcional: timeout para travamento automático por inatividade
    timeouts = [
      {
        timeout = 300;  # 5 minutos
        command = "${pkgs.noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
      }
    ];
  };

  # Pacotes adicionais para o usuário (lista vazia, sem erro)
  home.packages = [ ];
}
