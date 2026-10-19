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
TitleBar.Text = "  SHADOW HUB"
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
-- 2024 QUALITY
--========================================================

local q24Original
local q24Enabled = false

local function q24On()
    if q24Enabled then return end
    q24Enabled = true

    q24Original = {
        Technology = Lighting.Technology,
        ClockTime = Lighting.ClockTime,
        Brightness = Lighting.Brightness,
        ExposureCompensation = Lighting.ExposureCompensation,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ShadowSoftness = Lighting.ShadowSoftness,
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
        FogColor = Lighting.FogColor,
        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
    }

    pcall(function()
        Lighting.Technology = Enum.Technology.Voxel
    end)

    -- Não altera GlobalShadows nem GeographicLatitude.
    pcall(function()
        Lighting.PrioritizeLightingQuality = true
    end)

    Lighting.ClockTime = 14
    Lighting.Brightness = 2
    Lighting.ExposureCompensation = 0
    Lighting.Ambient = Color3.fromRGB(195, 195, 195)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
    Lighting.ShadowSoftness = 0.3
    Lighting.FogStart = 0
    Lighting.FogEnd = 100000
    Lighting.FogColor = Color3.fromRGB(195, 195, 195)

    -- Mantém os efeitos existentes no Lighting.
    -- Não remove Atmosphere, BloomEffect,
    -- SunRaysEffect, ColorCorrectionEffect
    -- nem DepthOfFieldEffect.

    pcall(function()
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
    end)

    print("[SHADOW HUB] 2024 QUALITY ativado")
end

local function q24Off()
    if not q24Enabled then return end
    q24Enabled = false

    if q24Original then
        for property, value in pairs(q24Original) do
            pcall(function()
                Lighting[property] = value
            end)
        end
        q24Original = nil
    end

    print("[SHADOW HUB] 2024 QUALITY desativado")
end

--========================================================
-- HEADLESS
--========================================================

local headConn
local headSnap

local function restoreHead()
    local data = headSnap
    headSnap = nil

    if not data then return end

    local head = data.head

    if head and head.Parent then
        pcall(function() head.Size = data.size end)
        pcall(function() head.Transparency = data.transparency end)
    end

    for obj, transparency in pairs(data.vis) do
        if obj and obj.Parent then
            pcall(function()
                obj.Transparency = transparency
            end)
        end
    end
end

local function applyHeadless(character)
    restoreHead()

    local head = character:FindFirstChild("Head")
        or character:WaitForChild("Head", 10)

    if not head then return end

    local visuals = {}

    for _, obj in ipairs(head:GetDescendants()) do
        if obj:IsA("Decal")
        or obj:IsA("Texture")
        or obj:IsA("SpecialMesh") then
            local ok, transparency = pcall(function()
                return obj.Transparency
            end)

            if ok then
                visuals[obj] = transparency
            end
        end
    end

    headSnap = {
        head = head,
        size = head.Size,
        transparency = head.Transparency,
        vis = visuals
    }

    head.Size = Vector3.new(0.1, 0.1, 0.1)
    head.Transparency = 1

    for obj in pairs(visuals) do
        pcall(function()
            obj.Transparency = 1
        end)
    end
end

local function headlessOn()
    if headConn then
        headConn:Disconnect()
        headConn = nil
    end

    restoreHead()

    if player.Character then
        task.spawn(function()
            task.wait(0.2)

            if _G.SHADOW_States["HEADLESS"]
            and player.Character then
                applyHeadless(player.Character)
            end
        end)
    end

    headConn = player.CharacterAdded:Connect(function(character)
        task.wait(0.2)

        if _G.SHADOW_States["HEADLESS"] then
            applyHeadless(character)
        end
    end)
end

local function headlessOff()
    if headConn then
        headConn:Disconnect()
        headConn = nil
    end

    restoreHead()
end

--========================================================
-- KORBLOX
--========================================================

local korbloxConns = {}
local korbloxOriginal = {}

local function applyKorblox()
    if not _G.SHADOW_States["KORBLOX"] then return end

    local character = player.Character
    if not character then return end

    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    if character:FindFirstChild("KorbloxFolder") then return end

    local folder = Instance.new("Folder")
    folder.Name = "KorbloxFolder"
    folder.Parent = character

    local function hidePart(part)
        if not part then return false end

        korbloxOriginal[part] = part.Transparency
        part.Transparency = 1

        return true
    end

    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        local upper = character:WaitForChild("RightUpperLeg", 3)
        local lower = character:WaitForChild("RightLowerLeg", 3)
        local foot = character:WaitForChild("RightFoot", 3)

        if not (upper and lower and foot) then
            folder:Destroy()
            return
        end

        hidePart(upper)
        hidePart(lower)
        hidePart(foot)

        local part = Instance.new("Part")
        part.Name = "KorbloxR15Visual"
        part.Size = Vector3.new(1, 2, 1)
        part.Transparency = 1
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
        part.Massless = true
        part.Parent = folder

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshId = "rbxassetid://902942096"
        mesh.TextureId = "rbxassetid://902843398"
        mesh.Parent = part

        local weld = Instance.new("Weld")
        weld.Part0 = upper
        weld.Part1 = part
        weld.C0 = CFrame.new(0.1, 0.2, 0)
        weld.Parent = part

    elseif humanoid.RigType == Enum.HumanoidRigType.R6 then
        local leg = character:WaitForChild("Right Leg", 3)
        if not leg then
            folder:Destroy()
            return
        end

        for _, obj in ipairs(character:GetChildren()) do
            if obj:IsA("CharacterMesh")
            and obj.BodyPart == Enum.BodyPart.RightLeg then
                obj:Destroy()
            end
        end

        hidePart(leg)

        local part = Instance.new("Part")
        part.Name = "KorbloxR6Visual"
        part.Size = Vector3.new(1, 2, 1)
        part.Transparency = 1
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
        part.Massless = true
        part.Parent = folder

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://101851696"
        mesh.TextureId = "rbxassetid://101851254"
        mesh.Parent = part

        local weld = Instance.new("Weld")
        weld.Part0 = leg
        weld.Part1 = part
        weld.C0 = CFrame.new()
        weld.Parent = part
    end
end

local function korbloxOn()
    if player.Character then
        task.spawn(applyKorblox)
    end

    table.insert(korbloxConns,
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            applyKorblox()
        end)
    )
end

local function korbloxOff()
    for _, connection in ipairs(korbloxConns) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    korbloxConns = {}

    local character = player.Character

    if character then
        local folder = character:FindFirstChild("KorbloxFolder")
        if folder then
            folder:Destroy()
        end
    end

    for part, transparency in pairs(korbloxOriginal) do
        if part and part.Parent then
            pcall(function()
                part.Transparency = transparency
            end)
        end
    end

    korbloxOriginal = {}
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
-- REGISTRO: SOMENTE OS 3 RECURSOS
--========================================================

CreateToggle("2024 QUALITY", q24On, q24Off)
CreateToggle("HEADLESS", headlessOn, headlessOff)
CreateToggle("KORBLOX", korbloxOn, korbloxOff)

print("[SHADOW HUB] Pronto! 3 botões carregados.")
