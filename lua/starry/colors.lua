local function clamp(component)
  return math.min(math.max(component, 0), 255)
end
local starry_color_table
local function LightenDarkenColor(col, amt)
  if type(amt) == 'number' then
    amt = { amt, amt, amt }
  end
  local num = tonumber(col:sub(2), 16)
  if num == nil then
    return col
  end
  if math.floor(amt[1]) ~= amt[1] then -- a float
    amt[1] = math.floor(amt[1] * 0x100)
    amt[2] = math.floor(amt[1] * 0x100)
    amt[3] = math.floor(amt[1] * 0x100)
  end
  local r = math.floor(num / 0x10000) + amt[1]
  local g = (math.floor(num / 0x100) % 0x100) + amt[2]
  local b = (num % 0x100) + amt[3]
  return string.format('#%06x', clamp(r) * 0x10000 + clamp(g) * 0x100 + clamp(b))
end

local function LightenDarkenColorScheme(values, amt)
  values.white = LightenDarkenColor(values.white, amt)
  values.br_white = LightenDarkenColor(values.br_white, amt)
  values.green = LightenDarkenColor(values.green, amt)
  values.green2 = LightenDarkenColor(values.green2, amt)
  values.br_green = LightenDarkenColor(values.br_green, amt)
  values.yellow = LightenDarkenColor(values.yellow, amt)
  values.br_yellow = LightenDarkenColor(values.br_yellow, amt)
  values.blue = LightenDarkenColor(values.blue, amt)
  values.blue1 = LightenDarkenColor(values.blue1, amt)
  values.blue2 = LightenDarkenColor(values.blue2, amt)
  values.br_blue = LightenDarkenColor(values.br_blue, amt)
  values.purple = LightenDarkenColor(values.purple, amt)
  values.br_purple = LightenDarkenColor(values.br_purple, amt)
  values.cyan = LightenDarkenColor(values.cyan, amt)
  values.br_cyan = LightenDarkenColor(values.br_cyan, amt)

  values.magenta = LightenDarkenColor(values.magenta, amt)
  values.gray = LightenDarkenColor(values.gray, amt)
  values.gray5 = LightenDarkenColor(values.gray5, amt)
  values.gray7 = LightenDarkenColor(values.gray7, amt)

  values.orange = LightenDarkenColor(values.orange, amt)
  return values
end

local function starry_init()
  local starry = {
    -- Common colors

    white = '#EEEFFF',
    br_white = '#FEFFFF',
    lightgray = '#A8ACB4',
    gray = '#888CA4',
    gray5 = '#5f496e',
    gray7 = '#777087',
    darkgray = '#676067',
    black = '#07050f',
    dark = '#131122',
    dark2 = '#23212f',
    darker = '#07101f',
    neardark = '#18142a',
    neardark2 = '#282430',
    aqua = '#66d9ef',
    red = '#F07178',
    red1 = '#ec5f67',
    br_red = '#f9a3a3',
    red2 = '#F92772',
    caramel = '#f9c37a',
    crimson = '#DC143C',
    darkred = '#821040',
    darkred2 = '#dc6068',
    darkred3 = '#4c0018',

    violet1 = '#EE82EE',
    tomato = '#FF6347',
    cranberry = '#CD5C5C',
    emerald = '#50c878',
    sky = '#87ceeb',
    green = '#C3E88D',
    lime = '#98EE64',
    green1 = '#1aad16',
    br_green = '#1afd16',
    green2 = '#77d507',

    yellow = '#FFCB6B',
    br_yellow = '#FFFB6B',
    yellow1 = '#fbec9f',
    yellow2 = '#bBa03A',
    tan = '#DDCFBF',
    brown = '#925632',

    blue = '#82AAFF',
    paleblue = '#B0C9FF',
    blue1 = '#10aef8',
    br_blue = '#408ef8',
    blue2 = '#01d5f1',
    cyan = '#89DDFF',
    br_cyan = '#A9EDFF',

    magenta = '#BF32BF',
    hoki = '#5f7e97',
    purple = '#C792EA',
    br_purple = '#D792FA',
    violet = '#B66FFD',

    purple1 = '#ae81ef',
    purple2 = '#9e71cf',
    purple3 = '#7d2c9d',
    purple4 = '#7202da',
    purple5 = '#b480d6',
    darkpurple = '#57308a',
    darkpurple2 = '#400c5d',

    orange = '#F78C6C',
    red_orange = '#af5f5f',
    coral = '#ff7f50',
    pink = '#FF9CAC',
    pink1 = '#da71c2',
    pink2 = '#f19bb6',
    pink3 = '#fecbc9',
    pink4 = '#c988ce',
    -- Dark colors
    darkgreen = '#abcf76',
    darkgreen2 = '#2b4f06',
    darkyellow = '#e6b455',
    darkblue = '#5c7b9b',
    darkcyan = '#7196a7',
    darkorange = '#e2795b',
    highlight_style = 'bold,italic',
    search_style = 'reverse,bold',
    none = 'NONE',
  }

  local function get_default(starry_colors)
    return {
      statement = starry_colors.pink,
      symbol = starry_colors.br_cyan,
      operator = starry_colors.cyan,
      label = starry_colors.purple1,
      condition = starry_colors.magenta,
      keyword = starry_colors.purple,
      keyword_func = starry_colors.sky,
      func = starry_colors.blue2,
      method = starry_colors.br_cyan,
      comments = starry_colors.warmgrey,
      number = starry_colors.coral,
      float = starry_colors.orange,
      char = starry_colors.tan,
      variable = starry_colors.blue,
      parameter = starry_colors.pink1,
      class = starry_colors.cyan,
      typedef = starry_colors.red2,
      punctutation = starry_colors.br_blue,
      structure = starry_colors.purple2,
      cursor = '#FFCC80',
      bright = starry_colors.br_white,

      textdark = starry_colors.gray,
      text = starry_colors.white,

      field = starry_colors.blue1,
      bool = starry_colors.orange,
      string = starry_colors.green,
      const = starry_colors.yellow,
      directory = starry_colors.blue,

      bg = starry_colors.dark,
      bg_darker = starry_colors.darker,
      bg_alt = starry_colors.neardark,

      selection = starry_colors.gray7,
      search_fg = starry_colors.orange,
      search_bg = starry_colors.black,
      inc_search = starry_colors.yellow,
      contrast = starry_colors.dark,
      less_active = starry_colors.neardark2,
      bracket = starry_colors.orange,
      active = starry_colors.gray5,
      more_active = starry_colors.gray7,
      border = starry_colors.gray5,
      line_numbers = starry_colors.gray7,
      highlight = starry_colors.gray5,
      disabled = starry_colors.darkgray,
      precondit = starry_colors.br_blue,
      accent = starry_colors.gray7,
      error = starry_colors.br_red,
      link = starry_colors.darkblue,
      type = starry_colors.br_yellow,
    }
  end
  starry = vim.tbl_extend('keep', starry, get_default(starry))

  local starry_moonlight = {
    -- Common colors

    white = '#EEF5FF',
    gray = '#a1abe0',
    warmgrey = '#8c9a9b',
    dark = '#212337',
    darker = '#1A2030',
    neardark = '#29303f',

    black = '#101418',
    red = '#ff757f',
    green = '#4dc4a0',
    yellow = '#ffe777',
    yellow1 = '#efc727',
    br_yellow = '#efc727',
    paleblue = '#B0C9FF',
    cyan = '#79e4fc',
    br_cyan = '#4994cc',

    blue = '#3481d9',
    blue1 = '#94c1f9',
    blue2 = '#6491a9',
    darkblue = '#24748a',
    br_blue = '#3aa1cc',
    purple = '#b4a4f4',
    purple1 = '#c4d4f4',
    orange = '#f67f81',
    pink = '#ecb2f0',
  }
  local moonlight = function()
    return {
      bg = starry_moonlight.dark,
      bg_darker = '#060816',
      darker = '#060816',
      bg_alt = '#1B1E2B',
      fg = '#fefcd7',
      text = '#f5fdac',
      string = '#c5cdcc',
      variable = '#3aa7c7',
      type = starry_moonlight.blue2,
      condition = starry_moonlight.br_blue,
      keyword = starry_moonlight.green,
      keyword_func = starry_moonlight.cyan,
      comments = starry_moonlight.darkblue,
      func = starry_moonlight.br_blue,
      method = starry_moonlight.cyan,
      bracket = starry_moonlight.yellow1,
      selection = '#403c64',
      structure = 'HotPink',
      class = 'PaleVioletRed',
      contrast = '#1b1c2b',
      less_active = '#222a30',
      active = '#24344c',
      more_active = '#324558',
      border = '#413893',
      line_numbers = starry_moonlight.hoki,
      highlight = '#514b70',
      disabled = '#515772',
      cursor = '#F1E4DC',
      accent = '#a3ace1',
      tag = starry.cyan,
      error = '#EF83D0',
      search_bg = starry.black,
      search_fg = '#8498ac',
      link = '#D9BBE4',
    }
  end

  local starry_dracula = {
    -- Common colors
    white = '#FEF8F2',
    gray = '#a1abe0',
    dark = '#21222c',
    darker = '#141520',
    neardark = '#293030',
    black = '#101010',
    red = '#ff555f',
    green = '#50fa7b',
    yellow = '#f1fa87',
    paleblue = '#8697b0',
    cyan = '#8be4f1',
    blue = '#04d1f9',
    purple = '#bd94f4',
    orange = '#ff79c1',
    pink = '#ff79c7',
  }
  local dracula = function()
    return {
      bg = starry.dark,
      bg_alt = '#282A36',
      bg_darker = '#191a21',
      fg = '#f4f3f2',
      text = '#a5adec',
      func = '#5FF67D',
      method = '#7FE65D',
      variable = '#F5E2ED',
      statement = '#a94934',
      field = '#9373A5',
      string = '#FAC739',
      keyword = '#FE57C0',
      keyword_func = '#FEC750',
      condition = '#EF70A0',
      structure = 'DeepPink',
      class = 'salmon',
      const = '#9876AA',
      bracket = '#f8f6AA',
      comments = '#6476a6',
      number = starry.purple,
      selection = '#483031',
      contrast = '#2b2c3b',
      less_active = '#302f3f',
      active = '#363B40',
      more_active = '#3d3f4f',
      border = '#5144a3',
      precondit = starry.yellow,
      line_numbers = '#5b6395',
      highlight = '#716f90',
      disabled = '#615752',
      cursor = '#7c44fc',
      accent = '#a34c81',
      error = '#FF5370',
      tag = starry.cyan,
      link = '#80CBC4',
      type = starry.blue,
    }
  end

  local starry_dracula_blood = {
    -- Common colors
    white = '#EEE8EE',
    gray = '#a1abe0',

    dark = '#1D1825',
    neardark = '#203030',
    darker = '#191321',
    black = '#100511',
    red = '#A71906',
    salmon = '#F7856E',
    green = '#8FE067',
    teal = '#4DB380',
    yellow = '#FFC66B',
    paleblue = '#8677c0',
    cyan = '#299999',
    blue = '#5594EC',
    purple = '#A781BB',
    orange = '#DA632B',
    magenta = '#D184C7',
    pink = '#fe69c7',
  }
  local dracula_blood = function()
    return {
      bg = starry_dracula_blood.dark,
      bg_alt = '#2C2C34',
      bg_darker = starry_dracula_blood.darker,
      fg = '#E8E8E3',
      bg2 = '#103b41',
      search_fg = starry_dracula_blood.salmon,
      statement = starry.darkorange,
      func = 'PaleGreen',
      method = '#A0E210',
      text = '#c5ddfc',
      comments = '#8A6A8A',
      keyword = '#CC4832',
      variable = '#F5D2DD',
      string = '#F0C366',
      const = '#9876CA',
      condition = '#EF70A0',
      contrast = '#2f2c3b',
      less_active = '#242028',
      active = '#453737',
      more_active = '#584a4e',
      border = '#814265',
      line_numbers = '#6F7795',
      highlight = '#515b70',
      disabled = '#6f5456',
      field = starry_dracula_blood.paleblue,
      cursor = '#7c44fc',
      accent = '#a34ca1',
      error = '#EF4360',
      type = '#F070C0',
    }
  end

  local starry_monokai = {
    -- Common colors

    white = '#E8E8E3',
    white2 = '#d8d8d3',
    gray = '#8F908A',
    lightgray = '#A7AFA1',

    dark = '#262721',
    darker = '#191a21',
    black = '#121812',
    neardark = '#30312A',

    darkgrey = '#64645e',
    warmgrey = '#75715E',

    pink = '#F92772',
    green = '#A6E22D',
    yellow = '#E6DB74',
    darkyellow = '#A67B44',
    orange = '#FD9720',
    purple = '#ae81ff',
    red = '#e73c50',
    purered = '#ff0000',
    darkred = '#5f0000',

    addfg = '#d7ffaf',
    addbg = '#5f875f',
    delfg = '#ff8b8b',
    delbg = '#f75f5f',
    changefg = '#d7d7ff',
    changebg = '#5f5f87',

    cyan = '#A1EFE4',
    br_green = '#9EC400',
    br_yellow = '#E7C547',
    br_blue = '#63D6FA',
    br_purple = '#B77EE0',
    br_cyan = '#54CED6',
    br_white = '#FFFFFF',

    salmon = '#F7856E',
    teal = '#4DB380',
    paleblue = '#a6a7d0',
    blue = '#5594EC',
    magenta = '#D184C7',
  }
  local monokai = function()
    return {
      -- syntax
      bg = starry_monokai.dark,
      bg_alt = '#30312A',
      bg_darker = starry_monokai.darker,
      fg = '#CED1D4',
      bg2 = '#103b41',
      statement = '#F82773',
      symbol = '#E8E8E3',
      operator = '#E03077',
      label = '#E03077',
      condition = '#EF3060',
      keyword = '#E03077',
      func = '#AEE23F',
      method = '#A0E210',
      text = '#d5edfc',
      comments = '#75715E',
      number = '#ae8eff',
      char = '#E6DB74',
      variable = starry_monokai.changefg,
      parameter = starry_monokai.orange,
      class = starry_monokai.blue,
      typedef = '#6570EF',

      field = starry_monokai.br_blue,
      bool = '#E04480',
      string = '#F0C366',
      const = '#A876FA',
      selection = '#474b51',
      search_bg = '#252056',
      search_fg = starry_monokai.dark_yellow,
      inc_search = starry_monokai.br_yellow,
      contrast = '#1b1c2b',
      less_active = '#343032',
      active = '#3E383A',
      more_active = '#503f4f',
      border = '#414245',
      line_numbers = '#676765',
      highlight = '#515b70',
      disabled = '#4f5466',
      cursor = '#7c44fc',
      accent = '#66d9ef',
      error = '#EF4360',
      link = '#80CBC4',
      type = '#66d9ef',
    }
  end

  local mariana_colors = {
    -- Common colors
    dark = '#2A333C',
    darker = '#243037',
    neardark = '#30323F',
    black = '#102023',
    white = '#FFFFFF',
    white2 = '#F7F7F7',
    white3 = '#D8DEE9',
    grey = '#333333',
    lightgray = '#a7abbd',

    darkgrey = '#64645e',
    warmgrey = '#75715E',

    pink = '#C695C6',
    green = '#99C794',
    aqua = '#66d9ef',
    yellow = '#E6DB74',
    orange = '#F9AE28',
    orange2 = '#EE932B',
    orange3 = '#FAC761',
    purple = '#ae81ff',
    red = '#EC5F66',
    red2 = '#F97B58',
    purered = '#ff0000',
    darkred = '#5f0000',

    blue = '#6699CC',
    blue1 = '#6699CC',
    blue2 = '#3E4A55',
    blue3 = '#2A333C',
    blue4 = '#64738A',
    blue5 = '#5F7484',
    blue5_day = '#343d48', -- note: this is base color of original mariana
    blue6 = '#A6ACB9',
    blue7 = '#304868',

    blue8 = '#243038',
    blue9 = '#323A48',
    blueA = '#B4C0F0',
    blueB = '#303449',
    blueC = '#B0C4D5',

    cyan = '#A1EFE4',
    br_green = '#9EC400',
    br_yellow = '#E7C547',
    br_blue = '#7AA6DA',
    br_purple = '#B77EE0',
    br_cyan = '#54CED6',
    br_white = '#FFFFFF',

    salmon = '#F7856E',
    teal = '#4DB380',
    paleblue = '#a6a7e0',
    magenta = '#D184C7',
  }
  local mariana = function()
    return {
      bg = mariana_colors.dark,
      bg_alt = mariana_colors.blue9,
      bg_darker = mariana_colors.darker,
      fg = mariana_colors.white3,
      bg2 = '#103b41',
      statement = '#F82773',
      symbol = mariana_colors.red,
      operator = mariana_colors.red2,
      label = mariana_colors.orange,
      condition = mariana_colors.red,
      keyword = mariana_colors.red,
      func = mariana_colors.blueA,
      method = mariana_colors.pink,
      text = mariana_colors.white3,
      comments = mariana_colors.blue6,
      number = mariana_colors.orange,
      char = mariana_colors.pink,
      variable = mariana_colors.white3,
      parameter = starry.orange,
      class = mariana_colors.pink,
      typedef = mariana_colors.br_cyan,
      punctutation = mariana_colors.blue5,

      field = mariana_colors.blueC,
      bool = '#E04480',
      string = mariana_colors.green,
      const = mariana_colors.red,
      selection = '#575b61',
      search_fg = mariana_colors.green,
      search_bg = mariana_colors.grey,
      inc_search = mariana_colors.orange2,
      contrast = mariana_colors.blue2,
      less_active = mariana_colors.blue2,
      float = mariana_colors.orange,
      bracket = mariana_colors.orange,
      active = mariana_colors.blue7,
      more_active = mariana_colors.blue5,
      border = mariana_colors.blue4,
      line_numbers = mariana_colors.blue1,
      highlight = '#515b70',
      disabled = mariana_colors.blue4,
      cursor = '#7c44fc',
      accent = mariana_colors.white3,
      error = '#EF4360',
      link = '#80CBC4',
      type = '#66d9ef',
    }
  end

  local emerald_colors = {
    -- Common colors
    white = '#E0FFE0',
    white2 = '#D0E7D0',
    white3 = '#A8DEB9',
    grey = '#233323',
    darkgray = '#476b61',

    dark = '#133020',
    darker = '#101D12',
    black = '#08170A',
    neardark = '#203428',

    caramel = '#f9c37a',
    lightgrey = '#64645e',
    warmgrey = '#657150',

    pink = '#D675D6',
    green = '#147816',
    blue = '#36a5fa',
    aqua = '#66c9cf',
    yellow = '#C2DD54',
    yellow2 = '#A2ED34',
    orange = '#F9AE58',
    orange2 = '#cd8b59',
    purple = '#ae81ff',
    red = '#EC7F86',
    red2 = '#F97B58',
    purered = '#ff0000',
    darkred = '#5f0000',

    green1 = '#0FC192',
    green2 = '#caefb3',
    green3 = '#abce00',
    green4 = '#648c01',
    green5 = '#2f5f02',
    green6 = '#58bd62',
    green7 = '#1A554e',
    green8 = '#C6Dc93',
    green9 = '#132a15',
    greena = '#10210e',
    greenb = '#046806',
    greenc = '#065836',
    greend = '#46f836',
    greene = '#86c8b6',

    cyan = '#A1EFE4',
    br_green = '#9EC400',
    br_yellow = '#E7C547',
    br_yellow2 = '#D0AC7A',
    br_blue = '#7AA6DA',
    br_purple = '#B77EE0',
    br_cyan = '#54CED6',
    br_white = '#FFFFFF',

    link = '#80CBF4',
    salmon = '#F7856E',
    teal = '#4DB3A0',
    paleblue = '#d6e7f0',
    magenta = '#D134C7',
  }

  local function emerald()
    return {
      bg = emerald_colors.dark,
      bg_alt = emerald_colors.green9,
      bg_darker = emerald_colors.darker,
      fg = emerald_colors.white3,
      bg2 = '#103b41',
      statement = '#DbB0A0',
      symbol = emerald_colors.yellow2,
      operator = emerald_colors.red2,
      label = emerald_colors.orange,
      condition = emerald_colors.green3,
      keyword = emerald_colors.cyan,
      func = emerald_colors.green3,
      method = emerald_colors.green6,
      text = emerald_colors.white3,
      comments = emerald_colors.green,
      number = emerald_colors.orange2,
      float = emerald_colors.orange,
      char = emerald_colors.aqua,
      variable = emerald_colors.white3,
      parameter = starry.orange,
      class = emerald_colors.pink,
      typedef = emerald_colors.teal,
      builtin = emerald_colors.teal,
      punctutation = emerald_colors.green4,
      preproc = emerald_colors.br_cyan,
      precondit = emerald_colors.white3,
      tag = emerald_colors.orange2,
      include = emerald_colors.orange,

      field = emerald_colors.green8,
      bool = '#C06431',
      string = emerald_colors.green6,
      const = emerald_colors.pink,
      selection = '#474b51',
      search_fg = emerald_colors.orange2,
      search_bg = emerald_colors.grey,
      inc_search = emerald_colors.green2,
      contrast = '#1b1c2b',
      less_active = emerald_colors.greena,
      bracket = emerald_colors.orange,
      active = emerald_colors.green9,
      more_active = emerald_colors.green5,
      border = emerald_colors.greenb,
      line_numbers = emerald_colors.greenb,
      highlight = '#315b40',
      disabled = emerald_colors.darkgray,
      cursor = '#a0d2ac',
      accent = emerald_colors.br_green,
      error = '#CA1414',
      link = emerald_colors.bluee,
      type = '#66d9af',
    }
  end

  local middlenight_blue_colors = {
    -- Common colors
    white = '#EEFFFF',
    white2 = '#E7F7F7',
    white3 = '#D8EED9',
    grey = '#d3d3d3',
    darkgray = '#476b61',

    dark = '#101022',
    neardark = '#181832',
    darker = '#040D16',
    black = '#010B10',

    caramel = '#f9c37a',
    lightgrey = '#64645e',
    warmgrey = '#657150',

    brown = '#925632',
    pink = '#df75b6',
    purple = '#A75ED0',
    violet = '#6f25f6',
    green = '#76da84',
    blue = '#5f95fa',
    blue2 = '#0f85ff',
    blue3 = '#0fA5CF',
    blue4 = '#7fB5FF',
    aqua = '#66c9cf',
    yellow = '#ffca44',
    yellow2 = '#c2ad54',
    orange = '#F9AE58',
    orange2 = '#cd8b59',
    red = '#EC5F66',
    red2 = '#F97B58',
    purered = '#ff0000',
    darkred = '#5f0000',

    green1 = '#0FE192',
    green2 = '#caefb3',
    green3 = '#abce00',
    green4 = '#648c01',
    green5 = '#2f5f02',
    green6 = '#589d62',
    green7 = '#1A554e',
    cyan = '#A1EFE4',
    br_green = '#9EDD00',
    br_green2 = '#9EFF30',
    br_yellow = '#E7E547',
    br_yellow2 = '#F0Fc7a',
    br_blue = '#AAA6FA',
    br_blue2 = '#CAD6FF',
    br_purple = '#C77EF0',
    br_cyan = '#54CED6',
    br_white = '#FFFFFF',

    salmon = '#F7856E',
    teal = '#4DB380',
    paleblue = '#b6b7f0',
    magenta = '#D184C7',
  }

  local middlenight_blue = function()
    return {
      bg = middlenight_blue_colors.dark,
      bg_alt = '#20202a',
      bg_darker = middlenight_blue_colors.darker,
      fg = '#ddeedd',
      bg2 = '#201022',
      statement = middlenight_blue_colors.br_yellow,
      symbol = '#757db3',
      operator = middlenight_blue_colors.purple,
      label = middlenight_blue_colors.orange,
      condition = starry.blue3,
      keyword = middlenight_blue_colors.auqa,
      keyword_func = middlenight_blue_colors.br_purple,
      func = middlenight_blue_colors.blue4,
      method = middlenight_blue_colors.blue,
      text = '#d0d5db',
      comments = '#7171d3',
      number = '#bb95fb',
      float = middlenight_blue_colors.orange,
      char = middlenight_blue_colors.aqua,
      variable = middlenight_blue_colors.br_blue2,
      parameter = '#c67eb9',
      class = '#838cca',
      typedef = '#c6c45e',
      punctutation = middlenight_blue_colors.green4,
      precondit = middlenight_blue_colors.aqua,

      field = middlenight_blue_colors.br_blue,
      bool = middlenight_blue_colors.cyan,
      string = middlenight_blue_colors.teal,
      const = '#52d1ce',
      directory = middlenight_blue_colors.orange2,

      selection = '#143062',
      search_fg = '#a0a0d0',
      search_bg = '#52408f',
      contrast = '#1b203b',
      less_active = '#242f3a',
      bracket = middlenight_blue_colors.paleblue,
      active = '#303051',
      more_active = '#3f3671',
      border = '#242938',
      line_numbers = '#5d5286',
      highlight = '#212b50',
      disabled = middlenight_blue_colors.darkgray,
      cursor = '#a0d2ac',
      accent = '#8eadbd',
      error = '#a61e20',
      link = '#80ABF4',
      tag = middlenight_blue_colors.blue2,
      type = '#66d9af',
    }
  end

  local earlysummer_colors = {
    -- Common colors
    white = '#EEFFFF',
    white2 = '#E7F7F7',
    white3 = '#A8BEC9',
    grey = '#d3d3d3',
    darkgray = '#476b61',

    black = '#111420',
    dark = '#212c31',
    neardark = '#2F3841',
    darker = '#15232e',
    dark2 = '#313D46',

    caramel = '#ffa37a',
    lightgrey = '#64645e',
    warmgrey = '#658180',

    brown = '#925632',
    pink = '#ef6596',
    redwine = '#e95680',
    green = '#76da84',
    blue = '#7fb5fa',
    blue2 = '#80e5fa',
    blue3 = '#90f5fa',
    aqua = '#66c9cf',
    yellow = '#ffca94',
    yellow2 = '#c2ad54',
    orange = '#D99E58',
    orange2 = '#cd8b59',
    purple = '#d191ff',
    red = '#EF5F86',
    red1 = '#FF9F96',
    red2 = '#F97B58',
    purered = '#ff0080',
    darkred = '#5f0030',

    green1 = '#0FC192',
    green2 = '#caefb3',
    green3 = '#abce00',
    dark_green = '#a0be79',
    cyan = '#39DFE4',
    br_green = '#9EC400',
    br_yellow = '#E7C547',
    br_yellow2 = '#d0ac7a',
    br_blue = '#7AA6DA',
    br_purple = '#B77EE0',
    br_cyan = '#54CED6',
    br_white = '#FFFFFF',

    salmon = '#F7856E',
    teal = '#4DB380',
    paleblue = '#d6e7f0',
    magenta = '#D184C7',
    link = '#80ABF4',
  }

  local function earlysummer()
    return {
      bg = earlysummer_colors.dark,
      bg_alt = earlysummer_colors.dark2,
      bg_darker = earlysummer_colors.darker,
      fg = '#bbccdd',
      statement = earlysummer_colors.red1,
      symbol = earlysummer_colors.yellow,
      operator = earlysummer_colors.redwine,
      label = earlysummer_colors.orange,
      condition = earlysummer_colors.magenta,
      keyword = earlysummer_colors.red,
      keyword_func = earlysummer_colors.purple,
      func = earlysummer_colors.blue2,
      method = earlysummer_colors.br_cyan,
      text = earlysummer_colors.white3,
      comments = earlysummer_colors.warmgrey,
      number = earlysummer_colors.brown,
      float = earlysummer_colors.orange,
      char = earlysummer_colors.aqua,
      variable = earlysummer_colors.blue,
      parameter = earlysummer_colors.pink,
      class = earlysummer_colors.orange2,
      typedef = earlysummer_colors.red2,
      punctutation = earlysummer_colors.br_blue,

      field = earlysummer_colors.caramel,
      bool = '#C06431',
      string = earlysummer_colors.dark_green,
      const = earlysummer_colors.cyan,
      directory = earlysummer_colors.blue,

      selection = '#544062',
      search_fg = earlysummer_colors.orange,
      inc_search = earlysummer_colors.purple,
      search_bg = '#303010',
      contrast = earlysummer_colors.dark2,
      less_active = '#202124',
      bracket = earlysummer_colors.orange,
      active = '#313043',
      more_active = '#4f5681',
      border = '#393F48',
      line_numbers = '#5d6276',
      highlight = '#4f4b60',
      disabled = earlysummer_colors.darkgray,
      cursor = '#a0d2ac',
      accent = '#8eadbd',
      error = earlysummer_colors.red2,
      link = '#808BF4',
      type = '#66d9af',
    }
  end

  local dark_solar_colors = {
    -- Common colors
    white = '#ABBCBB',
    white2 = '#97A7A7',
    white3 = '#889EA9',
    grey = '#006393',
    gray = '#006393',
    darkgray = '#074051',

    bg = '#012731',
    dark = '#012731',
    neardark = '#113441',
    darker = '#012026',
    black = '#01141D',

    caramel = '#ffa37a',
    lightgrey = '#94a4be',
    warmgrey = '#958180',

    brown = '#925632',
    pink = '#ff95b6',
    redwine = '#e95680',
    green = '#76ba6c',
    blue = '#2f85da',
    blue2 = '#4095ba',
    blue3 = '#90f5fa',
    aqua = '#66c9cf',
    yellow = '#bf8a04',
    yellow2 = '#c2ad54',
    orange = '#D99E58',
    orange2 = '#cd8b59',
    purple = '#d13d8f',
    red = '#D01F26',
    br_red = '#F41F36',
    red2 = '#F97B58',
    purered = '#ff0000',
    darkred = '#5f0000',

    green1 = '#0FC192',
    green2 = '#86aaac',
    green3 = '#abce00',
    dark_green = '#a0be70',
    cyan = '#29A194',
    br_green = '#56ae9c',
    br_yellow = '#B77E37',
    br_yellow2 = '#d0ac7a',
    br_blue = '#3A96DA',
    br_purple = '#974ED0',
    br_cyan = '#54AEA6',
    br_white = '#FCFCDF',

    salmon = '#F7856E',
    teal = '#4DB380',
    paleblue = '#96e7f0',
    magenta = '#D184C7',
    link = '#80ABF4',
  }

  local dark_solar = function()
    return {
      bg = dark_solar_colors.bg,
      bg_alt = '#083445',
      bg_darker = dark_solar_colors.black,
      fg = dark_solar_colors.white,
      statement = dark_solar_colors.green2,
      symbol = dark_solar_colors.br_cyan,
      operator = dark_solar_colors.br_green,
      label = dark_solar_colors.orange,
      condition = dark_solar_colors.magenta,
      keyword = dark_solar_colors.br_green,
      keyword_func = dark_solar_colors.green2,
      func = dark_solar_colors.blue2,
      method = dark_solar_colors.br_cyan,
      text = dark_solar_colors.blue2,
      comments = dark_solar_colors.warmgrey,
      number = dark_solar_colors.blue2,
      float = dark_solar_colors.teal,
      char = dark_solar_colors.aqua,
      variable = dark_solar_colors.lightgrey,
      parameter = dark_solar_colors.pink,
      class = dark_solar_colors.orange2,
      typedef = dark_solar_colors.red2,
      punctutation = dark_solar_colors.br_blue,

      field = dark_solar_colors.br_blue,
      bool = '#C06431',
      string = dark_solar_colors.br_green,
      const = dark_solar_colors.cyan,
      directory = dark_solar_colors.blue,

      selection = '#234252',
      search_fg = dark_solar_colors.yellow,
      search_bg = '#303010',
      contrast = '#1b1c2b',
      less_active = '#203154',
      bracket = dark_solar_colors.orange,
      active = '#374854',
      more_active = '#4f5681',
      border = '#193F48',
      line_numbers = '#2d5266',
      highlight = '#2f4b80',
      disabled = dark_solar_colors.darkgray,
      cursor = '#f34a00',
      accent = '#8ebddd',
      error = dark_solar_colors.br_red,
      link = '#407BF4',
      type = dark_solar_colors.br_yellow,
    }
  end

  local ukraine_colors = {
    -- Common colors
    white = '#EEFFDF',
    white2 = '#E7F7F7',
    white3 = '#D8EED9',
    grey = '#d3d3d3',
    darkgray = '#476b61',

    dark = '#1056B8',
    neardark = '#4450A8',
    darker = '#1446a6',
    black = '#012052',

    caramel = '#f9c37a',
    lightgrey = '#64645e',
    warmgrey = '#657150',

    brown = '#925632',
    pink = '#ff95b6',
    green = '#76da84',
    blue = '#5f95fa',
    aqua = '#66c9cf',
    yellow = '#ffda14',
    yellow2 = '#c2ad04',
    orange = '#F9AE48',
    orange2 = '#cd8b39',
    purple = '#f1b1ff',
    red = '#EC5F66',
    red2 = '#F97B58',
    purered = '#ff0000',
    darkred = '#5f0000',

    green1 = '#0FE192',
    green2 = '#caefb3',
    green3 = '#abce00',
    green4 = '#648c01',
    cyan = '#A1EFE4',
    br_green = '#9EDD00',
    br_green2 = '#9EFF30',
    br_yellow = '#E7E527',
    br_yellow2 = '#F0Fc4a',
    br_blue = '#AAA6FA',
    br_blue2 = '#2A56FF',
    br_purple = '#C77EF0',
    br_cyan = '#54CED6',
    br_white = '#FFFFDF',

    salmon = '#F7856E',
    teal = '#4DB380',
    paleblue = '#a6e7f0',
    magenta = '#D184C7',
  }

  local ukraine = function()
    return {
      bg = ukraine_colors.dark,
      bg_alt = '#2040b0',
      bg_darker = ukraine_colors.darker,
      fg = '#fdee1d',
      bg2 = '#201022',
      statement = ukraine_colors.br_yellow,
      symbol = ukraine_colors.green,
      operator = ukraine_colors.purple,
      label = ukraine_colors.orange,
      condition = ukraine_colors.cyan,
      keyword = ukraine_colors.orange,
      keyword_func = ukraine_colors.yellow,
      func = ukraine_colors.purple,
      method = ukraine_colors.pink,
      text = '#f0f52b',
      comments = '#a19103',
      number = '#bb95fb',
      float = ukraine_colors.orange,
      char = ukraine_colors.aqua,
      variable = ukraine_colors.br_yellow2,
      parameter = '#c67eb9',
      class = '#d3dcca',
      typedef = '#c6c45e',
      punctutation = ukraine_colors.green4,

      field = ukraine_colors.br_yellow,
      bool = ukraine_colors.cyan,
      string = ukraine_colors.green1,
      const = '#52d1ce',
      directory = ukraine_colors.orange2,

      selection = '#5470d2',
      search_fg = '#f0f0f0',
      search_bg = '#52408f',
      contrast = '#1b20cb',
      less_active = '#242fda',
      bracket = ukraine_colors.paleblue,
      active = '#3030E1',
      more_active = '#3f36F1',
      border = '#D4D938',
      line_numbers = '#DdD286',
      highlight = '#212bF0',
      disabled = ukraine_colors.br_blue,
      cursor = '#a0d2ac',
      accent = '#cecd2d',
      error = '#a61e20',
      link = '#80ABF4',
      type = '#66d9af',
    }
  end
  local config = require('starry.config').options
  local style_name = config.style.name
  -- Style specific colors
  if style_name == 'darker' then
    -- Darker theme style

    starry = LightenDarkenColorScheme(starry, { -25, -20, -10 })
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry.bg = '#212121'
    starry.dark = '#212121'
    starry.darker = '#1C1C1C'
    starry.bg_alt = '#1A1A1A'
    starry.fg = '#B0BEC5'
    starry.text = '#9292A8'
    starry.comments = '#616161'
    starry.selection = '#474849'
    starry.contrast = '#1A1A1A'

    starry.less_active = '#24262a'
    starry.active = '#2f2335'
    starry.more_active = '#424252'
    starry.border = '#31314B'
    starry.line_numbers = '#525272'
    starry.highlight = '#423F6F'
    starry.disabled = '#40404A'
    starry.accent = '#FF9800'
    if config.style.darker_contrast == true then
      -- Lighter theme style with high contrast
      starry.comments = '#858585'
      starry.line_numbers = '#5C5C5C'
    end
  elseif style_name == 'limestone' then
    -- limestone theme style

    starry.white = '#FFFFFF'
    starry.gray = '#818CA4'
    starry.black = '#606040'
    starry.red = '#E53935'
    starry.green = '#71A849'
    starry.green1 = '#51B829'
    starry.yellow = '#F6A434'
    starry.yellow1 = '#C6A414'
    starry.yellow2 = '#B69414'
    starry.blue = '#6182B8'
    starry.blue1 = '#5182D8'
    starry.paleblue = '#7786B0'
    starry.cyan = '#399DA5'
    starry.purple = '#7C4DDF'
    starry.orange = '#F76D47'
    starry.pink = '#EF5370'
    starry.violet = '#945eb8'
    starry.lime = '#98BE54'

    starry = vim.tbl_extend('force', starry, get_default(starry))

    starry.bg = '#EAEADA'
    starry.bg_alt = '#DFDFBF'
    starry.fg = '#345E6A'
    starry.text = '#547770'
    starry.comments = '#90A0B2'
    starry.selection = '#80CBC4'
    starry.contrast = '#DEDEDE'
    starry.less_active = '#E0E0D4'
    starry.active = '#E0D0D3'
    starry.more_active = '#C7C8A3'
    starry.border = '#A381E8'
    starry.line_numbers = '#AFC8AC'
    starry.highlight = '#C7C7A8'
    starry.disabled = '#A2A4A5'
    starry.cursor = '#272727'
    starry.parameter = '#5193a8'
    starry.type = '#A47EE8'
    starry.search_fg = '#FAC37D'
    starry.search_bg = starry.blue1

    starry.accent = '#60BCD4'
    starry.keyword = starry.orange
  elseif style_name == 'palenight' then
    -- Palenight theme style

    -- print(vim.inspect(starry))
    starry.bg = '#292D3E'
    starry.dark = '#292D3E'
    starry.darker = '#262738'
    starry.bg_alt = '#1B1E2B'
    starry.fg = '#A6ACCD'
    starry.text = '#818CB4'
    starry.comments = '#878EA5'
    starry.selection = '#44425F'
    starry.contrast = '#202331'
    starry.less_active = '#303145'
    starry.active = '#363743'
    starry.more_active = '#414863'
    starry.border = '#676E95'
    starry.line_numbers = '#5A5F98'
    starry.highlight = '#545287'
    starry.disabled = '#515772'
    starry.accent = '#AB47BC'
  elseif style_name == 'deep ocean' then
    -- Deep Ocean theme style

    starry = LightenDarkenColorScheme(starry, { -10, -5, 5 })
    starry = vim.tbl_extend('force', starry, get_default(starry))
    -- print(vim.inspect(starry))
    starry.bg = '#0F111A'
    starry.dark = '#0F111A'
    starry.darker = '#0D0F15'
    starry.bg_alt = '#090B10'
    starry.fg = '#8F93A2'
    starry.text = '#818CB4'
    starry.comments = '#666B7D'
    starry.selection = '#373448'
    starry.contrast = '#090B10'
    starry.less_active = '#141628'
    starry.active = '#202030'
    starry.more_active = '#3A3555'
    starry.border = '#312443'
    starry.line_numbers = '#5B5F91'
    starry.highlight = '#4F3F63'
    starry.disabled = '#464B5D'
    starry.accent = '#84FFFF'
  elseif style_name == 'oceanic' then
    starry = LightenDarkenColorScheme(starry, { 10, 10, 20 })
    starry = vim.tbl_extend('force', starry, get_default(starry))
    style_name = 'oceanic'
    -- Oceanic theme style
    starry.bg = '#20272f'
    starry.dark = '#20272f'
    starry.darker = '#1A2429'
    starry.bg_alt = '#192027'
    starry.fg = '#B0BEC5'
    starry.text = '#89AFB4'
    starry.comments = '#666B8D'
    starry.selection = '#445E6A'

    starry.less_active = '#252f35'
    starry.contrast = '#1E272C'
    starry.active = '#26323f'
    starry.more_active = '#375354'
    starry.border = '#2A373E'
    starry.line_numbers = '#577FAF'
    starry.highlight = '#425B67'
    starry.disabled = '#415967'
    starry.accent = '#A0A6F8'
  elseif style_name == 'moonlight' then
    starry = vim.tbl_extend('force', starry, starry_moonlight)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, moonlight())
  elseif style_name == 'dracula' then
    starry = vim.tbl_extend('force', starry, starry_dracula)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, dracula())
  elseif style_name == 'dracula_blood' then
    starry = vim.tbl_extend('force', starry, starry_dracula)
    starry = vim.tbl_extend('force', starry, starry_dracula_blood)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, dracula())
    starry = vim.tbl_extend('force', starry, dracula_blood())
  elseif style_name == 'monokai' or style_name == 'monokai_lighter' then
    if style_name == 'monokai_lighter' then
      starry_monokai.bg = '#2F2F23'
      starry_monokai.bg_alt = '#33342d'
      starry_monokai.less_active = '#373830'
      starry_monokai.active = '#4f4947'
      starry_monokai.line_numbers = '#A2AF93'
      starry_monokai.accent = '#A9AF83'
      starry_monokai.selection = '#696F43'
      starry_monokai.contrast = starry_monokai.less_active
      starry_monokai.comments = '#9E9F7D'
    end
    starry = vim.tbl_extend('force', starry, starry_monokai)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, monokai())
  elseif style_name == 'mariana' or style_name == 'mariana_lighter' then
    starry = vim.tbl_extend('force', starry, mariana_colors)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    local ma = vim.tbl_extend('force', starry, mariana())
    if style_name == 'mariana_lighter' then
      ma.bg = mariana_colors.blue5_day
      ma.fg = mariana_colors.white2
      ma.bg_alt = mariana_colors.blue2
      ma.less_active = mariana_colors.blueB
      ma.active = mariana_colors.blue7
      ma.line_numbers = mariana_colors.blue6
      ma.accent = ma.blueA
      ma.contrast = ma.less_active
    end
    starry = ma
  elseif style_name == 'emerald' then
    starry = vim.tbl_extend('force', starry, emerald_colors)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, emerald())
  elseif style_name == 'middlenight_blue' then
    starry = vim.tbl_extend('force', starry, middlenight_blue_colors)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, middlenight_blue())
  elseif style_name == 'dark_solar' then
    starry = vim.tbl_extend('force', starry, dark_solar_colors)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, dark_solar())
  elseif style_name == 'ukraine' then
    starry = vim.tbl_extend('force', starry, ukraine_colors)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, ukraine())
  elseif style_name == 'earlysummer' or style_name == 'earlysummer_lighter' then
    starry = vim.tbl_extend('force', starry, earlysummer_colors)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, earlysummer())
    if style_name == 'earlysummer_lighter' then
      starry.bg = '#292f3d'
      starry.bg_alt = '#353449'
      starry.less_active = '#212426'
      starry.active = '#30414F'
      starry.line_numbers = '#90A1AD'
      starry.accent = '#A0B1B0'
      starry.selection = '#607180'
      starry.comments = '#87AFB3'
      starry.contrast = starry.less_active
    end

    starry = vim.tbl_extend('force', starry, earlysummer())
  else
    starry = vim.tbl_extend('force', starry, starry_monokai)
    starry = vim.tbl_extend('force', starry, get_default(starry))
    starry = vim.tbl_extend('force', starry, monokai())
  end

  -- Optional colors

  -- Enable contrast sidebars, floating windows and popup menus
  if config.contrast.enable == false then
    starry.sidebar = starry.bg
    starry.floating = starry.bg
  else
    starry.sidebar = starry.bg_alt
    starry.floating = starry.bg_alt
  end

  if config.style.deep_black == true then
    starry.black = '#000000'
    local style = style_name
    if
      style == 'deep ocean'
      or style == 'darker'
      or style == 'moonlight'
      or style == 'middlenight_blue'
    then
      starry.bg = starry.black
    end
  end

  -- Set black titles for limestone style
  if style_name == 'limestone' then
    starry.title = starry.black
  else
    starry.title = starry.white
  end

  -- Apply user defined colors
  if type(config.custom_colors) ~= 'table' then
    error('Custom colors must be a table')
  end
  -- Iterate through the table
  for key, value in pairs(config.custom_colors) do
    -- If the key doesn't exist:
    if not starry[key] then
      error('Color ' .. key .. ' does not exist')
    end
    -- If it exists and the string starts with a "#"
    if string.sub(value, 1, 1) == '#' then
      -- Hex override
      starry[key] = value
      -- IF it doesn't, dont accept it
    else
      -- Another group
      if not starry[value] then
        error('Color ' .. value .. ' does not exist')
      end
      starry[key] = starry[value]
    end
  end

  starry_color_table = starry
  return starry
end

local function color_table()
  return starry_color_table
end

return { starry = starry_init, color_table = color_table, lighter_darker = LightenDarkenColorScheme }
