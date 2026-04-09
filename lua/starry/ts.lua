local config = require('starry.config').options
local s = require('starry.functions').styler
return {
  link_v8 = function(starry, underdouble)
    -- TreeSitter highlight groups

    local treesitter = {
      ['@annotation'] = { link = 'Special' }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
      ['@attribute'] = { link = 'WarningMsg' }, -- (unstable) TODO: docs
      ['@boolean'] = { fg = starry.bool, style = s('italic') }, -- For booleans.
      ['@character'] = { fg = starry.char }, -- For characters.
      ['@constructor'] = { link = 'PreProc' }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
      ['@constant'] = { fg = starry.const }, -- For constants
      ['@constant.builtin'] = { fg = starry.const, style = s('bold') }, -- For constant that are built in the language: `nil` in Lua.
      ['@constant.macro'] = { link = 'Special' }, -- For constants that are defined by macros: `NULL` in C.
      ['@variable.member'] = { fg = starry.field }, -- For fields (canonical name).
      ['@field'] = { link = '@variable.member' }, -- Deprecated alias.
      ['@number.float'] = { fg = starry.float }, -- For floats (canonical name).
      ['@float'] = { link = '@number.float' }, -- Deprecated alias.
      ['@keyword.import'] = { link = 'Include' }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
      ['@include'] = { link = '@keyword.import' }, -- Deprecated alias.

      ['@label'] = { fg = starry.green1 }, -- For labels: `label:` in C and `:label:` in Lua.
      ['@module'] = { link = 'Include' }, -- For modules (canonical name).
      ['@module.builtin'] = { link = 'Special' }, -- Built-in modules.
      ['@namespace'] = { link = '@module' }, -- Deprecated alias.
      ['@namespace.builtin'] = { link = '@module.builtin' }, -- Deprecated alias.
      ['@number'] = { link = 'Number' }, -- For all numbers
      ['@operator'] = { link = 'Operator' }, -- For any operator: `+`, but also `->` and `*` in C.
      ['@keyword.operator'] = { link = 'Operator', style = s('bold') }, -- For any operator: `+`, but also `->` and `*` in C.
      ['@variable.parameter'] = { fg = starry.parameter, style = s('bold') }, -- For parameters of a function (canonical name).
      ['@parameter'] = { link = '@variable.parameter' }, -- Deprecated alias.
      ['@property'] = { fg = starry.field }, -- Same as `@variable.member`.
      ['@punctuation.delimiter'] = { link = 'Macro' }, -- For delimiters ie: `.`
      ['@punctuation.bracket'] = { fg = starry.bracket }, -- For brackets and parens.
      ['@punctuation.special'] = { fg = starry.punctutation }, -- For special punctutation that does not fall in the categories before.
      ['@function.call'] = { fg = starry.func },
      ['@function.builtin'] = { link = 'Special' },
      ['@function.macro'] = { link = 'Macro' },
      ['@string'] = { link = 'String' }, -- For strings.
      ['@string.regexp'] = { fg = starry.pink2 }, -- For regexes (canonical name).
      ['@string.regex'] = { link = '@string.regexp' }, -- Deprecated alias.
      ['@string.escape'] = { link = 'Ignore' }, -- For escape characters within a string.
      ['@string.special'] = { link = 'SpecialChar' }, -- For escape characters within a string.
      ['@symbol'] = { fg = starry.symbol }, -- For identifiers referring to symbols or atoms.
      ['@type'] = { fg = starry.type }, -- For types.
      ['@type.builtin'] = { fg = starry.builtin or starry.purple1, style = s('bold') }, -- For builtin types.

      ['@type.qualifier'] = { link = 'Type' }, -- For types.
      ['@type.definition'] = { link = 'Typedef' }, -- For types.
      ['@tag'] = { fg = starry.tag or starry.red1 }, -- Tags like html tag names.
      ['@tag.delimiter'] = { fg = starry.yellow2 }, -- Tag delimiter like `<` `>` `/`

      ['@text'] = { fg = starry.text }, -- For strings considered text in a markup language.

      ['@text.reference'] = { fg = starry.keyword, bg = starry.bg_alt }, -- FIXME
      ['@markup.italic'] = { italic = true }, -- Canonical name for emphasis.
      ['@emphasis'] = { link = '@markup.italic' }, -- Deprecated alias.
      ['@markup.underline'] = { underline = true }, -- Canonical name for underline.
      ['@underline'] = { link = '@markup.underline' }, -- Deprecated alias.
      ['@markup.strikethrough'] = { strikethrough = true }, -- Canonical name for strikethrough.
      ['@strike'] = { link = '@markup.strikethrough' }, -- Deprecated alias.
      ['@current.scope'] = { bg = starry.less_active or starry.active },
      ['@markup.heading'] = { link = 'Title' }, -- Canonical name for title.
      ['@title'] = { link = '@markup.heading' }, -- Deprecated alias.
      ['@markup.raw'] = { link = 'String' }, -- Canonical name for literal.
      ['@literal'] = { link = '@markup.raw' }, -- Deprecated alias.
      ['@markup.list'] = { fg = starry.blue }, -- For special punctuation that does not fall in the categories before.
      ['@markup.list.markdown'] = { fg = starry.orange, bold = true },
      ['@markup.list.checked'] = { link = 'Comment' },
      ['@markup.list.unchecked'] = { link = 'Todo' },
      ['@markup.link.label'] = { link = 'SpecialChar' },
      ['@markup.link.label.symbol'] = { link = 'Identifier' },
      ['@markup'] = { link = '@none' },
      ['@markup.environment'] = { link = 'Macro' },
      ['@markup.environment.name'] = { link = 'Type' },
      ['@markup.strong'] = { bold = true },
      ['@markup.math'] = { link = 'Special' },
      ['@markup.link.url'] = { link = 'Underlined' },
      ['@none'] = { link = 'Comment' }, -- TODO: docs
    }

    -- Options:

    -- Italic comments
    if config.italics.comments == true then
      treesitter['@comment'] = { fg = starry.comments, style = s('italic') } -- For comment blocks.
      treesitter['@comment.todo'] = { link = 'Title', style = s('italic') } -- For comment blocks.
      treesitter['@comment.error'] = { link = 'WarningMsg', style = s('italic')} -- For comment blocks.
    else
      treesitter['@comment'] = { link = 'Comment' } -- For comment blocks.
      treesitter['@comment.todo'] = { link = 'Title' } -- For comment blocks.
      treesitter['@comment.error'] = { link = 'WarningMsg'} -- For comment blocks.
    end

    if config.italics.keywords == true then
      treesitter['@keyword.conditional'] = { fg = starry.condition, style = s('italic') } -- For keywords related to conditionals.
      treesitter['@conditional'] = { link = '@keyword.conditional' } -- Deprecated alias.
      treesitter['@keyword'] = { fg = starry.keyword, style = s('italic', 'bold') } -- For keywords that don't fall in previous categories.
      treesitter['@keyword.repeat'] = { fg = starry.condition, style = s('italic', 'bold') } -- For keywords related to loops.
      treesitter['@repeat'] = { link = '@keyword.repeat' } -- Deprecated alias.
      treesitter['@keyword.return'] = { link = '@keyword' } -- For return keywords.
      treesitter['@keyword.function'] = {
        fg = starry.keyword_func or starry.keyword,
        style = s('italic', 'bold'),
      } -- For keywords used to define a function.
    else
      treesitter['@keyword.conditional'] = { fg = starry.condition } -- For keywords related to conditionals.
      treesitter['@conditional'] = { link = '@keyword.conditional' } -- Deprecated alias.
      treesitter['@keyword'] = { fg = starry.keyword, style = s('bold') } -- For keywords that don't fall in previous categories.
      treesitter['@keyword.repeat'] = { fg = starry.condition, style = s('bold') } -- For keywords related to loops.
      treesitter['@repeat'] = { link = '@keyword.repeat' } -- Deprecated alias.
      treesitter['@keyword.return'] = { link = '@keyword' } -- For return keywords.
      treesitter['@keyword.function'] = {
        fg = starry.keyword_func or starry.keyword,
        style = s('bold'),
      } -- For keywords used to define a function.
    end

    if config.italics.functions == true then
      treesitter['@function'] = { fg = starry.func, style = s('italic', 'bold') } -- For function (calls and definitions).
      treesitter['@function.method'] = {
        fg = starry.method or starry.func,
        style = s('italic', 'bold'),
      } -- For method calls and definitions (canonical name).
      treesitter['@method'] = { link = '@function.method' } -- Deprecated alias.
      treesitter['@function.builtin'] = { fg = starry.func, style = s('italic', 'bold') } -- For builtin functions: `table.insert` in Lua.
    else
      treesitter['@function'] = { fg = starry.func, style = s('bold') } -- For function (calls and definitions).
      treesitter['@function.method'] = { fg = starry.method, style = s('bold') } -- For method calls and definitions (canonical name).
      treesitter['@method'] = { link = '@function.method' } -- Deprecated alias.
      treesitter['@function.builtin'] = { fg = starry.func, style = s('bold') } -- For builtin functions: `table.insert` in Lua.
    end
    treesitter['@function.method.call'] = { link = '@function.method' } -- For method calls.
    treesitter['@method.call'] = { link = '@function.method.call' } -- Deprecated alias.

    if config.italics.variables == true then
      treesitter['@variable.builtin'] = { fg = starry.variable, style = s('italic') } -- Variable names that are defined by the languages, like `this` or `self`.
    else
      treesitter['@variable.builtin'] = { fg = starry.variable } -- Variable names that are defined by the languages, like `this` or `self`.
    end

    treesitter['@variable'] = { link = 'Identifier' } -- Any variable name that does not have another highlight.
    if config.italics.strings == true then
      treesitter['@string.style'] = 'italic' -- For strings.
    end
    treesitter['@text'] = { link = 'Normal' }
    treesitter['@text.strong'] = { link = '@markup.strong' }
    treesitter['@text.emphasis'] = { link = '@markup.italic' }
    treesitter['@text.underline'] = { link = '@markup.underline' }
    treesitter['@text.strike'] = { link = '@markup.strikethrough' }
    treesitter['@text.title'] = { link = '@markup.heading' }
    treesitter['@text.literal'] = { link = '@markup.raw' }
    treesitter['@text.literal.markdown'] = { link = 'Normal' }
    treesitter['@text.literal.markdown_inline'] = { link = 'Special' }
    treesitter['@text.uri'] = { link = '@markup.link.url' }
    treesitter['@text.math'] = { link = '@markup.math' }
    treesitter['@text.environment'] = { link = '@markup.environment' }
    treesitter['@text.environment.name'] = { link = '@markup.environment.name' }
    treesitter['@text.reference'] = { link = 'Constant' }
    treesitter['@keyword.exception'] = { link = 'Exception' } -- Canonical name.
    treesitter['@exception'] = { link = '@keyword.exception' } -- Deprecated alias.

    treesitter['@text.todo'] = { link = '@comment.todo' }
    treesitter['@text.todo.unchecked'] = { link = '@markup.list.unchecked' }
    treesitter['@text.todo.checked'] = { link = '@markup.list.checked' }
    treesitter['@comment.note'] = { link = 'Comment' }
    treesitter['@text.note'] = { link = '@comment.note' } -- Deprecated alias.
    treesitter['@comment.warning'] = { link = 'WarningMsg' }
    treesitter['@text.warning'] = { link = '@comment.warning' } -- Deprecated alias.
    treesitter['@text.danger'] = { link = '@comment.error' }
    -- }}}

    -- Tags {{{
    treesitter['@tag'] = { link = 'Tag' }
    treesitter['@tag.attribute'] = { link = 'Identifier' }
    treesitter['@tag.delimiter'] = { link = 'Delimiter' }

    -- TSTextObjects
    treesitter.TSCurrentScope = { bg = starry.less_active or starry.active }
    treesitter.TSDefinitionUsage = {
      fg = starry.accent,
      style = s('bold', 'underline'),
      sp = 'white',
    } -- used for highlighting "read" references

    treesitter.TSDefinition = { fg = starry.keyword, style = s('bold', underdouble), sp = 'red' } -- used for highlighting "write" references

    return treesitter
  end,
}
