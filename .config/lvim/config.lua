-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50
vim.opt.cursorline = false
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
lvim.colorscheme = "catppuccin-frappe"
lvim.format_on_save = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>u"] = ":UndotreeToggle<cr>"
lvim.keys.normal_mode["<leader>F"] = ":Telescope live_grep<cr>"


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
          auto_trigger = false;
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
  { "catppuccin/nvim", name = "catppuccin" },
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
  "dracula/vim",
  "mbbill/undotree",
}
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "clang-format", filetypes = { "java" } },
  { command = "autopep8", filetypes = { "python" } },
}
-- Automatically install missing parsers when entering buffer
-- lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ignore_install = {"gitignore"} -- broken TS
lvim.builtin.nvimtree.setup.view.side = "right"
