### tabline.nvim

Add to your vimrc (or run in command line):

    lua require'tabline.setup'.setup()

to load plugin with default settings. If you want default mappings, also add:

    lua require'tabline.setup'.mappings(true)

If you want to customize the settings, execute:

    :Tabline config

General documentation:

    :help tabline-nvim

Consult `:help tnv-settings` to understand the meaning of the different
settings.
