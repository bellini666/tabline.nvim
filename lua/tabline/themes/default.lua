local fn = vim.fn
local printf = string.format

local t, fg, bg

local function mod(group)
  t = vim.o.termguicolors and 'gui' or 'cterm'
  fg = vim.o.termguicolors and '#ff6666' or '124'
  bg = fn.synIDattr(fn.synIDtrans(fn.hlID(group)), "bg")
  if bg == '' then
    return printf('%%s %sfg=%s %s=bold', t, fg, t)
  else
    return printf('%%s %sbg=%s %sfg=%s %s=bold', t, bg, t, fg, t)
  end
end

local function dim(group)
  t = vim.o.termguicolors and 'gui' or 'cterm'
  if vim.o.termguicolors then
    fg = vim.o.background == 'dark' and '#6c6c6c' or '#a9a9a9'
  else
    fg = vim.o.background == 'dark' and '242' or '248'
  end
  bg = fn.synIDattr(fn.synIDtrans(fn.hlID(group)), "bg")
  if bg == '' then
    return printf('%%s %sfg=%s %s=none', t, fg, t)
  else
    return printf('%%s %sbg=%s %sfg=%s %s=none', t, bg, t, fg, t)
  end
end

local function sep(group)
  t = vim.o.termguicolors and 'gui' or 'cterm'
  if vim.o.termguicolors then
    fg = vim.o.background == 'dark' and '#5f87af' or '#4a679a'
  else
    fg = vim.o.background == 'dark' and '67' or '7'
  end
  bg = fn.synIDattr(fn.synIDtrans(fn.hlID(group)), "bg")
  if bg == '' then
    return printf('%%s %sfg=%s %s=none', t, fg, t)
  else
    return printf('%%s %sbg=%s %sfg=%s %s=none', t, bg, t, fg, t)
  end
end

local function theme()
  return {
    name = 'default',

    TSelect =     'link %s Pmenu',
    TVisible =    'link %s Special',
    THidden =     'link %s Comment',
    TExtra =      'link %s Title',
    TSpecial =    'link %s PmenuSel',
    TFill =       'link %s Folded',
    TNumSel =     'link %s CursorLine',
    TNum =        'link %s CursorLine',
    TCorner =     'link %s Special',
    TSelectMod =  mod('Pmenu'),
    TVisibleMod = mod('Special'),
    THiddenMod =  mod('Comment'),
    TExtraMod =   mod('Title'),
    TSelectDim =  dim('Pmenu'),
    TSpecialDim = dim('PmenuSel'),
    TVisibleDim = dim('Special'),
    THiddenDim =  dim('Comment'),
    TExtraDim =   dim('Title'),
    TSelectSep =  sep('Pmenu'),
    TSpecialSep = dim('PmenuSel'),
    TVisibleSep = dim('Special'),
    THiddenSep =  dim('Comment'),
    TExtraSep =   dim('Title'),
}
end

return { theme = theme, mod = mod, dim = dim, sep = sep }
