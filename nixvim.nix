{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    # =========================
    # Editor básico
    # =========================
    opts = {
      number = true;
      relativenumber = true;

      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;

      smartindent = true;
      termguicolors = true;

      cursorline = true;
      scrolloff = 8;
      signcolumn = "yes";

      ignorecase = true;
      smartcase = true;
    };

    # =========================
    # Tema
    # =========================
    colorschemes.catppuccin.enable = true;

    # =========================
    # UI
    # =========================
    plugins = {
      web-devicons.enable = true;
      which-key.enable = true;
      lualine.enable = true;

      # =========================
      # Explorer (sidebar)
      # =========================
      oil.enable = true;

      # =========================
      # Git
      # =========================
      gitsigns.enable = true;

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
      # Telescope (Ctrl+P)
      # =========================
      telescope = {
        enable = true;

        dependencies = {
          fzf-native.enable = true;
        };
      };

      # =========================
      # Autocomplete (CMP)
      # =========================
      cmp = {
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
      # LSP (IDE engine)
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
      # Snippets
      # =========================
      luasnip.enable = true;
      cmp_luasnip.enable = true;

      # =========================
      # Debugger (DAP)
      # =========================
      dap.enable = true;
      dap-ui.enable = true;
    };

    # =========================
    # ATALHOS (VSCode STYLE)
    # =========================
    keymaps = [

      # 🔍 Search (Ctrl+P style)
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

      # 📁 Explorer
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<CR>";
      }

      # 📑 Buffers (abas)
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>Telescope buffers<CR>";
      }

      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
      }

      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
      }

      # 🐛 Debugger
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>lua require'dap'.continue()<CR>";
      }

      {
        mode = "n";
        key = "<F10>";
        action = "<cmd>lua require'dap'.step_over()<CR>";
      }

      {
        mode = "n";
        key = "<F11>";
        action = "<cmd>lua require'dap'.step_into()<CR>";
      }

      {
        mode = "n";
        key = "<F12>";
        action = "<cmd>lua require'dap'.step_out()<CR>";
      }

    ];

    # =========================
    # Ferramentas externas
    # =========================
    extraPackages = with pkgs; [
      ripgrep
      fd

      clang-tools
      cmake
      gdb
      gcc

      lua-language-server
      pyright
      bash-language-server

      stylua
    ];
  };
}
