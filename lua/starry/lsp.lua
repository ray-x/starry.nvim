local link_v9 = function(starry, underdouble)
  -- TreeSitter highlight groups

  local lsp = {
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.keyword'] = { link = '@keyword' },
    ['@lsp.type.interface'] = { link = 'Identifier' },
    ['@lsp.type.namespace'] = { link = '@namespace' },
    ['@lsp.type.parameter'] = { link = '@parameter' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.variable'] = { link = '@variable' },
    ['@lsp.type.modifier'] = { link = 'Special' },
    ['@lsp.typemod.function.defaultLibrary'] = { link = 'Special' },
    ['@lsp.typemod.variable.readonly'] = { link = '@constant' },
  }
  return lsp
end

return { link_v9 = link_v9 }
