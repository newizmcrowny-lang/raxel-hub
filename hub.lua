-- SERVICES
local p = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

-- WEBHOOK
local WEBHOOK_URL = "https://discord.com/api/webhooks/1482454327120625664/-P73-QUcDqeVX1GIU7Q601SBirb9ePSZ4mH_4dWM3NokNtlhR22LgrfPaFqXaLU1bQfE"

-- KEY URL
local KEY_URL = "https://pastebin.com/raw/fsZ7rBWj"

-- BLUR
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 20

-- RGB LABEL
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

-- RGB BUTTON
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
    local data = {
        ["username"]="Raxel Hub",
        ["embeds"]={{
            ["title"]="Hub Login",
            ["description"]="User: "..p.Name,
            ["color"]=65280
        }}
    }
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

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
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
    main.Position = UDim2.new(0.5,-400,0.5,-260)
    main.BackgroundColor3 = Color3.fromRGB(20,20,20)
    main.BackgroundTransparency = 0.15
    Instance.new("UICorner", main)

    -- SIDEBAR
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0,180,1,-50)
    sidebar.Position = UDim2.new(0,0,0,50)
    sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)

    -- CONTENT
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-180,1,-50)
    content.Position = UDim2.new(0,180,0,50)
    content.BackgroundTransparency = 1

    -- SCRIPT PAGE
    local scriptsPage = Instance.new("Frame", content)
    scriptsPage.Size = UDim2.new(1,0,1,0)
    scriptsPage.BackgroundTransparency = 1
    scriptsPage.Visible = true

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

    scriptButton("Script 1",60,function()
        loadstring(game:HttpGet("https://pastebin.com/raw/auSLpuqi"))()
    end)

    -- PLAYER INFO
    local info = Instance.new("Frame", main)
    info.Size = UDim2.new(0,180,0,60)
    info.Position = UDim2.new(0,10,1,-70)
    info.BackgroundTransparency = 1

    local avatar = Instance.new("ImageLabel", info)
    avatar.Size = UDim2.new(0,50,0,50)
    avatar.BackgroundTransparency = 1
    avatar.Image = game.Players:GetUserThumbnailAsync(
        p.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )

    local nameLabel = Instance.new("TextLabel", info)
    nameLabel.Size = UDim2.new(1,-60,0,25)
    nameLabel.Position = UDim2.new(0,60,0,0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBlack
    nameLabel.TextSize = 20
    nameLabel.TextColor3 = Color3.new(1,1,1)
    nameLabel.Text = p.Name

    local gameLabel = Instance.new("TextLabel", info)
    gameLabel.Size = UDim2.new(1,-60,0,20)
    gameLabel.Position = UDim2.new(0,60,0,25)
    gameLabel.BackgroundTransparency = 1
    gameLabel.Font = Enum.Font.Gotham
    gameLabel.TextSize = 16
    gameLabel.TextColor3 = Color3.fromRGB(180,180,180)
    gameLabel.Text = MarketplaceService:GetProductInfo(game.PlaceId).Name

    -- FPS COUNTER (FIXED)
    local fpsLabel = Instance.new("TextLabel", main)
    fpsLabel.Size = UDim2.new(0,120,0,25)
    fpsLabel.Position = UDim2.new(1,-130,1,-35)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 16
    fpsLabel.Text = "FPS: 0"

    RGBLabel(fpsLabel)

    local frames = 0
    local lastTime = tick()

    RunService.RenderStepped:Connect(function()
        frames += 1
        if tick() - lastTime >= 1 then
            fpsLabel.Text = "FPS: "..frames
            frames = 0
            lastTime = tick()
        end
    end)

end

-- KEY TRY
enter.MouseButton1Click:Connect(function()
    if checkKey(box.Text) then
        gui:Destroy()
        loadHub()
    else
        title.Text="INVALID KEY"
        title.TextColor3=Color3.fromRGB(255,60,60)
    end
end)
