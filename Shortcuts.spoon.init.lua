--- === Shortcuts ===
---
--- Let users choose random shortcuts name/content
local obj = {}
obj.__index = obj

-- luacheck: globals utf8

-- Metadata
obj.name = "Shortcuts"
obj.version = "1.0"
obj.author = "Me"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal function used to find our location, so we know where to load files from

obj.choices = {}
obj.chooser = nil
obj.hotkey = nil

local wf = hs.window.filter.defaultCurrentSpace

function obj.callback(choice)
    local lastFocused = wf:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then
        lastFocused[1]:focus()
    end
    if not choice then
        return
    end
    hs.eventtap.keyStrokes(choice.text) -- luacheck: ignore
end

function obj:init()
    -- is the emojis file available?
    print("Starting Shortcuts Spoon...")

	local file = io.open(hs.spoons.scriptPath() .. "../../shortcuts.csv", "r")
	local content = file:read("*all")
	file:close()

	local choices = {}
	for line in content:gmatch("([^\n]*)\n?") do
	  local email, name = line:match("([^,]+),([^,]+)")
	  table.insert(
		choices,
        {
            ["text"] = email,
            ["subText"] = name
        }
	  )
	end

	self.choices = choices

	self.chooser = hs.chooser.new(self.callback)
    self.chooser:rows(3)
    self.chooser:searchSubText(true)
    self.chooser:choices(self.choices)
    print("Shortcuts Spoon: Startup completed")
end

--- Shortcuts:bindHotkeys(mapping) -- ripped off from emojis
--- Method
--- Binds hotkeys for Emojis
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * toggle - This will toggle the emoji chooser
---
--- Returns:
---  * The Emojis object
function obj:bindHotkeys(mapping)
    if self.hotkey then
        self.hotkey:delete()
    end
    local toggleMods = mapping["toggle"][1]
    local toggleKey = mapping["toggle"][2]

    self.hotkey =
        hs.hotkey.new(
        toggleMods,
        toggleKey,
        function()
            if self.chooser:isVisible() then
                self.chooser:hide()
            else
                self.chooser:show()
            end
        end
    ):enable()

    return self
end

return obj
