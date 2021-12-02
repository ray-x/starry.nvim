-- Define style_switch
if vim.g.starry_style_switch == nil then
  vim.g.starry_style_switch = 1
end

if vim.g.starry_daylight_switch == nil then
  vim.g.starry_daylight_switch = false
end

local switch = {
  "darker", "lighter", "palenight", "oceanic", "deep ocean", "moonlight", "dracula",
  "dracula_blood", "monokai", "mariana", "emerald", "middlenight_blue", "earlysummer"
}
local switch_daytime = {"lighter", "monokai", "mariana", "earlysummer"}

local all_schemes = {}
vim.list_extend(all_schemes, switch)
vim.list_extend(all_schemes, switch_daytime)
-- Change_style takes a style name as a parameter and switches to that style
local change_style = function(style)
  vim.g.starry_style = style
  print("Starry style: ", style)
  if style == 'lighter' then
    vim.cmd [[set background=light]]
  else
    vim.cmd [[set background=dark]]
  end
  vim.cmd([[colorscheme ]] .. style)
end

-- Toggle_style takes no parameters toggles the style on every function call
local toggle_style = function()
  if vim.g.starry_daylight_switch then
    if tonumber(vim.fn.system('date +%H')) < 18 then
      switch = switch_daytime
    end
  end
  vim.g.starry_style_switch = (vim.g.starry_style_switch % #switch) + 1
  change_style(switch[vim.g.starry_style_switch])
end

local toggle_eob = function()
  if vim.g.starry_hide_eob == nil then
    vim.g.starry_hide_eob = true
  else
    vim.g.starry_hide_eob = nil
  end
  vim.cmd [[colorscheme starry]]
end

local change = function(scheme)
  if scheme ~= nil then
    change_style(scheme)
  else
    toggle_style()
  end
end

return {
  change_style = change_style,
  toggle_style = toggle_style,
  change = change,
  toggle_eob = toggle_eob,
  all_schemes = all_schemes
}
