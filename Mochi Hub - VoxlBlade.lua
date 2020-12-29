-- Mochi Hub - VoxlBlade
local MochiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/ChitogeKazuto/Scripts/main/Ui%20Venyx.lua"))()
local Mochi = MochiLibrary.new("Mochi Hub - VoxlBlade", 0)

-- LocalPlayerPage
local LocalPlayerPage = Mochi:addPage("VB - LP", 4384401919)
local LocalPlayerSection = LocalPlayerPage:addSection("LocalPlayer") -- LocalPlayerSection

LocalPlayerSection:addTextbox("WalkSpeed", 16, function(Value)
    local Speed = Value
    local oldmt = getrawmetatable(game)
    local oldnc = oldmt.__namecall
    local oldidx = oldmt.__index
    setreadonly(oldmt,false)
    local uis = game:GetService("UserInputService")
    oldmt.__index = function(...)
       if ({...})[2] == 'Kick' then
           return function() while wait() do end end
       end
       if ({...})[2] == 'WalkSpeed' then
           return (uis:IsKeyDown(Enum.KeyCode.LeftShift) and Speed) or 16
       end
       return oldidx(...)
    end
    oldmt.__namecall = function(...)
      if getnamecallmethod() == 'Kick' then
           return function() while wait() do end end
           end
       return oldnc(...)
    end
end)
local flyjump
LocalPlayerSection:addToggle("Fly Jump", false, function(Value)
    if Value == true then
	if flyjump then flyjump:Disconnect() end
	flyjump = game:GetService("UserInputService").JumpRequest:Connect(function(Jump)
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end)
else
    if flyjump then flyjump:Disconnect() end
end
end)

LocalPlayerSection:addToggle("No Clip", false, function(Value)
    noclip = true 
    game:GetService('RunService').Stepped:connect(function()
        if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end
        end)
    if Value == true then
        noclip = true
    else
        noclip = false 
    end
    end)

local TeleportSection = LocalPlayerPage:addSection("Teleport") -- TeleportSection

local TPLAYER = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(TPLAYER, v.Name)
    end
TeleportSection:addDropdown("Method", {"Instant", "Tween"}, function(Value)
       _G.TPInfo = Value
end)
TeleportSection:addDropdown("Teleport To Player", TPLAYER, function(Value)
    if _G.TPInfo == "Instant" then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Value].Character.HumanoidRootPart.CFrame
    else
local TweenService = game:GetService("TweenService")
local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
local info = TweenInfo.new(8, Enum.EasingStyle.Linear)
local g = {}
g.CFrame = game:GetService("Players")[Value].Character.HumanoidRootPart.CFrame + Vector3.new(3,1,0)

local Tween = TweenService:Create(HRP, info, g)
Tween:Play()
end
end)

-- VB - Misc
local VBMiscPage = Mochi:addPage("VB - Misc", 4483362458)
local VBMiscSection = VBMiscPage:addSection("Misc")

VBMiscSection:addToggle("Auto Attack", false, function(Value)
_G.AutoAttack = Value
    while _G.AutoAttack do wait()
        local A_1 = "LL"
        local Event = game:GetService("ReplicatedStorage").Events.Event1
        Event:InvokeServer(A_1)
    end
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

UniversalScriptsSection:addButton("FullBright", function()
	game:GetService("Lighting").Brightness = 2
	game:GetService("Lighting").ClockTime = 14
	game:GetService("Lighting").FogEnd = 100000
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)

UniversalScriptsSection:addButton("No Fog", function()
    game:GetService("Lighting").FogEnd = 100000
end)

local AdminScriptsSection = ScriptsPage:addSection("Admin Scripts") -- UniversalScriptsSection

AdminScriptsSection:addButton("Infinite Yield", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

AdminScriptsSection:addButton("CMD X", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
end)

AdminScriptsSection:addButton("Reviz", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/ibFPdiF7'),true))()
end)

-- Misc
local MiscPage = Mochi:addPage("Misc", 3944704135)
local ZoomSection = MiscPage:addSection("Zoom") -- ZoomSection
ZoomSection:addSlider("Zoom", game:GetService("Players").LocalPlayer.CameraMaxZoomDistance, 0, 10000, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)

local PlayerInfoSection = MiscPage:addSection("Player Info") -- PlayerInfoSection
PlayerInfoSection:addButton("Player Name : "..game:GetService("Players").LocalPlayer.Name, function()end)
PlayerInfoSection:addButton("Player ID : "..game:GetService("Players").LocalPlayer.UserId, function()end)

-- Settings
local SettingsPage = Mochi:addPage("Settings", 4483345737)
local GUISection = SettingsPage:addSection("GUI") -- GUISection

GUISection:addKeybind("Toggle Keybind", Enum.KeyCode.RightControl, function()
    Mochi:toggle()
end)

GUISection:addButton("Destroy Gui", function()
    game:GetService("CoreGui")["Mochi Hub - VoxlBlade"]:Destroy()
end)

Mochi:SelectPage(Mochi.pages[1], true)