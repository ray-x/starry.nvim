local util = require('starry.util')

-- Load the theme
local set = function(theme)
  util.load(theme)
  vim.cmd(
      [[command! -nargs=* -complete=custom,v:lua.package.loaded.starry.theme_complete Starry  lua require('starry.functions').change(<f-args>)]])
end

local clear = function()
  package.loaded['starry'] = nil
  package.loaded['starry.util'] = nil
  package.loaded['starry.colors'] = nil
  package.loaded['starry.theme'] = nil
  package.loaded['starry.functions'] = nil

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
end

local function theme_complete()
  local schemes = require'starry.functions'.all_schemes
  return table.concat(schemes, '\n')

end

return {set = set, clear = clear, theme_complete = theme_complete}
