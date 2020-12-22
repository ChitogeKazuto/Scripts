-- Mochi Hub - Universal
local MochiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/ChitogeKazuto/Scripts/main/Ui%20Venyx.lua"))()
local Mochi = MochiLibrary.new("Mochi Hub - Universal", 0)

-- LocalPlayerPage
local LocalPlayerPage = Mochi:addPage("LocalPlayer", 4384401919)
local LocalPlayerSection = LocalPlayerPage:addSection("LocalPlayer") -- LocalPlayerSection

LocalPlayerSection:addSlider("WalkSpeed", game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed, 0, 300, function(Value)
    if game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed <= Value then
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
end)
LocalPlayerSection:addSlider("JumpPower", game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower, 0, 300, function(Value)
    if game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower <= Value then
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Value
    end
end)

local TeleportSection = LocalPlayerPage:addSection("Teleport") -- TeleportSection

local TPLAYER = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(TPLAYER, v.Name)
    end
TeleportSection:addDropdown("Teleport To Player", TPLAYER, function(Value)
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Value].Character.HumanoidRootPart.CFrame
end)

-- Scripts
local ScriptsPage = Mochi:addPage("Scripts", 4370341699)
local UniversalScriptsSection = ScriptsPage:addSection("Universal Scripts") -- UniversalScriptsSection

UniversalScriptsSection:addButton("Ctrl+Click TP", function()
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse() 
    Mouse.Button1Down:connect(function()
        if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
            if not Mouse.Target then return end
        Plr.Character:MoveTo(Mouse.Hit.p)
        end)
end)

local AdminScriptsSection = ScriptsPage:addSection("Admin Scripts") -- UniversalScriptsSection

AdminScriptsSection:addButton("Infinite Yield", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

AdminScriptsSection:addButton("Reviz", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/ibFPdiF7'),true))()
end)

-- Settings
local SettingsPage = Mochi:addPage("Settings", 4483345737)
local GUISection = SettingsPage:addSection("GUI") -- GUISection

GUISection:addKeybind("Toggle Keybind", Enum.KeyCode.RightControl, function()
    Mochi:toggle()
end)

GUISection:addButton("Destroy Gui", function()
    game:GetService("CoreGui")["Mochi Hub - Universal"]:Destroy()
end)

Mochi:SelectPage(Mochi.pages[1], true)