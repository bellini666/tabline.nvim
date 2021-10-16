local v = require'tabline.setup'.tabline.v
local s = require'tabline.setup'.settings

-- vim functions {{{1
local tabpagenr = vim.fn.tabpagenr
local tabpagebuflist = vim.fn.tabpagebuflist
local gettabvar = vim.fn.gettabvar

-- table functions {{{1
local tbl = require'tabline.table'
local remove = table.remove
local concat = table.concat
local insert = table.insert
local index = tbl.index
local filter = tbl.filter
local filternew = tbl.filternew
local slice = tbl.slice
local map = tbl.map
--}}}

local printf = string.format

local short_cwd = require'tabline.render.paths'.short_cwd
local tab_mod_flag = require'tabline.render.tabline'.tab_mod_flag
local get_tab = require'tabline.tabs'.get_tab
local tabs_mode = require'tabline.helpers'.tabs_mode

local hide_tab_number = function() return tabpagenr('$') == 1 or s.tab_number_in_left_corner end

local format_right_corner, right_corner_icon, right_corner_label, mode_label

--------------------------------------------------------------------------------
-- Corner labels
--------------------------------------------------------------------------------

function format_right_corner()
  -- Label for the upper right corner.
  local N = tabpagenr()

  if (vim.t.tab or get_tab()).corner then
    return vim.t.tab.corner

  elseif not s.show_right_corner then
    return ''

  else
    local hi    = '%#TCorner#'
    local icon  = '%#TNumSel# ' .. right_corner_icon(N)
    local mod   = tab_mod_flag(N, true)
    local label = right_corner_label(N)
    return printf('%s%s %s %s', icon, hi, label, mod)
  end
end --}}}

-------------------------------------------------------------------------------
-- The icon for the right corner label
--
-- @param tnr: the tab number
-- Return the icon
-------------------------------------------------------------------------------
function right_corner_icon(tnr)
  local T, icon = gettabvar(tnr, 'tab'), s.icons.tab
  if T.icon then
    return T.icon .. ' '
  end
  return not icon and ''
         or type(icon) == 'string' and icon .. ' '
         or icon[tnr == tabpagenr() and 1 or 2] .. ' '
end


-------------------------------------------------------------------------------
-- Label for the right corner
--
-- The label can be either:
-- 1. the shortened cwd ('tabs' and 'buffers' mode)
-- 2. a custom tab name ('buffers' mode)
-- 3. the name of the active buffer for this tab ('buffers' mode) TODO?
-- 4. the number/total files in the arglist ('args' mode) TODO?
-------------------------------------------------------------------------------
function right_corner_label(N)
  return tabs_mode() and short_cwd(N) or vim.t.tab.name or short_cwd(N)
end

-------------------------------------------------------------------------------
-- Label for left corner
--
-- It's the tabline mode, and it's only shown under certain conditions.
-------------------------------------------------------------------------------
function mode_label()
  local labels = s.mode_labels
  if labels == 'none' or
        labels == 'secondary' and index(s.modes, v.mode) == 1 or
        labels ~= 'all' and labels ~= 'secondary' and not string.find(labels, v.mode) then
    return ''
  else
    return printf('%%#TExtra# %s %%#TFill# ', v.mode)
  end
end


return {
  format_right_corner = format_right_corner,
  right_corner_label = right_corner_label,
  mode_label = mode_label,
}

