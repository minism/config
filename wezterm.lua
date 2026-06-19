local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
config.color_scheme = 'Horizon Dark (base16)'

config.font = wezterm.font("JetBrainsMonoNL NF", {weight = "Regular"})
config.font_size = 13
-- config.font = wezterm.font_with_fallback { 'TamzenForPowerline' }

config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0
}

config.window_background_gradient = {
    orientation = 'Vertical',
    --orientation = {
    --    Linear = { angle = -45.0 }
    --},
    colors = {
        '#181e27',
        '#11161c',
    },
    noise = 64,
}

config.window_background_opacity = 0.9


-- Random bg

local function get_homedir()
    -- Check Unix/Linux/macOS first, then fall back to Windows
    local home = os.getenv("HOME") or os.getenv("USERPROFILE")
    return home
end

local function bgpath(file)
    return get_homedir() .. "/Pictures/Wallpaper/term/" .. file
end

local bgs = {
    bgpath('wallhaven-zme67y.jpg')
}

wezterm.on('window-config-reloaded', function(window, pane)
  -- If there are no overrides, this is our first time seeing
  -- this window, so we can pick a random bg.
  if not window:get_config_overrides() then
    -- Pick a random scheme name
    local bg = bgs[math.random(#bgs)]
--    window:set_config_overrides {
--        window_background_image = bg,
--    }
  end
end)

return config
