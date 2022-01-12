lua << EOF
local  has, plugin = pcall(require, modulename)
if not has then
  vim.cmd('packadd starry.nvim')
end
require('starry').clear()
require('starry').set('marinana_lighter')
EOF
