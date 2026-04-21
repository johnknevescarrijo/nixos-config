# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
 
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor=true;		
  boot.loader.efi.canTouchEfiVariables = true;	
  boot.loader.efi.efiSysMountPoint="/boot";
  boot.loader.systemd-boot.configurationLimit=10;
  boot.loader.systemd-boot.extraEntries = {
  "fedora.conf" = ''
    title Fedora
    efi /EFI/fedora/grubx64.efi
  '';
};  
 
  #Configuração de Swap
  swapDevices = [ { device = "/dev/disk/by-uuid/46fbef4d-c872-4c90-ba45-1f78f1b5d800"; } ];
	
  #Limpeza automatica
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};		
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings = {
  max-jobs = 4;
  cores = 0;
  substituters = [
    "https://cache.nixos.org/"
  ];
  connect-timeout = 5;
  stalled-download-timeout = 60;
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;
  #Login e inicia o Niri
  services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet";
      user = "john";
     };
   };
 };
  
  #Teclado
  services.xserver.xkb = {
  layout = "br";
  variant = "abnt2";
  };
  #Habilitar Niri
  programs.niri.enable=true;
  
  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  #Audio para minha placa
  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [ "snd-hda-intel.model=auto" ];
  #Bateria  
  services.upower.enable = true;
  
  #Serve para acesar arquivos e dispositivos
  services.gvfs.enable = true;
  services.udisks2.enable = true;  
  
  #Bloqueio de tela
  services.logind = {
  settings = {
    Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleSuspendKey = "suspend";
     };
   };
 };

  security.pam.services.swaylock = {};
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  
  #Configuração fish
  programs.fish.enable = true;
  users.users.john.shell = pkgs.fish;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.john = {
    isNormalUser = true;
    description = "john";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  
  #Meus Programas
  environment.systemPackages = with pkgs; [
     #Permição paraa APPs
     xdg-desktop-portal
     #Define interface
     xdg-desktop-portal-gtk
     #Tela de login
     tuigreet
      
    # Editores / IDEs
    vscode
    vscodium                     # versão open-source (opcional)
    neovim
    
    # Terminal
    kitty
    fish
    
    # Desenvolvimento
    gcc
    gdb                          # debugger
    cmake                        # build system
    ninja                        # build system alternativo
    clang-tools                  # linter/formatter C/C++
    bear                         # gerador de compile_commands.json
    
    # Bancos de dados
    dbeaver-bin                   # cliente SQL [citation:5]
    
    # Docker
    docker
    docker-compose
    
    # Python
    uv
    
    # Utilitários
    curl
    wget
    git
    rclone

   #Audio
   pavucontrol
   xfce.xfce4-volumed-pulse   # Gerencia teclas de volume
   wireplumber

   #Progrmas do Niri
   alacritty
   fuzzel
   swaybg
   swaylock
   mako
   xwayland-satellite
   polkit_gnome

    # Apps úteis
   pcmanfm              # gerenciador de arquivos        
   imv                  # visualizador de imagens
   mpv                  # player de vídeo
   brave                # navegador
   geany                # editor mais completo (opcional)
   waybar               # barra de status (se quiser)
   lollypop             # player de música
   fastfetch            #Customizar terminal
   #Pacote Libreooffice
   libreoffice-fresh
   hunspell
   hunspellDicts.pt_BR
   hunspellDicts.en_US
   papers              #Visualizador de Documentos
   gparted             #Controle de Disco
   #Suporte de Partições
   exfatprogs          # Suporte para partições exFAT
   ntfs3g              # Suporte para partições NTFS (Windows)
   dosfstools          # Suporte para partições FAT
   btrfs-progs         # Suporte para partições btrfs
   obsidian            #App de anotações
   logisim-evolution   #Projetos de hardware
   anki-bin            #Estudos de idioma
  ];

  # Configurações especiais para alguns programas
  programs.neovim = {           # configuração via module
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Docker precisa de configuração extra
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  #Serviços uteis para o Niri
  security.polkit.enable=true;
  services.gnome.gnome-keyring.enable=true;
  
  # Iniciar Mako automaticamente (jeito correto)
  systemd.user.services.mako = {
    enable = true;
    description = "Mako Notification Daemon";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.mako}/bin/mako";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
 # environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
 # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
