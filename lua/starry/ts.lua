local config = require('starry.config').options
return {
  link_v7 = function(starry, underdouble)
    -- TreeSitter highlight groups

    local treesitter = {
      TSAnnotation = { link = 'Special' }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.

      TSAttribute = { link = 'WarningMsg' }, -- (unstable)  TODO: docs

      TSBoolean = { fg = starry.bool, style = 'italic' }, -- For booleans.
      TSCharacter = { fg = starry.char }, -- For characters.
      TSConstructor = { link = 'PreProc' }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
      TSConstant = { fg = starry.const }, -- For constants
      TSConstBuiltin = { fg = starry.const, style = 'bold' }, -- For constant that are built in the language: `nil` in Lua.
      TSConstMacro = { link = 'Special' }, -- For constants that are defined by macros: `NULL` in C.
      TSException = { fg = starry.red3 }, -- For exception related keywords.
      TSField = { fg = starry.field }, -- For fields.
      TSFloat = { fg = starry.float }, -- For floats.
      TSFuncMacro = { link = 'Macro' }, -- For macro defined functions (calls and definitions): each `macro_rules` in Rust.
      TSInclude = { link = 'Include' }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.

      TSCurrentScope = { bg = starry.less_active or starry.active },
      TSDefinitionUsage = {
        fg = starry.accent,
        style = 'bold,underline',
        sp = 'white',
      }, -- used for highlighting "read" references

      TSDefinition = { fg = starry.keyword, style = 'bold,' .. underdouble, sp = starry.keyword }, -- used for highlighting "write" references
      TSLabel = { fg = starry.green1 }, -- For labels: `label:` in C and `:label:` in Lua.
      TSNamespace = { fg = starry.yellow1 }, -- For identifiers referring to modules and namespaces.
      TSNumber = { link = 'Number' }, -- For all numbers
      TSOperator = { link = 'Operator' }, -- For any operator: `+`, but also `->` and `*` in C.
      TSKeywordOperator = { link = 'Operator', style = 'bold' }, -- For any operator: `+`, but also `->` and `*` in C.
      TSParameter = { fg = starry.parameter, style = 'bold' }, -- For parameters of a function.
      TSParameterReference = { link = 'PreCondit' }, -- For references to parameters of a function.
      TSProperty = { fg = starry.field }, -- Same as `TSField`.
      TSPunctDelimiter = { link = 'Macro' }, -- For delimiters ie: `.`
      TSPunctBracket = { fg = starry.bracket }, -- For brackets and parens.
      TSPunctSpecial = { fg = starry.punctutation }, -- For special punctutation that does not fall in the categories before.
      TSFunctionCall = { fg = starry.func },
      TSString = { link = 'String' }, -- For strings.
      TSStringRegex = { fg = starry.pink2 }, -- For regexes.
      TSStringEscape = { link = 'Ignore' }, -- For escape characters within a string.
      TSSymbol = { fg = starry.symbol }, -- For identifiers referring to symbols or atoms.
      TSType = { fg = starry.type }, -- For types.
      TSTypeBuiltin = { fg = starry.builtin or starry.purple1, style = 'bold' }, -- For builtin types.
      TSTag = { fg = starry.tag or starry.red1 }, -- Tags like html tag names.
      TSTagDelimiter = { fg = starry.yellow2 }, -- Tag delimiter like `<` `>` `/`
      TSText = { fg = starry.text }, -- For strings considered text in a markup language.
      TSTextReference = { fg = starry.keyword, bg = starry.bg_alt }, -- FIXME
      TSEmphasis = { link = 'PreCondit' }, -- For text to be represented with emphasis.
      TSUnderline = { fg = starry.fg, style = underdouble }, -- For text to be represented with an underline.
      TSStrike = { fg = starry.gray, style = 'strikethrough' }, -- For strikethrough text.
      TSTitle = { fg = starry.title, style = 'bold' }, -- Text that is part of a title.
      TSLiteral = { link = 'TSText' }, -- Literal text.
      TSURI = { link = 'htmlLink' }, -- Any URI like a link or email.
      TSNone = { link = 'Comment' }, -- TODO: docs
    }

    -- Options:

    -- italics comments
    if config.italics.comments == true then
      treesitter.TSComment = { fg = starry.comments, style = 'italic' } -- For comment blocks.
    else
      treesitter.TSComment = { link = 'Comment' } -- For comment blocks.
    end

    if config.italics.keywords == true then
      treesitter.TSConditional = { fg = starry.condition, style = 'italic' } -- For keywords related to conditionnals.
      treesitter.TSKeyword = { fg = starry.keyword, style = 'italic,bold' } -- For keywords that don't fall in previous categories.
      treesitter.TSRepeat = { fg = starry.condition, style = 'italic,bold' } -- For keywords related to loops.
      treesitter.TSKeywordFunction = {
        fg = starry.keyword_func or starry.keyword,
        style = 'italic,bold',
      } -- For keywords used to define a function.
    else
      treesitter.TSConditional = { fg = starry.condition } -- For keywords related to conditionnals.
      treesitter.TSKeyword = { fg = starry.keyword, style = 'bold' } -- For keywords that don't fall in previous categories.
      treesitter.TSRepeat = { fg = starry.condition, style = 'bold' } -- For keywords related to loops.
      treesitter.TSKeywordFunction = {
        fg = starry.keyword_func or starry.keyword,
        style = 'bold',
      } -- For keywords used to define a function.
    end

    if config.italics.functions == true then
      treesitter.TSFunction = { fg = starry.func, style = 'italic,bold' } -- For function (calls and definitions).
      treesitter.TSMethod = {
        fg = starry.method or starry.func,
        style = 'italic,bold',
      } -- For method calls and definitions.
      treesitter.TSFuncBuiltin = { fg = starry.func, style = 'italic,bold' } -- For builtin functions: `table.insert` in Lua.
    else
      treesitter.TSFunction = { fg = starry.func, style = 'bold' } -- For function (calls and definitions).
      treesitter.TSMethod = { fg = starry.method, style = 'bold' } -- For method calls and definitions.
      treesitter.TSFuncBuiltin = { fg = starry.func, style = 'bold' } -- For builtin functions: `table.insert` in Lua.
    end

    if config.italics.variables == true then
      treesitter.TSVariableBuiltin = { fg = starry.variable, style = 'italic' } -- Variable names that are defined by the languages, like `this` or `self`.
    else
      treesitter.TSVariableBuiltin = { fg = starry.variable } -- Variable names that are defined by the languages, like `this` or `self`.
    end

    treesitter.TSVariable = { link = 'Identifier' } -- Any variable name that does not have another highlight.
    if config.italics.strings == true then
      treesitter.TSString.style = 'italic' -- For strings.
    end

    return treesitter
  end,

  link_v8 = function(starry, underdouble)
    -- TreeSitter highlight groups

    local treesitter = {
      ['@annotation'] = { link = 'Special' }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
      ['@attribute'] = { link = 'WarningMsg' }, -- (unstable) TODO: docs
      ['@boolean'] = { fg = starry.bool, style = 'italic' }, -- For booleans.
      ['@character'] = { fg = starry.char }, -- For characters.
      ['@constructor'] = { link = 'PreProc' }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
      ['@constant'] = { fg = starry.const }, -- For constants
      ['@constant.builtin'] = { fg = starry.const, style = 'bold' }, -- For constant that are built in the language: `nil` in Lua.
      ['@constant.macro'] = { link = 'Special' }, -- For constants that are defined by macros: `NULL` in C.
      ['@field'] = { fg = starry.field }, -- For fields.
      ['@float'] = { fg = starry.float }, -- For floats.
      ['@include'] = { link = 'Include' }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.

      ['@label'] = { fg = starry.green1 }, -- For labels: `label:` in C and `:label:` in Lua.
      ['@namespace'] = { fg = starry.yellow1 }, -- For identifiers referring to modules and namespaces.
      ['@number'] = { link = 'Number' }, -- For all numbers
      ['@operator'] = { link = 'Operator' }, -- For any operator: `+`, but also `->` and `*` in C.
      ['@keyword.operator'] = { link = 'Operator', style = 'bold' }, -- For any operator: `+`, but also `->` and `*` in C.
      ['@parameter'] = { fg = starry.parameter, style = 'bold' }, -- For parameters of a function.
      ['@parameter.reference'] = { link = 'PreCondit' }, -- For references to parameters of a function.
      ['@property'] = { fg = starry.field }, -- Same as `TSField`.
      ['@punctuation.delimiter'] = { link = 'Macro' }, -- For delimiters ie: `.`
      ['@punctuation.bracket'] = { fg = starry.bracket }, -- For brackets and parens.
      ['@punctuation.special'] = { fg = starry.punctutation }, -- For special punctutation that does not fall in the categories before.
      ['@function.call'] = { fg = starry.func },
      ['@function.builtin'] = { link = 'Special' },
      ['@function.marco'] = { link = 'Marco' },
      ['@string'] = { link = 'String' }, -- For strings.
      ['@string.regex'] = { fg = starry.pink2 }, -- For regexes.
      ['@string.escape'] = { link = 'Ignore' }, -- For escape characters within a string.
      ['@string.special'] = { link = 'SpecialChar' }, -- For escape characters within a string.
      ['@symbol'] = { fg = starry.symbol }, -- For identifiers referring to symbols or atoms.
      ['@type'] = { fg = starry.type }, -- For types.
      ['@type.builtin'] = { fg = starry.builtin or starry.purple1, style = 'bold' }, -- For builtin types.

      ['@type.qualifier'] = { link = 'Type' }, -- For types.
      ['@type.deinition'] = { link = 'Typedef' }, -- For types.
      ['@tag'] = { fg = starry.tag or starry.red1 }, -- Tags like html tag names.
      ['@tag.delimiter'] = { fg = starry.yellow2 }, -- Tag delimiter like `<` `>` `/`

      ['@text'] = { fg = starry.text }, -- For strings considered text in a markup language.

      ['@text.reference'] = { fg = starry.keyword, bg = starry.bg_alt }, -- FIXME
      ['@emphasis'] = { link = 'PreCondit' }, -- For text to be represented with emphasis.
      ['@underline'] = { fg = starry.fg, style = underdouble }, -- For text to be represented with an underline.
      ['@strike'] = { fg = starry.gray, style = 'strikethrough' }, -- For strikethrough text.
      ['@current.scope'] = { bg = starry.less_active or starry.active },
      ['@title'] = { fg = starry.title, style = 'bold' }, -- Text that is part of a title.
      ['@literal'] = { link = 'Text' }, -- Literal text.

      ['@none'] = { link = 'Comment' }, -- TODO: docs
    }

    -- Options:

    -- Italic comments
    if config.italics.comments == true then
      treesitter['@comment'] = { fg = starry.comments, style = 'italic' } -- For comment blocks.
    else
      treesitter['@comment'] = { link = 'Comment' } -- For comment blocks.
    end

    if config.italics.keywords == true then
      treesitter['@conditional'] = { fg = starry.condition, style = 'italic' } -- For keywords related to conditionnals.
      treesitter['@keyword'] = { fg = starry.keyword, style = 'italic,bold' } -- For keywords that don't fall in previous categories.
      treesitter['@repeat'] = { fg = starry.condition, style = 'italic,bold' } -- For keywords related to loops.
      treesitter['@keyword.return'] = { link = '@keyword' } -- For keywords related to loops.
      treesitter['@keyword.function'] = {
        fg = starry.keyword_func or starry.keyword,
        style = 'italic,bold',
      } -- For keywords used to define a function.
    else
      treesitter['@conditional'] = { fg = starry.condition } -- For keywords related to conditionnals.
      treesitter['@keyword'] = { fg = starry.keyword, style = 'bold' } -- For keywords that don't fall in previous categories.
      treesitter['@repeat'] = { fg = starry.condition, style = 'bold' } -- For keywords related to loops.
      treesitter['@keyword.return'] = { link = '@keyword' } -- For keywords related to loops.
      treesitter['@keyword.function'] = {
        fg = starry.keyword_func or starry.keyword,
        style = 'bold',
      } -- For keywords used to define a function.
    end

    if config.italics.functions == true then
      treesitter['@function'] = { fg = starry.func, style = 'italic,bold' } -- For function (calls and definitions).
      treesitter['@method'] = {
        fg = starry.method or starry.func,
        style = 'italic,bold',
      } -- For method calls and definitions.
      treesitter['@function.builtin'] = { fg = starry.func, style = 'italic,bold' } -- For builtin functions: `table.insert` in Lua.
    else
      treesitter['@function'] = { fg = starry.func, style = 'bold' } -- For function (calls and definitions).
      treesitter['@method'] = { fg = starry.method, style = 'bold' } -- For method calls and definitions.
      treesitter['@function.builtin'] = { fg = starry.func, style = 'bold' } -- For builtin functions: `table.insert` in Lua.
    end
    treesitter['@method.call'] = { link = '@method' } -- For method calls and definitions.

    if config.italics.variables == true then
      treesitter['@variable.builtin'] = { fg = starry.variable, style = 'italic' } -- Variable names that are defined by the languages, like `this` or `self`.
    else
      treesitter['@variable.builtin'] = { fg = starry.variable } -- Variable names that are defined by the languages, like `this` or `self`.
    end

    treesitter['@variable'] = { link = 'Identifier' } -- Any variable name that does not have another highlight.
    if config.italics.strings == true then
      treesitter['@string.style'] = 'italic' -- For strings.
    end
    treesitter['@text'] = { link = 'Normal' }
    treesitter['@text.strong'] = { style = 'bold' }
    treesitter['@text.emphasis'] = { style = 'bold,italic' }
    treesitter['@text.underline'] = { style = 'underline' }
    treesitter['@text.strike'] = { style = 'strikethrough' }
    treesitter['@text.title'] = { link = 'Title' }
    treesitter['@text.literal'] = { link = 'String' }
    treesitter['@text.literal.markdown'] = { link = 'Normal' }
    treesitter['@text.literal.markdown_inline'] = { link = 'Special' }
    treesitter['@text.uri'] = { link = 'Underlined' }
    treesitter['@text.math'] = { link = 'Special' }
    treesitter['@text.environment'] = { link = 'Macro' }
    treesitter['@text.environment.name'] = { link = 'Type' }
    treesitter['@text.reference'] = { link = 'Constant' }
    treesitter['@exception'] = { link = 'Exception' }

    treesitter['@text.todo'] = { link = 'Todo' }
    treesitter['@text.todo.unchecked'] = { link = 'Todo' }
    treesitter['@text.todo.checked'] = { link = 'Comment' }
    treesitter['@text.note'] = { link = 'Comment' }
    treesitter['@text.warning'] = { link = 'WarningMsg' }
    treesitter['@text.danger'] = { link = 'ErrorMsg' }
    -- }}}

    -- Tags {{{
    treesitter['@tag'] = { link = 'Tag' }
    treesitter['@tag.attribute'] = { link = 'Identifier' }
    treesitter['@tag.delimiter'] = { link = 'Delimiter' }

    -- TSTextObjects
    treesitter.TSCurrentScope = { bg = starry.less_active or starry.active }
    treesitter.TSDefinitionUsage = {
      fg = starry.accent,
      style = 'bold,underline',
      sp = 'white',
    } -- used for highlighting "read" references

    treesitter.TSDefinition = { fg = starry.keyword, style = 'bold,' .. underdouble, sp = 'red' } -- used for highlighting "write" references

    return treesitter
  end,
}
