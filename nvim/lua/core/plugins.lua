local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "ellisonleao/gruvbox.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  --{
  --  "nvim-treesitter/nvim-treesitter",
  --  build = ":TSUpdate",
  --  config = function () 
  --    local configs = require("nvim-treesitter.configs")

  --    configs.setup({
  --      ensure_installed = {
  --        "c",
  --        "python",
  --        "clojure",
  --        "rust",
  --        "lua",
  --        "vim",
  --        "vimdoc",
  --        "query",
  --        "javascript",
  --        "html"
  --      },
  --      sync_install = false,
  --      highlight = { enable = true },
  --      indent = { enable = true },  
  --    })
  --  end,
  --},

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  {"nvim-telescope/telescope.nvim"},
  {"airblade/vim-gitgutter"},
  {"neovim/nvim-lspconfig"},
})
