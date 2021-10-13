-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------

require'tabline.table'

-- table for internal stuff
local tabline = {
  closed_tabs = {},
  pinned = {},
}

-- internal variables
tabline.v = {
  mode = 'auto',
  max_bufs = 10,
}

-- user settings
local settings = {
  filtering = true,
  show_right_corner = true,
  tab_number_in_left_corner = true,
  actual_buffer_number = false,
  dim_inactive_icons = true,
  tabs_full_path = false,
  mode_labels = 'secondary',
  modes = { 'auto', 'buffers', 'args' },
  scratch_label = '[Scratch]',
  unnamed_label = '[Unnamed]',
}

settings.icons = {
  ['pin'] =      '📌', ['star'] =   '★',   ['book'] =     '📖',  ['lock'] =    '🔒',
  ['hammer'] =   '🔨', ['tick'] =   '✔',   ['cross'] =    '✖',   ['warning'] = '⚠',
  ['menu'] =     '☰',  ['apple'] =  '🍎',  ['linux'] =    '🐧',  ['windows'] = '❖',
  ['git'] =      '',  ['git2'] =   '⎇ ',  ['palette'] =  '🎨',  ['lens'] =    '🔍',
  ['flag'] =     '⚑',  ['flag2'] =  '🏁',  ['fire'] =     '🔥',  ['bomb'] =    '💣',
  ['home'] =     '🏠', ['mail'] =   '✉ ',  ['disk'] =     '🖪 ',  ['arrow'] =   '➤',
  ['terminal'] = '',
  ['tab'] = {"📂", "📁"},
}

settings.indicators = {
  ['modified'] = settings.no_icons and '[+]'  or '*',
  ['readonly'] = settings.no_icons and '[RO]' or '🔒',
  ['scratch'] = settings.no_icons and  '[!]'  or '✓',
  ['pinned'] = settings.no_icons and   '[^]'  or '[📌]',
}

local function setup(sets)
  if not tabline.buffers then
    require'tabline.bufs'.init_bufs()
  end
  if not tabline.tabs then
    require'tabline.tabs'.init_tabs()
  end
  for k, v in pairs(sets or {}) do
    settings[k] = v
  end
end

return {
  setup = setup,
  tabline = tabline,
  settings = settings,
}
