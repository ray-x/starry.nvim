-- Define style_switch
local switch = {
  "darker", "limestone", "palenight", "oceanic", "deep ocean", "moonlight", "dracula",
  "dracula_blood", "monokai", "mariana", "emerald", "middlenight_blue", "earlysummer", "dark_solar"
}
local switch_daytime = {"limestone", "monokai", "mariana", "earlysummer"}

local all_schemes = {}
vim.list_extend(all_schemes, switch)
vim.list_extend(all_schemes, switch_daytime)
-- Change_style takes a style name as a parameter and switches to that style
local change_style = function(style)
  local config = require('starry.config').options
  config.style.name = style
  -- print("Starry style: ", style)
  if style == 'limestone' then
    vim.cmd [[set background=light]]
  else
    vim.cmd [[set background=dark]]
  end
  vim.cmd([[colorscheme ]] .. style)
end

-- Toggle_style takes no parameters toggles the style on every function call
local toggle_style = function()
  local config = require('starry.config').options
  if config.style.daylight_switch then
    if tonumber(vim.fn.system('date +%H')) < 18 then
      switch = switch_daytime
    end
  end
  config.style.number = (config.style.number % #switch) + 1
  change_style(switch[config.style.number])
end

local toggle_eob = function()
  local config = require('starry.config').options
  config.disable.eob_lines = not config.disable.eob_lines
  vim.cmd [[colorscheme starry]]
end

local change = function(scheme)
  if scheme ~= nil then
    change_style(scheme)
  else
    toggle_style()
  end
end

local styler = function(...)
  local args = {...}
  if #args == 0 then
    return ''
  else
    local s = ''
    local config = require('starry.config').options
    for _, v in ipairs(args) do
      if v and not vim.tbl_contains(config.disable, v) then
        s = #s > 1 and s .. ',' .. v or v
      end
    end
    return s
  end
end


return {
  change_style = change_style,
  toggle_style = toggle_style,
  change = change,
  toggle_eob = toggle_eob,
  styler = styler,
  all_schemes = all_schemes
}
