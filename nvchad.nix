{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
  };

  home.packages = with pkgs; [
    neovide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
  };
}
