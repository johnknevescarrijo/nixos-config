{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;

      smartindent = true;

      ignorecase = true;
      smartcase = true;

      termguicolors = true;

      cursorline = true;

      scrolloff = 8;

      updatetime = 100;
    };

    globals.mapleader = " ";

    colorschemes.catppuccin.enable = true;
    #plugins.web-devicons.enable = true;
    plugins = {

      # =========================
      # File Explorer
      # =========================

      oil.enable = true;

      # =========================
      # Git
      # =========================

      gitsigns.enable = true;

      # =========================
      # Status Line
      # =========================

      lualine.enable = true;

      # =========================
      # Treesitter
      # =========================

      treesitter = {
        enable = true;

        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # =========================
      # Telescope
      # =========================

      telescope.enable = true;

      # =========================
      # Autocomplete
      # =========================

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };

      # =========================
      # LSP
      # =========================

      lsp = {
        enable = true;

        servers = {
          clangd.enable = true;
          pyright.enable = true;
          lua_ls.enable = true;
          bashls.enable = true;
        };
      };

      # =========================
      # Formatting
      # =========================

      none-ls = {
        enable = true;

        sources.formatting = {
          stylua.enable = true;
        };
      };

      # =========================
      # Which Key
      # =========================

      which-key.enable = true;
    };

    keymaps = [

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }

      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }

      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<CR>";
      }

    ];

    extraPackages = with pkgs; [
      ripgrep
      fd

      clang-tools
      lua-language-server
      pyright
      bash-language-server

      stylua
    ];
  };
}
