# 🌠🌌 Starry 🌌🌠

A collection of colorschemes for neovim (Neovim 5.0+ required), written in lua.

This colorscheme plugin was orignally built based on combination of

- [material.nvim](https://github.com/marko-cerovac/material.nvim)
- [moonlight.nvim](https://github.com/shaunsingh/moonlight.nvim)

Following colorschemes were added later on:

- Dracula & Dracula_blood theme
- Monokai (Based on Sublime Build 3)
- Mariana (The latest Sublime (Build 4) builtin color scheme) and Mariana_lighter
- Emerald (Low contrast green color scheme)
- Middlenight_blue (The theme to use in middle night)
- Earlysummer (more vivid colors) and Earlysummer_lighter
- Darksolar (dark solarized)
- Ukraine yellow text on blue background

## Why this repo:

- All-In-One
- Better color contrast and easy for eyes tuning for material.nvim and moonlight.nvim
- Colorscheme color random loading (loading from Deep ocean, Oceanic, Palenight, Lighter, Darker, moonlight, dracula,
  monokai, mariana, emerald, middlenight_blue, earlysummer randomly )
- Tracking latest neovim/lsp/treesitter highlight updates. e.g. `NormalFloat`, `FloatShadow`, `LspReferenceRead/Write`
- Random loading
- Daylight mode, tune the color for daytime
- Transparent background ready

## Credits:

- [marko-cerovac](https://github.com/marko-cerovac) For the material color palettes. The lua color scheme framework
- [shaunsingh](https://github.com/shaunsingh) For the moonlight color schema

The basic color palettes of material is from [material.vim](https://github.com/kaicataldo/material.vim)

## materail.vim

![material.vim](https://raw.githubusercontent.com/kaicataldo/material.vim/main/screenshots/material-all-variants.png)

## moonlight.nvim

![moonlight](https://user-images.githubusercontent.com/71196912/117904602-a3a55e00-b29f-11eb-9fc0-ab585eafb46e.png)

## Dracula

Color palettes from [github.com/dracula/vim](https://github.com/dracula/vim)
![darcula](https://user-images.githubusercontent.com/1681295/119607837-61038a00-be38-11eb-99b0-48fa7118044f.jpg)

### Dracula_blood

reddish tone of dracula
![blood](https://user-images.githubusercontent.com/1681295/144513439-4aaef1f1-0ab5-4f62-88a1-1fb2d0aa2ec0.png)

## Monokai

Color palettes from [colors/monokai.vim](https://github.com/crusoexia/vim-monokai)

![monokai](https://user-images.githubusercontent.com/1681295/119609635-3ff06880-be3b-11eb-9394-00ca016abe0b.png)

## Mariana

The sublime 4.0 default color scheme

Color palettes from [twolfson/sublime-files](https://github.com/twolfson/sublime-files/blob/master/Packages/Color%20Scheme%20-%20Default/Mariana.sublime-color-scheme)

![mariana](https://preview.redd.it/efzsm1gf0n171.jpg?width=1520&format=pjpg&auto=webp&s=aafb09e752f7fdc9afe3a3a13d069fda2eddc06d)

![mariana2](https://user-images.githubusercontent.com/1681295/119898862-b600e680-bf85-11eb-84c1-727e5add5a18.jpg)

Please check README of starry.nvim project for setups.

## Emerald

I heard green can reduce eye strain :-P

![emerald](https://user-images.githubusercontent.com/1681295/125885744-b19b33e7-cb7c-452c-9def-9a1c4db59603.jpg)

## Middlenight_blue

![middlenight_blue](https://user-images.githubusercontent.com/1681295/125889413-ad5e4b35-d274-4b6d-a8d2-a074628c0d93.jpg)

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

## Example Setup

```vim
let starry_italic_comments = true
let starry_italic_string = false
let starry_italic_keywords = false
let starry_italic_functions = false
let starry_italic_variables = false
let starry_contrast = true
let starry_borders = false
let starry_disable_background = false  "set to true to disable background and allow transparent background
let starry_style_fix=v:true  "disable random loading
let starry_style="moonlight"  "load moonlight everytime or
let starry_darker_contrast=v:true
let starry_deep_black=false       "OLED deep black
let starry_italic_keywords=false
let starry_italic_functions=false
let starry_set_hl=false " Note: enable for nvim 0.6+, it is faster (loading time down to 4~6s from 7~11s), but it does
" not overwrite old values and may has some side effects
let starry_daylight_switch=false  "this allow using brighter color
" other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
```

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
