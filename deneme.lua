-- SERVICES
local p=game:GetService("Players").LocalPlayer
local UIS=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local HttpService=game:GetService("HttpService")
local Stats=game:GetService("Stats")
local TweenService=game:GetService("TweenService")

-- WEBHOOK
local WEBHOOK_URL="YOUR_WEBHOOK"

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

-- CONTENT
local content=Instance.new("Frame",main)
content.Size=UDim2.new(1,-180,1,-50)
content.Position=UDim2.new(0,180,0,50)
content.BackgroundTransparency=1

-- PAGES
local scriptsPage=Instance.new("Frame",content)
scriptsPage.Size=UDim2.new(1,0,1,0)
scriptsPage.BackgroundTransparency=1

local settingsPage=Instance.new("Frame",content)
settingsPage.Size=UDim2.new(1,0,1,0)
settingsPage.Position=UDim2.new(1,0,0,0)
settingsPage.BackgroundTransparency=1

-- SIDEBAR BUTTONS
local scriptsBtn=Instance.new("TextButton",sidebar)
scriptsBtn.Size=UDim2.new(1,0,0,50)
scriptsBtn.Text="Scripts"
scriptsBtn.BackgroundColor3=Color3.fromRGB(25,25,25)
scriptsBtn.TextColor3=Color3.new(1,1,1)

local settingsBtn=Instance.new("TextButton",sidebar)
settingsBtn.Size=UDim2.new(1,0,0,50)
settingsBtn.Position=UDim2.new(0,0,0,50)
settingsBtn.Text="Settings"
settingsBtn.BackgroundColor3=Color3.fromRGB(25,25,25)
settingsBtn.TextColor3=Color3.new(1,1,1)

-- PAGE SWITCH
local function switchPage(page)

local pages={scriptsPage,settingsPage}

for _,v in pairs(pages) do

local pos=v==page and UDim2.new(0,0,0,0) or UDim2.new(1,0,0,0)

TweenService:Create(
v,
TweenInfo.new(.35,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
{Position=pos}
):Play()

end

end

-- HOVER ANIM
local function hover(btn)

btn.MouseEnter:Connect(function()
TweenService:Create(btn,TweenInfo.new(.2),{BackgroundColor3=Color3.fromRGB(50,50,50)}):Play()
end)

btn.MouseLeave:Connect(function()
TweenService:Create(btn,TweenInfo.new(.2),{BackgroundColor3=Color3.fromRGB(25,25,25)}):Play()
end)

end

hover(scriptsBtn)
hover(settingsBtn)

scriptsBtn.MouseButton1Click:Connect(function()
switchPage(scriptsPage)
end)

settingsBtn.MouseButton1Click:Connect(function()
switchPage(settingsPage)
end)

-- SETTINGS UI
local blurToggle=Instance.new("TextButton",settingsPage)
blurToggle.Size=UDim2.new(0,300,0,60)
blurToggle.Position=UDim2.new(0,40,0,60)
blurToggle.Text="Toggle Blur"
blurToggle.BackgroundColor3=Color3.fromRGB(45,45,45)
blurToggle.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",blurToggle)

blurToggle.MouseButton1Click:Connect(function()
blur.Enabled=not blur.Enabled
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