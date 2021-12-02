local starry = require("starry.colors").starry()

local theme = {}

theme.loadSyntax = function()
  -- Syntax highlight groups

  local syntax = {
    Type = {fg = starry.type}, -- int, long, char, etc.
    StorageClass = {fg = starry.class or starry.cyan}, -- static, register, volatile, etc.
    Structure = {fg = starry.structure or starry.puple}, -- struct, union, enum, etc.
    Constant = {fg = starry.const or starry.yellow}, -- any constant
    String = {fg = starry.string or starry.green, bg = starry.none}, -- Any string
    Character = {fg = starry.orange}, -- any character constant: 'c', '\n'
    Number = {fg = starry.number or starry.coral}, -- a number constant: 5
    Boolean = {fg = starry.bool or starry.orange, style = 'italic'}, -- a boolean constant: TRUE, false
    Float = {fg = starry.float or starry.number}, -- a floating point constant: 2.3e10
    Statement = {fg = starry.statement or starry.pink}, -- any statement
    Label = {fg = starry.label or starry.purple}, -- case, default, etc.
    Operator = {fg = starry.operator or starry.cyan}, -- sizeof", "+", "*", etc.
    Exception = {fg = starry.purple2}, -- try, catch, throw
    PreProc = {fg = starry.purple}, -- generic Preprocessor
    Include = {fg = starry.blue}, -- preprocessor #include
    Define = {fg = starry.pink}, -- preprocessor #define
    Macro = {fg = starry.cyan}, -- same as Define
    Typedef = {fg = starry.typedef or starry.red}, -- A typedef
    PreCondit = {fg = starry.paleblue}, -- preprocessor #if, #else, #endif, etc.
    Special = {fg = starry.red}, -- any special symbol
    SpecialChar = {fg = starry.pink}, -- special character in a constant
    Tag = {fg = starry.lime}, -- you can use CTRL-] on this
    Delimiter = {fg = starry.blue1}, -- character that needs attention like , or .
    SpecialComment = {fg = starry.comments or starry.gray}, -- special things inside a comment
    Debug = {fg = starry.red}, -- debugging statements
    Underlined = {fg = starry.link, bg = starry.none, style = 'undercurl', sp = starry.blue}, -- text that stands out, HTML links
    Ignore = {fg = starry.disabled}, -- left blank, hidden
    Error = {fg = starry.error, bg = starry.none, style = 'bold,undercurl', sp = starry.pink}, -- any erroneous construct
    Todo = {fg = starry.yellow, bg = starry.bg_alt or starry.search_bg, style = 'bold,italic'}, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    htmlLink = {fg = starry.link, style = "underline", sp = starry.blue},
    htmlH1 = {fg = starry.cyan, style = "bold"},
    htmlH2 = {fg = starry.red, style = "bold"},
    htmlH3 = {fg = starry.green, style = "bold"},
    htmlH4 = {fg = starry.yellow, style = "bold"},
    htmlH5 = {fg = starry.purple, style = "bold"},
    markdownH1 = {fg = starry.cyan, style = "bold"},
    markdownH2 = {fg = starry.red, style = "bold"},
    markdownH3 = {fg = starry.green, style = "bold"},
    markdownH1Delimiter = {fg = starry.cyan},
    markdownH2Delimiter = {fg = starry.red},
    markdownH3Delimiter = {fg = starry.green}
  }

  -- Options:

  -- Italic comments
  if vim.g.starry_italic_comments == true then
    syntax.Comment = {fg = starry.comments, bg = starry.none, style = 'italic'} -- italic comments
  else
    syntax.Comment = {fg = starry.comments} -- normal comments
  end

  -- Italic string
  if vim.g.starry_italic_string == true then
    syntax.String.style = 'italic'
  end

  -- Italic Keywords
  if vim.g.starry_italic_keywords == true then
    syntax.Conditional = {
      fg = starry.condition or starry.purple,
      bg = starry.none,
      style = 'italic'
    } -- italic if, then, else, endif, switch, etc.
    syntax.Keyword = {
      fg = starry.keyword or starry.purple,
      bg = starry.none,
      style = 'italic'
    } -- italic for, do, while, etc.
    syntax.Repeat = {
      fg = starry.condition or starry.purple,
      bg = starry.none,
      style = 'italic'
    } -- italic any other keyword
  else
    syntax.Conditional = {fg = starry.condition or starry.purple} -- normal if, then, else, endif, switch, etc.
    syntax.Keyword = {fg = starry.keyword or starry.purple} -- normal for, do, while, etc.
    syntax.Repeat = {fg = starry.purple} -- normal any other keyword
  end

  -- Italic Function names
  if vim.g.starry_italic_functions == true then
    syntax.Function = {
      fg = starry.func or starry.blue,
      bg = starry.none,
      style = 'italic,bold'
    } -- italic funtion names
  else
    syntax.Function = {fg = starry.func or starry.blue, style = 'bold'} -- normal function names
  end

  if vim.g.starry_italic_variables == true then
    syntax.Identifier = {fg = starry.variable, bg = starry.none, style = 'italic'}; -- any variable name
  else
    syntax.Identifier = {fg = starry.variable}; -- any variable name
  end

  return syntax

end

theme.loadEditor = function()
  -- Editor highlight groups

  local editor = {
    NormalFloat = {fg = starry.fg, bg = starry.floating}, -- normal text and background color for floating windows
    FloatBorder = {fg = starry.comments, bg = starry.less_active},
    FloatShadow = {bg = starry.black, blend = 36},
    FloatShadowThrough = {bg = starry.black, blend = 66},
    ColorColumn = {fg = starry.none, bg = starry.active}, --  used for the columns set with 'colorcolumn'
    Conceal = {fg = starry.disabled}, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = {fg = starry.cursor, bg = starry.none, style = 'reverse'}, -- the character under the cursor
    CursorIM = {fg = starry.cursor, bg = starry.none, style = 'reverse'}, -- like Cursor, but used when in IME mode
    Directory = {fg = starry.directory or starry.blue, bg = starry.none}, -- directory names (and other special names in listings)
    DiffAdd = {fg = starry.green, bg = starry.none, style = 'undercurl', sp = starry.active}, -- diff mode: Added line
    DiffChange = {
      fg = starry.orange,
      bg = starry.none,
      style = 'undercurl,reverse',
      sp = starry.red
    }, --  diff mode: Changed line
    DiffDelete = {fg = starry.red, bg = starry.none, style = 'reverse'}, -- diff mode: Deleted line
    DiffText = {fg = starry.yellow, bg = starry.none, style = 'reverse'}, -- diff mode: Changed text within a changed line
    EndOfBuffer = {fg = starry.disabled}, -- ~ lines at the end of a buffer
    ErrorMsg = {fg = starry.error}, -- error messages
    Folded = {fg = starry.link, bg = starry.none, style = 'bold'},
    FoldColumn = {fg = starry.blue},
    IncSearch = {fg = starry.white, bg = starry.highlight, style = 'bold,reverse'},
    LineNr = {fg = starry.line_numbers},
    CursorLineNr = {fg = starry.accent},
    MatchParen = {
      fg = starry.yellow,
      bg = starry.active or starry.none,
      style = 'bold,underline'
    },
    ModeMsg = {fg = starry.accent},
    MoreMsg = {fg = starry.accent},
    NonText = {fg = starry.disabled},
    Pmenu = {fg = starry.text, bg = starry.contrast},
    PmenuSel = {
      fg = starry.accent,
      bg = starry.more_active or starry.active,
      style = 'bold,italic'
    },
    PmenuSbar = {fg = starry.text, bg = starry.contrast},
    PmenuThumb = {fg = starry.fg, bg = starry.accent},
    Question = {fg = starry.green},
    QuickFixLine = {fg = starry.highlight, bg = starry.white, style = 'reverse'},
    qfLineNr = {fg = starry.highlight, bg = starry.white, style = 'reverse'},
    Search = {
      fg = starry.search_fg or starry.highlight,
      bg = starry.search_bg or starry.yellow,
      style = 'reverse'
    },
    SpecialKey = {fg = starry.purple},
    SpellBad = {fg = starry.orange, bg = starry.none, style = 'undercurl', sp = starry.red},
    SpellCap = {fg = starry.blue, bg = starry.none, style = 'undercurl', sp = starry.violet},
    SpellLocal = {fg = starry.cyan, bg = starry.none, style = 'undercurl'},
    SpellRare = {
      fg = starry.purple,
      bg = starry.none,
      style = 'undercurl',
      sp = starry.darkred
    },
    StatusLine = {fg = starry.accent, bg = starry.active},
    StatusLineNC = {fg = starry.text, bg = starry.less_active},
    StatusLineTerm = {fg = starry.fg, bg = starry.active},
    StatusLineTermNC = {fg = starry.text, bg = starry.less_active},
    TabLineFill = {fg = starry.fg},
    TablineSel = {fg = starry.bg, bg = starry.accent},
    Tabline = {fg = starry.fg},
    Title = {fg = starry.title, bg = starry.none, style = 'bold'},
    Visual = {fg = starry.none, bg = starry.selection},
    VisualNOS = {fg = starry.none, bg = starry.selection},
    WarningMsg = {fg = starry.yellow},
    WildMenu = {fg = starry.orange, bg = starry.none, style = 'bold'},
    CursorColumn = {fg = starry.none, bg = starry.active},
    CursorLine = {fg = starry.none, bg = starry.active},
    ToolbarLine = {fg = starry.fg, bg = starry.bg_alt},
    ToolbarButton = {fg = starry.fg, bg = starry.none, style = 'bold'},
    NormalMode = {fg = starry.accent, bg = starry.bg, style = 'reverse'},
    InsertMode = {fg = starry.green, bg = starry.none, style = 'reverse'},
    ReplacelMode = {fg = starry.red, bg = starry.none, style = 'reverse'},
    VisualMode = {fg = starry.purple, bg = starry.none, style = 'reverse'},
    CommandMode = {fg = starry.gray, bg = starry.none, style = 'reverse'},
    Warnings = {fg = starry.yellow},

    healthError = {fg = starry.error},
    healthSuccess = {fg = starry.green},
    healthWarning = {fg = starry.yellow},

    -- Dashboard
    DashboardShortCut = {fg = starry.red},
    DashboardHeader = {fg = starry.comments},
    DashboardCenter = {fg = starry.accent},
    DashboardFooter = {fg = starry.green, style = "italic"}

  }

  -- Options:

  -- Set transparent background
  if vim.g.starry_disable_background == true then
    editor.Normal = {fg = starry.fg, bg = starry.none} -- normal text and background color
    editor.SignColumn = {fg = starry.fg, bg = starry.none}
  else
    editor.Normal = {fg = starry.fg, bg = starry.bg} -- normal text and background color
    editor.SignColumn = {fg = starry.fg, bg = starry.bg}
  end

  -- Remove window split borders
  if vim.g.starry_borders == true then
    editor.VertSplit = {fg = starry.border} -- the column separating vertically split windows
  else
    editor.VertSplit = {fg = starry.bg} -- the column separating vertically split windows
  end

  -- Set End of Buffer lines (~)
  if vim.g.starry_hide_eob == true then
    editor.EndOfBuffer = {fg = starry.bg} -- ~ lines at the end of a buffer
  else
    editor.EndOfBuffer = {fg = starry.disabled} -- ~ lines at the end of a buffer
  end

  return editor
end

theme.loadTerminal = function()

  vim.g.terminal_color_0 = starry.black
  vim.g.terminal_color_1 = starry.red
  vim.g.terminal_color_2 = starry.green
  vim.g.terminal_color_3 = starry.yellow
  vim.g.terminal_color_4 = starry.blue
  vim.g.terminal_color_5 = starry.purple
  vim.g.terminal_color_6 = starry.cyan
  vim.g.terminal_color_7 = starry.white
  vim.g.terminal_color_8 = starry.gray
  vim.g.terminal_color_9 = starry.red
  vim.g.terminal_color_10 = starry.green
  vim.g.terminal_color_11 = starry.yellow
  vim.g.terminal_color_12 = starry.blue
  vim.g.terminal_color_13 = starry.purple
  vim.g.terminal_color_14 = starry.cyan
  vim.g.terminal_color_15 = starry.white
end


theme.loadTreeSitter = function()
  -- TreeSitter highlight groups

  local treesitter = {
    TSAnnotation = {fg = starry.red}, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSAttribute = {fg = starry.yellow}, -- (unstable) TODO: docs
    TSBoolean = {fg = starry.bool or starry.coral, style = 'italic'}, -- For booleans.
    TSCharacter = {fg = starry.char or starry.orange}, -- For characters.
    TSConstructor = {fg = starry.purple}, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    TSConstant = {fg = starry.const or starry.yellow}, -- For constants
    TSConstBuiltin = {fg = starry.const or starry.red}, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro = {fg = starry.red}, -- For constants that are defined by macros: `NULL` in C.
    TSError = {fg = starry.error}, -- For syntax/parser errors.
    TSException = {fg = starry.red3}, -- For exception related keywords.
    TSField = {fg = starry.variable or starry.blue1}, -- For fields.
    TSFloat = {fg = starry.float or starry.red}, -- For floats.
    TSFuncMacro = {fg = starry.blue}, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSInclude = {fg = starry.cyan}, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.

    TSDefinitionUsage = {
      fg = starry.accent or starry.salmon,
      style = 'bold,undercurl',
      sp = 'white'
    }, -- used for highlighting "read" references

    TSDefinition = {fg = starry.keyword or "yellow", style = 'bold,undercurl', sp = 'red'}, -- used for highlighting "write" references
    TSLabel = {fg = starry.green1}, -- For labels: `label:` in C and `:label:` in Lua.
    TSNamespace = {fg = starry.yellow1}, -- For identifiers referring to modules and namespaces.
    TSNumber = {fg = starry.number or starry.yellow2}, -- For all numbers
    TSOperator = {fg = starry.operator or starry.cyan}, -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter = {fg = starry.parameter or starry.blue2}, -- For parameters of a function.
    TSParameterReference = {fg = starry.paleblue}, -- For references to parameters of a function.
    TSProperty = {fg = starry.field or starry.blue1}, -- Same as `TSField`.
    TSPunctDelimiter = {fg = starry.cyan}, -- For delimiters ie: `.`
    TSPunctBracket = {fg = starry.bracket or starry.pink2}, -- For brackets and parens.
    TSPunctSpecial = {fg = starry.punctutation or starry.purple1}, -- For special punctutation that does not fall in the catagories before.
    TSString = {fg = starry.string or starry.green}, -- For strings.
    TSStringRegex = {fg = starry.pink2}, -- For regexes.
    TSStringEscape = {fg = starry.disabled}, -- For escape characters within a string.
    TSSymbol = {fg = starry.symbol or starry.yellow}, -- For identifiers referring to symbols or atoms.
    TSType = {fg = starry.type}, -- For types.
    TSTypeBuiltin = {fg = starry.purple1, style = 'bold'}, -- For builtin types.
    TSTag = {fg = starry.red1}, -- Tags like html tag names.
    TSTagDelimiter = {fg = starry.yellow2}, -- Tag delimiter like `<` `>` `/`
    TSText = {fg = starry.text}, -- For strings considered text in a markup language.
    TSTextReference = {fg = starry.bg_alt}, -- FIXME
    TSEmphasis = {fg = starry.paleblue}, -- For text to be represented with emphasis.
    TSUnderline = {fg = starry.fg, bg = starry.none, style = 'underline'}, -- For text to be represented with an underline.
    TSStrike = {fg = starry.gray}, -- For strikethrough text.
    TSCurrentScope = {bg = starry.less_active or starry.active},
    TSTitle = {fg = starry.title, bg = starry.none, style = 'bold'}, -- Text that is part of a title.
    TSLiteral = {fg = starry.fg}, -- Literal text.
    TSURI = {fg = starry.link} -- Any URI like a link or email.
    -- TSNone =                    { },    -- TODO: docs
  }

  -- Options:

  -- Italic comments
  if vim.g.starry_italic_comments == true then
    treesitter.TSComment = {fg = starry.comments, bg = starry.none, style = 'italic'} -- For comment blocks.
  else
    treesitter.TSComment = {fg = starry.comments} -- For comment blocks.
  end

  if vim.g.starry_italic_keywords == true then
    treesitter.TSConditional = {fg = starry.condition or starry.purple, style = 'italic'} -- For keywords related to conditionnals.
    treesitter.TSKeyword = {fg = starry.keyword or starry.purple, style = 'italic,bold'} -- For keywords that don't fall in previous categories.
    treesitter.TSRepeat = {fg = starry.condition or starry.purple, style = 'italic,bold'} -- For keywords related to loops.
    treesitter.TSKeywordFunction = {
      fg = starry.keyword_func or starry.keyword or starry.purple,
      style = 'italic,bold'
    } -- For keywords used to define a fuction.
  else
    treesitter.TSConditional = {fg = starry.condition or starry.purple} -- For keywords related to conditionnals.
    treesitter.TSKeyword = {fg = starry.keyword or starry.purple, style = 'bold'} -- For keywords that don't fall in previous categories.
    treesitter.TSRepeat = {fg = starry.condition or starry.purple, style = 'bold'} -- For keywords related to loops.
    treesitter.TSKeywordFunction = {
      fg = starry.keyword_func or starry.keyword or starry.purple,
      style = 'bold'
    } -- For keywords used to define a fuction.
  end

  if vim.g.starry_italic_functions == true then
    treesitter.TSFunction = {fg = starry.func or starry.blue, style = 'italic,bold'} -- For fuction (calls and definitions).
    treesitter.TSMethod = {
      fg = starry.method or starry.func or starry.blue,
      style = 'italic,bold'
    } -- For method calls and definitions.
    treesitter.TSFuncBuiltin = {fg = starry.func or starry.cyan, style = 'italic,bold'} -- For builtin functions: `table.insert` in Lua.
  else
    treesitter.TSFunction = {fg = starry.func or starry.blue, style = 'bold'} -- For fuction (calls and definitions).
    treesitter.TSMethod = {fg = starry.method or starry.blue, style = 'bold'} -- For method calls and definitions.
    treesitter.TSFuncBuiltin = {fg = starry.func or starry.cyan, style = 'bold'} -- For builtin functions: `table.insert` in Lua.
  end

  if vim.g.starry_italic_variables == true then
    treesitter.TSVariable = {fg = starry.variable, style = 'italic'} -- Any variable name that does not have another highlight.
    treesitter.TSVariableBuiltin = {fg = starry.variable, style = 'italic'} -- Variable names that are defined by the languages, like `this` or `self`.
  else
    treesitter.TSVariable = {fg = starry.variable} -- Any variable name that does not have another highlight.
    treesitter.TSVariableBuiltin = {fg = starry.variable} -- Variable names that are defined by the languages, like `this` or `self`.
  end

  if vim.g.starry_italic_strings == true then
    treesitter.TSString.style = 'italic' -- For strings.
  end

  return treesitter

end

theme.loadLSP = function()
  -- Lsp highlight groups

  local lsp = {
    DiagnosticError = {fg = starry.error}, -- used for "Error" diagnostic virtual text
    DiagnosticSignError = {fg = starry.error}, -- used for "Error" diagnostic signs in sign column
    DiagnosticFloatingError = {fg = starry.error}, -- used for "Error" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextError = {fg = starry.error}, -- Virtual text "Error"
    DiagnosticUnderlineError = {style = 'undercurl', sp = starry.error}, -- used to underline "Error" diagnostics.
    DiagnosticWarn = {fg = starry.yellow}, -- used for "Warning" diagnostic signs in sign column
    DiagnosticSignWarn = {fg = starry.yellow}, -- used for "Warning" diagnostic signs in sign column
    DiagnosticFloatingWarn = {fg = starry.yellow}, -- used for "Warning" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextWarn = {fg = starry.yellow}, -- Virtual text "Warning"
    DiagnosticUnderlineWarn = {style = 'undercurl', sp = starry.yellow}, -- used to underline "Warning" diagnostics.
    DiagnosticInfo = {fg = starry.paleblue}, -- used for "Information" diagnostic virtual text
    DiagnosticSignInfo = {fg = starry.paleblue}, -- used for "Information" diagnostic signs in sign column
    DiagnosticFloatingInfo = {fg = starry.paleblue}, -- used for "Information" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextInfo = {fg = starry.paleblue}, -- Virtual text "Information"
    DiagnosticUnderlineInfo = {style = 'undercurl', sp = starry.paleblue}, -- used to underline "Information" diagnostics.
    DiagnosticDefaultHint = {fg = starry.link}, -- used for "Hint" diagnostic virtual text
    DiagnosticSignHint = {fg = starry.link}, -- used for "Hint" diagnostic signs in sign column
    DiagnosticUnderlineHint = {style = 'undercurl', sp = starry.paleblue}, -- used to underline "Hint" diagnostics.

    LspDiagnosticsDefaultError = {fg = starry.error}, -- used for "Error" diagnostic virtual text
    LspDiagnosticsSignError = {fg = starry.error}, -- used for "Error" diagnostic signs in sign column
    LspDiagnosticsFloatingError = {fg = starry.error}, -- used for "Error" diagnostic messages in the diagnostics float
    LspDiagnosticsVirtualTextError = {fg = starry.error}, -- Virtual text "Error"
    LspDiagnosticsUnderlineError = {style = 'undercurl', sp = starry.error}, -- used to underline "Error" diagnostics.
    LspDiagnosticsDefaultWarning = {fg = starry.yellow}, -- used for "Warning" diagnostic signs in sign column
    LspDiagnosticsSignWarning = {fg = starry.yellow}, -- used for "Warning" diagnostic signs in sign column
    LspDiagnosticsFloatingWarning = {fg = starry.yellow}, -- used for "Warning" diagnostic messages in the diagnostics float
    LspDiagnosticsVirtualTextWarning = {fg = starry.yellow}, -- Virtual text "Warning"
    LspDiagnosticsUnderlineWarning = {style = 'undercurl', sp = starry.yellow}, -- used to underline "Warning" diagnostics.
    LspDiagnosticsDefaultInformation = {fg = starry.paleblue}, -- used for "Information" diagnostic virtual text
    LspDiagnosticsSignInformation = {fg = starry.paleblue}, -- used for "Information" diagnostic signs in sign column
    LspDiagnosticsFloatingInformation = {fg = starry.paleblue}, -- used for "Information" diagnostic messages in the diagnostics float
    LspDiagnosticsVirtualTextInformation = {fg = starry.paleblue}, -- Virtual text "Information"
    LspDiagnosticsUnderlineInformation = {style = 'undercurl', sp = starry.paleblue}, -- used to underline "Information" diagnostics.
    LspDiagnosticsDefaultHint = {fg = starry.link}, -- used for "Hint" diagnostic virtual text
    LspDiagnosticsSignHint = {fg = starry.link}, -- used for "Hint" diagnostic signs in sign column
    LspDiagnosticsUnderlineHint = {style = 'undercurl', sp = starry.paleblue}, -- used to underline "Hint" diagnostics.
    LspReferenceText = {style = 'bold,italic,undercurl', sp = 'yellow'}, -- used for highlighting "text" references
    LspReferenceRead = {
      -- fg = starry.accent or starry.salmon,
      style = 'bold,italic,undercurl',
      sp = 'lime'
    }, -- used for highlighting "read" references
    LspReferenceWrite = {
      fg = starry.keyword or "yellow",
      bg = starry.highlight,
      style = 'bold,italic,undercurl',
      sp = 'red2'
    }, -- used for highlighting "write" references
    LspSignatureActiveParameter = {
      fg = starry.search_fg or starry.yellow,
      bg = starry.search_bg or starry.highlight,
      style = 'bold,italic,undercurl',
      sp = 'violet'
    }
  }

  return lsp

end

theme.loadPlugins = function()
  -- Plugins highlight groups

  local plugins = {

    -- LspTrouble
    LspTroubleText = {fg = starry.text},
    LspTroubleCount = {fg = starry.purple, bg = starry.active},
    LspTroubleNormal = {fg = starry.fg, bg = starry.sidebar},

    -- Nvim-Compe
    CompeDocumentation = {fg = starry.text, bg = starry.contrast},
    CmpDocumentation = {fg = starry.text, bg = starry.contrast},

    -- Diff
    diffAdded = {fg = starry.green},
    diffRemoved = {fg = starry.red},
    diffChanged = {fg = starry.blue},
    diffOldFile = {fg = starry.text},
    diffNewFile = {fg = starry.title},
    diffFile = {fg = starry.gray},
    diffLine = {fg = starry.cyan},
    diffIndexLine = {fg = starry.purple},

    -- Neogit
    NeogitBranch = {fg = starry.paleblue},
    NeogitRemote = {fg = starry.purple},
    NeogitHunkHeader = {fg = starry.fg, bg = starry.highlight},
    NeogitHunkHeaderHighlight = {fg = starry.blue, bg = starry.contrast},
    NeogitDiffContextHighlight = {fg = starry.text, bg = starry.contrast},
    NeogitDiffDeleteHighlight = {fg = starry.red},
    NeogitDiffAddHighlight = {fg = starry.green},

    -- GitGutter
    GitGutterAdd = {fg = starry.green}, -- diff mode: Added line |diff.txt|
    GitGutterChange = {fg = starry.blue}, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = {fg = starry.red}, -- diff mode: Deleted line |diff.txt|

    -- GitSigns
    GitSignsAdd = {fg = starry.green}, -- diff mode: Added line |diff.txt|
    GitSignsAddNr = {fg = starry.green}, -- diff mode: Added line |diff.txt|
    GitSignsAddLn = {fg = starry.green}, -- diff mode: Added line |diff.txt|
    GitSignsChange = {fg = starry.blue}, -- diff mode: Changed line |diff.txt|
    GitSignsChangeNr = {fg = starry.blue}, -- diff mode: Changed line |diff.txt|
    GitSignsChangeLn = {fg = starry.blue}, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = {fg = starry.red}, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteNr = {fg = starry.red}, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteLn = {fg = starry.red}, -- diff mode: Deleted line |diff.txt|

    -- Telescope
    TelescopeNormal = {fg = starry.fg, bg = starry.bg},
    TelescopePromptBorder = {fg = starry.cyan},
    TelescopeResultsBorder = {fg = starry.purple},
    TelescopePreviewBorder = {fg = starry.green},
    TelescopeSelectionCaret = {fg = starry.purple},
    TelescopeSelection = {fg = starry.purple, bg = starry.active},
    TelescopeMatching = {fg = starry.cyan},

    -- NvimTree
    NvimTreeRootFolder = {fg = starry.title, style = "italic"},
    NvimTreeFolderName = {fg = starry.text},
    NvimTreeFolderIcon = {fg = starry.accent},
    NvimTreeEmptyFolderName = {fg = starry.disabled},
    NvimTreeOpenedFolderName = {fg = starry.accent, style = "italic"},
    NvimTreeIndentMarker = {fg = starry.disabled},
    NvimTreeGitDirty = {fg = starry.blue},
    NvimTreeGitNew = {fg = starry.lime},
    NvimTreeGitStaged = {fg = starry.comments},
    NvimTreeGitDeleted = {fg = starry.red},
    NvimTreeOpenedFile = {fg = starry.accent},
    NvimTreeImageFile = {fg = starry.yellow},
    NvimTreeMarkdownFile = {fg = starry.pink},
    NvimTreeExecFile = {fg = starry.green},
    NvimTreeSpecialFile = {fg = starry.purple, style = "underline"},
    LspDiagnosticsError = {fg = starry.error},
    LspDiagnosticsWarning = {fg = starry.yellow},
    LspDiagnosticsInformation = {fg = starry.paleblue},
    LspDiagnosticsHint = {fg = starry.purple},

    -- WhichKey
    WhichKey = {fg = starry.accent, style = 'bold'},
    WhichKeyGroup = {fg = starry.text},
    WhichKeyDesc = {fg = starry.blue, style = 'italic'},
    WhichKeySeperator = {fg = starry.fg},
    WhichKeyFloating = {bg = starry.floating},
    WhichKeyFloat = {bg = starry.floating},

    -- LspSaga
    DiagnosticError = {fg = starry.error},
    DiagnosticWarning = {fg = starry.yellow},
    DiagnosticInformation = {fg = starry.paleblue},
    DiagnosticHint = {fg = starry.purple},
    DiagnosticTruncateLine = {fg = starry.fg},
    LspFloatWinNormal = {bg = starry.contrast},
    LspFloatWinBorder = {fg = starry.purple},
    LspSagaBorderTitle = {fg = starry.cyan},
    LspSagaHoverBorder = {fg = starry.paleblue},
    LspSagaRenameBorder = {fg = starry.green},
    LspSagaDefPreviewBorder = {fg = starry.green},
    LspSagaCodeActionBorder = {fg = starry.blue},
    LspSagaFinderSelection = {fg = starry.green},
    LspSagaCodeActionTitle = {fg = starry.paleblue},
    LspSagaCodeActionContent = {fg = starry.purple},
    LspSagaSignatureHelpBorder = {fg = starry.pink},
    ReferencesCount = {fg = starry.purple},
    DefinitionCount = {fg = starry.purple},
    DefinitionIcon = {fg = starry.blue},
    ReferencesIcon = {fg = starry.blue},
    TargetWord = {fg = starry.cyan},

    -- BufferLine
    BufferLineIndicatorSelected = {fg = starry.type},
    BufferLineFill = {bg = starry.bg_alt},
    BufferLineBufferSelected = {fg = starry.statement, bg = starry.less_active},

    -- Sneak
    Sneak = {fg = starry.bg, bg = starry.accent},
    SneakScope = {bg = starry.selection},

    -- Indent Blankline
    IndentBlanklineChar = {fg = starry.highlight},
    IndentBlanklineContextChar = {fg = starry.func or starry.sky, style = 'bold'},

    -- Nvim dap
    DapBreakpoint = {fg = starry.red},
    DapStopped = {fg = starry.green},

    -- Hop
    HopNextKey = {fg = starry.keyword or starry.func or starry.red, style = 'bold,underline'},
    HopNextKey1 = {fg = starry.purple, style = 'bold'},
    HopNextKey2 = {fg = starry.blue, style = 'bold'},
    HopUnmatched = {fg = starry.comments or starry.gray7},

    -- Lightspeed
    LightspeedLabel = {
      fg = starry.search_fg or starry.yellow,
      bg = starry.search_bg or starry.highlight
    },
    LightspeedOverlapped = {bg = starry.selection, fg = starry.red},
    LightspeedLabelDistant = {bg = starry.magenta, fg = starry.bg},
    LightspeedLabelDistantOverlapped = {bg = starry.magenta, fg = starry.bg},
    LightspeedShortcut = {fg = starry.orange, bg = starry.bg, style = "italic"},
    LightspeedShortcutOverlapped = {fg = starry.orange, style = "bold"},
    LightspeedMaskedChar = {fg = starry.red, style = "undercurl"},
    LightspeedGreyWash = {fg = starry.comment},
    LightspeedUnlabeledMatch = {fg = starry.red, style = "underline"},
    LightspeedOneCharMatch = {fg = starry.red, style = "underline"},
    LightspeedUniqueChar = {fg = starry.white, style = "underline"},
    LightspeedPendingOpArea = {fg = starry.white, style = "underline"},
    LightspeedPendingChangeOpArea = {fg = starry.white, style = "underline"},
    LightspeedCursor = {fg = starry.black, bg = starry.blue},

    -- Cmp
    CmpItemAbbrDeprecated = {fg = starry.light_gray, style = "strikethrough"},
    CmpItemAbbrMatch = {fg = starry.search_fg, bg = starry.search_bg},
    CmpItemAbbrMatchFuzzy = {fg = starry.search_fg, bg = starry.search_bg},
    CmpItemKindVariable = {fg = starry.variable},
    CmpItemKindInterface = {fg = starry.blue2},
    CmpItemKindText = {fg = starry.fg},
    CmpItemKindFunction = {fg = starry.func},
    CmpItemKindMethod = {fg = starry.method},
    CmpItemKindKeyword = {fg = starry.keyword},
    -- Fern
    FernBranchText = {fg = starry.blue}
  }

  -- Options:

  -- Disable nvim-tree background
  if vim.g.starry_disable_background == true then
    plugins.NvimTreeNormal = {fg = starry.fg, bg = starry.none}
  else
    plugins.NvimTreeNormal = {fg = starry.fg, bg = starry.sidebar}
  end

  return plugins

end



return theme
