local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = 'Gruvbox dark, medium (base16)'
config.font = wezterm.font("JetBrainsMonoNL NF", {weight = "Bold"})
config.font_size = 13

config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0
}

return config
