-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.color_scheme = 'Darcula (base16)'
config.font = wezterm.font("Hack Nerd Font")
config.disable_default_key_bindings = true
config.audible_bell = "Disabled"

-- config keybindings
config.keys = {
  {
    key = "t",
    mods = "CTRL",
    action = wezterm.action.SpawnTab "CurrentPaneDomain"
  },
  {
    key = "w",
    mods = "CTRL",
    action = wezterm.action.CloseCurrentTab{confirm=true} 
  },
}

-- wezterm starts loading from HOME directory
config.window_background_image = ".config/wezterm/bg-bladerunner49.jpg"
config.window_background_image_hsb = {
  brightness = 0.2,
  hue = 1.0,
  saturation = 1.0,
}

-- and finally, return the configuration to wezterm
return config
