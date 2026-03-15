-- SERVICES
local p=game:GetService("Players").LocalPlayer
local UIS=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local HttpService=game:GetService("HttpService")
local Stats=game:GetService("Stats")

-- WEBHOOK
local WEBHOOK_URL="https://discord.com/api/webhooks/1482454327120625664/-P73-QUcDqeVX1GIU7Q601SBirb9ePSZ4mH_4dWM3NokNtlhR22LgrfPaFqXaLU1bQfE"

-- KEY URL
local KEY_URL="https://pastebin.com/raw/fsZ7rBWj"

-- BLUR
local blur=Instance.new("BlurEffect",Lighting)
blur.Size=20

-- RGB GUIDE CORNER FUNCTION (hafif köşe ışığı)
local function cornerRGB(frame)
	local tl=Instance.new("Frame",frame)
	tl.Size=UDim2.new(0,10,0,10)
	tl.Position=UDim2.new(0,0,0,0)
	tl.BackgroundTransparency=0
	tl.BorderSizePixel=0
	Instance.new("UICorner",tl)
	
	local tr=tl:Clone()
	tr.Position=UDim2.new(1,-10,0,0)
	tr.Parent=frame
	
	local bl=tl:Clone()
	bl.Position=UDim2.new(0,0,1,-10)
	bl.Parent=frame
	
	local br=tl:Clone()
	br.Position=UDim2.new(1,-10,1,-10)
	br.Parent=frame
	
	task.spawn(function()
		local h=0
		while frame.Parent do
			for _,c in pairs({tl,tr,bl,br}) do
				c.BackgroundColor3=Color3.fromHSV(h,1,1)
			end
			h=h+0.01
			if h>1 then h=0 end
			task.wait()
		end
	end)
end

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
		["embeds"]={{["title"]="Hub Login",["description"]="User: "..p.Name,["color"]=65280}}
	}
	pcall(function()
		HttpService:PostAsync(WEBHOOK_URL,HttpService:JSONEncode(data),Enum.HttpContentType.ApplicationJson)
	end)
end

-- KEY UI
local gui=Instance.new("ScreenGui",p.PlayerGui)
local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,800,0,520)
frame.Position=UDim2.new(0.5,-400,0.5,-260)
frame.BackgroundColor3=Color3.fromRGB(25,25,25)
frame.BackgroundTransparency=.15
Instance.new("UICorner",frame)
cornerRGB(frame) -- RGB köşe ışıkları

local title=Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,0,0,40)
title.Position=UDim2.new(0,0,0,0)
title.BackgroundTransparency=1
title.Text="RAXEL HUB"
title.Font=Enum.Font.GothamBlack
title.TextColor3=Color3.new(1,1,1)
title.TextSize=26

local box=Instance.new("TextBox",frame)
box.Size=UDim2.new(0.8,0,0,50)
box.Position=UDim2.new(0.1,0,0.45,0)
box.PlaceholderText="Enter Key"
box.BackgroundColor3=Color3.fromRGB(40,40,40)
box.TextColor3=Color3.new(1,1,1)
box.Font = Enum.Font.GothamBlack
box.TextSize = 24
Instance.new("UICorner",box)

local enter=Instance.new("TextButton",frame)
enter.Size=UDim2.new(0.8,0,0,50)
enter.Position=UDim2.new(0.1,0,0.75,0)
enter.Text="ENTER"
enter.Font=Enum.Font.GothamBlack
enter.TextSize=24
enter.BackgroundColor3=Color3.fromRGB(0,170,255)
enter.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",enter)

-- HUB FUNCTION
local function loadHub()
	sendWebhook()
	local hub=Instance.new("ScreenGui",p.PlayerGui)

	local main=Instance.new("Frame",hub)
	main.Size=UDim2.new(0,800,0,520)
	main.Position=UDim2.new(0.5,-400,0.5,-260)
	main.BackgroundColor3=Color3.fromRGB(20,20,20)
	main.BackgroundTransparency=.15
	Instance.new("UICorner",main)
	main.Position=UDim2.new(0.5,-400,0.5,-600) -- başta yukarıda

	-- animasyonlu geçiş
	main:TweenPosition(UDim2.new(0.5,-400,0.5,-260),"Out","Quad",0.5,true)

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

	-- CONTENT
	local content=Instance.new("Frame",main)
	content.Size=UDim2.new(1,-180,1,-50)
	content.Position=UDim2.new(0,180,0,50)
	content.BackgroundTransparency=1

	-- SCRIPTS PAGE
	local scriptsPage=Instance.new("Frame",content)
	scriptsPage.Size=UDim2.new(1,0,1,0)
	scriptsPage.BackgroundTransparency=1
	scriptsPage.Visible=true

	-- SETTINGS PAGE
	local settingsPage=Instance.new("Frame",content)
	settingsPage.Size=UDim2.new(1,0,1,0)
	settingsPage.BackgroundTransparency=1
	settingsPage.Visible=false

	-- Toggle Blur
	local blurToggle=Instance.new("TextButton",settingsPage)
	blurToggle.Size=UDim2.new(0,340,0,70)
	blurToggle.Position=UDim2.new(0,40,0,60)
	blurToggle.Text="Toggle Blur"
	blurToggle.Font=Enum.Font.GothamBlack
	blurToggle.TextSize=24
	blurToggle.TextColor3=Color3.new(1,1,1)
	blurToggle.BackgroundColor3=Color3.fromRGB(45,45,45)
	Instance.new("UICorner",blurToggle)
	blurToggle.MouseButton1Click:Connect(function()
		blur.Enabled = not blur.Enabled
	end)

	-- FPS sağ altta
	local fpsLabel=Instance.new("TextLabel",main)
	fpsLabel.Size=UDim2.new(0,120,0,25)
	fpsLabel.Position=UDim2.new(1,-130,1,-35)
	fpsLabel.BackgroundTransparency=1
	fpsLabel.Font=Enum.Font.GothamBold
	fpsLabel.TextSize=16
	task.spawn(function()
		local last=tick()
		local frames=0
		while true do
			frames=frames+1
			if tick()-last>=1 then
				fpsLabel.Text="FPS: "..frames
				frames=0
				last=tick()
			end
			task.wait()
		end
	end)

	-- Sol alt avatar + isim + oyun
	local sidebar=Instance.new("Frame",main)
	sidebar.Size=UDim2.new(0,180,1,-50)
	sidebar.Position=UDim2.new(0,0,0,50)
	sidebar.BackgroundTransparency=1

	local info=Instance.new("Frame",sidebar)
	info.Size=UDim2.new(1,0,0,90)
	info.Position=UDim2.new(0,0,1,-90)
	info.BackgroundTransparency=1

	local avatar=Instance.new("ImageLabel",info)
	avatar.Size=UDim2.new(0,50,0,50)
	avatar.Position=UDim2.new(0,10,0,10)
	avatar.BackgroundTransparency=1
	avatar.Image=game.Players:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size420x420)

	local name=Instance.new("TextLabel",info)
	name.Size=UDim2.new(1,-70,0,25)
	name.Position=UDim2.new(0,65,0,10)
	name.BackgroundTransparency=1
	name.Font=Enum.Font.GothamBold
	name.TextSize=18
	name.TextColor3=Color3.new(1,1,1)
	name.Text=p.Name
	name.TextXAlignment=Enum.TextXAlignment.Left

	local gameName=Instance.new("TextLabel",info)
	gameName.Size=UDim2.new(1,-70,0,20)
	gameName.Position=UDim2.new(0,65,0,35)
	gameName.BackgroundTransparency=1
	gameName.Font=Enum.Font.Gotham
	gameName.TextSize=14
	gameName.TextColor3=Color3.fromRGB(180,180,180)
	gameName.Text=game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	gameName.TextXAlignment=Enum.TextXAlignment.Left
end

-- KEY TRY
enter.MouseButton1Click:Connect(function()
	if checkKey(box.Text) then
		-- Animasyonlu geçiş
		frame:TweenPosition(UDim2.new(0.5,-400,-0.5,-260),"Out","Quad",0.5,true,function()
			gui:Destroy()
			loadHub()
		end)
	else
		title.Text="INVALID KEY"
		title.TextColor3=Color3.fromRGB(255,60,60)
	end
end)
