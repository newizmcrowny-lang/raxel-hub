-- SERVICES
local p = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")

-- WEBHOOK
local WEBHOOK_URL = "https://discord.com/api/webhooks/1482454327120625664/-P73-QUcDqeVX1GIU7Q601SBirb9ePSZ4mH_4dWM3NokNtlhR22LgrfPaFqXaLU1bQfE"

-- KEY URL
local KEY_URL = "https://pastebin.com/raw/fsZ7rBWj"

-- BLUR
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 20

-- RGB ANIMATIONS
local function RGBLabel(label)
    task.spawn(function()
        local h = 0
        while label.Parent do
            label.TextColor3 = Color3.fromHSV(h,1,1)
            h = h + 0.005
            if h>1 then h=0 end
            task.wait()
        end
    end)
end

local function RGBButton(button)
    task.spawn(function()
        local h = 0
        while button.Parent do
            button.BackgroundColor3 = Color3.fromHSV(h,0.7,1)
            h = h + 0.005
            if h>1 then h=0 end
            task.wait()
        end
    end)
end

local function RGBToggleBar(bar)
    task.spawn(function()
        local h = 0
        local dir = 1
        while bar.Parent do
            bar.BackgroundColor3 = Color3.fromHSV(h,0.7,1)
            h = h + 0.01
            if h>1 then h=0 end
            local pos = bar.Position.X.Offset + (dir*1)
            if pos>bar.Parent.AbsoluteSize.X-50 or pos<0 then dir = -dir end
            bar.Position = UDim2.new(0,pos,0,0)
            task.wait(0.01)
        end
    end)
end

-- KEY CHECK
local function checkKey(input)
    local ok,res = pcall(function() return game:HttpGet(KEY_URL) end)
    if ok and res then
        for key in string.gmatch(res,"[^\r\n]+") do
            if input==key then return true end
        end
    end
    return false
end

-- WEBHOOK
local function sendWebhook()
    if WEBHOOK_URL=="" then return end
    local data = {["username"]="Raxel Hub",["embeds"]={{["title"]="Hub Login",["description"]="User: "..p.Name,["color"]=65280}}}
    pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

-- KEY GUI
local gui = Instance.new("ScreenGui", p.PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,800,0,520)
frame.Position = UDim2.new(0.5,-400,0.5,-260)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BackgroundTransparency = 0.15
Instance.new("UICorner", frame)

-- RGB BORDER for KEY
local function RGBBorder(frame,thick)
    local bars = {}
    local function createBar(size,pos)
        local f = Instance.new("Frame", frame)
        f.Size = size
        f.Position = pos
        f.BackgroundTransparency = 0
        f.BorderSizePixel = 0
        table.insert(bars,f)
    end
    createBar(UDim2.new(1,0,0,thick),UDim2.new(0,0,0,0))
    createBar(UDim2.new(1,0,0,thick),UDim2.new(0,0,1,-thick))
    createBar(UDim2.new(0,thick,1,0),UDim2.new(0,0,0,0))
    createBar(UDim2.new(0,thick,1,0),UDim2.new(1,-thick,0,0))
    task.spawn(function()
        local h=0
        while frame.Parent do
            for _,b in pairs(bars) do
                b.BackgroundColor3 = Color3.fromHSV(h,1,1)
            end
            h = h+0.005
            if h>1 then h=0 end
            task.wait()
        end
    end)
end
RGBBorder(frame,6)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "RAXEL HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.new(1,1,1)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8,0,0,50)
box.Position = UDim2.new(0.1,0,0.45,0)
box.PlaceholderText = "Enter Key"
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)
box.Font = Enum.Font.GothamBlack
box.TextSize = 26
Instance.new("UICorner", box)

local enter = Instance.new("TextButton", frame)
enter.Size = UDim2.new(0.8,0,0,50)
enter.Position = UDim2.new(0.1,0,0.75,0)
enter.Text = "ENTER"
enter.Font = Enum.Font.GothamBlack
enter.TextSize = 26
enter.BackgroundColor3 = Color3.fromRGB(0,170,255)
enter.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", enter)

-- HUB LOAD
local function loadHub()
    sendWebhook()
    local hub = Instance.new("ScreenGui", p.PlayerGui)
    local main = Instance.new("Frame", hub)
    main.Size = UDim2.new(0,800,0,520)
    main.Position = UDim2.new(0.5,-400,0.5,-600)
    main.BackgroundColor3 = Color3.fromRGB(20,20,20)
    main.BackgroundTransparency = 0.15
    Instance.new("UICorner", main)
    main:TweenPosition(UDim2.new(0.5,-400,0.5,-260),"Out","Quad",0.5,true)

    -- HEADER
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1,0,0,50)
    header.BackgroundTransparency = 1
    local hubTitle = Instance.new("TextLabel", header)
    hubTitle.Size = UDim2.new(1,0,1,0)
    hubTitle.BackgroundTransparency = 1
    hubTitle.Text = "RAXEL HUB"
    hubTitle.Font = Enum.Font.GothamBlack
    hubTitle.TextSize = 26
    hubTitle.TextColor3 = Color3.new(1,1,1)

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
        if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local delta=input.Position-dragStart
            main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)

    -- CLOSE BUTTON
    local close = Instance.new("TextButton", header)
    close.Size = UDim2.new(0,50,1,0)
    close.Position = UDim2.new(1,-50,0,0)
    close.Text = "X"
    close.Font = Enum.Font.GothamBold
    close.BackgroundTransparency = 1
    close.TextColor3 = Color3.new(1,1,1)
    close.MouseButton1Click:Connect(function()
        main:TweenPosition(UDim2.new(0.5,-400,0.5,-600),"In","Quad",0.5,true,function()
            blur:Destroy()
            hub:Destroy()
        end)
    end)

    -- SIDEBAR
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0,180,1,-50)
    sidebar.Position = UDim2.new(0,0,0,50)
    sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)

    local scriptsButton = Instance.new("TextButton", sidebar)
    scriptsButton.Size = UDim2.new(1,0,0,50)
    scriptsButton.Position = UDim2.new(0,0,0,0)
    scriptsButton.Text = "Scripts"
    scriptsButton.Font = Enum.Font.GothamBlack
    scriptsButton.TextSize = 24
    scriptsButton.TextColor3 = Color3.new(1,1,1)
    scriptsButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", scriptsButton)

    local settingsButton = Instance.new("TextButton", sidebar)
    settingsButton.Size = UDim2.new(1,0,0,50)
    settingsButton.Position = UDim2.new(0,0,0,70) -- boşluk
    settingsButton.Text = "Settings"
    settingsButton.Font = Enum.Font.GothamBlack
    settingsButton.TextSize = 24
    settingsButton.TextColor3 = Color3.new(1,1,1)
    settingsButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", settingsButton)

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-180,1,-50)
    content.Position = UDim2.new(0,180,0,50)
    content.BackgroundTransparency = 1

    -- PAGES
    local scriptsPage = Instance.new("Frame", content)
    scriptsPage.Size = UDim2.new(1,0,1,0)
    scriptsPage.BackgroundTransparency = 1
    scriptsPage.Visible = true

    local settingsPage = Instance.new("Frame", content)
    settingsPage.Size = UDim2.new(1,0,1,0)
    settingsPage.BackgroundTransparency = 1
    settingsPage.Visible = false

    -- SCRIPT BUTTONS
    local function scriptButton(name,pos,func)
        local b=Instance.new("TextButton",scriptsPage)
        b.Size = UDim2.new(0,340,0,70)
        b.Position = UDim2.new(0,40,0,pos)
        b.Text=name
        b.Font = Enum.Font.GothamBlack
        b.TextSize = 24
        b.TextColor3 = Color3.new(1,1,1)
        b.BackgroundColor3 = Color3.fromRGB(45,45,45)
        Instance.new("UICorner",b)
        b.MouseButton1Click:Connect(func)
        RGBButton(b)
    end

    scriptButton("Script 1",60,function() loadstring(game:HttpGet("https://pastebin.com/raw/auSLpuqi"))() end)
    scriptButton("Script 2",160,function() end)
    scriptButton("Script 3",260,function() end)

    -- SETTINGS TOGGLE BLUR
    local blurToggle = Instance.new("Frame", settingsPage)
    blurToggle.Size = UDim2.new(0,340,0,70)
    blurToggle.Position = UDim2.new(0,40,0,60)
    blurToggle.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", blurToggle)

    local toggleText = Instance.new("TextLabel", blurToggle)
    toggleText.Size = UDim2.new(1,0,1,0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = "Toggle Blur"
    toggleText.Font = Enum.Font.GothamBlack
    toggleText.TextSize = 24
    toggleText.TextColor3 = Color3.new(1,1,1)

    local toggleBar = Instance.new("Frame", blurToggle)
    toggleBar.Size = UDim2.new(0,50,1,0)
    toggleBar.Position = UDim2.new(0,0,0,0)
    RGBToggleBar(toggleBar)

    blurToggle.InputBegan:Connect(function()
        blur.Enabled = not blur.Enabled
    end)

    -- CATEGORY SWITCH
    scriptsButton.MouseButton1Click:Connect(function()
        scriptsPage.Visible = true
        settingsPage.Visible = false
    end)
    settingsButton.MouseButton1Click:Connect(function()
        scriptsPage.Visible = false
        settingsPage.Visible = true
    end)

    -- BOTTOM LEFT AVATAR + NAME + GAME
    local info = Instance.new("Frame", main)
    info.Size = UDim2.new(0,300,0,90)
    info.Position = UDim2.new(0,10,1,-100)
    info.BackgroundTransparency = 1

    local avatar = Instance.new("ImageLabel", info)
    avatar.Size = UDim2.new(0,50,0,50)
    avatar.Position = UDim2.new(0,0,0,0)
    avatar.BackgroundTransparency = 1
    avatar.Image = game.Players:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)

    local nameLabel = Instance.new("TextLabel", info)
    nameLabel.Size = UDim2.new(1,-60,0,25)
    nameLabel.Position = UDim2.new(0,60,0,0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBlack
    nameLabel.TextSize = 24
    nameLabel.TextColor3 = Color3.new(1,1,1)
    nameLabel.Text = p.Name
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local gameLabel = Instance.new("TextLabel", info)
    gameLabel.Size = UDim2.new(1,-60,0,20)
    gameLabel.Position = UDim2.new(0,60,0,30)
    gameLabel.BackgroundTransparency = 1
    gameLabel.Font = Enum.Font.Gotham
    gameLabel.TextSize = 18
    gameLabel.TextColor3 = Color3.fromRGB(180,180,180)
    gameLabel.Text = MarketplaceService:GetProductInfo(game.PlaceId).Name
    gameLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- BOTTOM RIGHT FPS
    local fpsLabel = Instance.new("TextLabel", main)
    fpsLabel.Size = UDim2.new(0,120,0,25)
    fpsLabel.Position = UDim2.new(1,-130,1,-35)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 16
    RGBLabel(fpsLabel)
    task.spawn(function()
        while true do
            local fps = Stats.Render.FPS:GetValueString()
            fpsLabel.Text = "FPS: "..fps
            task.wait(0.5)
        end
    end)
end

-- KEY TRY
enter.MouseButton1Click:Connect(function()
    if checkKey(box.Text) then
        frame:TweenPosition(UDim2.new(0.5,-400,-0.5,-260),"Out","Quad",0.5,true,function()
            gui:Destroy()
            loadHub()
        end)
    else
        title.Text="INVALID KEY"
        title.TextColor3=Color3.fromRGB(255,60,60)
    end
end)
