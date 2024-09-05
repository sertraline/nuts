local wezterm = require 'wezterm'
local config = wezterm.config_builder()

wezterm.on('switch-to-left', function(window, pane)
    local tab = window:mux_window():active_tab()

    if tab:get_pane_direction 'Left' ~= nil then
        window:perform_action(wezterm.action.ActivatePaneDirection 'Left', pane)
    else
        window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
    end
end)

wezterm.on('switch-to-right', function(window, pane)
    local tab = window:mux_window():active_tab()

    if tab:get_pane_direction 'Right' ~= nil then
        window:perform_action(
            wezterm.action.ActivatePaneDirection 'Right',
            pane
        )
    else
        window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
    end
end)

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

config.keys = {
    {
        key = 'h',
        mods = 'ALT',
        action = wezterm.action.EmitEvent 'switch-to-left',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.EmitEvent 'switch-to-right',
    },
}

return config
