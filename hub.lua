-- SERVICES
local p=game:GetService("Players").LocalPlayer
local UIS=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local HttpService=game:GetService("HttpService")
local Stats=game:GetService("Stats")

-- WEBHOOK
local WEBHOOK_URL="https://discord.com/api/webhooks/1482454327120625664/-P73-QUcDqeVX1GIU7Q601SBirb9ePSZ4mH_4dWM3NokNtlhR22LgrfPaFqXaLU1bQfE"

-- KEY
local KEY_URL="https://pastebin.com/raw/fsZ7rBWj"

-- BLUR
local blur=Instance.new("BlurEffect",Lighting)
blur.Size=20

-- KEY CHECK
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

-- WEBHOOK
local function sendWebhook()

if WEBHOOK_URL=="" then return end

local data={
["username"]="Raxel Hub",
["embeds"]={{
["title"]="Hub Login",
["description"]="User: "..p.Name,
["color"]=65280
}}
}

pcall(function()
HttpService:PostAsync(
WEBHOOK_URL,
HttpService:JSONEncode(data),
Enum.HttpContentType.ApplicationJson
)
end)

end

-- KEY UI
local gui=Instance.new("ScreenGui",p.PlayerGui)

local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,360,0,220)
frame.Position=UDim2.new(0.5,-180,0.5,-110)
frame.BackgroundColor3=Color3.fromRGB(25,25,25)
frame.BackgroundTransparency=.15
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

-- HUB
local function loadHub()

sendWebhook()

local hub=Instance.new("ScreenGui",p.PlayerGui)

local main=Instance.new("Frame",hub)
main.Size=UDim2.new(0,800,0,520)
main.Position=UDim2.new(0.5,-400,0.5,-260)
main.BackgroundColor3=Color3.fromRGB(20,20,20)
main.BackgroundTransparency=.15
Instance.new("UICorner",main)

-- HEADER
local header=Instance.new("Frame",main)
header.Size=UDim2.new(1,0,0,50)
header.BackgroundTransparency=1

local hubTitle=Instance.new("TextLabel",header)
hubTitle.Size=UDim2.new(1,0,1,0)
hubTitle.BackgroundTransparency=1
hubTitle.Text="RAXEL HUB"
hubTitle.Font=Enum.Font.GothamBlack
hubTitle.TextSize=26
hubTitle.TextColor3=Color3.new(1,1,1)

-- CLOSE
local close=Instance.new("TextButton",header)
close.Size=UDim2.new(0,50,1,0)
close.Position=UDim2.new(1,-50,0,0)
close.Text="X"
close.Font=Enum.Font.GothamBold
close.BackgroundTransparency=1
close.TextColor3=Color3.new(1,1,1)

close.MouseButton1Click:Connect(function()
blur:Destroy()
hub:Destroy()
end)

-- DRAG FIX
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

UIS.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=false
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
local delta=input.Position-dragStart
main.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)
end
end)

-- SIDEBAR
local sidebar=Instance.new("Frame",main)
sidebar.Size=UDim2.new(0,180,1,-50)
sidebar.Position=UDim2.new(0,0,0,50)
sidebar.BackgroundColor3=Color3.fromRGB(25,25,25)

-- PLAYER INFO
local info=Instance.new("Frame",sidebar)
info.Size=UDim2.new(1,0,0,90)
info.Position=UDim2.new(0,0,1,-90)
info.BackgroundTransparency=1

local avatar=Instance.new("ImageLabel",info)
avatar.Size=UDim2.new(0,50,0,50)
avatar.Position=UDim2.new(0,10,0,10)
avatar.BackgroundTransparency=1

local thumb=game.Players:GetUserThumbnailAsync(
p.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)

avatar.Image=thumb

local name=Instance.new("TextLabel",info)
name.Size=UDim2.new(1,-70,0,25)
name.Position=UDim2.new(0,65,0,10)
name.BackgroundTransparency=1
name.Font=Enum.Font.GothamBold
name.TextSize=18
name.TextColor3=Color3.new(1,1,1)
name.Text=p.Name
name.TextXAlignment=Enum.TextXAlignment.Left

-- GAME NAME
local gameName=Instance.new("TextLabel",info)
gameName.Size=UDim2.new(1,-70,0,20)
gameName.Position=UDim2.new(0,65,0,35)
gameName.BackgroundTransparency=1
gameName.Font=Enum.Font.Gotham
gameName.TextSize=14
gameName.TextColor3=Color3.fromRGB(180,180,180)
gameName.Text=game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
gameName.TextXAlignment=Enum.TextXAlignment.Left

-- CONTENT
local content=Instance.new("Frame",main)
content.Size=UDim2.new(1,-180,1,-50)
content.Position=UDim2.new(0,180,0,50)
content.BackgroundTransparency=1

local scriptsPage=Instance.new("Frame",content)
scriptsPage.Size=UDim2.new(1,0,1,0)
scriptsPage.BackgroundTransparency=1

-- SCRIPT BUTTON
local function scriptButton(name,pos,func)

local b=Instance.new("TextButton",scriptsPage)
b.Size=UDim2.new(0,340,0,70)
b.Position=UDim2.new(0,40,0,pos)
b.Text=name
b.Font=Enum.Font.GothamBlack
b.TextSize=24
b.TextColor3=Color3.new(1,1,1)
b.BackgroundColor3=Color3.fromRGB(45,45,45)

Instance.new("UICorner",b)

b.MouseButton1Click:Connect(func)

end

-- SCRIPTS
scriptButton("Script 1",60,function()
loadstring(game:HttpGet("https://pastebin.com/raw/auSLpuqi"))()
end)

scriptButton("Script 2",160,function()

local PPS=game:GetService("ProximityPromptService")
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

scriptButton("Script 3",260,function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f6e40e83490bff819d3a3eabd8937a4b.lua"))()
end)

-- PING DISPLAY
local pingLabel=Instance.new("TextLabel",main)
pingLabel.Size=UDim2.new(0,120,0,25)
pingLabel.Position=UDim2.new(1,-130,1,-35)
pingLabel.BackgroundTransparency=1
pingLabel.Font=Enum.Font.GothamBold
pingLabel.TextSize=16
pingLabel.TextColor3=Color3.new(1,1,1)

task.spawn(function()
while true do
local ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
pingLabel.Text="Ping: "..ping
task.wait(1)
end
end)

end

-- KEY SUBMIT
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