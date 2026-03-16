-- RAXEL HUB UI DEMO (SAFE)
-- LocalScript olarak kullan

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local p = Players.LocalPlayer

-- BLUR
local blur = Lighting:FindFirstChild("RaxelHubBlur") or Instance.new("BlurEffect")
blur.Name = "RaxelHubBlur"
blur.Size = 20
blur.Enabled = true
blur.Parent = Lighting

-- HELPERS
local function notify(title, text, duration)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title or "Raxel Hub",
			Text = text or "",
			Duration = duration or 3
		})
	end)
end

local function rgbLabel(label)
	task.spawn(function()
		local h = 0
		while label and label.Parent do
			label.TextColor3 = Color3.fromHSV(h, 1, 1)
			h += 0.005
			if h > 1 then h = 0 end
			task.wait()
		end
	end)
end

local function rgbButton(button)
	task.spawn(function()
		local h = 0
		while button and button.Parent do
			button.BackgroundColor3 = Color3.fromHSV(h, 0.7, 1)
			h += 0.005
			if h > 1 then h = 0 end
			task.wait()
		end
	end)
end

local function shakeGui(obj)
	local originalPos = obj.Position

	for i = 1,8 do
		local offset = (i % 2 == 0) and 10 or -10

		obj.Position = UDim2.new(
			originalPos.X.Scale,
			originalPos.X.Offset + offset,
			originalPos.Y.Scale,
			originalPos.Y.Offset
		)

		task.wait(0.03)
	end

	obj.Position = originalPos
end

local function getExecutorName()
	local ok, result = pcall(function()
		if identifyexecutor then
			return identifyexecutor()
		elseif getexecutorname then
			return getexecutorname()
		else
			return "Studio / Demo"
		end
	end)

	if ok and result then
		return tostring(result)
	end

	return "Studio / Demo"
end

local function rgbBorder(frameObj, thick)
	local bars = {}

	local function createBar(size, pos)
		local f = Instance.new("Frame")
		f.Parent = frameObj
		f.Size = size
		f.Position = pos
		f.BorderSizePixel = 0
		table.insert(bars, f)
	end

	createBar(UDim2.new(1,0,0,thick), UDim2.new(0,0,0,0))
	createBar(UDim2.new(1,0,0,thick), UDim2.new(0,0,1,-thick))
	createBar(UDim2.new(0,thick,1,0), UDim2.new(0,0,0,0))
	createBar(UDim2.new(0,thick,1,0), UDim2.new(1,-thick,0,0))

	task.spawn(function()
		local h = 0
		while frameObj and frameObj.Parent do
			for _, b in ipairs(bars) do
				if b and b.Parent then
					b.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
				end
			end
			h += 0.005
			if h > 1 then h = 0 end
			task.wait()
		end
	end)
end

local KEY_URL = "https://pastebin.com/raw/fsZ7rBWj"

local function checkKey(input)
	local ok, response = pcall(function()
		return game:HttpGet(KEY_URL)
	end)

	if ok and response then
		for key in string.gmatch(response,"[^\r\n]+") do
			if tostring(input) == key then
				return true
			end
		end
	end

	return false
end

-- CLEAN OLD GUI
for _, gui in ipairs(p.PlayerGui:GetChildren()) do
	if gui.Name == "RaxelKeyGui" or gui.Name == "RaxelHub" then
		gui:Destroy()
	end
end

-- KEY GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RaxelKeyGui"
gui.ResetOnSpawn = false
gui.Parent = p.PlayerGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 800, 0, 520)
frame.Position = UDim2.new(0.5, -400, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
Instance.new("UICorner", frame)
rgbBorder(frame, 6)

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "RAXEL HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.new(1,1,1)

local box = Instance.new("TextBox")
box.Parent = frame
box.Size = UDim2.new(0.8,0,0,50)
box.Position = UDim2.new(0.1,0,0.45,0)
box.PlaceholderText = "Enter Key"
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)
box.Font = Enum.Font.GothamBlack
box.TextSize = 26
box.BorderSizePixel = 0
Instance.new("UICorner", box)

local enter = Instance.new("TextButton")
enter.Parent = frame
enter.Size = UDim2.new(0.8,0,0,50)
enter.Position = UDim2.new(0.1,0,0.75,0)
enter.Text = "ENTER"
enter.Font = Enum.Font.GothamBlack
enter.TextSize = 26
enter.BackgroundColor3 = Color3.fromRGB(0,170,255)
enter.TextColor3 = Color3.new(1,1,1)
enter.BorderSizePixel = 0
Instance.new("UICorner", enter)
rgbButton(enter)

-- HUB LOAD
local function loadHub()
	local hub = Instance.new("ScreenGui")
	hub.Name = "RaxelHub"
	hub.ResetOnSpawn = false
	hub.Parent = p.PlayerGui

	-- LOADER
	local loader = Instance.new("Frame")
	loader.Parent = hub
	loader.Size = UDim2.new(0,420,0,140)
	loader.Position = UDim2.new(0.5,-210,0.5,-70)
	loader.BackgroundColor3 = Color3.fromRGB(18,18,18)
	loader.BackgroundTransparency = 0.1
	loader.BorderSizePixel = 0
	Instance.new("UICorner", loader)

	local loaderTitle = Instance.new("TextLabel")
	loaderTitle.Parent = loader
	loaderTitle.Size = UDim2.new(1,0,0,40)
	loaderTitle.Position = UDim2.new(0,0,0,10)
	loaderTitle.BackgroundTransparency = 1
	loaderTitle.Text = "Loading RAXEL HUB..."
	loaderTitle.Font = Enum.Font.GothamBlack
	loaderTitle.TextSize = 24
	loaderTitle.TextColor3 = Color3.new(1,1,1)
	rgbLabel(loaderTitle)

	local loadBarBg = Instance.new("Frame")
	loadBarBg.Parent = loader
	loadBarBg.Size = UDim2.new(0,340,0,18)
	loadBarBg.Position = UDim2.new(0.5,-170,0,78)
	loadBarBg.BackgroundColor3 = Color3.fromRGB(35,35,35)
	loadBarBg.BorderSizePixel = 0
	Instance.new("UICorner", loadBarBg)

	local loadBar = Instance.new("Frame")
	loadBar.Parent = loadBarBg
	loadBar.Size = UDim2.new(0,0,1,0)
	loadBar.BackgroundColor3 = Color3.fromRGB(0,170,255)
	loadBar.BorderSizePixel = 0
	Instance.new("UICorner", loadBar)

	local loadText = Instance.new("TextLabel")
	loadText.Parent = loader
	loadText.Size = UDim2.new(1,0,0,24)
	loadText.Position = UDim2.new(0,0,0,105)
	loadText.BackgroundTransparency = 1
	loadText.Text = "Initializing..."
	loadText.Font = Enum.Font.GothamBold
	loadText.TextSize = 16
	loadText.TextColor3 = Color3.fromRGB(220,220,220)

	task.spawn(function()
		local steps = {
			{0.25, "Loading Interface..."},
			{0.55, "Loading Scripts..."},
			{0.80, "Loading Effects..."},
			{1.00, "Done!"}
		}
		for _, step in ipairs(steps) do
			loadText.Text = step[2]
			loadBar:TweenSize(UDim2.new(step[1],0,1,0), "Out", "Quad", 0.35, true)
			task.wait(0.4)
		end
	end)

	task.wait(1.8)
	loader:Destroy()

	local main = Instance.new("Frame")
	main.Parent = hub
	main.Size = UDim2.new(0,800,0,520)
	main.Position = UDim2.new(0.5,-400,0.5,-600)
	main.BackgroundColor3 = Color3.fromRGB(20,20,20)
	main.BackgroundTransparency = 0.15
	main.BorderSizePixel = 0
	Instance.new("UICorner", main)
	main:TweenPosition(UDim2.new(0.5,-400,0.5,-260), "Out", "Quad", 0.5, true)

	local expandedSize = UDim2.new(0,800,0,520)
	local minimizedSize = UDim2.new(0,800,0,50)
	local isMinimized = false
	local hubVisible = true

	-- RightShift toggle
	UIS.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == Enum.KeyCode.RightShift then
			hubVisible = not hubVisible
			main.Visible = hubVisible
		end
	end)

	-- SNOW EFFECT
	local snowFolder = Instance.new("Folder")
	snowFolder.Name = "Snow"
	snowFolder.Parent = main

	local function createSnow()
		local snow = Instance.new("Frame")
		snow.Parent = snowFolder
		snow.Size = UDim2.new(0, math.random(2,6), 0, math.random(2,6))
		snow.BackgroundColor3 = Color3.new(1,1,1)
		snow.BorderSizePixel = 0
		snow.BackgroundTransparency = 0.2
		snow.ZIndex = 1

		local startX = math.random(0,800)
		snow.Position = UDim2.new(0,startX,0,-10)

		snow:TweenPosition(
			UDim2.new(0, startX + math.random(-50,50), 0, 530),
			"Out",
			"Linear",
			math.random(4,8),
			true,
			function()
				if snow then snow:Destroy() end
			end
		)
	end

	task.spawn(function()
		while main and main.Parent do
			if main.Visible and not isMinimized then
				createSnow()
			end
			task.wait(0.1)
		end
	end)

	-- HEADER
	local header = Instance.new("Frame")
	header.Parent = main
	header.Size = UDim2.new(1,0,0,50)
	header.BackgroundTransparency = 1
	header.ZIndex = 3

	local hubTitle = Instance.new("TextLabel")
	hubTitle.Parent = header
	hubTitle.Size = UDim2.new(1,0,1,0)
	hubTitle.BackgroundTransparency = 1
	hubTitle.Text = "RAXEL HUB"
	hubTitle.Font = Enum.Font.GothamBlack
	hubTitle.TextSize = 26
	hubTitle.TextColor3 = Color3.new(1,1,1)
	hubTitle.ZIndex = 3

	-- DRAG
	local dragging = false
	local dragStart
	local startPos

	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	-- SIDEBAR
	local sidebar = Instance.new("Frame")
	sidebar.Parent = main
	sidebar.Size = UDim2.new(0,180,1,-50)
	sidebar.Position = UDim2.new(0,0,0,50)
	sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
	sidebar.BorderSizePixel = 0
	sidebar.ZIndex = 3

	local scriptsButton = Instance.new("TextButton")
	scriptsButton.Parent = sidebar
	scriptsButton.Size = UDim2.new(1,0,0,90)
	scriptsButton.Position = UDim2.new(0,0,0,0)
	scriptsButton.Text = "Scripts"
	scriptsButton.Font = Enum.Font.GothamBlack
	scriptsButton.TextSize = 24
	scriptsButton.TextColor3 = Color3.new(1,1,1)
	scriptsButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
	scriptsButton.BorderSizePixel = 0
	scriptsButton.ZIndex = 4
	Instance.new("UICorner", scriptsButton)

	local settingsButton = Instance.new("TextButton")
	settingsButton.Parent = sidebar
	settingsButton.Size = UDim2.new(1,0,0,90)
	settingsButton.Position = UDim2.new(0,0,0,100)
	settingsButton.Text = "Settings"
	settingsButton.Font = Enum.Font.GothamBlack
	settingsButton.TextSize = 24
	settingsButton.TextColor3 = Color3.new(1,1,1)
	settingsButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
	settingsButton.BorderSizePixel = 0
	settingsButton.ZIndex = 4
	Instance.new("UICorner", settingsButton)

	rgbButton(scriptsButton)
	rgbButton(settingsButton)

	-- HEADER BUTTONS
	local minimize = Instance.new("TextButton")
	minimize.Parent = header
	minimize.Size = UDim2.new(0,55,0,40)
	minimize.Position = UDim2.new(1,-120,0,5)
	minimize.Text = "-"
	minimize.Font = Enum.Font.GothamBlack
	minimize.TextSize = 28
	minimize.BackgroundColor3 = Color3.fromRGB(45,45,45)
	minimize.TextColor3 = Color3.new(1,1,1)
	minimize.BorderSizePixel = 0
	minimize.ZIndex = 4
	Instance.new("UICorner", minimize)
	rgbButton(minimize)

	local close = Instance.new("TextButton")
	close.Parent = header
	close.Size = UDim2.new(0,55,0,40)
	close.Position = UDim2.new(1,-60,0,5)
	close.Text = "X"
	close.Font = Enum.Font.GothamBlack
	close.TextSize = 24
	close.BackgroundColor3 = Color3.fromRGB(45,45,45)
	close.TextColor3 = Color3.new(1,1,1)
	close.BorderSizePixel = 0
	close.ZIndex = 4
	Instance.new("UICorner", close)
	rgbButton(close)

	local content = Instance.new("Frame")
	content.Parent = main
	content.Size = UDim2.new(1,-180,1,-50)
	content.Position = UDim2.new(0,180,0,50)
	content.BackgroundTransparency = 1
	content.ZIndex = 3

	-- PAGES
	local scriptsPage = Instance.new("ScrollingFrame")
	scriptsPage.Parent = content
	scriptsPage.Size = UDim2.new(1,0,1,0)
	scriptsPage.BackgroundTransparency = 1
	scriptsPage.Visible = true
	scriptsPage.ZIndex = 3
	scriptsPage.CanvasSize = UDim2.new(0,0,0,670)
	scriptsPage.ScrollBarThickness = 6
	scriptsPage.BorderSizePixel = 0
	scriptsPage.ScrollingDirection = Enum.ScrollingDirection.Y

	local settingsPage = Instance.new("Frame")
	settingsPage.Parent = content
	settingsPage.Size = UDim2.new(1,0,1,0)
	settingsPage.BackgroundTransparency = 1
	settingsPage.Visible = false
	settingsPage.ZIndex = 3

	-- SCRIPT BUTTONS
	local function scriptButton(name, pos, func)
		local b = Instance.new("TextButton")
		b.Parent = scriptsPage
		b.Size = UDim2.new(0,340,0,70)
		b.Position = UDim2.new(0,40,0,pos)
		b.Text = name
		b.Font = Enum.Font.GothamBlack
		b.TextSize = 24
		b.TextColor3 = Color3.new(1,1,1)
		b.BackgroundColor3 = Color3.fromRGB(45,45,45)
		b.BorderSizePixel = 0
		b.ZIndex = 4
		Instance.new("UICorner", b)
		b.MouseButton1Click:Connect(func)
		rgbButton(b)
		return b
	end

	scriptButton("Illusion Hub",60,function()
		notify("Raxel Hub", "Illusion Hub selected", 3)
	end)

	scriptButton("MewHub",160,function()
		notify("Raxel Hub", "MewHub selected", 3)
	end)

	scriptButton("Auto Grab",260,function()
		notify("Raxel Hub", "Auto Grab selected", 3)
	end)

	scriptButton("AP Spammer",360,function()
		notify("Raxel Hub", "AP Spammer selected", 3)
	end)

	scriptButton("Auto Bat",460,function()
		notify("Raxel Hub", "Auto Bat selected", 3)
	end)

	local coming = Instance.new("TextButton")
	coming.Parent = scriptsPage
	coming.Size = UDim2.new(0,340,0,70)
	coming.Position = UDim2.new(0,40,0,560)
	coming.Text = ""
	coming.BackgroundColor3 = Color3.fromRGB(60,60,60)
	coming.BackgroundTransparency = 0.35
	coming.BorderSizePixel = 0
	coming.ZIndex = 4
	Instance.new("UICorner", coming)

	local comingStroke = Instance.new("UIStroke")
	comingStroke.Parent = coming
	comingStroke.Thickness = 2
	comingStroke.Transparency = 0.4

	local soonText = Instance.new("TextLabel")
	soonText.Parent = coming
	soonText.Size = UDim2.new(1,0,1,0)
	soonText.BackgroundTransparency = 1
	soonText.Text = "COMING SOON"
	soonText.Font = Enum.Font.GothamBlack
	soonText.TextSize = 22
	soonText.TextColor3 = Color3.fromRGB(200,200,200)
	soonText.ZIndex = 5

	coming.MouseButton1Click:Connect(function()
		notify("Raxel Hub", "Insant TP - Coming Soon", 3)
	end)

	-- SETTINGS
	local blurToggle = Instance.new("TextButton")
	blurToggle.Parent = settingsPage
	blurToggle.Size = UDim2.new(0,340,0,70)
	blurToggle.Position = UDim2.new(0,40,0,60)
	blurToggle.BackgroundColor3 = Color3.fromRGB(45,45,45)
	blurToggle.Text = "Toggle Blur"
	blurToggle.Font = Enum.Font.GothamBlack
	blurToggle.TextSize = 24
	blurToggle.TextColor3 = Color3.new(1,1,1)
	blurToggle.BorderSizePixel = 0
	blurToggle.ZIndex = 4
	Instance.new("UICorner", blurToggle)
	rgbButton(blurToggle)

	blurToggle.MouseButton1Click:Connect(function()
		blur.Enabled = not blur.Enabled
		notify("Raxel Hub", "Blur: "..(blur.Enabled and "ON" or "OFF"), 2)
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

	-- BOTTOM LEFT
	local info = Instance.new("Frame")
	info.Parent = main
	info.Size = UDim2.new(0,220,0,60)
	info.Position = UDim2.new(0,10,1,-70)
	info.BackgroundTransparency = 1
	info.ZIndex = 4

	local avatar = Instance.new("ImageLabel")
	avatar.Parent = info
	avatar.Size = UDim2.new(0,50,0,50)
	avatar.Position = UDim2.new(0,0,0,5)
	avatar.BackgroundTransparency = 1
	avatar.ZIndex = 4
	avatar.Image = Players:GetUserThumbnailAsync(
		p.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size420x420
	)

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Parent = info
	nameLabel.Size = UDim2.new(1,-60,0,25)
	nameLabel.Position = UDim2.new(0,60,0,0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Font = Enum.Font.GothamBlack
	nameLabel.TextSize = 20
	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.Text = p.Name
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ZIndex = 4

	local gameLabel = Instance.new("TextLabel")
	gameLabel.Parent = info
	gameLabel.Size = UDim2.new(1,-60,0,20)
	gameLabel.Position = UDim2.new(0,60,0,25)
	gameLabel.BackgroundTransparency = 1
	gameLabel.Font = Enum.Font.Gotham
	gameLabel.TextSize = 16
	gameLabel.TextColor3 = Color3.fromRGB(180,180,180)
	gameLabel.Text = MarketplaceService:GetProductInfo(game.PlaceId).Name
	gameLabel.TextXAlignment = Enum.TextXAlignment.Left
	gameLabel.ZIndex = 4

	-- PERF PANEL
	local perfPanel = Instance.new("Frame")
	perfPanel.Parent = main
	perfPanel.Size = UDim2.new(0,180,0,72)
	perfPanel.Position = UDim2.new(1,-190,1,-82)
	perfPanel.BackgroundColor3 = Color3.fromRGB(18,18,18)
	perfPanel.BackgroundTransparency = 0.2
	perfPanel.BorderSizePixel = 0
	perfPanel.ZIndex = 4
	Instance.new("UICorner", perfPanel)

	local fpsLabel = Instance.new("TextLabel")
	fpsLabel.Parent = perfPanel
	fpsLabel.Size = UDim2.new(1,-10,0,20)
	fpsLabel.Position = UDim2.new(0,8,0,4)
	fpsLabel.BackgroundTransparency = 1
	fpsLabel.Font = Enum.Font.GothamBold
	fpsLabel.TextSize = 15
	fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
	fpsLabel.Text = "FPS: 0"
	fpsLabel.ZIndex = 5

	local pingLabel = Instance.new("TextLabel")
	pingLabel.Parent = perfPanel
	pingLabel.Size = UDim2.new(1,-10,0,20)
	pingLabel.Position = UDim2.new(0,8,0,24)
	pingLabel.BackgroundTransparency = 1
	pingLabel.Font = Enum.Font.GothamBold
	pingLabel.TextSize = 15
	pingLabel.TextXAlignment = Enum.TextXAlignment.Left
	pingLabel.Text = "PING: 0ms"
	pingLabel.ZIndex = 5

	local execLabel = Instance.new("TextLabel")
	execLabel.Parent = perfPanel
	execLabel.Size = UDim2.new(1,-10,0,20)
	execLabel.Position = UDim2.new(0,8,0,44)
	execLabel.BackgroundTransparency = 1
	execLabel.Font = Enum.Font.GothamBold
	execLabel.TextSize = 13
	execLabel.TextXAlignment = Enum.TextXAlignment.Left
	execLabel.Text = "EXEC: "..getExecutorName()
	execLabel.ZIndex = 5

	rgbLabel(fpsLabel)
	rgbLabel(pingLabel)
	rgbLabel(execLabel)

	local frames = 0
	local last = tick()

	RunService.RenderStepped:Connect(function()
		if not main.Parent then return end
		frames += 1
		if tick() - last >= 1 then
			fpsLabel.Text = "FPS: "..frames
			frames = 0
			last = tick()

			local ping = 0
			pcall(function()
				ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
			end)
			pingLabel.Text = "PING: "..tostring(ping).."ms"
		end
	end)

	-- MINIMIZE
	local function setMinimized(state)
		isMinimized = state
		if state then
			sidebar.Visible = false
			content.Visible = false
			info.Visible = false
			perfPanel.Visible = false
			main:TweenSize(minimizedSize, "Out", "Quad", 0.25, true)
			minimize.Text = "+"
		else
			main:TweenSize(expandedSize, "Out", "Quad", 0.25, true)
			task.delay(0.26, function()
				if main and main.Parent then
					sidebar.Visible = true
					content.Visible = true
					info.Visible = true
					perfPanel.Visible = true
				end
			end)
			minimize.Text = "-"
		end
	end

	minimize.MouseButton1Click:Connect(function()
		setMinimized(not isMinimized)
	end)

	close.MouseButton1Click:Connect(function()
		main:TweenPosition(UDim2.new(0.5,-400,0.5,-600), "In", "Quad", 0.5, true, function()
			if hub then hub:Destroy() end
		end)
	end)

	notify("Raxel Hub", "Loaded! RightShift = Mini Hub Toggle", 4)
end

-- KEY TRY
enter.MouseButton1Click:Connect(function()
	if checkKey(box.Text) then
		frame:TweenPosition(UDim2.new(0.5,-400,-0.5,-260), "Out", "Quad", 0.5, true, function()
			gui:Destroy()
			loadHub()
		end)
	else
		title.Text = "INVALID KEY"
		title.TextColor3 = Color3.fromRGB(255,60,60)
	end
end)
