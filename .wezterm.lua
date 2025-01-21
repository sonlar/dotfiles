-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.keys = {
	-- CTRL + 1-3 to activate that pane
	{ key = "1", mods = "CTRL", action = act.ActivatePaneByIndex(0) },
	{ key = "2", mods = "CTRL", action = act.ActivatePaneByIndex(1) },
	{ key = "3", mods = "CTRL", action = act.ActivatePaneByIndex(2) },
	-- Create a new tab in the same domain as the current pane.
	{
		key = "t",
		mods = "CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	-- Close current pane
	{
    		key = 'w',
    		mods = 'CTRL',
   		action = wezterm.action.CloseCurrentPane { confirm = true },
  	},
	-- Create new pane horizontally
	{
		key = "!",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Create new pane vertically
	{
		key = '"',
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

for i = 1, 8 do
	-- ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font("FiraCode Nerd Font")
-- and finally, return the configuration to wezterm
return config
