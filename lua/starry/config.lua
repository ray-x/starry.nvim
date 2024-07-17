local Config = {}

local defaults = {
  borders = false, -- Split window borders
  hide_eob = true,

  italics = {
    comments = false, -- Italic comments
    strings = false, -- Italic strings
    keywords = false, -- Italic keywords
    functions = false, -- Italic functions
    variables = false -- Italic variables
  },

  contrast = { -- Select which windows get the contrast background
    enable = true, -- Enable contrast
    terminal = true, -- Darker terminal
    filetypes = {}, -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
  },

  text_contrast = {
    lighter = false, -- Higher contrast text for lighter style
    darker = false -- Higher contrast text for darker style
  },

  disable = {
    background = false, -- true: transparent background
    term_colors = false, -- Disable setting the terminal colors
    eob_lines = false -- Make end-of-buffer lines invisible
  },

  style = {
    name = 'moonlight', -- Theme style name (moonlight, earliestsummer, etc.)
    number = 1, -- Theme style number (1 to num of styles)
    disable = {},  -- a list of styles to disable, e.g. {'bold', 'underline'}
    fix = true,
    darker_contrast = false, -- More contrast for darker style
    daylight_swith = false, -- Enable day and night style switching
    deep_black = false, -- Enable a deeper black background
  },
  custom_colors = {}, -- define custom colors
  custom_highlights = {} -- define custom highlights
}

Config.options = {}

Config.setup = function(options)
  Config.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

return Config
