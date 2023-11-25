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
local config = require('starry.config').options

if config.disable.background == true then
  starry.bg = starry.none
  starry.bg_alt = starry.none
  starry.bg_darker = starry.none
  starry.floating = starry.none
end
theme.loadSyntax = function()
  -- Syntax highlight groups
  local syntax = {
    Type = { fg = starry.type }, -- int, long, char, etc.
    StorageClass = { fg = starry.class }, -- static, register, volatile, etc.
    Structure = { fg = starry.structure }, -- struct, union, enum, etc.
    Struct = { link = 'Structure' }, -- struct, union, enum, etc.
    Constant = { fg = starry.const }, -- any constant
    String = { fg = starry.string }, -- Any string
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
    SpecialComment = { fg = starry.comments, style = 'bold' }, -- special things inside a comment
    Debug = { link = 'Special' }, -- debugging statements
    Underlined = { fg = starry.link, style = 'undercurl', sp = starry.blue }, -- text that stands out, HTML links
    Ignore = { fg = starry.disabled }, -- left blank, hidden
    Error = { fg = starry.error, style = 'bold,undercurl', sp = starry.pink }, -- any erroneous construct
    Todo = { fg = starry.yellow, bg = starry.bg_alt, style = starry.highlight_style }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    MsgArea = { fg = starry.string }, -- Any string

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
  local config = require('starry.config').options
  -- Italic comments
  if config.italics.comments == true then
    syntax.Comment = { fg = starry.comments, style = 'italic' } -- italic comments
  else
    syntax.Comment = { link = 'SpecialComment' } -- normal comments
  end

  -- Italic string
  if config.italics.string == true then
    syntax.String.style = 'italic'
  end

  -- Italic Keywords
  if config.italics.keywords == true then
    syntax.Conditional = {
      fg = starry.condition,
      style = 'italic',
    } -- italic if, then, else, endif, switch, etc.
    syntax.Keyword = {
      fg = starry.keyword,
      style = 'italic',
      bold = true,
    } -- italic for, do, while, etc.
    syntax.Repeat = {
      fg = starry.condition,
      style = 'italic',
    } -- italic any other keyword
  else
    syntax.Conditional = { fg = starry.condition, style = 'bold' } -- normal if, then, else, endif, switch, etc.
    syntax.Keyword = { fg = starry.keyword, style = 'bold' } -- normal for, do, while, etc.
    syntax.Repeat = { link = 'PreProc' } -- normal any other keyword
  end

  -- Italic Function names
  if config.italics.functions == true then
    syntax.Function = {
      fg = starry.func,
      style = 'italic,bold',
    } -- italic function names
  else
    syntax.Function = { fg = starry.func, style = 'bold' } -- normal function names
  end
  syntax.Method = { link = 'Function' }

  if config.italics.variables == true then
    syntax.Identifier = { fg = starry.variable, style = 'italic' } -- Variable names that are defined by the languages, like `this` or `self`.
  else
    syntax.Identifier = { fg = starry.variable } -- Variable names that are defined by the languages, like `this` or `self`.
  end
  return syntax
end

theme.loadEditor = function()
  -- Editor highlight groups
  local lineNrStyle
  if vim.wo.relativenumber == true or vim.o.relativenumber == true then
    lineNrStyle = 'bold,' .. underdot
  end

  local editor = {
    FloatShadow = { bg = starry.darker, blend = 36 },
    FloatShadowThrough = { bg = starry.darker, blend = 66 },
    ColorColumn = { bg = starry.active }, --  used for the columns set with 'colorcolumn'
    Conceal = { link = 'Ignore' }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = starry.cursor, style = 'reverse' }, -- the character under the cursor
    CursorIM = { fg = starry.cursor, style = 'reverse' }, -- like Cursor, but used when in IME mode
    Directory = { fg = starry.directory }, -- directory names (and other special names in listings)
    DiffAdd = { bg = starry.less_active, style = 'bold,' .. underdash }, -- diff mode: Added line
    DiffChange = {
      fg = starry.brown,   -- search is reverse
      bg = starry.less_active,
      style = starry.search_style,
      -- sp = starry.red,
    }, --  diff mode: Changed line
    DiffDelete = { bg = starry.less_active, fg = starry.active, style = 'strikethrough' }, -- diff mode: Deleted line
    DiffText = { bg = starry.darkgreen2, style = 'bold' }, -- diff mode: Changed text within a changed line
    TermCursor = { link = 'Cursor' },
    TermCursorNC = { link = 'Cursor' },
    EndOfBuffer = { link = 'Ignore' }, -- ~ lines at the end of a buffer
    ErrorMsg = { link = 'DiagnosticError' }, -- error messages
    Folded = { fg = starry.link, style = 'bold' },
    FoldColumn = { link = 'Include' },
    IncSearch = { fg = starry.inc_search, style = 'bold,reverse' },
    LineNr = { fg = starry.line_numbers, style = lineNrStyle },
    LineNrAbove = { fg = starry.disabled },
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
    Pmenu = { fg = starry.text, bg = starry.contrast },
    PmenuKind = { fg = starry.green, bg = starry.contrast },
    PmenuExtra = { fg = starry.paleblue, bg = starry.contrast },
    PmenuSel = {
      fg = starry.accent,
      bg = starry.more_active,
      style = starry.highlight_style,
    },
    PmenuSbar = { fg = starry.text, bg = starry.contrast },
    PmenuThumb = { bg = starry.accent },
    Question = { fg = starry.green },
    QuickFixLine = { fg = starry.highlight, bg = starry.white, style = 'reverse' },
    qfLineNr = { fg = starry.highlight, bg = starry.white, style = 'reverse' },
    Search = {
      fg = starry.search_fg,
      bg = starry.search_bg,
      style = starry.search_style,
    },
    SpecialKey = { link = 'PreProc' },
    SpellBad = { fg = starry.orange, style = 'undercurl', sp = starry.red },
    SpellCap = { fg = starry.blue, style = 'undercurl', sp = starry.violet },
    SpellLocal = { fg = starry.cyan, style = underdot },
    SpellRare = {
      fg = starry.purple,
      style = underdot,
      sp = starry.darkred,
    },
    Rare = { link = 'SpellRare' },
    StatusLine = { fg = starry.accent, bg = starry.active },
    StatusLineNC = { fg = starry.text, bg = starry.less_active },
    StatusLineTerm = { fg = starry.fg, bg = starry.active },
    StatusLineTermNC = { fg = starry.text, bg = starry.less_active },
    TabLineFill = { fg = starry.fg },
    TablineSel = { bg = starry.accent, fg = starry.dark },
    Tabline = { fg = starry.fg },
    Title = { fg = starry.title, style = 'bold' },
    Visual = { bg = starry.selection },
    VisualNOS = { link = 'Visual' },
    VisualNC = { link = 'Visual' },
    NormalNC = { link = 'Normal' }, -- normal text and background color
    WarningMsg = { fg = starry.yellow },
    WildMenu = { fg = starry.orange, style = 'bold' },
    CursorColumn = { bg = starry.active },
    CursorLine = { bg = starry.less_active },
    ToolbarLine = { fg = starry.fg, bg = starry.bg_alt },
    ToolbarButton = { fg = starry.fg, style = 'bold' },
    NormalMode = { fg = starry.accent, bg = starry.bg, style = 'reverse' },
    InsertMode = { fg = starry.green, style = 'reverse' },
    ReplacelMode = { fg = starry.red, style = 'reverse' },
    VisualMode = { fg = starry.purple, style = 'reverse' },
    CommandMode = { fg = starry.gray, style = 'reverse' },
    Warnings = { link = 'WarningMsg' },

    healthError = { link = 'DiagnosticError' },
    healthSuccess = { link = 'Question' },
    healthWarning = { link = 'WarningMsg' },

    -- Notify
    NotifyBackground = { link = 'Normal' },
    -- Dashboard
    DashboardShortCut = { link = 'Special' },
    DashboardHeader = { link = 'SpecialComment' },
    DashboardCenter = { fg = starry.accent },
    DashboardFooter = { fg = starry.green, style = 'italic' },

    WinSeparator = { fg = starry.border },
  }

  -- Options:

  if config.style.darker_contrast == true and starry.bg_darker then
    editor.Normal = { fg = starry.fg, bg = starry.bg_darker } -- normal text and background color
    editor.SignColumn = { fg = starry.fg, bg = starry.bg_darker }
    editor.NormalFloat = { fg = starry.fg, bg = starry.black } -- normal text and background color for floating windows
    editor.FloatBorder = { fg = starry.comments, bg = starry.bg_darker }
  else
    editor.Normal = { fg = starry.fg, bg = starry.bg } -- normal text and background color
    editor.SignColumn = { fg = starry.fg, bg = starry.bg }
    editor.NormalFloat = { fg = starry.fg, bg = starry.floating } -- normal text and background color for floating windows
    editor.FloatBorder = { fg = starry.comments, bg = starry.bg_alt }
  end

  -- Remove window split borders
  if config.borders == true then
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

theme.loadLSP = function()
  -- Lsp highlight groups
  return {
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
    DiagnosticUnderlineWarn = { style = 'underline', sp = starry.yellow }, -- used to underline "Warning" diagnostics.
    DiagnosticInfo = { link = 'PreCondit' }, -- used for "Information" diagnostic virtual text
    DiagnosticSignInfo = { link = 'DiagnosticInfo' }, -- used for "Information" diagnostic signs in sign column
    DiagnosticFloatingInfo = { link = 'DiagnosticInfo' }, -- used for "Information" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextInfo = { link = 'DiagnosticInfo' }, -- Virtual text "Information"
    DiagnosticUnderlineInfo = { style = underdash, sp = starry.darkblue }, -- used to underline "Information" diagnostics.
    DiagnosticDefaultHint = { fg = starry.link }, -- used for "Hint" diagnostic virtual text
    DiagnosticSignHint = { link = 'DiagnosticDefaultHint' }, -- used for "Hint" diagnostic signs in sign column
    DiagnosticUnderlineHint = { style = underdot, sp = starry.darkblue }, -- used to underline "Hint" diagnostics.

    LspReferenceText = { style = 'bold,' .. underdot, bg = starry.less_active, sp = 'green' }, -- used for highlighting "text" references
    LspReferenceRead = {
      bg = starry.less_active,
      style = 'bold,' .. underdash,
      sp = 'green',
    }, -- used for highlighting "read" references
    LspReferenceWrite = {
      bg = starry.less_active,
      style = 'bold,' .. underdouble,
      sp = 'yellow',
    }, -- used for highlighting "write" references
    LspSignatureActiveParameter = {
      fg = starry.search_fg,
      bg = starry.darkblue,
      style = 'bold,' .. underdouble,
      sp = 'violet',
    },
    LspCodeLens = { link = 'DiagnosticHint' },
    LspInlayHint = { fg = starry.gray7 },
  }
end

theme.loadTreesitter = function()
  if vim.fn.has('nvim-0.8') == 1 then
    return require('starry.ts').link_v8(starry, underdouble)
  else
    return require('starry.ts').link_v8(starry, underdouble)
  end
end

theme.loadLSPV9 = function()
  if vim.fn.has('nvim-0.9') then
    return require('starry.lsp').link_v9(starry, underdouble)
  end
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

    Hlargs = { link = 'WarningMsg' },

    -- Diff
    diffAdded = { bg = starry.active },
    diffRemoved = { link = 'Special' },
    diffChanged = { bg = starry.active },
    diffOldFile = { link = 'Text' },
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
    GitGutterChangeDelete = { link = 'GitGutterDelete' }, -- diff mode: Changed line |diff.txt|

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

    GitSignsAddInline = { style = underdot, sp = starry.green }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteInline = { style = 'strikethrough', sp = starry.error }, -- diff mode: Deleted line |diff.txt|
    GitSignsChangeInline = { style = underdot, sp = starry.br_blue }, -- diff mode: Deleted line |diff.txt|
    -- Telescope
    TelescopeNormal = { fg = starry.text, bg = starry.bg },
    TelescopePromptBorder = { link = 'Macro' },
    TelescopeResultsBorder = { link = 'PreProc' },
    TelescopePreviewBorder = { link = 'Question' },
    TelescopeSelectionCaret = { link = 'PreProc' },
    TelescopeSelection = { fg = starry.purple, bg = starry.active },
    TelescopeMatching = { link = 'Macro' },

    -- NvimTree
    NvimTreeRootFolder = { fg = starry.title, style = 'italic' },
    NvimTreeFolderName = { link = 'Identifier' },
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
    WhichKeyGroup = { link = 'Identifier' },
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
    BufferLineFill = { bg = starry.bg_alt },
    BufferLineBackground = { bg = starry.bg },

    -- Sneak
    Sneak = { bg = starry.accent, style = 'reverse' },
    SneakScope = { bg = starry.selection },

    -- Indent Blankline
    IblIndent = { fg = starry.purple },
    IblScope = { fg = starry.purple, style = 'bold' },
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
    -- Flash
    FlashLabel = { link = 'HopNextKey' },
    FlashBackdrop = { link = 'HopUnmatched' },

    -- Leap
    LeapMatch = {
      fg = starry.search_fg,
      bg = starry.search_bg,
    },
    LeapLabelPrimary = { fg = starry.purple, style = 'bold' },
    LeapLabelSecondary = { fg = starry.blue, style = 'bold' },
    LeapBackdrop = { fg = starry.comments },

    -- Cmp
    CmpItemAbbrDeprecated = { fg = starry.lightgray, style = 'strikethrough' },
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
  if config.style.disable_background == true then
    plugins.NvimTreeNormal = { link = 'Normal' }
  else
    plugins.NvimTreeNormal = { fg = starry.fg, bg = starry.sidebar }
  end

  return plugins
end
return theme
