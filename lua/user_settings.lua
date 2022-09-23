local map = require("utils").map
local which_key = require("utils").wk_add

-- WARN: Do not touch this table.
extra_which_keys = {}

disable_plugins = {
  -- NOTE: These two plugins are for better performance
  -- and fixing one of neovim bugs.
  impatient = false,
  fix_cursor_htostirngold = false,

  -- NOTE: Many plugins use this plugin as a dependency.
  -- I suggest to not remove this plugins.
  plenary = false,

  -- NOTE: These plugins are colorscheme. By default only
  -- enfocado is enabled. you can enable other by changing
  -- true to false.
  tokyonight = false,
  nightfly = false,
  moonfly = false,
  nord = false,
  onedark = false,
  nvim_enfocado = false,

  -- NOTE: These plugins are for debugging. You can install
  -- Some debug servers with dap_install but the list of those
  -- Are realy small. You can install debugger by your self and
  -- then configure it by your self so you can use nvim_dap and nvim_dap_ui
  -- without dap_install
  nvim_dap = true,
  dap_install = true,
  nvim_dap_ui = true,

  -- NOTE: these plugins are telescope and telescope extensions. fzf is for
  -- better searching experince and you can fuzzy find directories with
  -- telescope_find_directories
  telescope_fzf_native = false,
  telescope_find_directories = false,
  telescope = false,

  -- NOTE: scrollview is builtin scrollbar for CodeArt and
  -- And neoscroll is for scroll animation.
  scrollview = true,
  neoscroll = true,

  -- NOTE: nvim-cmp and luasnip are for code completion.
  nvim_cmp = false,
  luasnip = false,
  friendly_snippets = false,
  cmp_buffer = false,
  cmp_path = false,
  cmp_nvim_lsp = false,
  cmp_luasnip = false,
  cmp_nvim_lua = false,

  nvim_web_devicons = false,
  lualine = false,
  nvim_bufferline = false,
  indent_blankline = false,

  better_escape = true, -- For exiting from insert mode with jj and jk

  truezen = false,
  nvim_tree = false,
  treesitter = false,
  nvim_colorizer = false,
  alpha = false,
  nvim_lspconfig = false,
  lsp_installer = false,
  null_ls = false,
  lspsaga = false,
  symbols_outline = false,
  lsp_signature = false,
  toggleterm = false,
  fugitive = false,
  gitsigns = false,
  autopairs = false,
  nvim_ts_autotag = false,
  todo_comments = false,
  which_key = false,
  mkdir = false,
  kommentary = false,
  ts_context_commentstring = false,
  vim_matchup = false,
  vim_resize = false,
}

additional_plugins = {
  -- You can put your additional plugins here.
  -- Syntax is like normal packer.nvim Syntax.
  -- If you need to set some settings for your plugins
  -- you must put configs in config = function() like below examples

  -- { "famiu/feline.nvim", branch = "develop" },

  -- "mhartington/formatter.nvim",

  -- { "crispgm/nvim-go", ft = "go" },

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   ft = "markdown",
  --   run = ":call mkdp#util#install()",
  --   config = function()
  --     vim.g.mkdp_auto_close = 0
  --   end,
  -- },

  -- {
  --   "andweeb/presence.nvim",
  --   config = function()
  --     require("presence"):setup({
  --       log_level = "info", -- Log messages (one of the following: "debug", "info", "warn", "error")
  --       debounce_timeout = 5,
  --       blacklist = {}, -- file name, path, or workspace matches
  --     })
  --   end,
  -- },
  { "jlcrochet/vim-razor" }
}

-- NOTE: here
-- Name of functions is exactly like config file in nvim/lua/plugins directory
-- the only diffrence is if in file name you have hifen(-) here you must
-- replace it with underline.
local config = {
  -- null-ls configuration
  null_ls = function()
    -- Formatting and linting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
      return
    end

    -- Check supported formatters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    -- Check supported linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
      debug = false,
      sources = {
        -- Settings up some linters and code formatters.
        formatting.black,
        formatting.stylua,
        formatting.rustfmt,
        formatting.clang_format,
        formatting.prettier,
        formatting.taplo,
        formatting.shfmt.with({
          command = "shfmt",
          args = {
            "-i",
            "2",
            "-ci",
            "-bn",
            "$FILENAME",
            "-w",
          },
        }),
        diagnostics.zsh,
        -- diagnostics.luacheck,
        diagnostics.pylint,
      },
      -- This function is for format on save.
      -- on_attach = function(client)
      --   if client.resolved_capabilities.document_formatting then
    })
  end,
  treesitter = {
    highlight = {
      enable = true,
    },
  },
  bufferline = {
    options = {
      mode = "tabs",
      show_close_icon = false,
      show_buffer_close_icons = false,
      numbers = function(opts)
        return string.format("%s", opts.id)
      end,
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
        {
          filetype = "vista_kind",
          text = "Lsp Tags",
          text_align = "center",
        },
        {
          filetype = "Outline",
          text = " Lsp Tags",
          text_align = "center",
        },
      },
    },
  },
  dapui = {
    floating = {
      border = "single"
    }
  },
  lspsaga = {
    border_style = "single"
  },
  cmp = {
    window = {
      completion = {
        border = "single"
      },
      documentation = {
        border = "single"
      }
    }
  },
  toggleterm = {
    open_mapping = [[<m-return>]],
    direction = "float",
    float_opts = {
      border = "single",
      width = 120,
      height = 40,
      winblend = 0
    },
  },
  lsp_signature = {
    bind = false,
    handler_opts = { border = "single" },
  },
  nvim_tree = {
    disable_netrw = true,
    open_on_tab = false,
    open_on_setup = true,
    hijack_cursor = true,
    hijack_directories = true
  },
  other_configs = function()
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
    vim.g.tokyonight_dark_sidebar = true
    vim.g.tokyonight_lualine_sidebar = true
    vim.cmd("colorscheme tokyonight-night")
    -- Other settings here
    -- For examples for disabling line number:
    -- vim.opt.number = false
    -- vim.opt.relativenumber = false

    -- Or for changing terminal toggle mapping:
    -- first argument is mode of mapping. second argument is keymap.
    -- third argument is command. and last argument is optional argument like {expr = true}.
    -- map("n", "<C-t>", ":ToggleTerm<CR>")
    -- map("t", "<C-t>", ":ToggleTerm<CR>")

    -- This is example of how to make keymap and add it to
    -- which_keys(that pop of window on bottom of NeoVim that help you to find keymaps)
    -- This will make new group of keymaps names Something with two commands and they're describtions.
    -- with pressing `<leader> + s` you can trigger which keys to show you
    -- Something commands. with pressing e it will echo hello on command prompt at the end of NeoVim
    -- and with pressing f it will echo Goodbye on command prompt at the end of NeoVim
    -- wk_add(
    --   {
    --     s = {
    --       name = "Something",
    --       e = { ":echo 'Hello'<CR>", "Echo Hello" },
    --       f = { ":echo 'Goodbye'<CR>", "Echo Goodbye" },
    --     },
    --   },
    --   { prefix = "<leader>", mode = "v" } -- mode = "v" means it only works on visual mode.
    --   extra_which_keys
    -- )

    -- user_lualine_style = 1 -- You can choose between predefined 1, 2, 3, 4 and 5
    -- or you can define your custome seperator like this.
    -- first item is for component seperator and second item is
    -- for section seperator.
    -- user_lualine_style = { { left = " ", right = " " }, { left = "", right = "" } }

    -- user_indent_blankline_style = 1 -- You can choose between predefined 1, 2, 3, 4,5 and 6
    -- or you can use your favorite character.
    -- user_indent_blankline_style = ""

    do -- bufferline / tabs
      map("n", "<M-t>", "<cmd>tabnew<CR><cmd>Telescope find_files<CR>", {silent = true}) -- open a new tab
      map("n", "<M-T>", "<cmd>tabclose<CR>", {silent = true}) -- close tab
      map("n", "<M-1>", "<cmd>BufferLineGoToBuffer 1<CR>", { silent = true, noremap = true })
      map("n", "<M-2>", "<cmd>BufferLineGoToBuffer 2<CR>", { silent = true, noremap = true })
      map("n", "<M-3>", "<cmd>BufferLineGoToBuffer 3<CR>", { silent = true, noremap = true })
      map("n", "<M-4>", "<cmd>BufferLineGoToBuffer 4<CR>", { silent = true, noremap = true })
      map("n", "<M-5>", "<cmd>BufferLineGoToBuffer 5<CR>", { silent = true, noremap = true })
      map("n", "<M-6>", "<cmd>BufferLineGoToBuffer 6<CR>", { silent = true, noremap = true })
      map("n", "<M-7>", "<cmd>BufferLineGoToBuffer 7<CR>", { silent = true, noremap = true })
      map("n", "<M-8>", "<cmd>BufferLineGoToBuffer 8<CR>", { silent = true, noremap = true })
      map("n", "<M-9>", "<cmd>BufferLineGoToBuffer 9<CR>", { silent = true, noremap = true })
    end

    do -- quick exit
      map("n", "<M-w>", "<cmd>q<CR>", {silent = true}) -- close window
      map("n", "<M-x>", "<cmd>wq<CR>", {silent = true}) -- close window, save

      map("n", "<M-q>", "<cmd>qa<CR>", {silent = true}) -- close all windows, dont save
      map("n", "<M-Q>", "<cmd>qa!<CR>", {silent = true}) -- close all windows, dont save, dont warn
      map("n", "<M-X>", "<cmd>wqa<CR>", {silent = true}) -- close all windows, save
    end

    do -- window navigation
      map("n", "<M-j>", "<cmd>wincmd j<CR>", {silent = true}) -- move focus down
      map("n", "<M-k>", "<cmd>wincmd k<CR>", {silent = true}) -- move focus up
      map("n", "<M-h>", "<cmd>wincmd h<CR>", {silent = true}) -- move focus left
      map("n", "<M-l>", "<cmd>wincmd l<CR>", {silent = true}) -- move focus right
    end

    do -- open new window
      map("n", "<M-o>", "<cmd>vsplit<CR><cmd>Telescope find_files<CR>", {silent = true}) -- split left
      map("n", "<M-O>", "<cmd>split<CR><cmd>Telescope find_files<CR>", {silent = true}) -- split bellow
    end

    do -- Lspsaga
      map("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true }) -- rename symbol
      map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true }) -- find usage
      map("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true, noremap = true }) -- hover doc
      map("n", "gd", "<cmd>Lspsaga preview_definition<CR>", { silent = true, noremap = true }) -- preview definition
    end

    do
      --map("n", "<M>-<space>", "<cmd>Telescope find_files<CR>", { silent = true })
    end
  end,
}

return config
