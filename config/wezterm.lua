-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.


-- or, changing the font size and color scheme.
-- config.font_size = 10
config.color_scheme = 'Gruvbox dark, medium (base16)'
config.window_background_opacity = 1
config.font = wezterm.font 'Hack Nerd Font Mono'
config.enable_tab_bar = false
config.audible_bell = 'Disabled'
config.enable_kitty_keyboard = true 
-- Finally, return the configuration to wezterm:
return config
