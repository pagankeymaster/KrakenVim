local present, blankline = pcall(require, "indent_blankline")

if not present then
  return
end

local theming = require("utils.theming")
local hi = theming.highlight
local colors = theming.get_active_theme()

local config = {
  char = "│",
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "alpha",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "nvchad_cheatsheet",
    "lsp-installer",
  },
  space_char_blankline = " ",
  buftype_exclude = { "terminal" },
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}

local presets = {}

presets.shaded = function()
  hi("IndentBlanklineIndent1", {
    fg = colors.shades.shade06,
    bg = colors.shades.shade06,
    nocombine = true,
  })
  hi("IndentBlanklineIndent2", {
    fg = colors.common.base00,
    bg = colors.common.base00,
    nocombine = true,
  })

  hi("IndentBlanklineIndent3", {
    bg = colors.shades.shade06,
    nocombine = true,
  })
  hi("IndentBlanklineIndent4", {
    bg = colors.common.base00,
    nocombine = true,
  })

  config.space_char_highlight_list = {
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
  }
  config.char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  }
end

presets.rainbow = function()
  hi("IndentBlanklineIndent1", { fg = colors.rainbow.pink, nocombine = true })
  hi("IndentBlanklineIndent2", { fg = colors.rainbow.cyan, nocombine = true })
  hi("IndentBlanklineIndent3", { fg = colors.rainbow.green, nocombine = true })
  hi("IndentBlanklineIndent4", { fg = colors.rainbow.purple, nocombine = true })
  hi("IndentBlanklineIndent5", { fg = colors.rainbow.cobalt, nocombine = true })
  hi("IndentBlanklineIndent6", { fg = colors.rainbow.yellow, nocombine = true })
  hi("IndentBlanklineIndent7", { fg = colors.rainbow.orange, nocombine = true })

  config.char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
    "IndentBlanklineIndent7",
  }
end

presets.rshaded = function()
  hi("IndentBlanklineIndentS1", {
    fg = colors.rainbow.cobalt,
    bg = colors.rainbow.cobalt,
    nocombine = true,
  })
  hi("IndentBlanklineIndentS2", {
    fg = colors.rainbow.pink,
    bg = colors.rainbow.pink,
    nocombine = true,
  })
  hi("IndentBlanklineIndentS3", {
    fg = colors.rainbow.cyan,
    bg = colors.rainbow.cyan,
    nocombine = true,
  })
  hi("IndentBlanklineIndentS4", {
    fg = colors.rainbow.green,
    bg = colors.rainbow.green,
    nocombine = true,
  })
  hi("IndentBlanklineIndentS5", {
    fg = colors.rainbow.purple,
    bg = colors.rainbow.purple,
    nocombine = true,
  })
  hi("IndentBlanklineIndentS6", {
    fg = colors.rainbow.yellow,
    bg = colors.rainbow.yellow,
    nocombine = true,
  })
  hi("IndentBlanklineIndentS7", {
    fg = colors.rainbow.orange,
    bg = colors.rainbow.orange,
    nocombine = true,
  })

  hi("IndentBlanklineIndentF1", {
    bg = colors.rainbow.cobalt,
    nocombine = true,
  })
  hi("IndentBlanklineIndentF2", {
    bg = colors.rainbow.pink,
    nocombine = true,
  })
  hi("IndentBlanklineIndentF3", {
    bg = colors.rainbow.cyan,
    nocombine = true,
  })
  hi("IndentBlanklineIndentF4", {
    bg = colors.rainbow.green,
    nocombine = true,
  })
  hi("IndentBlanklineIndentF5", {
    bg = colors.rainbow.purple,
    nocombine = true,
  })
  hi("IndentBlanklineIndentF6", {
    bg = colors.rainbow.yellow,
    nocombine = true,
  })
  hi("IndentBlanklineIndentF7", {
    bg = colors.rainbow.orange,
    nocombine = true,
  })

  config.space_char_highlight_list = {
    "IndentBlanklineIndentF1",
    "IndentBlanklineIndentF2",
    "IndentBlanklineIndentF3",
    "IndentBlanklineIndentF4",
    "IndentBlanklineIndentF5",
    "IndentBlanklineIndentF6",
    "IndentBlanklineIndentF7",
  }
  config.char_highlight_list = {
    "IndentBlanklineIndentS1",
    "IndentBlanklineIndentS2",
    "IndentBlanklineIndentS3",
    "IndentBlanklineIndentS4",
    "IndentBlanklineIndentS5",
    "IndentBlanklineIndentS6",
    "IndentBlanklineIndentS7",
  }
end

presets.normal = function()
  hi("IndentBlanklineIndent1", { fg = colors.shades.shade01, nocombine = true })
  config.char_highlight_list = {
    "IndentBlanklineIndent1",
  }
end

presets.normal()

blankline.setup(config)

-- vim:ft=lua
