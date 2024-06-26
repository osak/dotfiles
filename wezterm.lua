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

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Latte'

config.default_domain = 'WSL:Ubuntu'
config.font = wezterm.font_with_fallback {
  'Hack Nerd Font',
  'Source Han Code JP'
}
config.font_size = 11

config.keys = {
  {
      key = '1',
      mods = 'ALT|CTRL',
      action = wezterm.action.SpawnCommandInNewTab { domain = { DomainName = 'local' }, args = { 'powershell' } },
  },
  {
      key = '2',
      mods = 'ALT|CTRL',
      action = wezterm.action.SpawnTab { DomainName = 'WSL:Ubuntu' },
  },
}
config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config
