local fu = require("starry.functions")
local change_style = function(style)
  fu.change_style(style)
  print(' require "material" deprecated')
end

-- Toggle_style takes no parameters toggles the style on every function call
local toggle_style = function()
  fu.toggle_style()
  print(' require "material" deprecated')
end

local change = function(scheme)
  fu.change(scheme)
  print(' require "material" deprecated')
end

return {change_style = change_style, toggle_style = toggle_style, change = change}
