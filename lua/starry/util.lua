local util = {}
local config = require('starry.config').options
-- Go trough the table and highlight the group with the color values
util.highlight = function(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  local blend = color.blend and "blend=" .. tostring(color.blend) or ""

  local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp .. blend

  vim.cmd(hl)
  if color.link then
    vim.cmd("highlight! link " .. group .. " " .. color.link)
  end
end

-- Only define Starry if it's the active colorshceme
function util.onColorScheme()
  local schemes = require'starry.functions'.all_schemes

  if vim.tbl_contains(schemes, vim.g.colors_name) then
    vim.cmd [[autocmd! Starry]]
    vim.cmd [[augroup! Starry]]
  end
end

-- Change the background for the terminal and packer windows
util.contrast = function()
  vim.cmd [[augroup Starry]]
  vim.cmd [[  autocmd!]]
  vim.cmd [[  autocmd ColorScheme * lua require("starry.util").onColorScheme()]]
  vim.cmd [[  autocmd TermOpen * setlocal winhighlight=Normal:NormalFloat,SignColumn:NormalFloat]]
  vim.cmd [[  autocmd FileType packer setlocal winhighlight=Normal:NormalFloat,SignColumn:NormalFloat]]
  vim.cmd [[  autocmd FileType qf setlocal winhighlight=Normal:NormalFloat,SignColumn:NormalFloat]]
  vim.cmd [[augroup end]]
end

-- Load the theme
function util.load(theme)
  if theme then
    vim.g.starry_style = theme
    vim.g.starry_style_fix = true
  end
  -- Set the theme environment
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  if theme ~= 'lighter' then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
  vim.o.termguicolors = true
  if theme then
    vim.g.colors_name = theme
  else
    vim.g.colors_name = "starry"
  end

  local starry = require('starry.theme')
  -- Load plugins, treesitter and lsp async
  local async
  async = vim.loop.new_async(vim.schedule_wrap(function()

    local treesitter = starry.loadTreeSitter()
    for group, colors in pairs(treesitter) do
      util.highlight(group, colors)
    end

    if config.disable.term_colors == false then
      starry.loadTerminal()
    end
    -- imort tables for plugins and lsp
    local plugins = starry.loadPlugins()
    local lsp = starry.loadLSP()

    for group, colors in pairs(plugins) do
      util.highlight(group, colors)
    end

    for group, colors in pairs(lsp) do
      util.highlight(group, colors)
    end

    if type(config.custom_highlights) == 'table' then
      for group, colors in pairs(config.custom_highlights) do
        util.highlight(group, colors)
      end
    end
    util.contrast()
    async:close()
    vim.cmd('doautocmd ColorScheme')

  end))

  -- load base theme
  local editor = starry.loadEditor()
  local syntax = starry.loadSyntax()

  for group, colors in pairs(editor) do
    util.highlight(group, colors)
  end

  for group, colors in pairs(syntax) do
    util.highlight(group, colors)
  end

  async:send()
end

return util
