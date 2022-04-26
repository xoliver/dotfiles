HYPER = {"ctrl", "alt", "cmd", "shift"}
col = hs.drawing.color.x11

hs.loadSpoon("SpoonInstall")
-- Install CLI tool (hs)
hs.ipc.cliInstall("/opt/homebrew")

spoon.SpoonInstall.repos.ShiftIt = {
    url = "https://github.com/peterklijn/hammerspoon-shiftit",
    desc = "ShiftIt spoon repository",
    branch = "master"
}
spoon.SpoonInstall:andUse(
    "ShiftIt",
    {
        repo = "ShiftIt",
        hotkeys = {
            left = {HYPER, "left"},
            right = {HYPER, "right"},
            up = {HYPER, "up"},
            down = {HYPER, "down"},
            upleft = {HYPER, "1"},
            upright = {HYPER, "2"},
            botleft = {HYPER, "3"},
            botright = {HYPER, "4"},
            maximum = {HYPER, "m"},
            toggleFullScreen = {HYPER, "f"},
            nextScreen = {HYPER, "n"},
            previousScreen = {HYPER, "p"},
            resizeOut = {HYPER, "="},
            resizeIn = {HYPER, "-"},
        },
    }
)

spoon.SpoonInstall:andUse(
    "AppLauncher",
    {
        config = {
            modifiers = HYPER
        },
        hotkeys = {
            u = "Google Chrome",
            i = "iTerm",
            o = "Slack",
            ["]"] = "Spotify",
            ["["] = "Notion",
        }
    }
)

spoon.SpoonInstall:andUse(
    "Emojis",
    {
        hotkeys = {
            toggle = {HYPER, "j"},
        }
    }
)

spoon.SpoonInstall:andUse(
    "MicMute",
    {
        hotkeys = {
            toggle = {HYPER, "q"},
        }
    }
)

-- From https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/
spoon.SpoonInstall:andUse(
    "MenubarFlag",
    {
        config = {
            colors = {
                ["British - PC"] = {},
                ["Catalan"] = {
                    col.yellow,
                    col.red,
                    col.yellow,
                    col.red,
                    col.yellow,
                    col.red,
                    col.yellow,
                    col.red,
                    col.yellow
                },
                ["Pinyin - Simplified"] = {col.red},
                ["Greek"] = {col.blue, col.white, col.blue}
            },
            allScreens = true,
            indicatorAlpha = 0.25
        },
        start = true
    }
)

-- From https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/
spoon.SpoonInstall:andUse(
    "FadeLogo",
    {
        config = {
            default_run = 1.0
        },
        start = true
    }
)

-- Bring Bitwarden to front and focus on the search field
-- From https://community.bitwarden.com/t/hotkey-to-vault-search-field/9555/7
function launch_bitwarden_search()
    hs.application.launchOrFocus("Bitwarden")
    local app = hs.appfinder.appFromName("Bitwarden")
    if (app ~= nil) then
        local activated = app:activate(true)
        if (activated) then
            -- for Dock icon mode
            app:selectMenuItem({"View", "Search vault"})
            -- for menubar item mode
            hs.eventtap.keyStroke({"cmd"}, "f")
        else
            hs.alert.show("😕 Unable to activate Bitwarden app")
        end
    else
        hs.alert.show("😕 Bitwarden app not found")
    end
end
hs.hotkey.bind(HYPER, "y", launch_bitwarden_search)

function go_lunch()
  hs.application.launchOrFocus("Slack")
  local app = hs.appfinder.appFromName("Slack")
  if (app ~= nil) then
      local activated = app:activate(true)
      if (activated) then
          -- for Dock icon mode
          -- app:selectMenuItem({"View", "Search vault"})
          -- for menubar item mode
          hs.eventtap.keyStroke({"cmd"}, "1")
          hs.eventtap.keyStroke({"shift", "cmd"}, "y")
          hs.eventtap.keyStrokes("Lunching")
          hs.eventtap.keyStroke({"shift"}, "tab")
          hs.eventtap.keyStroke({}, "return")
          -- hs.timer.usleep(1000000)
          hs.eventtap.keyStrokes("pizza")
          hs.eventtap.keyStroke({}, "return")
          hs.eventtap.keyStroke({"cmd"}, "return")
      else
          hs.alert.show("😕 Unable to activate Slack app")
      end
  else
      hs.alert.show("😕 Slack app not found")
  end
end
hs.hotkey.bind(HYPER, "l", go_lunch)


mi=hs.midi.new("MPK mini")
-- mi:callback(function(object, deviceName, commandType, description, metadata)
--     print("object: " .. tostring(object))
--     print("deviceName: " .. deviceName)
--     print("commandType: " .. commandType)
--     print("description: " .. description)
--     print("metadata: " .. hs.inspect(metadata))
--   end)