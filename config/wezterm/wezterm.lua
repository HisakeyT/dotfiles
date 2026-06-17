-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.color_scheme = "Tokyo Night Moon"
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
config.window_frame = {
	font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" }),
	font_size = 16,
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#222436"
	local foreground = "#828bb8"
	local edge_background = "none"

	if tab.is_active then
		background = "#3b4261"
		foreground = "#c8d3f5"
	elseif hover then
		background = "#2f334d"
		foreground = "#c8d3f5"
	end

	local edge_foreground = background

	local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "

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
