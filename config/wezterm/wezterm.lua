-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
-- config.color_scheme = "GitHub Dark"
config.char_select_bg_color = "#282A36"
config.char_select_fg_color = "#F8F8F2"
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12.0
config.use_ime = true

config.initial_cols = 160
config.initial_rows = 45
config.scrollback_lines = 100000

-- config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.tab_max_width = 100

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

----------------------------------------------------
-- keybinds
----------------------------------------------------
local keybinds = require("keybinds")
config.disable_default_key_bindings = false
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.leader = keybinds.leader

return config
