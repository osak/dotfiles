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

config.default_prog = { 'zsh', '-l' }

config.font = wezterm.font_with_fallback {
  'Moralerspace Argon'
}
config.font_size = 12

config.leader = { key = 'k', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
      key = 'c',
      mods = 'LEADER',
      action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
   -- Leader + " で水平分割
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Leader + % で垂直分割
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },

  -- Leader + h/j/k/l でペイン移動
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left', },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down', },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up', },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right', },

  { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0), },
  { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1), },
  { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2), },
  { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3), },
  { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4), },
  { key = '6', mods = 'LEADER', action = wezterm.action.ActivateTab(5), },
  { key = '7', mods = 'LEADER', action = wezterm.action.ActivateTab(6), },
  { key = '8', mods = 'LEADER', action = wezterm.action.ActivateTab(7), },
  { key = '9', mods = 'LEADER', action = wezterm.action.ActivateTab(8), },

  -- 検索
  { key = '?', mods = 'LEADER|SHIFT', action = wezterm.action.Search {CaseSensitiveString=""}, },
  -- コピー
  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode, },

  -- 前のプロンプトへ
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollToPrompt(-1) },
  -- 次のプロンプトへ  
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollToPrompt(1) },
}
config.audible_bell = "Disabled"

local copy_mode_additional_keys = {
  { key = 'k', mods = 'SHIFT', action = wezterm.action.CopyMode { MoveBackwardZoneOfType = 'Output' } },
  { key = 'j', mods = 'SHIFT', action = wezterm.action.CopyMode { MoveForwardZoneOfType = 'Output' } },
  { key = 'k', mods = 'SHIFT|CTRL', action = wezterm.action.CopyMode { MoveBackwardZoneOfType = 'Prompt' } },
  { key = 'j', mods = 'SHIFT|CTRL', action = wezterm.action.CopyMode { MoveForwardZoneOfType = 'Prompt' } },
  { key = '[', mods = 'CTRL', action = wezterm.action.CopyMode 'Close' },
  { key = '/', mods = 'NONE', action = wezterm.action.Search {CaseSensitiveString=""}, },
  -- W: vimのW (WORD移動) と同じ動作
  { key = 'w', mods = 'SHIFT', action = wezterm.action.CopyMode 'MoveForwardWord' },
}

local copy_mode = wezterm.gui.default_key_tables().copy_mode
for _, key in ipairs(copy_mode_additional_keys) do
  table.insert(copy_mode, key)
end

local search_mode_additional_keys = {
  { key = '[', mods = 'CTRL', action = wezterm.action.CopyMode 'AcceptPattern' },
}
local search_mode = wezterm.gui.default_key_tables().search_mode
for _, key in ipairs(search_mode_additional_keys) do
  table.insert(search_mode, key)
end


config.key_tables = {
  copy_mode = copy_mode,
  search_mode = search_mode,
}

-- and finally, return the configuration to wezterm
return config
