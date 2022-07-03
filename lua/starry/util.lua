local util = {}
local config = require('starry.config').options
local nvim06 = vim.fn.has('nvim-0.6')

local ns = vim.api.nvim_create_namespace('color_starry')
util.hlv2 = function(group, style)
  local val = { fg = style.fg, bg = style.bg }
  if style.sp then
    val.sp = style.sp
  end
  if style.blend then
    val.blend = style.blend
  end
  if style.style then
    local s = vim.split(style.style, ',')
    for i = 1, #s do
      val[s[i]] = true
    end
    -- lprint(group, val)
  end
  if style.link then
    val = { link = style.link }
  end
  vim.api.nvim_set_hl(0, group, val)
end

-- Go trough the table and highlight the group with the color values
util.highlight = function(group, color)
  if nvim06 and vim.g.starry_set_hl ~= false then
    util.hlv2(group, color)
  else
    local style = color.style and 'gui=' .. color.style or 'gui=NONE'
    local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
    local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
    local sp = color.sp and 'guisp=' .. color.sp or ''
    local blend = color.blend and 'blend=' .. tostring(color.blend) or ''

    local hlcmd = 'highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp .. blend
    if color.link then
      -- lprint('link' ,group, color)
      hlcmd = 'highlight! link ' .. group .. ' ' .. color.link
    end
    vim.cmd(hlcmd)
  end
end

-- Only define Starry if it's the active colorshceme
function util.onColorScheme()
  local schemes = require('starry.functions').all_schemes

  if vim.tbl_contains(schemes, vim.g.colors_name) then
    vim.cmd([[autocmd! Starry]])
    vim.cmd([[augroup! Starry]])
  end
end

-- Change the background for the terminal and packer windows
util.contrast = function()
  vim.cmd([[augroup Starry]])
  vim.cmd([[  autocmd!]])
  vim.cmd([[  autocmd ColorScheme * lua require("starry.util").onColorScheme()]])
  vim.cmd([[  autocmd TermOpen * setlocal winhighlight=Normal:NormalFloat,SignColumn:NormalFloat]])
  vim.cmd([[  autocmd FileType packer setlocal winhighlight=Normal:NormalFloat,SignColumn:NormalFloat]])
  vim.cmd([[  autocmd FileType qf setlocal winhighlight=Normal:NormalFloat,SignColumn:NormalFloat]])
  vim.cmd([[augroup end]])
end

local themes = {
  'darker',
  'palenight',
  'oceanic',
  'deep ocean',
  'moonlight',
  'dracula',
  'dracula_blood',
  'monokai',
  'monokai_lighter',
  'mariana',
  'emerald',
  'middlenight_blue',
  'ukraine',
  'earlysummer',
}

local themes_daytime = { 'limestone', 'monokai_lighter', 'mariana_lighter', 'earlysummer_lighter', 'ukraine' }

-- Load the theme
function util.load(theme)
  if theme == nil then
    local h = tonumber(os.date('%H'))
    if vim.g.starry_daylight_switch and vim.g.starry_style_fix ~= true then
      if 6 < h and h < 18 then
        themes = themes_daytime
      end
    end

    if vim.g.starry_style_fix ~= true then
      vim.g.starry_style_fix = true
      local v = math.random(1, #themes)
      vim.g.starry_style = themes[v]
    else
      vim.g.starry_style = vim.g.starry_style or 'mariana'
    end
    theme = vim.g.starry_style
  else
    vim.g.starry_style = theme
    vim.g.starry_style_fix = true
  end
  -- Set the theme environment
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end
  if theme ~= 'limestone' then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
  vim.o.termguicolors = true
  if theme then
    vim.g.colors_name = theme
  else
    vim.g.colors_name = 'starry'
  end

  -- local ns = vim.api.nvim_create_namespace('color_starry')
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
    vim.api.nvim__set_hl_ns(ns)
    async:close()
    vim.cmd('doautocmd ColorScheme')
  end))

  -- load base theme
  local editor = starry.loadEditor()

  for group, colors in pairs(editor) do
    util.highlight(group, colors)
  end

  local syntax = starry.loadSyntax()

  for group, colors in pairs(syntax) do
    util.highlight(group, colors)
  end

  async:send()

  vim.cmd('hi Normal guibg=' .. editor.Normal.bg .. ' guifg=' .. editor.Normal.fg)
  vim.api.nvim__set_hl_ns(ns)
end

return util
