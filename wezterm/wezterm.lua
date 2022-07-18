local wezterm = require 'wezterm';
return {
  font = wezterm.font("JetBrains Mono"),
  font_size = 12,
  window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
  },
  hide_tab_bar_if_only_one_tab = true,

  window_background_opacity = 0.7,
  -- window_background_image = "../../Downloads/blackhole_placeholder.jpg",
  --window_background_image = "../../Downloads/cyberpunk-city-buildings-art.jpg",
  colors = {
    -- foreground = 'yellow',
    -- The default background color
    -- foreground = "hsl:235 100 50",
    background = 'rgba(0,0,0,0.5)',
    -- background = "rgba(188,66,245,0.9)",
  }

}
