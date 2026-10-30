
--========================================================
-- OLD PANEL
-- 2024 QUALITY 1 / 2024 QUALITY 2
--========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ALTURA = 40
local RAIO_GRADE = 1400
local ESPACO = 40
local INTERVALO_BUSCA = 3

--========================================================
-- INTERFACE
--========================================================

local gui = Instance.new("ScreenGui")
gui.Name = "OLD"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(245, 190)
main.Position = UDim2.new(0.5, -122, 0.5, -95)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

--========================================================
-- CABEÇALHO
--========================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "OLD"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(30, 30)
minimize.Position = UDim2.new(1, -38, 0, 6)
minimize.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
minimize.Text = "-"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 23
minimize.Font = Enum.Font.GothamBold
minimize.Parent = header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimize

local minStroke = Instance.new("UIStroke")
minStroke.Color = Color3.new(1, 1, 1)
minStroke.Parent = minimize

--========================================================
-- BOTÕES
--========================================================

local function criarBotao(texto, posicao)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -30, 0, 45)
    button.Position = UDim2.fromOffset(15, posicao)
    button.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    button.BorderSizePixel = 0
    button.Text = texto
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = main

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Thickness = 1
    stroke.Parent = button

    return button
end

local quality1 = criarBotao("2024 QUALITY 1", 58)
local quality2 = criarBotao("2024 QUALITY 2", 115)

--========================================================
-- EXECUTOR DE QUALIDADE
--========================================================

local function aplicarQualidade(tipo)

    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    local config

    if tipo == 1 then
        config = {
            Ambient = Color3.fromRGB(190, 190, 190),
            Outdoor = Color3.fromRGB(85, 85, 85),
            Brilho = 2.02,
            ForcaLuz = 0.4,
            LuzesAtivas = true
        }
    else
        config = {
            Ambient = Color3.fromRGB(195, 195, 195),
            Outdoor = Color3.fromRGB(100, 100, 100),
            Brilho = 2,
            ForcaLuz = 0.4,
            LuzesAtivas = false
        }
    end

    -- ILUMINAÇÃO

    Lighting.Ambient = config.Ambient
    Lighting.OutdoorAmbient = config.Outdoor
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = config.Brilho
    Lighting.ClockTime = 14

    pcall(function()
        Lighting.Technology = Enum.Technology.Voxel
    end)

    -- RAYCAST DOS TETOS

    task.spawn(function()

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
    end)

    -- LUZES

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Light") then

            if config.LuzesAtivas then
                obj.Enabled = true
                obj.Brightness = config.ForcaLuz
            else
                obj.Enabled = false
                obj.Brightness = config.ForcaLuz
            end

        end
    end
end

quality1.MouseButton1Click:Connect(function()
    aplicarQualidade(1)
end)

quality2.MouseButton1Click:Connect(function()
    aplicarQualidade(2)
end)

--========================================================
-- MINIMIZAR EM BOLA
--========================================================

local bubble = Instance.new("TextButton")
bubble.Size = UDim2.fromOffset(65, 65)
bubble.Position = main.Position
bubble.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bubble.Text = "OLD"
bubble.TextColor3 = Color3.new(1, 1, 1)
bubble.TextSize = 17
bubble.Font = Enum.Font.GothamBold
bubble.Visible = false
bubble.Active = true
bubble.Parent = gui

local bubbleCorner = Instance.new("UICorner")
bubbleCorner.CornerRadius = UDim.new(1, 0)
bubbleCorner.Parent = bubble

local bubbleStroke = Instance.new("UIStroke")
bubbleStroke.Color = Color3.new(1, 1, 1)
bubbleStroke.Thickness = 2
bubbleStroke.Parent = bubble

minimize.MouseButton1Click:Connect(function()
    bubble.Position = main.Position
    main.Visible = false
    bubble.Visible = true
end)

bubble.MouseButton1Click:Connect(function()
    main.Position = bubble.Position
    bubble.Visible = false
    main.Visible = true
end)

--========================================================
-- SISTEMA DE ARRASTAR
--========================================================

local function tornarArrastavel(objeto)

    local dragging = false
    local dragStart
    local startPos

    objeto.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = objeto.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging then
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

                local delta = input.Position - dragStart

                objeto.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    end)
end

tornarArrastavel(header)
tornarArrastavel(bubble)

print("[OLD] Painel iniciado!")
