local util = {}
local config = require('starry.config').options
local nvim06 = (vim.fn.has('nvim-0.6') == 1)

util.hlv2 = function(group, style)
  local val = {}
  if style.bg and style.bg ~= 'NONE' then
    val.bg = style.bg
  end
  if style.fg and style.fg ~= 'NONE' then
    val.fg = style.fg
  end
  if style.sp then
    val.sp = style.sp
  end
  if style.blend then
    val.blend = style.blend
  end
  if style.style then
    local s = vim.split(style.style, ',')
    for i = 1, #s do
      if not vim.tbl_contains(config.style.disable, s[i]) then
        val[s[i]] = true
      end
    end
    -- lprint(group, val)
  end
  if style.link then
    val = { link = style.link }
  end
  vim.api.nvim_set_hl(0, group, val)
end

-- Go trough the table and highlight the group with the color values
util.highlight = function(group, color, col)
  if not nvim06 then
    return vim.notify(
      'Starry.nvim: Your Neovim version is outdated, please update to 0.6 or higher',
      3
    )
  end

  util.hlv2(group, color)
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
  local group = vim.api.nvim_create_augroup('Starry', { clear = true })

  -- clean up autogroups if the theme is not material
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
      if vim.g.colors_name ~= 'starry' then
        vim.api.nvim_del_augroup_by_name('Starry')
      end
    end,
    group = group,
  })
  local config = require('starry.config').options

  -- apply contrast to the built-in terminal
  if config.contrast.terminal then
    vim.api.nvim_create_autocmd('TermOpen', {
      command = 'setlocal winhighlight=Normal:NormalContrast,SignColumn:NormalContrast',
      group = group,
    })
  end

  -- apply contrast to filetypes
  for _, ft in ipairs(config.contrast.filetypes) do
    vim.api.nvim_create_autocmd('FileType', {
      pattern = ft,
      command = 'setlocal winhighlight=Normal:NormalContrast,SignColumn:SignColumnFloat',
      group = group,
    })
  end
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
  'mariana_lighter',
  'emerald',
  'middlenight_blue',
  'ukraine',
  'earlysummer',
  'dark_solar',
}

local themes_daytime =
  { 'limestone', 'monokai_lighter', 'mariana_lighter', 'earlysummer_lighter', 'ukraine' }

-- Load the theme
function util.load(theme)
  local config = require('starry.config').options
  if not theme then
    if config.style.daylight_switch and config.style.fix ~= true then
      local h = tonumber(os.date('%H'))
      if 6 < h and h < 18 then
        themes = themes_daytime
      end
    end

    if config.style.fix ~= true then
      config.style.fix = true
      local v = math.random(1, #themes)
      config.style.name = themes[v]
    else
      config.style.name = config.style.name or 'monokai'
    end
    theme = config.style.name
  else
    config.style.name = theme
    config.style.fix = true
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
  local treesitter = starry.loadTreesitter()
  for group, colors in pairs(treesitter) do
    util.highlight(group, colors)
  end

  -- vim.api.nvim_set_hl_ns(0)
  -- require('starry.tsmap').link()

  local async
  local uv = vim.uv or vim.loop
  async = uv.new_async(vim.schedule_wrap(function()
    if config.disable.term_colors == false then
      starry.loadTerminal()
    end
    -- import tables for plugins and lsp
    local lsp = starry.loadLSP()
    for group, colors in pairs(lsp) do
      util.highlight(group, colors)
    end

    local plugins = starry.loadPlugins()
    for group, colors in pairs(plugins) do
      util.highlight(group, colors)
    end

    lsp = starry.loadLSPV9()
    for group, colors in pairs(lsp) do
      util.highlight(group, colors)
    end

    if type(config.custom_highlights) == 'table' then
      for group, colors in pairs(config.custom_highlights) do
        util.highlight(group, colors)
      end
    end
    util.contrast()
    if vim.fn.has('nvim-0.8') == 0 then
      vim.api.nvim__set_hl_ns(0)
    else
      vim.api.nvim_set_hl_ns(0)
    end
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

  vim.cmd('hi Normal guibg=' .. (editor.Normal.bg or 'NONE') .. ' guifg=' .. editor.Normal.fg)
end

return util
