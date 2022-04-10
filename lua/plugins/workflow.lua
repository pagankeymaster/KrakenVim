local M = {}

local function use(plugin)
  table.insert(M, plugin)
end

use { "tweekmonster/haunted.vim", cmd = "Haunt" }

use {
  "MattesGroeger/vim-bookmarks",
  setup = function()
    require "configs.workflow.bookmarks"
  end,
  cmd = "BookmarkToggle",
  event = {
    "InsertEnter",
    "CmdlineEnter",
    "CursorMoved",
  },
}

use {
  "kevinhwang91/rnvimr",
  cmd = {
    "RnvimrToggle",
    "RnvimrResize",
  },
  setup = function()
    require "configs.workflow.rnvimr"
  end,
}

use {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  wants = {
    "plenary.nvim",
    "nvim-web-devicons",
    "nui.nvim",
    "nvim-window-picker",
  },
  cmd = "Neotree"
}

use {
  "s1n7ax/nvim-window-picker",
  tag = "1.*",
  config = function()
    require "configs.workflow.picker"
  end,
  opt = true
}

use {
  "phaazon/hop.nvim",
  cmd = { "HopWord", "HopLine", "HopChar1", "HopChar2", "HopPattern" },
  config = function()
    require "configs.workflow.hop"
  end,
}

use {
  "Pocco81/AutoSave.nvim",
  cmd = { "ASOn", "ASOff", "ASToggle" },
  config = function()
    require "configs.workflow.autosave"
  end,
}

use { "Shatur/neovim-session-manager", cmd = "SessionManager" }

use {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  config = function()
    require "configs.workflow.undotree"
  end,
}

use {
  "max397574/better-escape.nvim",
  config = function()
    require "configs.workflow.escape"
  end,
  event = "InsertLeave",
}

use { "abecodes/tabout.nvim", opt = true }

use {
  "akinsho/toggleterm.nvim",
  config = function()
    require "configs.workflow.toggleterm"
  end,
  module = { "toggleterm" },
  cmd = { "ToggleTerm", "ToggleTermToggleAll" },
}

use {
  "folke/which-key.nvim",
  config = function()
    require "configs.workflow.whichkey"
  end,
}

use { "ggandor/lightspeed.nvim", cmd = "LightSpeedInit" }

use {
  "bennypowers/nvim-regexplainer",
  config = function()
    require "configs.workflow.regexplainer"
  end,
  after = { "nvim-treesitter", "plenary.nvim", "nui.nvim" },
}

use { "winston0410/cmd-parser.nvim", event = "CmdlineEnter" }

use { "nvim-pack/nvim-spectre", opt = true }

return M

-- vim:ft=lua
