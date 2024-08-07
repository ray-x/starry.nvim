# 🌠🌌 Starry 🌌🌠

A collection of colorschemes for neovim (Neovim 8.0+ required), written in lua.
This first version of starry plugin was built based on

- [material.nvim](https://github.com/marko-cerovac/material.nvim)

Following colorschemes were added later on:
- Moonlight (Low contrast bluish clean and elegant color theme)
- Dracula & Dracula_blood theme
- Monokai (Based on Sublime Build 3)
- Mariana (The latest Sublime (Build 4) builtin color scheme) and Mariana_lighter
- Emerald (Low contrast green color scheme)
- Middlenight_blue (The theme to use in middle night)
- Earlysummer (more vivid colors) and Earlysummer_lighter
- Darksolar (dark solarized)<F13><F49><F13>
- Ukraine yellow text on blue background

## Why this repo:

- All-In-One
- Better color contrast and easy for eyes tuning for material.nvim and moonlight.nvim
- Colorscheme color random loading (loading from Deep ocean, Oceanic, Palenight, Lighter, Darker, moonlight, dracula,
  monokai, mariana, emerald, middlenight_blue, earlysummer randomly )
- Built with latest neovim API
- Tracking latest neovim/lsp/treesitter highlight updates. e.g. `NormalFloat`, `FloatShadow`, `LspReferenceRead/Write`
- Random loading
- Daylight mode, tune the color for daytime
- Transparent background ready

## Credits:

- [marko-cerovac](https://github.com/marko-cerovac) For the material color palettes. The lua color scheme framework
- [shaunsingh](https://github.com/shaunsingh) for his work of schemes based on material

The basic color palettes of material is from [material.vim](https://github.com/kaicataldo/material.vim)

## material.vim
<img width="1308" alt="material" src="https://user-images.githubusercontent.com/1681295/187317446-4da617f5-05b5-437a-b44c-9bc5307ad7e5.png">

## moonlight.nvim
### transparent mode
<img width="1115" alt="moonlight" src="https://user-images.githubusercontent.com/1681295/186778877-f29aeed9-15f2-4622-b568-a7a6656923b4.png">

![moonlight color palette](https://user-images.githubusercontent.com/1681295/186777638-2df2ab4e-d710-44a2-a4d6-36d7253ba712.png)
### non-transparent mode
<img width="1175" alt="moonlight" src="https://user-images.githubusercontent.com/1681295/186844098-19fc0454-f84a-41d3-b8f6-ac667212efb8.png">


## Dracula

Color palettes from [github.com/dracula/vim](https://github.com/dracula/vim)
![darcula](https://user-images.githubusercontent.com/1681295/119607837-61038a00-be38-11eb-99b0-48fa7118044f.jpg)

<img width="1027" alt="dracula" src="https://user-images.githubusercontent.com/1681295/187320632-c45ce928-2446-49a3-bea3-b78697d53590.png">

### Dracula_blood

reddish tone of dracula
![blood](https://user-images.githubusercontent.com/1681295/144513439-4aaef1f1-0ab5-4f62-88a1-1fb2d0aa2ec0.png)
<img width="1035" alt="dracula_blood" src="https://user-images.githubusercontent.com/1681295/187320415-0f1b83ea-854f-4ed6-9183-1c41c7e7c7a5.png">

## Monokai

Color palettes from [colors/monokai.vim](https://github.com/crusoexia/vim-monokai)

![monokai](https://user-images.githubusercontent.com/1681295/119609635-3ff06880-be3b-11eb-9394-00ca016abe0b.png)

<img width="1035" alt="monokai" src="https://user-images.githubusercontent.com/1681295/187320860-d1e00aa0-f0ce-439c-85c5-5fac7915a441.png">

## Mariana

The sublime 4.0 default color scheme

Color palettes from [twolfson/sublime-files](https://github.com/twolfson/sublime-files/blob/master/Packages/Color%20Scheme%20-%20Default/Mariana.sublime-color-scheme)

![mariana](https://preview.redd.it/efzsm1gf0n171.jpg?width=1520&format=pjpg&auto=webp&s=aafb09e752f7fdc9afe3a3a13d069fda2eddc06d)

![mariana2](https://user-images.githubusercontent.com/1681295/119898862-b600e680-bf85-11eb-84c1-727e5add5a18.jpg)

Please check README of starry.nvim project for setups.

## Emerald

I heard green can reduce eye strain :-P


<img width="1445" alt="emerald" src="https://user-images.githubusercontent.com/1681295/187136363-4338d102-12f1-4442-8074-580493d829c9.png">


## Middlenight_blue

![middlenight](https://user-images.githubusercontent.com/1681295/188315123-8a1f8a85-f194-4567-b906-9082653cf4cf.jpg)

## Earlysummer

Colorful colorscheme

![Earlysummer](https://user-images.githubusercontent.com/1681295/132972253-45584b1f-d2f1-46f1-a9f7-f1d5bf89ec64.jpg)

## Dark solar
Bluish colorscheme
<img width="1367" alt="darksolar" src="https://user-images.githubusercontent.com/1681295/185341657-8dd31ed7-e9de-4710-8a20-c3d85ca02c1c.png">

## Nighttime and daytime

Some of the scheme allow choose nighttime and day time mode, you can set starry_daylight_switch to true to turn on
this feature. Here is an example for nighttime and daytime for earlysummer color scheme

![night time and day time](https://preview.redd.it/ng02dvlthi181.png?width=960&crop=smart&auto=webp&s=3e8c4c492077fa693925bdf70e18e90b2d81d2f8)

## limestone

The only light colorschem

![limestone colorscheme](https://user-images.githubusercontent.com/1681295/144512689-b4d88040-d2ac-4979-bc58-dccbd14ffc8b.png)

## Ukraine
Yellow text on blue background. Color palette from Ukraine nation flag.
<img width="780" alt="image" src="https://user-images.githubusercontent.com/1681295/161696426-20f9a0a5-c62b-42e7-923a-6392a587e058.png">

## Supported Plugins

All the plugins supported by starry.nvim, e.g. Treesitter, LSP, Telescope, NvimTree...

`nvim-cmp`:

![image](https://user-images.githubusercontent.com/1681295/143810714-20c12ba3-5835-44f1-ad9f-58bb02a63136.png)

## install

Plug

```vim
Plug 'ray-x/starry.nvim'
```

packer:

```lua
use {'ray-x/starry.nvim', setup = function()
-- see example setup below
vim.g.starry_italic_comments = true
...
end}
```

## Example Setup

Note: vim way of setting up global variable is deprecated, please use lua way to setup color scheme

```lua
local config = {
  border = false, -- Split window borders
  hide_eob = true, -- Hide end of buffer
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
    -- " other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
    disable = {},  -- a list of styles to disable, e.g. {'bold', 'underline'}
    fix = true,
    darker_contrast = false, -- More contrast for darker style
    daylight_swith = false, -- Enable day and night style switching
    deep_black = false, -- Enable a deeper black background
  },

  custom_colors = {
    variable = '#f797d7',
  },
  custom_highlights = {
    LineNr = { fg = '#777777' },
    Idnetifier = { fg = '#ff4797' },
  }
}
require('starry').setup(config)

Toggle style

```vim
:colorscheme starry        " this allow pickup a colorscheme randomly
```

```vim
:colorscheme mariana        " this allow switch to mariana
```

or

```lua
:lua require('starry.functions').toggle_style()
```

or

```vim
:Starry
```

Change to specific style

```vim
:Starry dracula_blood
```

```lua
lua require('starry.functions').change_style("dracula_blood")
```

override default color group, please also check [material.nvim Configuration](https://github.com/marko-cerovac/material.nvim#%EF%B8%8F-configuration)
Example:
```lua
local starry = require 'starry'
local colors = require 'starry.colors'

starry.setup{
    custom_highlights = {
        LineNr = { bg = '#9F809E' }
        CursorLine = { fg = colors.editor.constrast , underline = true },

        -- This is a list of possible values
        -- override @string of treesitter
        @string = {
            fg = "#339922", -- foreground color
            bg = "NONE", -- background color
            sp = "#779988", -- special color (for colored underlines, undercurls...)
            bold = false, -- make group bold
            italic = false, -- make group italic
            underline = false, -- make group underlined
            undercurl = false, -- make group undercurled
            underdot = false, -- make group underdotted
            underdash = false -- make group underslashed
            striketrough = false, -- make group striked trough
            reverse = false, -- reverse the fg and bg colors
            link = "Comment" -- link to some other highlight group
        }
    },

    -- Custom colors must be a function that takes in the default colors table as
    -- a paramter, and then modifies them.
    -- To se the available colors, see lua/material/colors/init.lua
    custom_colors = function(colors)
        colors.editor.bg = "#SOME_COLOR"
        colors.main.purple = "#SOME_COLOR"
        colors.lsp.error = "#SOME_COLOR"
    end
}
vim.cmd('colorscheme oceanic')
```
