hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.ShiftIt = {
   url = "https://github.com/peterklijn/hammerspoon-shiftit",
   desc = "ShiftIt spoon repository",
   branch = "master",
}
spoon.SpoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })
spoon.ShiftIt:bindHotkeys({
    left = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'left' },
    right = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'right' },
    up = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'up' },
    down = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'down' },
    upleft = {{ 'ctrl', 'alt', 'cmd', 'shift' }, '1' },
    upright = {{ 'ctrl', 'alt', 'cmd', 'shift' }, '2' },
    botleft = {{ 'ctrl', 'alt', 'cmd', 'shift' }, '3' },
    botright = {{ 'ctrl', 'alt', 'cmd', 'shift' }, '4' },
    maximum = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'm' },
    toggleFullScreen = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'f' },
    nextScreen = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'n' },
    previousScreen = {{ 'ctrl', 'alt', 'cmd', 'shift' }, 'p' },
    resizeOut = {{ 'ctrl', 'alt', 'cmd', 'shift' }, '=' },
    resizeIn = {{ 'ctrl', 'alt', 'cmd', 'shift' }, '-' },
  });

spoon.SpoonInstall:andUse("AppLauncher", {
	config = {
	  modifiers = {"ctrl", "alt", "cmd", "shift"},
	},
  hotkeys = {
	  u = "Google Chrome",
	  i = "iTerm",
	  o = "Slack",
	  ["]"] = "Spotify",
  },
});
