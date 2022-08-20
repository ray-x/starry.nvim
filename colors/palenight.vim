lua << EOF
local  has, plugin = pcall(require, 'starry')
if not has then
  vim.cmd('packadd starry.nvim')
end
require('starry').clear()
require('starry').set('palenight')
EOF
