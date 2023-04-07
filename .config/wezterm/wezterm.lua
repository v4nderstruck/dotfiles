function ternary(cond, T, F)
  if cond then return T else return F end
end

-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local this_os = os.getenv("DOTFILES_OS")

-- maximize window on startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.color_scheme = 'Darcula (base16)'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = ternary(this_os == "MACOS", 14, 12)
config.audible_bell = "Disabled"
config.front_end = "WebGpu"
-- keybinds
config.keys = {
  {
    key = "P",
    mods = "SUPER",
    action = wezterm.action.ActivateCommandPalette
  }
}

-- wezterm starts loading from HOME directory
-- config.window_background_image = os.getenv("HOME") .. "/.config/wezterm/bladerunner.webm"
config.window_background_image = os.getenv( "HOME" ) .. "/.config/wezterm/media/bg-bladerunner49.jpg"
-- config.window_background_image = os.getenv( "HOME" ) .. "/.config/wezterm/media/bladerunner.gif"
config.window_background_image_hsb = {
  brightness = 0.35,
  hue = 1.0,
  saturation = 1.0,
}

-- and finally, return the configuration to wezterm
return config
