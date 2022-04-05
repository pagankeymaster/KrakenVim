--- Wraps frequently used neovim API functions. And passes some default options
--- to decrease the code.
-- @module utils.neovim
-- @alias M

local M = {}

--- Check whether the current buffer is empty.
-- @see help empty()
-- @see help expand()
function M.is_buffer_empty()
  return fn.empty(fn.expand "%:t") == 1
end

--- Check if the windows width is greater than a given number of columns.
-- @param cols number of columns
-- @see help winwidth()
function M.has_width_gt(cols)
  return fn.winwidth(0) / 2 > cols
end

--- Wraps around vim.notify. Sets some default values that will be used by the
--- nvim-notify notification replacement plugin.
-- @param options takes in notification category, title, icon, etc.
-- @see help vim.notify for more info.
function M.notify(options)
  -- if only a string is passed then show a generic notification.
  if type(options) == "string" then
    api.nvim_notify(options, vim.log.levels.INFO, { icon = "", title = "Notification" })
    return
  end

  -- default configuration
  local forced = vim.tbl_extend("force", {
    message = "This is a sample notification.",
    icon = "",
    title = "Notification",
    level = vim.log.levels.INFO,
  }, options or {}) -- don't let the table be nil
  api.nvim_notify(forced.message, forced.level, { title = forced.title, icon = forced.icon })
end

--- A cnoreabbrev wrapper.
-- @param buffer the buffer number that it applies to
-- @param command the command that will be executed on trigger
-- @param expression the pattern that will trigger the abbrev
-- @see help cnoreabbrev
function M.abbrev(buffer, command, expression)
  local formatted = string.format("cnoreabbrev %s %s %s", expression and "<expr>" or "", buffer, command)
  cmd(formatted)
end

--- Aliases an already existing command or, creates a new user command
--- or, overwrites the existing command.
-- @param alias the name of the new user command.
-- @param command the callback or a string containing a command
-- that will be triggered on running that alias on cmdline (say)
-- @param options table of other options that will be passed over to
-- nvim_add_user_command
-- @see help nvim_add_user_command
function M.alias(alias, command, options)
  if not options then
    -- don't let options be nil
    options = {}
  end
  api.nvim_add_user_command(alias, command, options)
end

--- The wrapper for nvim_create_autocmd API function.
-- @param events a string or a table of vim events.
-- @param command a Lua function or, a string containing VimL code.
-- @param options table of other options it is not compulsory FYI
-- @return opaque value to use with nvim_del_autocmd
-- @see help nvim_create_autocmd
function M.autocmd(events, command, options)
  if not options then
    options = {}
  end
  local autocmd_opts = {}

  autocmd_opts[type(command) == "string" and "command" or "callback"] = command
  if not options.buffer then
    autocmd_opts.pattern = not options.patterns and "*" or options.patterns
  else
    autocmd_opts.buffer = options.buffer or options.bufnr
  end

  if options.group then
    autocmd_opts.group = options.group
  end

  api.nvim_create_autocmd(events, autocmd_opts)
  -- pass the group name if more autocmds are needed to be added to this group
  return options.group
end

--- Wrapper for nvim_create_augroup.
-- @param name title of the auto group
-- @param autocmds a table of tables that contains the same structure as M.autocmd.
-- @field autocmds.events refer to M.autocmd
-- @field autocmds.command refer to M.autocmd
-- @tparam autocmds.options refer to M.autocmd
-- @tparam clear boolean option if the auto-group will be repeated if it is
-- called again. Will be cleared if set to true.
-- @return same as M.autocmd
function M.augroup(name, autocmds, clear)
  clear = clear == false and false or true
  local append = M.autocmd
  local group = api.nvim_create_augroup(name, { clear = clear })
  for _, autocmd in ipairs(autocmds) do
    if not autocmd.options then
      autocmd.options = {}
    end
    autocmd.options.group = group
    append(autocmd.events, autocmd.command, autocmd.options)
  end
  return group
end

--- Checks if a treesitter parser is available for the current file.
--- If not then prompts to install the parser(s).
-- @see Adapted from https://is.gd/rETGe2
function M.ensure_treesitter_language_installed()
  local parsers = require "nvim-treesitter.parsers"
  local lang = parsers.get_buf_lang()
  if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
    schedule(function()
      vim.ui.select(
        { "Sure, I don't mind.", "Nope, fuck yourself!" },
        { prompt = "Install tree-sitter parsers for " .. lang .. "?" },
        function(item)
          if item == "Sure, I don't mind." then
            cmd("TSInstall " .. lang)
          end
        end
      )
    end)
  end
end

return M

-- vim:ft=lua
