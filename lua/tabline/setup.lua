-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------

require'tabline.table'

local tabline = { -- internal tables {{{1
  closed_tabs = {},
  pinned = {},
}

tabline.v = { -- internal variables {{{1
  mode = 'auto',
  max_bufs = 10,
}

local settings = {  -- user settings {{{1
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

settings.icons = { -- icons {{{1
  ['pin'] =      '📌', ['star'] =   '★',   ['book'] =     '📖',  ['lock'] =    '🔒',
  ['hammer'] =   '🔨', ['tick'] =   '✔',   ['cross'] =    '✖',   ['warning'] = '⚠',
  ['menu'] =     '☰',  ['apple'] =  '🍎',  ['linux'] =    '🐧',  ['windows'] = '❖',
  ['git'] =      '',  ['git2'] =   '⎇ ',  ['palette'] =  '🎨',  ['lens'] =    '🔍',
  ['flag'] =     '⚑',  ['flag2'] =  '🏁',  ['fire'] =     '🔥',  ['bomb'] =    '💣',
  ['home'] =     '🏠', ['mail'] =   '✉ ',  ['disk'] =     '🖪 ',  ['arrow'] =   '➤',
  ['terminal'] = '',
  ['tab'] = {"📂", "📁"},
}

settings.indicators = { -- indicators {{{1
  ['modified'] = settings.no_icons and '[+]'  or '*',
  ['readonly'] = settings.no_icons and '[RO]' or '🔒',
  ['scratch'] = settings.no_icons and  '[!]'  or '✓',
  ['pinned'] = settings.no_icons and   '[^]'  or '[📌]',
}

-- }}}

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
