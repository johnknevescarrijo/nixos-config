{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    # =========================
    # Editor basics
    # =========================
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

      signcolumn = "yes";
    };

    globals.mapleader = " ";

    # =========================
    # Theme
    # =========================
    colorschemes.catppuccin.enable = true;

    # =========================
    # UI improvements
    # =========================
    plugins.web-devicons.enable = true;
    plugins.which-key.enable = true;
    plugins.lualine.enable = true;

    # =========================
    # File explorer
    # =========================
    plugins.oil.enable = true;

    # =========================
    # Git
    # =========================
    plugins.gitsigns.enable = true;

    # =========================
    # Treesitter (syntax)
    # =========================
    plugins.treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # =========================
    # Telescope (fuzzy finder)
    # =========================
    plugins.telescope = {
      enable = true;

      dependencies = {
        fzf-native.enable = true;
      };
    };

    # =========================
    # Completion (CMP)
    # =========================
    plugins.cmp = {
      enable = true;

      settings = {
        autoEnableSources = true;

        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
    };

    # =========================
    # LSP (language servers)
    # =========================
    plugins.lsp = {
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
    plugins.none-ls = {
      enable = true;

      sources.formatting = {
        stylua.enable = true;
      };
    };

    # =========================
    # Keymaps estilo IDE
    # =========================
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

      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
      }

      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
      }
    ];

    # =========================
    # External tools
    # =========================
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
