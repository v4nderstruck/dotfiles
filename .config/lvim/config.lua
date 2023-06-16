-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50
vim.opt.cursorline = false
vim.opt.textwidth = 80
vim.opt.formatoptions = "cq"
-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

lvim.transparent_window = true
-- lvim.colorscheme = "catppuccin"
lvim.format_on_save = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>u"] = ":UndotreeToggle<cr>"
lvim.keys.normal_mode["<leader>F"] = ":Telescope live_grep<cr>"
lvim.keys.normal_mode["<leader>pp"] = ":Telescope persisted<cr>"
lvim.keys.normal_mode["<leader>so"] = ":SymbolsOutline<cr>"

-- terminal into normal mode
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", "<C-\\><C-n>", opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

lvim.plugins = {
  "mfussenegger/nvim-jdtls",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            open = "<M-p>",
          }
        },
        suggestion = {
          auto_trigger = false,
          enabled = true,
          keymap = {
            accept = "<M-l>",
            dismiss = "<M-h>",
            next = "<M-r>",
          }
        }
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        position = "left",
        width = 20
      })
    end
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd.colorscheme "oxocarbon"
    end
  },
  "dracula/vim",
  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup({
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = false,                                                   -- silent nvim message when sourcing session file
        use_git_branch = false,                                           -- create session files based on the branch of the git enabled repository
        autosave = true,                                                  -- automatically save session files when exiting Neovim
        should_autosave = nil,                                            -- function to determine if a session should be autosaved
        autoload = true,                                                 -- automatically load the session for the cwd on Neovim startup
        on_autoload_no_session = nil,                                     -- function to run when `autoload = true` but there is no session to load
        follow_cwd = true,                                                -- change session file name to match current working directory if it changes
        allowed_dirs = nil,                                               -- table of dirs that the plugin will auto-save and auto-load from
        ignored_dirs = nil,                                               -- table of dirs that are ignored when auto-saving and auto-loading
        telescope = {                                                     -- options for the telescope extension
          reset_prompt_after_deletion = true,                             -- whether to reset prompt after session deleted
        }
      })
    end
  }
}
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "clang-format", filetypes = { "java" } },
  { command = "autopep8",     filetypes = { "python" } },
}
require("lvim.lsp.manager").setup("marksman", {})
-- Automatically install missing parsers when entering buffer
-- lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ignore_install = { "gitignore" } -- broken TS
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "persisted")
end
