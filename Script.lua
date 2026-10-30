--========================================================
-- SHADOW HUB
-- 2024 QUALITY | HEADLESS | KORBLOX
-- Interface preta com bordas brancas
--========================================================

print("[SHADOW HUB] Iniciando...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 15)

if not playerGui then
warn("[SHADOW HUB] PlayerGui não carregou")
return
end

local oldGui = playerGui:FindFirstChild("SHADOWHUB_Panel")
if oldGui then
oldGui:Destroy()
end

_G.SHADOW_States = _G.SHADOW_States or {}

--========================================================
-- INTERFACE
--========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SHADOWHUB_Panel"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -105)
MainFrame.Size = UDim2.new(0, 260, 0, 210)
MainFrame.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("TextLabel")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.Font = Enum.Font.GothamBold
TitleBar.Text = " SHADOW HUB"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.TextSize = 18
TitleBar.TextXAlignment = Enum.TextXAlignment.Left
TitleBar.ZIndex = 2

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.ZIndex = 3

local FloatButton = Instance.new("TextButton")
FloatButton.Name = "SHADOW_Float"
FloatButton.Parent = ScreenGui
FloatButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FloatButton.Position = UDim2.new(0.05, 0, 0.4, 0)
FloatButton.Size = UDim2.new(0, 90, 0, 40)
FloatButton.Visible = false
FloatButton.Font = Enum.Font.GothamBold
FloatButton.Text = "SHADOW\nHUB"
FloatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatButton.TextSize = 12
FloatButton.BorderSizePixel = 0
FloatButton.Active = true

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(0, 8)
FloatCorner.Parent = FloatButton

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(255, 255, 255)
FloatStroke.Thickness = 1.5
FloatStroke.Parent = FloatButton

CloseButton.Activated:Connect(function()
MainFrame.Visible = false
FloatButton.Visible = true
end)

--========================================================
-- ARRASTAR PAINEL E BOTÃO FLUTUANTE
--========================================================

local function makeDraggable(object, handle)
local dragging = false
local dragStart
local startPos
local dragInput

handle.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = object.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
dragInput = nil
end
end)
end
end)

handle.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and dragInput
and (input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart

object.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)
end

makeDraggable(MainFrame, TitleBar)

local floatDragging = false
local floatMoved = false
local floatStart
local floatPosition
local floatInput

FloatButton.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
floatDragging = true
floatMoved = false
floatStart = input.Position
floatPosition = FloatButton.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
floatDragging = false
floatInput = nil
end
end)
end
end)

FloatButton.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch then
floatInput = input
end
end)

UserInputService.InputChanged:Connect(function(input)
if floatDragging and floatInput
and (input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - floatStart

if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
floatMoved = true
end

FloatButton.Position = UDim2.new(
floatPosition.X.Scale,
floatPosition.X.Offset + delta.X,
floatPosition.Y.Scale,
floatPosition.Y.Offset + delta.Y
)
end
end)

FloatButton.Activated:Connect(function()
if not floatMoved then
MainFrame.Visible = true
FloatButton.Visible = false
end
end)

--========================================================
-- LISTA DE BOTÕES
--========================================================

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0, 10, 0, 55)
Container.Size = UDim2.new(1, -20, 1, -65)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

--========================================================
-- 2024 QUALITY_1 
--========================================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local ALTURA = 40
local RAIO_GRADE = 1400
local ESPACO = 40
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

local BRILHO_SOL = 2.02
local FORCA_LUZ = 0.4
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

--========================================================
-- 2024 QUALITY_2
--========================================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local ALTURA = 40
local RAIO_GRADE = 1400
local ESPACO = 40
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

local BRILHO_SOL = 2
local FORCA_LUZ = 0.4
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

--========================================================
-- SISTEMA DE TOGGLES
--========================================================

local function CreateToggle(name, onEnable, onDisable)
_G.SHADOW_States[name] = false

local frame = Instance.new("Frame")
frame.Name = name .. "_Toggle"
frame.Parent = Container
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Size = UDim2.new(1, 0, 0, 40)
frame.BorderSizePixel = 0

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 7)
corner.Parent = frame

local label = Instance.new("TextLabel")
label.Parent = frame
label.BackgroundTransparency = 1
label.Position = UDim2.new(0, 10, 0, 0)
label.Size = UDim2.new(1, -90, 1, 0)
label.Font = Enum.Font.GothamMedium
label.Text = name
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextSize = 13
label.TextXAlignment = Enum.TextXAlignment.Left

local button = Instance.new("TextButton")
button.Parent = frame
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.Position = UDim2.new(1, -70, 0.5, -13)
button.Size = UDim2.new(0, 60, 0, 26)
button.Font = Enum.Font.GothamBold
button.Text = "OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 12
button.BorderSizePixel = 0

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 5)
buttonCorner.Parent = button

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(255, 255, 255)
buttonStroke.Thickness = 1
buttonStroke.Parent = button

button.Activated:Connect(function()
local enabled = not _G.SHADOW_States[name]
_G.SHADOW_States[name] = enabled

if enabled then
button.Text = "ON"
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.TextColor3 = Color3.fromRGB(0, 0, 0)

local ok, err = pcall(onEnable)
if not ok then
warn("[SHADOW HUB] " .. name .. ": " .. tostring(err))
end
else
button.Text = "OFF"
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)

local ok, err = pcall(onDisable)
if not ok then
warn("[SHADOW HUB] " .. name .. ": " .. tostring(err))
end
end
end)
end

--========================================================
-- REGISTRO: SOMENTE OS 2 RECURSOS
--========================================================

CreateToggle("2024 QUALITY", q24On, q24Off)
CreateToggle("HEADLESS", headlessOn, headlessOff)
CreateToggle("KORBLOX", korbloxOn, korbloxOff)

print("[SHADOW HUB] Pronto! 2 botões carregados.")

