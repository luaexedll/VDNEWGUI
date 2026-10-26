-- SKVGui part1
local SKVGui = {}
function SKVGui.BuildFrame(S, Ctx)
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SKV_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Размер и позиция окна из настроек
local winW = S.WindowWidth or 750
local winH = S.WindowHeight or 580
local winX = S.WindowX or 0
local winY = S.WindowY or 0

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, winW, 0, winH)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 13)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Размеры интерфейса
local HEADER_HEIGHT = 36
local SCROLLBAR_WIDTH = 8
local CONTENT_WIDTH = winW - SCROLLBAR_WIDTH
local CONTENT_HEIGHT = winH - HEADER_HEIGHT

-- === Заголовок окна ===
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, HEADER_HEIGHT)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local hdrCorner = Instance.new("UICorner", Header)
hdrCorner.CornerRadius = UDim.new(0, 14)

-- Линейка файла
local fileLine = Instance.new("Frame")
fileLine.Size = UDim2.new(1, 0, 0, 1)
fileLine.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
fileLine.BorderSizePixel = 0
fileLine.Parent = Header

-- Текст заголовка
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 8, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "SKV - настройки"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = Header

-- Кнопки управления окном
local function makeBtn(size, imagePath)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, size, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    b.Text = ""
    b.BorderSizePixel = 0
    b.Parent = Header
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 4)
    local img = Instance.new("ImageLabel", b)
    img.Size = UDim2.new(1, 0, 1, 0)
    img.BackgroundTransparency = 1
    img.Image = imagePath
    img.TintColor = Color3.fromRGB(255, 255, 255)
    return b
end

local btnMin = makeBtn(24, "rbxassetid://263948")
local btnMax = makeBtn(24, "rbxassetid://237851")
local btnClose = makeBtn(24, "rbxassetid://283205")

btnMin.Position = UDim2.new(1, -76, 0, 0)
btnMax.Position = UDim2.new(1, -52, 0, 0)
btnClose.Position = UDim2.new(1, -28, 0, 0)

local dragging = false
local dragStart = nil
local startPos = nil

-- Перетаскивание за заголовок
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not Ctx.isInteracting then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        Ctx.isInteracting = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement and not Ctx.isInteracting then
        local d = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- Кнопки: минимизировать, развернуть, закрыть
local function closeWin()
    pcall(function()
        if S.FullCleanup then S.FullCleanup() end
        if MainFrame and MainFrame.Parent then MainFrame:Destroy() end
    end)
end

btnClose.MouseButton1Click:Connect(function()
    closeWin()
end)

btnMax.MouseButton1Click:Connect(function()
    -- Сворачивание/разворачивание реализуется в следующих модулях
end)

btnMin.MouseButton1Click:Connect(function()
    MainFrame.Size = UDim2.new(0, 300, 0, 60)
    MainFrame.Position = UDim2.new(0.5, -150, 0.85, 0)
end)
Ctx.ScreenGui = ScreenGui
Ctx.MainFrame = MainFrame
Ctx.UIS = UIS
Ctx.Tween = TweenService
Ctx.LocalPlayer = LocalPlayer
return ScreenGui, MainFrame
end
return SKVGui
