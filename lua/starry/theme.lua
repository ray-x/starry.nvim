local starry = require('starry.colors').starry()

local theme = {}
local underdouble = 'underline'
local underdot = 'underline'
local underdash = 'underline'
if vim.fn.has('nvim-0.8') == 0 and vim.fn.has('nvim-0.7') == 1 then
  underdot = 'underdot'
  underdash = 'underdash'
  underdouble = 'underlineline'
end

if vim.fn.has('nvim-0.8') == 1 then
  underdouble = 'underdouble'
  underdot = 'underdotted'
  underdash = 'underdashed'
end

theme.loadSyntax = function()
  -- Syntax highlight groups

  local syntax = {
    Type = { fg = starry.type }, -- int, long, char, etc.
    StorageClass = { fg = starry.class }, -- static, register, volatile, etc.
    Structure = { fg = starry.structure }, -- struct, union, enum, etc.
    Constant = { fg = starry.const }, -- any constant
    String = { fg = starry.string, bg = starry.none }, -- Any string
    Character = { fg = starry.orange }, -- any character constant: 'c', '\n'
    Number = { fg = starry.number }, -- a number constant: 5
    Boolean = { fg = starry.bool, style = 'italic' }, -- a boolean constant: TRUE, false
    Float = { fg = starry.float }, -- a floating point constant: 2.3e10
    Statement = { fg = starry.statement }, -- any statement
    Label = { fg = starry.label }, -- case, default, etc.
    Operator = { fg = starry.operator }, -- sizeof", "+", "*", etc.
    Exception = { fg = starry.purple2 }, -- try, catch, throw
    PreProc = { fg = starry.preproc or starry.purple }, -- generic Preprocessor
    Include = { fg = starry.include or starry.blue }, -- preprocessor #include
    Define = { fg = starry.pink }, -- preprocessor #define
    Macro = { fg = starry.cyan }, -- same as Define
    Typedef = { fg = starry.typedef }, -- A typedef
    PreCondit = { fg = starry.precondit, style = 'bold' }, -- preprocessor #if, #else, #endif, etc.
    Special = { fg = starry.red }, -- any special symbol
    SpecialChar = { link = 'Define' }, -- special character in a constant
    Tag = { fg = starry.lime }, -- you can use CTRL-] on this
    Delimiter = { fg = starry.blue1 }, -- character that needs attention like , or .
    SpecialComment = { fg = starry.comments }, -- special things inside a comment
    Debug = { link = 'Special' }, -- debugging statements
    Underlined = { fg = starry.link, bg = starry.none, style = 'undercurl', sp = starry.blue }, -- text that stands out, HTML links
    Ignore = { fg = starry.disabled }, -- left blank, hidden
    Error = { fg = starry.error, style = 'bold,undercurl', sp = starry.pink }, -- any erroneous construct
    Todo = { fg = starry.yellow, bg = starry.bg_alt, style = 'bold,italic' }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    MsgArea = { fg = starry.string, bg = starry.none }, -- Any string

    htmlLink = { fg = starry.link, style = 'underline', sp = starry.blue },
    htmlH1 = { fg = starry.cyan, style = 'bold,' .. underdouble },
    htmlH2 = { fg = starry.red, style = 'bold' },
    htmlH3 = { fg = starry.green, style = 'bold' },
    htmlH4 = { fg = starry.yellow, style = 'bold' },
    htmlH5 = { fg = starry.br_purple, style = 'bold' },
    markdownH1 = { link = 'htmlH1' },
    markdownH2 = { link = 'htmlH2' },
    markdownH3 = { link = 'htmlH3' },
    markdownH1Delimiter = { link = 'Macro' },
    markdownH2Delimiter = { link = 'Special' },
    markdownH3Delimiter = { link = 'Question' },
  }

  -- Options:

  -- Italic comments
  if vim.g.starry_italic_comments == true then
    syntax.Comment = { fg = starry.comments, bg = starry.none, style = 'italic' } -- italic comments
  else
    syntax.Comment = { link = 'SpecialComment' } -- normal comments
  end

  -- Italic string
  if vim.g.starry_italic_string == true then
    syntax.String.style = 'italic'
  end

  -- Italic Keywords
  if vim.g.starry_italic_keywords == true then
    syntax.Conditional = {
      fg = starry.condition,
      bg = starry.none,
      style = 'italic',
    } -- italic if, then, else, endif, switch, etc.
    syntax.Keyword = {
      fg = starry.keyword,
      bg = starry.none,
      style = 'italic',
      bold = true,
    } -- italic for, do, while, etc.
    syntax.Repeat = {
      fg = starry.condition,
      bg = starry.none,
      style = 'italic',
    } -- italic any other keyword
  else
    syntax.Conditional = { fg = starry.condition, style = 'bold' } -- normal if, then, else, endif, switch, etc.
    syntax.Keyword = { fg = starry.keyword, style = 'bold' } -- normal for, do, while, etc.
    syntax.Repeat = { link = 'PreProc' } -- normal any other keyword
  end

  -- Italic Function names
  if vim.g.starry_italic_functions == true then
    syntax.Function = {
      fg = starry.func,
      bg = starry.none,
      style = 'italic,bold',
    } -- italic function names
  else
    syntax.Function = { fg = starry.func, style = 'bold' } -- normal function names
  end

  if vim.g.starry_italic_variables == true then
    syntax.Identifier = { fg = starry.variable, style = 'italic' } -- Variable names that are defined by the languages, like `this` or `self`.
  else
    syntax.Identifier = { fg = starry.variable } -- Variable names that are defined by the languages, like `this` or `self`.
  end
  return syntax
end

theme.loadEditor = function()
  -- Editor highlight groups

  local editor = {
    FloatShadow = { bg = starry.black, blend = 36 },
    FloatShadowThrough = { bg = starry.black, blend = 66 },
    ColorColumn = { fg = starry.none, bg = starry.active }, --  used for the columns set with 'colorcolumn'
    Conceal = { link = 'Ignore' }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = starry.cursor, bg = starry.none, style = 'reverse' }, -- the character under the cursor
    CursorIM = { fg = starry.cursor, bg = starry.none, style = 'reverse' }, -- like Cursor, but used when in IME mode
    Directory = { fg = starry.directory, bg = starry.none }, -- directory names (and other special names in listings)
    DiffAdd = { bg = starry.active, style = 'bold,' .. underdash }, -- diff mode: Added line
    DiffChange = {
      fg = starry.orange,
      bg = starry.none,
      style = 'reverse,bold,' .. underdot,
      sp = starry.red,
    }, --  diff mode: Changed line
    DiffDelete = { bg = starry.less_active, style = 'strikethrough' }, -- diff mode: Deleted line
    DiffText = { bg = starry.none, style = 'reverse' }, -- diff mode: Changed text within a changed line
    EndOfBuffer = { link = 'Ignore' }, -- ~ lines at the end of a buffer
    ErrorMsg = { link = 'DiagnosticError' }, -- error messages
    Folded = { fg = starry.link, bg = starry.none, style = 'bold' },
    FoldColumn = { link = 'Include' },
    IncSearch = { fg = starry.orange, bg = starry.highlight, style = 'bold,reverse' },
    LineNr = { fg = starry.text, style = 'bold,' .. underdot },
    LineNrAbove = { fg = starry.line_numbers },
    LineNrBelow = { link = 'LineNrAbove' },
    CursorLineNr = { link = 'ModeMsg', style = 'bold' },
    MatchParen = {
      fg = starry.yellow,
      bg = starry.active,
      style = 'bold,underline',
    },
    ModeMsg = { fg = starry.accent },
    MoreMsg = { link = 'ModeMsg' },
    NonText = { link = 'Ignore' },
    Pmenu = { fg = starry.textdark, bg = starry.contrast },
    PmenuSel = {
      fg = starry.accent,
      bg = starry.more_active,
      style = 'bold,italic',
    },
    PmenuSbar = { fg = starry.text, bg = starry.contrast },
    PmenuThumb = { fg = starry.fg, bg = starry.accent },
    Question = { fg = starry.green },
    QuickFixLine = { fg = starry.highlight, bg = starry.white, style = 'reverse' },
    qfLineNr = { fg = starry.highlight, bg = starry.white, style = 'reverse' },
    Search = {
      fg = starry.search_fg,
      bg = starry.highlight,
      style = 'reverse,bold',
    },
    SpecialKey = { link = 'PreProc' },
    SpellBad = { fg = starry.orange, bg = starry.none, style = 'undercurl', sp = starry.red },
    SpellCap = { fg = starry.blue, bg = starry.none, style = 'undercurl', sp = starry.violet },
    SpellLocal = { fg = starry.cyan, bg = starry.none, style = underdot },
    SpellRare = {
      fg = starry.purple,
      bg = starry.none,
      style = underdot,
      sp = starry.darkred,
    },
    StatusLine = { fg = starry.accent, bg = starry.active },
    StatusLineNC = { fg = starry.text, bg = starry.less_active },
    StatusLineTerm = { fg = starry.fg, bg = starry.active },
    StatusLineTermNC = { fg = starry.text, bg = starry.less_active },
    TabLineFill = { fg = starry.fg },
    TablineSel = { fg = starry.bg, bg = starry.accent },
    Tabline = { fg = starry.fg },
    Title = { fg = starry.title, bg = starry.none, style = 'bold' },
    Visual = { fg = starry.none, bg = starry.selection },
    VisualNOS = { link = 'Visual' },
    WarningMsg = { fg = starry.yellow },
    WildMenu = { fg = starry.orange, bg = starry.none, style = 'bold' },
    CursorColumn = { fg = starry.none, bg = starry.active },
    CursorLine = { fg = starry.none, bg = starry.active },
    ToolbarLine = { fg = starry.fg, bg = starry.bg_alt },
    ToolbarButton = { fg = starry.fg, bg = starry.none, style = 'bold' },
    NormalMode = { fg = starry.accent, bg = starry.bg, style = 'reverse' },
    InsertMode = { fg = starry.green, bg = starry.none, style = 'reverse' },
    ReplacelMode = { fg = starry.red, bg = starry.none, style = 'reverse' },
    VisualMode = { fg = starry.purple, bg = starry.none, style = 'reverse' },
    CommandMode = { fg = starry.gray, bg = starry.none, style = 'reverse' },
    Warnings = { link = 'WarningMsg' },

    healthError = { link = 'DiagnosticError' },
    healthSuccess = { link = 'Question' },
    healthWarning = { link = 'WarningMsg' },

    -- Dashboard
    DashboardShortCut = { link = 'Special' },
    DashboardHeader = { link = 'SpecialComment' },
    DashboardCenter = { fg = starry.accent },
    DashboardFooter = { fg = starry.green, style = 'italic' },

    WinSeparator = { fg = starry.border },
  }

  -- Options:

  -- Set transparent background
  if vim.g.starry_disable_background == true then
    editor.Normal = { fg = starry.fg, bg = starry.none } -- normal text and background color
    editor.SignColumn = { fg = starry.fg, bg = starry.none }

    editor.NormalFloat = { fg = starry.fg, bg = starry.none } -- normal text and background color for floating windows
    editor.FloatBorder = { fg = starry.comments, bg = starry.none }
  elseif vim.g.starry_darker_contrast == true and starry.bg_darker then
    editor.Normal = { fg = starry.fg, bg = starry.bg_darker } -- normal text and background color
    editor.SignColumn = { fg = starry.fg, bg = starry.bg_darker }

    editor.NormalFloat = { fg = starry.fg, bg = starry.bg } -- normal text and background color for floating windows
    editor.FloatBorder = { fg = starry.comments, bg = starry.bg }
  else
    editor.Normal = { fg = starry.fg, bg = starry.bg } -- normal text and background color
    editor.SignColumn = { fg = starry.fg, bg = starry.bg }

    editor.NormalFloat = { fg = starry.fg, bg = starry.floating } -- normal text and background color for floating windows
    editor.FloatBorder = { fg = starry.comments, bg = starry.less_active }
  end

  -- Remove window split borders
  if vim.g.starry_borders == true then
    editor.VertSplit = { fg = starry.border } -- the column separating vertically split windows
  else
    editor.VertSplit = { fg = starry.bg } -- the column separating vertically split windows
  end
  -- Set End of Buffer lines (~)
  if vim.g.starry_hide_eob == true then
    editor.EndOfBuffer = { fg = starry.bg } -- ~ lines at the end of a buffer
  else
    editor.EndOfBuffer = { link = 'Ignore' } -- ~ lines at the end of a buffer
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
  vim.g.terminal_color_9 = starry.br_red
  vim.g.terminal_color_10 = starry.br_green
  vim.g.terminal_color_11 = starry.br_yellow
  vim.g.terminal_color_12 = starry.br_blue
  vim.g.terminal_color_13 = starry.br_purple
  vim.g.terminal_color_14 = starry.br_cyan
  vim.g.terminal_color_15 = starry.br_white

  vim.g.terminal_color_foreground = starry.fg
  vim.g.terminal_color_background = starry.bg
end

theme.loadTreeSitter = function()
  -- TreeSitter highlight groups

  local treesitter = {
    TSAnnotation = { link = 'Special' }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSAttribute = { link = 'WarningMsg' }, -- (unstable) TODO: docs
    TSBoolean = { fg = starry.bool, style = 'italic' }, -- For booleans.
    TSCharacter = { fg = starry.char }, -- For characters.
    TSConstructor = { link = 'PreProc' }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    TSConstant = { fg = starry.const }, -- For constants
    TSConstBuiltin = { fg = starry.const, style = 'bold' }, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro = { link = 'Special' }, -- For constants that are defined by macros: `NULL` in C.
    TSError = { link = 'Error' }, -- For syntax/parser errors.
    TSException = { fg = starry.red3 }, -- For exception related keywords.
    TSField = { fg = starry.field }, -- For fields.
    TSFloat = { fg = starry.float }, -- For floats.
    TSFuncMacro = { link = 'Macro' }, -- For macro defined functions (calls and definitions): each `macro_rules` in Rust.
    TSInclude = { link = 'Include' }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.

    TSDefinitionUsage = {
      fg = starry.accent,
      style = 'bold,underline',
      sp = 'white',
    }, -- used for highlighting "read" references

    TSDefinition = { fg = starry.keyword, style = 'bold,' .. underdouble, sp = 'red' }, -- used for highlighting "write" references
    TSLabel = { fg = starry.green1 }, -- For labels: `label:` in C and `:label:` in Lua.
    TSNamespace = { fg = starry.yellow1 }, -- For identifiers referring to modules and namespaces.
    TSNumber = { link = 'Number' }, -- For all numbers
    TSOperator = { link = 'Operator' }, -- For any operator: `+`, but also `->` and `*` in C.
    TSKeywordOperator = { link = 'Operator', style = 'bold' }, -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter = { fg = starry.parameter, style = 'bold' }, -- For parameters of a function.
    TSParameterReference = { link = 'PreCondit' }, -- For references to parameters of a function.
    Hlargs = { link = 'TSParameterReference' },
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
    TSUnderline = { fg = starry.fg, bg = starry.none, style = underdouble }, -- For text to be represented with an underline.
    TSStrike = { fg = starry.gray, style = 'strikethrough' }, -- For strikethrough text.
    TSCurrentScope = { bg = starry.less_active or starry.active },
    TSTitle = { fg = starry.title, bg = starry.none, style = 'bold' }, -- Text that is part of a title.
    TSLiteral = { link = 'TSText' }, -- Literal text.
    TSURI = { link = 'htmlLink' }, -- Any URI like a link or email.
    TSNone = { link = 'SpecialComment' }, -- TODO: docs
  }

  -- Options:

  -- Italic comments
  if vim.g.starry_italic_comments == true then
    treesitter.TSComment = { fg = starry.comments, bg = starry.none, style = 'italic' } -- For comment blocks.
  else
    treesitter.TSComment = { link = 'SpecialComment' } -- For comment blocks.
  end

  if vim.g.starry_italic_keywords == true then
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

  if vim.g.starry_italic_functions == true then
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

  if vim.g.starry_italic_variables == true then
    treesitter.TSVariableBuiltin = { fg = starry.variable, style = 'italic' } -- Variable names that are defined by the languages, like `this` or `self`.
  else
    treesitter.TSVariableBuiltin = { fg = starry.variable } -- Variable names that are defined by the languages, like `this` or `self`.
  end

  treesitter.TSVariable = { link = 'Identifier' } -- Any variable name that does not have another highlight.
  if vim.g.starry_italic_strings == true then
    treesitter.TSString.style = 'italic' -- For strings.
  end

  return treesitter
end

theme.loadLSP = function()
  -- Lsp highlight groups

  local lsp = {
    DiagnosticHint = { link = 'PreProc' },
    DiagnosticTruncateLine = { fg = starry.fg },
    DiagnosticError = { link = 'Special', style = 'bold' }, -- used for "Error" diagnostic virtual text
    DiagnosticSignError = { link = 'DiagnosticError' }, -- used for "Error" diagnostic signs in sign column
    DiagnosticFloatingError = { link = 'DiagnosticError' }, -- used for "Error" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextError = { link = 'DiagnosticError' }, -- Virtual text "Error"
    DiagnosticUnderlineError = { style = 'bold,undercurl', sp = starry.error }, -- used to underline "Error" diagnostics.
    DiagnosticWarn = { link = 'WarningMsg' }, -- used for "Warning" diagnostic signs in sign column
    DiagnosticSignWarn = { link = 'WarningMsg' }, -- used for "Warning" diagnostic signs in sign column
    DiagnosticFloatingWarn = { link = 'WarningMsg' }, -- used for "Warning" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextWarn = { link = 'WarningMsg' }, -- Virtual text "Warning"
    DiagnosticUnderlineWarn = { style = 'undercurl', sp = starry.yellow }, -- used to underline "Warning" diagnostics.
    DiagnosticInfo = { link = 'PreCondit' }, -- used for "Information" diagnostic virtual text
    DiagnosticSignInfo = { link = 'DiagnosticInfo' }, -- used for "Information" diagnostic signs in sign column
    DiagnosticFloatingInfo = { link = 'DiagnosticInfo' }, -- used for "Information" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextInfo = { link = 'DiagnosticInfo' }, -- Virtual text "Information"
    DiagnosticUnderlineInfo = { style = 'undercurl', sp = starry.paleblue }, -- used to underline "Information" diagnostics.
    DiagnosticDefaultHint = { fg = starry.link }, -- used for "Hint" diagnostic virtual text
    DiagnosticSignHint = { link = 'DiagnosticDefaultHint' }, -- used for "Hint" diagnostic signs in sign column
    DiagnosticUnderlineHint = { style = 'undercurl', sp = starry.br_blue }, -- used to underline "Hint" diagnostics.

    LspReferenceText = { style = 'bold,' .. underdot, sp = 'green' }, -- used for highlighting "text" references
    LspReferenceRead = {
      fg = starry.accent,
      style = 'bold,' .. underdash,
      sp = starry.green or 'green',
    }, -- used for highlighting "read" references
    LspReferenceWrite = {
      fg = starry.keyword,
      bg = starry.highlight,
      style = 'bold,' .. underdouble,
      sp = 'yellow',
    }, -- used for highlighting "write" references
    LspSignatureActiveParameter = {
      fg = starry.search_fg,
      bg = starry.darkblue,
      style = 'bold,' .. underdouble,
      sp = 'violet',
    },
  }

  return lsp
end

theme.loadPlugins = function()
  -- Plugins highlight groups

  local plugins = {

    -- LspTrouble
    TroubleText = { fg = starry.text, bg = starry.sidebar },
    TroubleCount = { fg = starry.purple, bg = starry.sidebar },
    TroubleNormal = { fg = starry.fg, bg = starry.sidebar },
    TroubleSignError = { fg = starry.error, bg = starry.sidebar },
    TroubleSignWarning = { fg = starry.yellow, bg = starry.sidebar },
    TroubleSignInformation = { link = 'PreCondit', bg = starry.sidebar },
    TroubleSignHint = { fg = starry.purple, bg = starry.sidebar },
    TroubleFoldIcon = { fg = starry.accent, bg = starry.sidebar },
    TroubleIndent = { fg = starry.border, bg = starry.sidebar },
    TroubleLocation = { fg = starry.disabled, bg = starry.sidebar },
    -- Nvim-Compe
    CompeDocumentation = { fg = starry.text, bg = starry.contrast },
    CmpDocumentation = { fg = starry.text, bg = starry.contrast },

    -- Diff
    diffAdded = { bg = starry.active },
    diffRemoved = { link = 'Special' },
    diffChanged = { bg = starry.active },
    diffOldFile = { link = 'TSText' },
    diffNewFile = { fg = starry.title },
    diffFile = { fg = starry.gray },
    diffLine = { link = 'Macro' },
    diffIndexLine = { link = 'PreProc' },

    -- Neogit
    NeogitBranch = { link = 'PreCondit' },
    NeogitRemote = { link = 'PreProc' },
    NeogitHunkHeader = { fg = starry.fg, bg = starry.highlight },
    NeogitHunkHeaderHighlight = { fg = starry.blue, bg = starry.contrast },
    NeogitDiffContextHighlight = { fg = starry.text, bg = starry.contrast },
    NeogitDiffDeleteHighlight = { link = 'Special' },
    NeogitDiffAddHighlight = { link = 'Question' },

    -- GitGutter
    GitGutterAdd = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|

    -- GitSigns
    GitSignsAdd = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitSignsAddNr = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitSignsAddLn = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitSignsChangeNr = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitSignsChangeLn = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteNr = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteLn = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|

    GitSignsAddInline = { style = 'undercurl', sp = starry.green }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteInline = { style = 'underline', sp = starry.error }, -- diff mode: Deleted line |diff.txt|
    GitSignsChangeInline = { style = 'undercurl', sp = starry.br_blue }, -- diff mode: Deleted line |diff.txt|
    -- Telescope
    TelescopeNormal = { link = 'NormalFloat' },
    TelescopePromptBorder = { link = 'Macro' },
    TelescopeResultsBorder = { link = 'PreProc' },
    TelescopePreviewBorder = { link = 'Question' },
    TelescopeSelectionCaret = { link = 'PreProc' },
    TelescopeSelection = { fg = starry.purple, bg = starry.active },
    TelescopeMatching = { link = 'Macro' },

    -- NvimTree
    NvimTreeRootFolder = { fg = starry.title, style = 'italic' },
    NvimTreeFolderName = { link = 'TSText' },
    NvimTreeFolderIcon = { fg = starry.accent },
    NvimTreeEmptyFolderName = { link = 'Ignore' },
    NvimTreeOpenedFolderName = { fg = starry.accent, style = 'italic' },
    NvimTreeIndentMarker = { link = 'Ignore' },
    NvimTreeGitDirty = { link = 'Include' },
    NvimTreeGitNew = { link = 'Tag' },
    NvimTreeGitStaged = { link = 'SpecialComment' },
    NvimTreeGitDeleted = { link = 'Special' },
    NvimTreeOpenedFile = { fg = starry.accent },
    NvimTreeImageFile = { link = 'WarningMsg' },
    NvimTreeMarkdownFile = { link = 'Define' },
    NvimTreeExecFile = { link = 'Question' },
    NvimTreeSpecialFile = { fg = starry.purple, style = 'underline' },
    LspDiagnosticsError = { link = 'DiagnosticError' },
    LspDiagnosticsWarning = { link = 'WarningMsg' }, -- LspDiagXXX deprecated
    DiagnosticsWarning = { link = 'WarningMsg' },
    LspDiagnosticsInformation = { link = 'PreCondit' },
    DiagnosticsInformation = { link = 'PreCondit' },
    LspDiagnosticsHint = { link = 'PreProc' },
    DiagnosticsHint = { link = 'PreProc' },

    -- WhichKey
    WhichKey = { fg = starry.accent, style = 'bold' },
    WhichKeyGroup = { link = 'TSText' },
    WhichKeyDesc = { fg = starry.blue, style = 'italic' },
    WhichKeySeperator = { fg = starry.fg },
    WhichKeyFloating = { bg = starry.floating },
    WhichKeyFloat = { bg = starry.floating },

    -- LspSaga
    LspFloatWinNormal = { bg = starry.contrast },
    LspFloatWinBorder = { link = 'PreProc' },
    LspSagaBorderTitle = { link = 'Macro' },
    LspSagaHoverBorder = { link = 'PreCondit' },
    LspSagaRenameBorder = { link = 'Question' },
    LspSagaDefPreviewBorder = { link = 'Question' },
    LspSagaCodeActionBorder = { link = 'Include' },
    LspSagaFinderSelection = { link = 'Question' },
    LspSagaCodeActionTitle = { link = 'PreCondit' },
    LspSagaCodeActionContent = { link = 'PreProc' },
    LspSagaSignatureHelpBorder = { link = 'Define' },
    ReferencesCount = { link = 'PreProc' },
    DefinitionCount = { link = 'PreProc' },
    DefinitionIcon = { link = 'Include' },
    ReferencesIcon = { link = 'Include' },
    TargetWord = { link = 'Macro' },
    FocusedSymbol = { bg = starry.selection },
    SymbolsOutlineConnector = { fg = starry.border },
    -- BufferLine
    BufferLineIndicatorSelected = { fg = starry.type },
    BufferLineFill = { bg = starry.bg_alt },
    BufferLineBackground = { bg = starry.bg },
    BufferLineBufferSelected = { fg = starry.statement, bg = starry.less_active },

    -- Sneak
    Sneak = { fg = starry.bg, bg = starry.accent },
    SneakScope = { bg = starry.selection },

    -- Indent Blankline
    IndentBlanklineChar = { fg = starry.purple, style = 'bold' },
    IndentBlanklineContextChar = { fg = starry.purple, style = 'bold' },
    IndentBlanklineContextStart = { style = 'bold,' .. 'underline', sp = starry.violet },
    IndentBlanklineIndent1 = { fg = starry.purple, style = 'nocombine' },
    IndentBlanklineIndent2 = { fg = starry.blue, style = 'nocombine' },
    IndentBlanklineIndent3 = { fg = starry.green, style = 'nocombine' },
    IndentBlanklineIndent4 = { fg = starry.yellow, style = 'nocombine' },
    IndentBlanklineIndent5 = { fg = starry.orange, style = 'nocombine' },
    IndentBlanklineIndent6 = { fg = starry.red, style = 'nocombine' },

    -- Nvim dap
    DapBreakpoint = { link = 'Special' },
    DapStopped = { link = 'Question' },

    -- Hop
    HopNextKey = { fg = starry.red, style = 'bold,undercurl' },
    HopNextKey1 = { fg = starry.br_purple, style = 'bold,undercurl' },
    HopNextKey2 = { fg = starry.blue, style = 'bold,undercurl' },
    HopUnmatched = { fg = starry.comments },

    -- Lightspeed
    LightspeedLabel = {
      fg = starry.search_fg,
      bg = starry.search_bg,
    },
    LightspeedOverlapped = { bg = starry.selection, fg = starry.red },
    LightspeedLabelDistant = { bg = starry.magenta, fg = starry.bg },
    LightspeedLabelDistantOverlapped = { bg = starry.magenta, fg = starry.bg },
    LightspeedShortcut = { fg = starry.orange, bg = starry.bg, style = 'italic' },
    LightspeedShortcutOverlapped = { fg = starry.orange, style = 'bold' },
    LightspeedMaskedChar = { fg = starry.red, style = 'undercurl' },
    LightspeedGreyWash = { link = 'SpecialComment' },
    LightspeedUnlabeledMatch = { fg = starry.red, style = 'underline' },
    LightspeedOneCharMatch = { link = 'LightspeedUnlabeledMatch' },
    LightspeedUniqueChar = { fg = starry.white, style = 'underline' },
    LightspeedPendingOpArea = { link = 'LightspeedUniqueChar' },
    LightspeedPendingChangeOpArea = { fg = starry.white, style = 'underline' },
    LightspeedCursor = { fg = starry.black, bg = starry.blue },

    -- Cmp
    CmpItemAbbrDeprecated = { fg = starry.light_gray, style = 'strikethrough' },
    CmpItemAbbrMatch = { fg = starry.search_fg, bg = starry.search_bg },
    CmpItemAbbrMatchFuzzy = { fg = starry.search_fg, bg = starry.search_bg },
    CmpItemKindVariable = { fg = starry.variable },
    CmpItemKindInterface = { fg = starry.br_blue },
    CmpItemKindText = { fg = starry.fg },
    CmpItemKindFunction = { fg = starry.func },
    CmpItemKindMethod = { fg = starry.method },
    CmpItemKindKeyword = { fg = starry.keyword },
    -- Fern
    FernBranchText = { link = 'Include' },
  }

  -- Options:

  -- Disable nvim-tree background
  if vim.g.starry_disable_background == true then
    plugins.NvimTreeNormal = { fg = starry.fg, bg = starry.none }
  else
    plugins.NvimTreeNormal = { fg = starry.fg, bg = starry.sidebar }
  end

  return plugins
end
return theme
