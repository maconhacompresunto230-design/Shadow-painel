
--========================================================
-- SHADOW HUB | OLD
-- 2024 QUALITY 1 / 2024 QUALITY 2
--========================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local antigo = playerGui:FindFirstChild("ShadowHubOLD")
if antigo then antigo:Destroy() end

--========================================================
-- INTERFACE
--========================================================

local gui = Instance.new("ScreenGui")
gui.Name = "ShadowHubOLD"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,230,0,175)
main.Position = UDim2.new(0.5,-115,0.5,-87)
main.BackgroundColor3 = Color3.fromRGB(8,8,8)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

Instance.new("UICorner",main).CornerRadius = UDim.new(0,12)

local outline = Instance.new("UIStroke",main)
outline.Color = Color3.new(1,1,1)
outline.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "OLD"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = main

local function criarBotao(nome,texto,posicao,pai)
	local b = Instance.new("TextButton")
	b.Name = nome
	b.Size = UDim2.new(1,-30,0,42)
	b.Position = posicao
	b.BackgroundColor3 = Color3.fromRGB(22,22,22)
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = texto
	b.TextSize = 13
	b.Font = Enum.Font.GothamSemibold
	b.Parent = pai

	Instance.new("UICorner",b).CornerRadius = UDim.new(0,7)

	local s = Instance.new("UIStroke",b)
	s.Color = Color3.fromRGB(180,180,180)
	s.Thickness = 1

	return b
end

local quality1 = criarBotao(
	"Quality1",
	"2024 QUALITY 1",
	UDim2.new(0,15,0,52),
	main
)

local quality2 = criarBotao(
	"Quality2",
	"2024 QUALITY 2",
	UDim2.new(0,15,0,105),
	main
)

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,30,0,27)
minimize.Position = UDim2.new(1,-35,0,5)
minimize.BackgroundColor3 = Color3.fromRGB(22,22,22)
minimize.Text = "—"
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Parent = main

--========================================================
-- BOLA OLD
--========================================================

local ball = Instance.new("TextButton")
ball.Name = "OLD_Minimized"
ball.Size = UDim2.new(0,55,0,55)
ball.Position = UDim2.new(0.5,-27,0.5,-27)
ball.BackgroundColor3 = Color3.fromRGB(8,8,8)
ball.Text = "OLD"
ball.TextColor3 = Color3.new(1,1,1)
ball.TextSize = 15
ball.Font = Enum.Font.GothamBold
ball.Visible = false
ball.Active = true
ball.Parent = gui

Instance.new("UICorner",ball).CornerRadius = UDim.new(1,0)

local ballStroke = Instance.new("UIStroke",ball)
ballStroke.Color = Color3.new(1,1,1)
ballStroke.Thickness = 1.5

minimize.MouseButton1Click:Connect(function()
	main.Visible = false
	ball.Visible = true
end)

ball.MouseButton1Click:Connect(function()
	ball.Visible = false
	main.Visible = true
end)

--========================================================
-- ARRASTAR
--========================================================

local function arrastar(obj)
	local dragging = false
	local dragStart
	local startPos
	local dragInput

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = obj.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - dragStart
			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

arrastar(main)
arrastar(ball)

--========================================================
-- BOTÃO 2024 QUALITY 1
-- SCRIPT ORIGINAL COMPLETO
--========================================================

quality1.MouseButton1Click:Connect(function()

	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")

	local ALTURA = 40
	local RAIO_GRADE = 1400
	local ESPACO = 4
	local INTERVALO_BUSCA = 3

	local TECNOLOGIA_VOXEL = true
	local AMBIENT_COLOR = Color3.fromRGB(190, 190, 190)
	local OUTDOOR_AMBIENT = Color3.fromRGB(85, 85, 85)
	local COLOR_SHIFT_BOTTOM = Color3.fromRGB(0, 0, 0)
	local COLOR_SHIFT_TOP = Color3.fromRGB(255, 255, 255)

	local Lighting = game:GetService("Lighting")

	Lighting.Ambient = AMBIENT_COLOR
	Lighting.OutdoorAmbient = OUTDOOR_AMBIENT
	Lighting.ColorShift_Bottom = COLOR_SHIFT_BOTTOM
	Lighting.ColorShift_Top = COLOR_SHIFT_TOP

	if TECNOLOGIA_VOXEL then
		pcall(function()
			Lighting.Technology = Enum.Technology.Voxel
		end)
	end

	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {character}
	params.FilterType = Enum.RaycastFilterType.Exclude

	local origemBase = hrp.Position
	local direcao = Vector3.new(0, ALTURA, 0)

	local tetosEncontrados = {}
	local contador = 0

	for x = -RAIO_GRADE, RAIO_GRADE, ESPACO do
		for z = -RAIO_GRADE, RAIO_GRADE, ESPACO do
			local origem = origemBase + Vector3.new(x, 0, z)
			local result = workspace:Raycast(origem, direcao, params)

			if result and result.Instance:IsA("BasePart") then
				local teto = result.Instance

				if not tetosEncontrados[teto] then
					tetosEncontrados[teto] = true
					teto.CastShadow = false
				end
			end

			contador += 1
			if contador % 100 == 0 then
				task.wait(INTERVALO_BUSCA)
			end
		end
	end

	local FORCA_LUZ = 0.4
	local BRILHO_SOL = 2.02
	local HORARIO = 14

	Lighting.Brightness = BRILHO_SOL
	Lighting.ClockTime = HORARIO

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Light") then
			if FORCA_LUZ <= 0 then
				obj.Enabled = false
			else
				obj.Enabled = true
				obj.Brightness = FORCA_LUZ
			end
		end
	end

end)

--========================================================
-- BOTÃO 2024 QUALITY 2
-- SCRIPT ORIGINAL COMPLETO
--========================================================

quality2.MouseButton1Click:Connect(function()

	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")

	local ALTURA = 40
	local RAIO_GRADE = 1400
	local ESPACO = 4
	local INTERVALO_BUSCA = 3

	local TECNOLOGIA_VOXEL = true
	local AMBIENT_COLOR = Color3.fromRGB(195, 195, 195)
	local OUTDOOR_AMBIENT = Color3.fromRGB(100, 100, 100)
	local COLOR_SHIFT_BOTTOM = Color3.fromRGB(0, 0, 0)
	local COLOR_SHIFT_TOP = Color3.fromRGB(255, 255, 255)

	local Lighting = game:GetService("Lighting")

	Lighting.Ambient = AMBIENT_COLOR
	Lighting.OutdoorAmbient = OUTDOOR_AMBIENT
	Lighting.ColorShift_Bottom = COLOR_SHIFT_BOTTOM
	Lighting.ColorShift_Top = COLOR_SHIFT_TOP

	if TECNOLOGIA_VOXEL then
		pcall(function()
			Lighting.Technology = Enum.Technology.Voxel
		end)
	end

	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {character}
	params.FilterType = Enum.RaycastFilterType.Exclude

	local origemBase = hrp.Position
	local direcao = Vector3.new(0, ALTURA, 0)

	local tetosEncontrados = {}
	local contador = 0

	for x = -RAIO_GRADE, RAIO_GRADE, ESPACO do
		for z = -RAIO_GRADE, RAIO_GRADE, ESPACO do
			local origem = origemBase + Vector3.new(x, 0, z)
			local result = workspace:Raycast(origem, direcao, params)

			if result and result.Instance:IsA("BasePart") then
				local teto = result.Instance

				if not tetosEncontrados[teto] then
					tetosEncontrados[teto] = true
					teto.CastShadow = false
				end
			end

			contador += 1
			if contador % 100 == 0 then
				task.wait(INTERVALO_BUSCA)
			end
		end
	end

	local FORCA_LUZ = 0.4
	local BRILHO_SOL = 2
	local HORARIO = 14

	Lighting.Brightness = BRILHO_SOL
	Lighting.ClockTime = HORARIO

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Light") then
			if FORCA_LUZ <= 0 then
				obj.Enabled = false
			else
				obj.Enabled = false
				obj.Brightness = FORCA_LUZ
			end
		end
	end

end)

print("[SHADOW HUB OLD] Carregado!")
