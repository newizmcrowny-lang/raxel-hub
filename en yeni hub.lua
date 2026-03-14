local p=game:GetService("Players").LocalPlayer
local UIS=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")

local KEY_URL="https://pastebin.com/raw/fsZ7rBWj"

local blur=Instance.new("BlurEffect",Lighting)
blur.Size=15

local function checkKey(input)
local ok,res=pcall(function()
return game:HttpGet(KEY_URL)
end)

if ok and res then
for key in string.gmatch(res,"[^\r\n]+") do
if input==key then
return true
end
end
end

return false
end

local gui=Instance.new("ScreenGui",p.PlayerGui)

local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,360,0,220)
frame.Position=UDim2.new(0.5,-180,0.5,-110)
frame.BackgroundColor3=Color3.fromRGB(20,20,20)
Instance.new("UICorner",frame)

local title=Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,0,0,40)
title.BackgroundTransparency=1
title.Text="RAXEL HUB"
title.Font=Enum.Font.GothamBlack
title.TextColor3=Color3.new(1,1,1)
title.TextSize=24

local box=Instance.new("TextBox",frame)
box.Size=UDim2.new(0.8,0,0,40)
box.Position=UDim2.new(0.1,0,0.45,0)
box.PlaceholderText="Enter Key"
box.BackgroundColor3=Color3.fromRGB(40,40,40)
box.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",box)

local enter=Instance.new("TextButton",frame)
enter.Size=UDim2.new(0.8,0,0,40)
enter.Position=UDim2.new(0.1,0,0.75,0)
enter.Text="ENTER"
enter.Font=Enum.Font.GothamBold
enter.TextSize=18
enter.BackgroundColor3=Color3.fromRGB(0,170,255)
enter.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",enter)

local function loadHub()

local hub=Instance.new("ScreenGui",p.PlayerGui)

local main=Instance.new("Frame",hub)
main.Size=UDim2.new(0,780,0,500)
main.Position=UDim2.new(0.5,-390,0.5,-250)
main.BackgroundColor3=Color3.fromRGB(18,18,18)
Instance.new("UICorner",main)

-- HEADER
local header=Instance.new("Frame",main)
header.Size=UDim2.new(1,0,0,50)
header.BackgroundColor3=Color3.fromRGB(25,25,25)

local hubTitle=Instance.new("TextLabel",header)
hubTitle.Size=UDim2.new(1,0,1,0)
hubTitle.BackgroundTransparency=1
hubTitle.Text="RAXEL HUB"
hubTitle.Font=Enum.Font.GothamBlack
hubTitle.TextColor3=Color3.new(1,1,1)
hubTitle.TextSize=26

-- CLOSE
local close=Instance.new("TextButton",header)
close.Size=UDim2.new(0,50,1,0)
close.Position=UDim2.new(1,-50,0,0)
close.Text="X"
close.Font=Enum.Font.GothamBold
close.TextSize=20
close.BackgroundTransparency=1
close.TextColor3=Color3.new(1,1,1)

close.MouseButton1Click:Connect(function()
hub:Destroy()
blur:Destroy()
end)

-- MINIMIZE
local minimize=Instance.new("TextButton",header)
minimize.Size=UDim2.new(0,50,1,0)
minimize.Position=UDim2.new(1,-100,0,0)
minimize.Text="-"
minimize.Font=Enum.Font.GothamBold
minimize.TextSize=24
minimize.BackgroundTransparency=1
minimize.TextColor3=Color3.new(1,1,1)

local minimized=false
minimize.MouseButton1Click:Connect(function()
minimized=not minimized
for _,v in pairs(main:GetChildren()) do
if v~=header then
v.Visible=not minimized
end
end
end)

-- DRAG
local dragging=false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
dragStart=input.Position
startPos=main.Position
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
local delta=input.Position-dragStart
main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)

header.InputEnded:Connect(function()
dragging=false
end)

-- SIDEBAR
local sidebar=Instance.new("Frame",main)
sidebar.Size=UDim2.new(0,180,1,-50)
sidebar.Position=UDim2.new(0,0,0,50)
sidebar.BackgroundColor3=Color3.fromRGB(22,22,22)

-- CONTENT
local content=Instance.new("Frame",main)
content.Size=UDim2.new(1,-180,1,-50)
content.Position=UDim2.new(0,180,0,50)
content.BackgroundTransparency=1

local scriptsPage=Instance.new("Frame",content)
scriptsPage.Size=UDim2.new(1,0,1,0)
scriptsPage.BackgroundTransparency=1

local settingsPage=Instance.new("Frame",content)
settingsPage.Size=UDim2.new(1,0,1,0)
settingsPage.Visible=false
settingsPage.BackgroundTransparency=1

-- SIDEBAR BUTTON
local function sideButton(name,pos,page)

local b=Instance.new("TextButton",sidebar)
b.Size=UDim2.new(1,-20,0,40)
b.Position=UDim2.new(0,10,0,pos)
b.Text=name
b.Font=Enum.Font.GothamBold
b.TextSize=18
b.BackgroundColor3=Color3.fromRGB(35,35,35)
b.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",b)

b.MouseButton1Click:Connect(function()
scriptsPage.Visible=false
settingsPage.Visible=false
page.Visible=true
end)

end

sideButton("Scripts",40,scriptsPage)
sideButton("Settings",90,settingsPage)

-- SCRIPT BUTTONS
local function button(name,pos,func)

local b=Instance.new("TextButton",scriptsPage)
b.Size=UDim2.new(0,320,0,70)
b.Position=UDim2.new(0,60,0,pos)
b.Text=name
b.Font=Enum.Font.GothamBlack
b.TextSize=24
b.TextColor3=Color3.new(1,1,1)
b.BackgroundColor3=Color3.fromRGB(40,40,40)

Instance.new("UICorner",b)

local gradient=Instance.new("UIGradient",b)

task.spawn(function()
while true do
for i=0,1,0.01 do
gradient.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromHSV(i,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromHSV(i+0.25,1,1))
}
task.wait()
end
end
end)

b.MouseButton1Click:Connect(func)

end

button("Script 1",60,function()
loadstring(game:HttpGet("https://pastebin.com/raw/auSLpuqi"))()
end)

button("Script 2",150,function()

local PPS=game:GetService("ProximityPromptService")
local UIS=game:GetService("UserInputService")
local active=false

UIS.InputBegan:Connect(function(i,g)
if not g and i.KeyCode==Enum.KeyCode.F then
active=not active
end
end)

PPS.PromptButtonHoldBegan:Connect(function(p)
if active then
p.HoldDuration=0
p.RequiresLineOfSight=false
if fireproximityprompt then fireproximityprompt(p) end
end
end)

end)

button("Script 3",240,function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f6e40e83490bff819d3a3eabd8937a4b.lua"))()
end)

-- AVATAR
local thumb=game.Players:GetUserThumbnailAsync(
p.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size100x100
)

local avatar=Instance.new("ImageLabel",sidebar)
avatar.Size=UDim2.new(0,60,0,60)
avatar.Position=UDim2.new(0,10,1,-80)
avatar.Image=thumb
avatar.BackgroundTransparency=1

local username=Instance.new("TextLabel",sidebar)
username.Size=UDim2.new(0,100,0,30)
username.Position=UDim2.new(0,80,1,-65)
username.BackgroundTransparency=1
username.Text=p.Name
username.Font=Enum.Font.GothamBold
username.TextSize=16
username.TextColor3=Color3.new(1,1,1)

-- CREDIT
local credit=Instance.new("TextLabel",main)
credit.Size=UDim2.new(0,200,0,30)
credit.Position=UDim2.new(1,-210,1,-35)
credit.BackgroundTransparency=1
credit.Text="credit by laxecan"
credit.TextColor3=Color3.fromRGB(170,170,170)
credit.Font=Enum.Font.Gotham
credit.TextSize=14
credit.TextXAlignment=Enum.TextXAlignment.Right

end

local function tryKey()

if checkKey(box.Text) then
gui:Destroy()
loadHub()
else
title.Text="INVALID KEY"
title.TextColor3=Color3.fromRGB(255,60,60)
end

end

enter.MouseButton1Click:Connect(tryKey)

box.FocusLost:Connect(function(enterPressed)
if enterPressed then
tryKey()
end
end)

UIS.InputBegan:Connect(function(input,gpe)
if gpe then return end
if input.KeyCode==Enum.KeyCode.Return then
if box:IsFocused() then
tryKey()
end
end
end)
