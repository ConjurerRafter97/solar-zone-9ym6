--Made by I_JustTrySomething (credit if posting a video)
--Feel free to edit if you know what you doing.
--PS: Right Shift keybind to minimize GUI
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()

--==================================================
-- SERVICES
--==================================================

local P = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local Animals = workspace:WaitForChild("Animals")
local Player = P.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "Realistic Hunting MENU"
Gui.ResetOnSpawn = false
Gui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(270, 370)
Main.Position = UDim2.new(.5, -135, .5, -185)
Main.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.ZIndex = 2
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local S = Instance.new("UIStroke", Main)
S.Color = Color3.fromRGB(85, 105, 130)
S.Thickness = 1.5
S.Transparency = 0.1

--==================================================
-- MAIN GUI
--==================================================

local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "MainShadow"
MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MainShadow.Position = UDim2.fromScale(0.5, 0.5)
MainShadow.Size = UDim2.new(1, 45, 1, 45)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxassetid://6014261993"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.35
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(49, 49, 450, 450)
MainShadow.ZIndex = 1
MainShadow.Parent = Main

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 0, 35)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "Realistic Hunting MENU"
Title.TextColor3 = Color3.fromRGB(235, 235, 245)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = Main

--==================================================
-- MINIMIZE BUTTON
--==================================================

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(27, 27)
Minimize.Position = UDim2.new(1, -62, 0, 4)
Minimize.BackgroundColor3 = Color3.fromRGB(45, 46, 57)
Minimize.Text = "_"
Minimize.TextColor3 = Color3.fromRGB(190, 200, 215)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 19
Minimize.ZIndex = 3
Minimize.Parent = Main

Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 7)

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(27, 27)
Close.Position = UDim2.new(1, -32, 0, 4)
Close.BackgroundColor3 = Color3.fromRGB(45, 46, 57)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 100, 110)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Close.ZIndex = 3
Close.Parent = Main

Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 7)

--==================================================
-- MINIMIZE DEER ICON
--==================================================

local MiniButton = Instance.new("TextButton")
MiniButton.Name = "DeerMiniButton"
MiniButton.Size = UDim2.fromOffset(52, 52)

MiniButton.Position = UDim2.new(
    Main.Position.X.Scale,
    Main.Position.X.Offset + 10,
    Main.Position.Y.Scale,
    Main.Position.Y.Offset + 10
)

MiniButton.BackgroundColor3 = Color3.fromRGB(24, 25, 32)
MiniButton.BorderSizePixel = 0
MiniButton.Text = "🦌"
MiniButton.TextColor3 = Color3.fromRGB(235, 235, 245)
MiniButton.Font = Enum.Font.GothamBold
MiniButton.TextSize = 27
MiniButton.Visible = false
MiniButton.AutoButtonColor = true
MiniButton.ZIndex = 3
MiniButton.Parent = Gui

Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(0, 13)

local MiniStroke = Instance.new("UIStroke", MiniButton)
MiniStroke.Color = S.Color
MiniStroke.Thickness = S.Thickness
MiniStroke.Transparency = S.Transparency
MiniStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

--==================================================
-- DEER ICON SHADOW
--==================================================

local MiniShadow = Instance.new("ImageLabel")
MiniShadow.Name = "MiniShadow"
MiniShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MiniShadow.Position = UDim2.fromScale(0.5, 0.5)
MiniShadow.Size = UDim2.new(1, 30, 1, 30)
MiniShadow.BackgroundTransparency = 1
MiniShadow.Image = "rbxassetid://6014261993"
MiniShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MiniShadow.ImageTransparency = 0.25
MiniShadow.ScaleType = Enum.ScaleType.Slice
MiniShadow.SliceCenter = Rect.new(49, 49, 450, 450)
MiniShadow.ZIndex = 2
MiniShadow.Parent = MiniButton

--==================================================
-- VARIABLES
--==================================================

local Objects = {}
local Connections = {}
local PlayerObjects = {}
local PlayerConnections = {}

local Enabled = false
local PlayersEnabled = false
local Flying = false
local Closed = false
local Minimized = false
local Transitioning = false

--==================================================
-- MINIMIZE / RESTORE ANIMATIONS
--==================================================

local AnimationInfo = TweenInfo.new(
    0.42,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.InOut
)

local MainOriginalPosition = Main.Position
local MainOriginalSize = Main.Size

local MiniOriginalPosition = MiniButton.Position
local MiniPositionInitialized = false

local MainTransparencyValues = nil

local function CaptureMainTransparency()
    if MainTransparencyValues then
        return
    end

    MainTransparencyValues = {}

    local function SaveProperty(Object, Property)
        local Success, Value = pcall(function()
            return Object[Property]
        end)

        if Success then
            MainTransparencyValues[#MainTransparencyValues + 1] = {
                Object = Object,
                Property = Property,
                Value = Value
            }
        end
    end

    local function CaptureObject(Object)
        if Object:IsA("GuiObject") then
            SaveProperty(Object, "BackgroundTransparency")
        end

        if Object:IsA("TextLabel")
        or Object:IsA("TextButton")
        or Object:IsA("TextBox") then
            SaveProperty(Object, "TextTransparency")
            SaveProperty(Object, "TextStrokeTransparency")
        end

        if Object:IsA("ImageLabel")
        or Object:IsA("ImageButton") then
            SaveProperty(Object, "ImageTransparency")
        end

        if Object:IsA("UIStroke") then
            SaveProperty(Object, "Transparency")
        end
    end

    CaptureObject(Main)

    for _, Object in ipairs(Main:GetDescendants()) do
        CaptureObject(Object)
    end
end

local function TweenMainTransparency(FadeOut)
    CaptureMainTransparency()

    for _, Entry in ipairs(MainTransparencyValues) do
        local Object = Entry.Object

        if Object and Object.Parent then
            local Target = FadeOut and 1 or Entry.Value

            local Success, Tween = pcall(function()
                return TweenService:Create(
                    Object,
                    AnimationInfo,
                    {
                        [Entry.Property] = Target
                    }
                )
            end)

            if Success and Tween then
                Tween:Play()
            end
        end
    end
end

local function MinimizeGUI()
    if Closed or Minimized or Transitioning then
        return
    end

    Transitioning = true
    Minimized = true

    MainOriginalPosition = Main.Position

    if not MiniPositionInitialized then
        MiniOriginalPosition = UDim2.new(
            MainOriginalPosition.X.Scale,
            MainOriginalPosition.X.Offset + 10,
            MainOriginalPosition.Y.Scale,
            MainOriginalPosition.Y.Offset + 10
        )

        MiniPositionInitialized = true
    end

    MiniButton.Position = UDim2.new(
        MiniOriginalPosition.X.Scale,
        MiniOriginalPosition.X.Offset + 26,
        MiniOriginalPosition.Y.Scale,
        MiniOriginalPosition.Y.Offset + 26
    )

    MiniButton.Size = UDim2.fromOffset(0, 0)
    MiniButton.BackgroundTransparency = 1
    MiniButton.TextTransparency = 1
    MiniStroke.Transparency = 1
    MiniShadow.ImageTransparency = 1

    MiniButton.Visible = true

    local MainTween = TweenService:Create(
        Main,
        AnimationInfo,
        {
            Size = UDim2.new(
                MainOriginalSize.X.Scale,
                MainOriginalSize.X.Offset,
                0,
                0
            )
        }
    )

    local MiniTween = TweenService:Create(
        MiniButton,
        AnimationInfo,
        {
            Position = MiniOriginalPosition,
            Size = UDim2.fromOffset(52, 52),
            BackgroundTransparency = 0,
            TextTransparency = 0
        }
    )

    local MiniStrokeTween = TweenService:Create(
        MiniStroke,
        AnimationInfo,
        {
            Transparency = S.Transparency
        }
    )

    local MiniShadowTween = TweenService:Create(
        MiniShadow,
        AnimationInfo,
        {
            ImageTransparency = 0.25
        }
    )

    TweenMainTransparency(true)

    MainTween:Play()
    MiniTween:Play()
    MiniStrokeTween:Play()
    MiniShadowTween:Play()

    MainTween.Completed:Wait()

    if Closed then
        return
    end

    Main.Visible = false
    Main.Size = MainOriginalSize
    Main.Position = MainOriginalPosition

    Transitioning = false
end

local function RestoreGUI()
    if Closed or not Minimized or Transitioning then
        return
    end

    Transitioning = true
    Minimized = false

    Main.Position = MainOriginalPosition
    Main.Size = UDim2.new(
        MainOriginalSize.X.Scale,
        MainOriginalSize.X.Offset,
        0,
        0
    )

    Main.Visible = true

    CaptureMainTransparency()

    for _, Entry in ipairs(MainTransparencyValues) do
        local Object = Entry.Object

        if Object and Object.Parent then
            pcall(function()
                Object[Entry.Property] = 1
            end)
        end
    end

    MiniButton.Position = MiniOriginalPosition
    MiniButton.Size = UDim2.fromOffset(52, 52)

    local MainTween = TweenService:Create(
        Main,
        AnimationInfo,
        {
            Size = MainOriginalSize
        }
    )

    local MiniTween = TweenService:Create(
        MiniButton,
        AnimationInfo,
        {
            Position = UDim2.new(
                MiniOriginalPosition.X.Scale,
                MiniOriginalPosition.X.Offset + 26,
                MiniOriginalPosition.Y.Scale,
                MiniOriginalPosition.Y.Offset + 26
            ),
            Size = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
            TextTransparency = 1
        }
    )

    local MiniStrokeTween = TweenService:Create(
        MiniStroke,
        AnimationInfo,
        {
            Transparency = 1
        }
    )

    local MiniShadowTween = TweenService:Create(
        MiniShadow,
        AnimationInfo,
        {
            ImageTransparency = 1
        }
    )

    TweenMainTransparency(false)

    MainTween:Play()
    MiniTween:Play()
    MiniStrokeTween:Play()
    MiniShadowTween:Play()

    MainTween.Completed:Wait()

    if Closed then
        return
    end

    MiniButton.Visible = false
    MiniButton.Size = UDim2.fromOffset(52, 52)
    MiniButton.BackgroundTransparency = 0
    MiniButton.TextTransparency = 0
    MiniStroke.Transparency = S.Transparency
    MiniShadow.ImageTransparency = 0.25

    MiniButton.Position = MiniOriginalPosition

    Transitioning = false
end

local function ToggleMinimize()
    if Minimized then
        RestoreGUI()
    else
        MinimizeGUI()
    end
end

Minimize.MouseButton1Click:Connect(MinimizeGUI)

--==================================================
-- TOGGLES
--==================================================

local function MakeToggle(Y, Name, Subtitle, Height)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, -24, 0, Height or 52)
    B.Position = UDim2.fromOffset(12, Y)
    B.BackgroundColor3 = Color3.fromRGB(42, 43, 54)
    B.Text = ""
    B.ZIndex = 3
    B.Parent = Main

    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)

    local T = Instance.new("TextLabel")
    T.Size = UDim2.new(1, -58, 0, 22)
    T.Position = UDim2.fromOffset(12, Subtitle and 3 or 0)
    T.BackgroundTransparency = 1
    T.Text = Name
    T.TextColor3 = Color3.fromRGB(235, 235, 245)
    T.Font = Enum.Font.GothamMedium
    T.TextSize = 13
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.ZIndex = 4
    T.Parent = B

    if Subtitle then
        local Sub = Instance.new("TextLabel")
        Sub.Size = UDim2.new(1, -24, 0, 20)
        Sub.Position = UDim2.fromOffset(12, 25)
        Sub.BackgroundTransparency = 1
        Sub.Text = Subtitle
        Sub.TextColor3 = Color3.fromRGB(175, 180, 195)
        Sub.Font = Enum.Font.Gotham
        Sub.TextSize = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.TextYAlignment = Enum.TextYAlignment.Center
        Sub.ZIndex = 4
        Sub.Parent = B
    end

    local Sw = Instance.new("Frame")
    Sw.Size = UDim2.fromOffset(32, 18)
    Sw.Position = UDim2.new(1, -42, .5, -9)
    Sw.BackgroundColor3 = Color3.fromRGB(75, 75, 85)
    Sw.ZIndex = 4
    Sw.Parent = B

    Instance.new("UICorner", Sw).CornerRadius = UDim.new(1, 0)

    local K = Instance.new("Frame")
    K.Size = UDim2.fromOffset(14, 14)
    K.Position = UDim2.fromOffset(2, 2)
    K.BackgroundColor3 = Color3.new(1, 1, 1)
    K.ZIndex = 5
    K.Parent = Sw

    Instance.new("UICorner", K).CornerRadius = UDim.new(1, 0)

    local function Update(V)
        Sw.BackgroundColor3 = V
            and Color3.fromRGB(18, 145, 125)
            or Color3.fromRGB(75, 75, 85)

        K.Position = V
            and UDim2.fromOffset(16, 2)
            or UDim2.fromOffset(2, 2)
    end

    return B, Update
end

local AnimalButton, AnimalVisual =
    MakeToggle(43, "Animals ESP", "X = DOWN,  Space = UP")

local FlyButton, FlyVisual = MakeToggle(
    163,
    "Flying",
    "NumPad 1 = decrease, NumPad 2 = increase",
    76
)

local PlayerButton, PlayerVisual = MakeToggle(
    103,
    "Players ESP",
    "Names and distance from you",
    52
)

--==================================================
-- TP BUTTON
--==================================================

local AutoTPButton = Instance.new("TextButton")
AutoTPButton.Size = UDim2.new(1, -24, 0, 52)
AutoTPButton.Position = UDim2.fromOffset(12, 247)
AutoTPButton.BackgroundColor3 = Color3.fromRGB(42, 43, 54)
AutoTPButton.Text = ""
AutoTPButton.ZIndex = 3
AutoTPButton.Parent = Main

Instance.new("UICorner", AutoTPButton).CornerRadius = UDim.new(0, 8)

local AutoTPTitle = Instance.new("TextLabel")
AutoTPTitle.Size = UDim2.new(1, -95, 0, 22)
AutoTPTitle.Position = UDim2.fromOffset(12, 3)
AutoTPTitle.BackgroundTransparency = 1
AutoTPTitle.Text = "Auto claim Dead animals"
AutoTPTitle.TextColor3 = Color3.fromRGB(235, 235, 245)
AutoTPTitle.Font = Enum.Font.GothamMedium
AutoTPTitle.TextSize = 12
AutoTPTitle.TextXAlignment = Enum.TextXAlignment.Left
AutoTPTitle.ZIndex = 4
AutoTPTitle.Parent = AutoTPButton

local AutoTPSubtitle = Instance.new("TextLabel")
AutoTPSubtitle.Size = UDim2.new(1, -24, 0, 20)
AutoTPSubtitle.Position = UDim2.fromOffset(12, 25)
AutoTPSubtitle.BackgroundTransparency = 1
AutoTPSubtitle.Text = "Teleport to your tagged animal"
AutoTPSubtitle.TextColor3 = Color3.fromRGB(175, 180, 195)
AutoTPSubtitle.Font = Enum.Font.Gotham
AutoTPSubtitle.TextSize = 10
AutoTPSubtitle.TextXAlignment = Enum.TextXAlignment.Left
AutoTPSubtitle.ZIndex = 4
AutoTPSubtitle.Parent = AutoTPButton

local AutoTPKey = Instance.new("TextLabel")
AutoTPKey.Size = UDim2.fromOffset(82, 17)
AutoTPKey.Position = UDim2.new(1, -91, 0, 4)
AutoTPKey.BackgroundColor3 = Color3.fromRGB(55, 65, 80)
AutoTPKey.Text = "[ NumPad 3 ]"
AutoTPKey.TextColor3 = Color3.fromRGB(100, 210, 190)
AutoTPKey.Font = Enum.Font.GothamBold
AutoTPKey.TextSize = 9
AutoTPKey.ZIndex = 4
AutoTPKey.Parent = AutoTPButton

Instance.new("UICorner", AutoTPKey).CornerRadius = UDim.new(0, 5)

--==================================================
-- SHOP TP BUTTON
--==================================================

local ShopTPButton = Instance.new("TextButton")
ShopTPButton.Size = UDim2.new(1, -24, 0, 48)
ShopTPButton.Position = UDim2.fromOffset(12, 307)
ShopTPButton.BackgroundColor3 = Color3.fromRGB(42, 43, 54)
ShopTPButton.Text = ""
ShopTPButton.ZIndex = 3
ShopTPButton.Parent = Main

Instance.new("UICorner", ShopTPButton).CornerRadius = UDim.new(0, 8)

local ShopTPTitle = Instance.new("TextLabel")
ShopTPTitle.Size = UDim2.new(1, -24, 0, 22)
ShopTPTitle.Position = UDim2.fromOffset(12, 3)
ShopTPTitle.BackgroundTransparency = 1
ShopTPTitle.Text = "TP to Gunshop"
ShopTPTitle.TextColor3 = Color3.fromRGB(235, 235, 245)
ShopTPTitle.Font = Enum.Font.GothamMedium
ShopTPTitle.TextSize = 13
ShopTPTitle.TextXAlignment = Enum.TextXAlignment.Left
ShopTPTitle.ZIndex = 4
ShopTPTitle.Parent = ShopTPButton

local ShopTPSubtitle = Instance.new("TextLabel")
ShopTPSubtitle.Size = UDim2.new(1, -24, 0, 18)
ShopTPSubtitle.Position = UDim2.fromOffset(12, 25)
ShopTPSubtitle.BackgroundTransparency = 1
ShopTPSubtitle.Text = "Teleport to the gun shop"
ShopTPSubtitle.TextColor3 = Color3.fromRGB(175, 180, 195)
ShopTPSubtitle.Font = Enum.Font.Gotham
ShopTPSubtitle.TextSize = 10
ShopTPSubtitle.TextXAlignment = Enum.TextXAlignment.Left
ShopTPSubtitle.ZIndex = 4
ShopTPSubtitle.Parent = ShopTPButton

--==================================================
-- FLY KEYBIND DISPLAY
--==================================================

local FlyKey = Instance.new("TextLabel")
FlyKey.Size = UDim2.fromOffset(43, 17)
FlyKey.Position = UDim2.new(1, -54, 0, 4)
FlyKey.BackgroundColor3 = Color3.fromRGB(55, 65, 80)
FlyKey.Text = "[ Y ]"
FlyKey.TextColor3 = Color3.fromRGB(100, 210, 190)
FlyKey.Font = Enum.Font.GothamBold
FlyKey.TextSize = 10
FlyKey.ZIndex = 4
FlyKey.Parent = FlyButton

Instance.new("UICorner", FlyKey).CornerRadius = UDim.new(0, 5)

--==================================================
-- FLY SPEED DISPLAY
--==================================================

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, -75, 0, 20)
SpeedTitle.Position = UDim2.fromOffset(12, 51)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "CURRENT FLY SPEED"
SpeedTitle.TextColor3 = Color3.fromRGB(175, 180, 195)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 10
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.ZIndex = 4
SpeedTitle.Parent = FlyButton

local SpeedValue = Instance.new("TextLabel")
SpeedValue.Size = UDim2.fromOffset(55, 20)
SpeedValue.Position = UDim2.new(1, -65, 0, 51)
SpeedValue.BackgroundTransparency = 1
SpeedValue.Text = "70"
SpeedValue.TextColor3 = Color3.fromRGB(65, 210, 180)
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextSize = 15
SpeedValue.TextXAlignment = Enum.TextXAlignment.Right
SpeedValue.ZIndex = 4
SpeedValue.Parent = FlyButton

--==================================================
-- ANIMAL GRADE COLORS
--==================================================

local GradeColors = {
    bronze = Color3.fromRGB(205, 127, 50),
    silver = Color3.fromRGB(230, 230, 240),
    gold = Color3.fromRGB(255, 215, 0),
    diamond = Color3.fromRGB(85, 190, 255),

    common = Color3.fromRGB(200, 200, 200),
    uncommon = Color3.fromRGB(80, 220, 100),
    rare = Color3.fromRGB(65, 150, 255),
    epic = Color3.fromRGB(180, 85, 255),
    legendary = Color3.fromRGB(255, 165, 0),
    mythic = Color3.fromRGB(255, 70, 100),
    divine = Color3.fromRGB(255, 120, 210),
    secret = Color3.fromRGB(255, 255, 255),
    platinum = Color3.fromRGB(150, 220, 255)
}

local function GetGradeColor(G)
    if G == nil then
        return Color3.new(1, 1, 1)
    end

    local Name = tostring(G):lower()
    return GradeColors[Name] or Color3.new(1, 1, 1)
end

--==================================================
-- ANIMAL TAG CHECK
--==================================================

local function GetTagPrompt(M)
    local TagSpot = M:FindFirstChild("TagSpot", true)

    if not TagSpot then
        return nil
    end

    return TagSpot:FindFirstChild("TagPrompt", true)
end

local function GetAnimalOwnerId(M)
    local Prompt = GetTagPrompt(M)

    if not Prompt then
        return nil, nil
    end

    return Prompt:GetAttribute("OwnerId"), Prompt
end

local function IsTaggedByOtherPlayer(M)
    local OwnerId = GetAnimalOwnerId(M)

    if OwnerId == nil then
        return false
    end

    return tonumber(OwnerId) ~= Player.UserId
end

--==================================================
-- ANIMAL SCANNER
--==================================================

local AnimalRepairQueue = {}
local AnimalRepairWorkerRunning = false

local function Grade(M)
    local G = M:GetAttribute("Grade")

    if G == nil then
        local V = M:FindFirstChild("Grade", true)

        if V and V:IsA("ValueBase") then
            G = V.Value
        end
    end

    return G
end

--==================================================
-- QUEUE ANIMAL ESP REPAIR
--==================================================

local function QueueAnimalRepair(M)
    if not Enabled or Closed then
        return
    end

    if not Objects[M] then
        return
    end

    AnimalRepairQueue[M] = true
end

--==================================================
-- REMOVE ANIMAL
--==================================================

local function Remove(M)
    local Entry = Objects[M]

    if not Entry then
        return
    end

    if Entry.OwnerConnection then
        Entry.OwnerConnection:Disconnect()
    end

    if Entry.HighlightConnection then
        Entry.HighlightConnection:Disconnect()
    end

    if Entry.BillboardConnection then
        Entry.BillboardConnection:Disconnect()
    end

    if Entry.LabelConnection then
        Entry.LabelConnection:Disconnect()
    end

    if Entry.Highlight then
        Entry.Highlight:Destroy()
    end

    if Entry.Billboard then
        Entry.Billboard:Destroy()
    end

    Objects[M] = nil
    AnimalRepairQueue[M] = nil
end

--==================================================
-- CREATE ANIMAL ESP
--==================================================

local function CreateAnimalHighlight(M, Entry)
    if not M or not M.Parent then
        return
    end

    if Entry.Highlight and Entry.Highlight.Parent then
        return
    end

    local H = Instance.new("Highlight")
    H.Name = "AnimalESPHighlight"
    H.Adornee = M
    H.FillColor = Color3.fromRGB(18, 100, 100)
    H.OutlineColor = Color3.fromRGB(255, 165, 0)
    H.FillTransparency = .45
    H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    H.Parent = M

    Entry.Highlight = H

    if Entry.HighlightConnection then
        Entry.HighlightConnection:Disconnect()
    end

    Entry.HighlightConnection = H.Destroying:Connect(function()
        QueueAnimalRepair(M)
    end)
end

--==================================================
-- CREATE ANIMAL LABEL
--==================================================

local function CreateAnimalLabel(M, Entry)
    if not M or not M.Parent then
        return
    end

    if Entry.Billboard and Entry.Billboard.Parent
    and Entry.Label and Entry.Label.Parent then
        return
    end

    local Part = M:FindFirstChildWhichIsA("BasePart", true)

    if not Part then
        return
    end

    if Entry.BillboardConnection then
        Entry.BillboardConnection:Disconnect()
        Entry.BillboardConnection = nil
    end

    if Entry.LabelConnection then
        Entry.LabelConnection:Disconnect()
        Entry.LabelConnection = nil
    end

    if Entry.Billboard then
        Entry.Billboard:Destroy()
    end

    local B = Instance.new("BillboardGui")
    B.Name = "GradeLabel"
    B.Adornee = Part
    B.Size = UDim2.fromOffset(180, 25)
    B.StudsOffset = Vector3.new(0, 3, 0)
    B.AlwaysOnTop = true
    B.Parent = M

    Entry.Billboard = B

    local L = Instance.new("TextLabel")
    L.Size = UDim2.fromScale(1, 1)
    L.BackgroundTransparency = 1

    local G = Grade(M)

    L.Text = (G ~= nil and tostring(G):lower() or "unknown")
        .. " | "
        .. M.Name

    L.TextColor3 = GetGradeColor(G)
    L.TextStrokeTransparency = .25
    L.Font = Enum.Font.GothamBold
    L.TextSize = 13
    L.Parent = B

    Entry.Label = L

    Entry.BillboardConnection = B.Destroying:Connect(function()
        QueueAnimalRepair(M)
    end)

    Entry.LabelConnection = L.Destroying:Connect(function()
        QueueAnimalRepair(M)
    end)
end

--==================================================
-- ANIMAL OWNER TRACKING
--==================================================

local function ConnectAnimalOwner(M, Entry)
    local _, Prompt = GetAnimalOwnerId(M)

    if not Prompt then
        return
    end

    if Entry.OwnerPrompt == Prompt
    and Entry.OwnerConnection then
        return
    end

    if Entry.OwnerConnection then
        Entry.OwnerConnection:Disconnect()
        Entry.OwnerConnection = nil
    end

    Entry.OwnerPrompt = Prompt

    Entry.OwnerConnection =
        Prompt:GetAttributeChangedSignal("OwnerId"):Connect(function()
            if not Enabled or Closed then
                return
            end

            if IsTaggedByOtherPlayer(M) then
                Remove(M)
            else
                QueueAnimalRepair(M)
            end
        end)
end

--==================================================
-- ENSURE ANIMAL ESP EXISTS
--==================================================

local function Add(M)
    if not Enabled or Closed then
        return
    end

    if not M or not M:IsA("Model") or not M.Parent then
        return
    end

    if IsTaggedByOtherPlayer(M) then
        Remove(M)
        return
    end

    local Entry = Objects[M]

    if not Entry then
        Entry = {
            Highlight = nil,
            Billboard = nil,
            Label = nil,

            OwnerConnection = nil,
            OwnerPrompt = nil,

            HighlightConnection = nil,
            BillboardConnection = nil,
            LabelConnection = nil
        }

        Objects[M] = Entry
    end

    ConnectAnimalOwner(M, Entry)

    CreateAnimalHighlight(M, Entry)
    CreateAnimalLabel(M, Entry)
end

--==================================================
-- ANIMAL REPAIR 
--==================================================

local function StartAnimalRepairWorker()
    if AnimalRepairWorkerRunning then
        return
    end

    AnimalRepairWorkerRunning = true

    task.spawn(function()
        while Enabled and not Closed do
            for M in pairs(AnimalRepairQueue) do
                AnimalRepairQueue[M] = nil

                local Entry = Objects[M]

                if Entry and M.Parent then
                    if IsTaggedByOtherPlayer(M) then
                        Remove(M)
                    else
                        ConnectAnimalOwner(M, Entry)

                        CreateAnimalHighlight(M, Entry)
                        CreateAnimalLabel(M, Entry)
                    end
                end
            end

            task.wait(0.3)
        end

        AnimalRepairWorkerRunning = false
    end)
end

--==================================================
-- CLEAR ANIMALS
--==================================================

local function ClearAnimals()
    for M in pairs(Objects) do
        Remove(M)
    end

    table.clear(AnimalRepairQueue)
end

--==================================================
-- ANIMAL TOGGLE
--==================================================

AnimalButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    AnimalVisual(Enabled)

    if Enabled then
        for _, M in ipairs(Animals:GetDescendants()) do
            if M:IsA("Model") then
                Add(M)
            end
        end

        StartAnimalRepairWorker()
    else
        ClearAnimals()
    end
end)

--==================================================
-- ANIMAL ADDED
--==================================================

Connections[#Connections + 1] = Animals.DescendantAdded:Connect(function(M)
    if not Enabled or Closed then
        return
    end

    if M:IsA("Model") then
        Add(M)
        return
    end

    local Model = M:FindFirstAncestorOfClass("Model")

    if not Model then
        return
    end

    if M:IsA("BasePart") then
        if Objects[Model] then
            QueueAnimalRepair(Model)
        else
            Add(Model)
        end

        return
    end

    if M.Name == "Grade"
    or M.Name == "TagPrompt"
    or M.Name == "TagSpot" then

        Remove(Model)
        Add(Model)
    end
end)

--==================================================
-- Auto claim Dead animals
--==================================================

local AutoTPRunning = false

local function AutoTeleportToDeadAnimal()
    if Closed or AutoTPRunning then
        return
    end

    AutoTPRunning = true

    task.spawn(function()
        while not Closed do
            local Character = Player.Character

            if not Character then
                break
            end

            local HRP = Character:FindFirstChild("HumanoidRootPart")

            if not HRP then
                break
            end

            local FoundAnimal = false

            for _, M in ipairs(Animals:GetDescendants()) do
                if M:IsA("Model") then
                    local OwnerId, Prompt = GetAnimalOwnerId(M)

                    if Prompt and OwnerId ~= nil then
                        if tonumber(OwnerId) == Player.UserId then

                            local TagSpot = M:FindFirstChild("TagSpot", true)

                            if TagSpot and TagSpot:IsA("Attachment") then
                                FoundAnimal = true

                                local TargetPosition = TagSpot.WorldPosition

                                local ParentPart = TagSpot.Parent
                                local HeightOffset = 0

                                if ParentPart and ParentPart:IsA("BasePart") then
                                    HeightOffset = ParentPart.Size.Y * 0.60
                                end

                                local CurrentPivot = Character:GetPivot()
                                local Rotation = CurrentPivot - CurrentPivot.Position

                                Character:PivotTo(
                                    CFrame.new(
                                        TargetPosition + Vector3.new(0, HeightOffset, 0)
                                    ) * Rotation
                                )

                                local BodyPart = M:FindFirstChild("Body", true)

                                if BodyPart and BodyPart:IsA("BasePart") then
                                    task.wait()

                                    local Camera = workspace.CurrentCamera

                                    if Camera then
                                        Camera.CFrame = CFrame.lookAt(
                                            Camera.CFrame.Position,
                                            BodyPart.Position
                                        )

                                        Camera.Focus = CFrame.new(BodyPart.Position)
                                    end
                                end

                                -- SPAM TAG PROMPT UNTIL ANIMAL DISAPPEARS
                                if Prompt:IsA("ProximityPrompt") then
                                    Prompt.HoldDuration = 0.01

                                    while not Closed
                                        and M:IsDescendantOf(Animals)
                                        and Prompt.Parent do

                                        Prompt:InputHoldBegin()
                                        task.wait(0.01)
                                        Prompt:InputHoldEnd()
                                        task.wait(0.01)
                                    end
                                else
                                    while not Closed and M:IsDescendantOf(Animals) do
                                        task.wait(0.05)
                                    end
                                end

                                break
                            end
                        end
                    end
                end
            end

            if not FoundAnimal then
                break
            end
        end

        AutoTPRunning = false
    end)
end

AutoTPButton.MouseButton1Click:Connect(AutoTeleportToDeadAnimal)

--==================================================
-- TP TO SHOP
--==================================================

local function TeleportToShop()
    if Closed then
        return
    end

    local Character = Player.Character

    if not Character then
        return
    end

    Character:PivotTo(CFrame.new(
        -241, 55.5000458, 200,
        1, 0, 0,
        0, 1, 0,
        0, 0, 1
    ))
end

ShopTPButton.MouseButton1Click:Connect(TeleportToShop)

--==================================================
-- PLAYER ESP
--==================================================

local PlayerESPTable = {}
local PlayerRepairQueue = {}
local RepairWorkerRunning = false

--==================================================
-- REMOVE PLAYER CHARACTER
--==================================================

local function RemovePlayerCharacter(Character)
    local Entry = PlayerESPTable[Character]

    if not Entry then
        return
    end

    if Entry.HighlightConnection then
        Entry.HighlightConnection:Disconnect()
    end

    if Entry.BillboardConnection then
        Entry.BillboardConnection:Disconnect()
    end

    if Entry.LabelConnection then
        Entry.LabelConnection:Disconnect()
    end

    if Entry.Highlight then
        Entry.Highlight:Destroy()
    end

    if Entry.Billboard then
        Entry.Billboard:Destroy()
    end

    PlayerESPTable[Character] = nil
    PlayerRepairQueue[Character] = nil
end

--==================================================
-- QUEUE PLAYER ESP REPAIR
--==================================================

local function QueuePlayerRepair(Character)
    if not PlayersEnabled or Closed then
        return
    end

    if not PlayerESPTable[Character] then
        return
    end

    PlayerRepairQueue[Character] = true
end

--==================================================
-- CREATE PLAYER ESP
--==================================================

local function CreatePlayerHighlight(Character, Entry)
    if not Character or not Character.Parent then
        return
    end

    if Entry.Highlight and Entry.Highlight.Parent then
        return
    end

    local H = Instance.new("Highlight")
    H.Name = "PlayerESPHighlight"
    H.Adornee = Character
    H.FillColor = Color3.fromRGB(65, 100, 210)
    H.OutlineColor = Color3.fromRGB(120, 170, 255)
    H.FillTransparency = .45
    H.OutlineTransparency = 0
    H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    H.Parent = Character

    Entry.Highlight = H

    if Entry.HighlightConnection then
        Entry.HighlightConnection:Disconnect()
    end

    Entry.HighlightConnection = H.Destroying:Connect(function()
        QueuePlayerRepair(Character)
    end)
end

--==================================================
-- CREATE PLAYER LABEL
--==================================================

local function CreatePlayerLabel(TargetPlayer, Character, Entry)
    if Entry.LabelCreating then
        return
    end

    if Entry.Billboard and Entry.Billboard.Parent
    and Entry.Label and Entry.Label.Parent then
        return
    end

    Entry.LabelCreating = true

    task.spawn(function()
        local Head = Character:FindFirstChild("Head")

        if not Head then
            Head = Character:WaitForChild("Head", 5)
        end

        if not Head then
            Head = Character:FindFirstChild("HumanoidRootPart")
        end

        if Closed
        or not PlayersEnabled
        or PlayerESPTable[Character] ~= Entry
        or not Character.Parent then

            Entry.LabelCreating = false
            return
        end

        if not Head or not Head:IsA("BasePart") then
            Entry.LabelCreating = false
            return
        end

        if Entry.BillboardConnection then
            Entry.BillboardConnection:Disconnect()
            Entry.BillboardConnection = nil
        end

        if Entry.LabelConnection then
            Entry.LabelConnection:Disconnect()
            Entry.LabelConnection = nil
        end

        if Entry.Billboard then
            Entry.Billboard:Destroy()
        end

        local B = Instance.new("BillboardGui")
        B.Name = "PlayerESPLabel"
        B.Adornee = Head
        B.Size = UDim2.fromOffset(190, 38)
        B.StudsOffset = Vector3.new(0, 3, 0)
        B.AlwaysOnTop = true
        B.MaxDistance = 0
        B.Parent = PlayerGui

        Entry.Billboard = B

        local L = Instance.new("TextLabel")
        L.Size = UDim2.fromScale(1, 1)
        L.BackgroundTransparency = 1
        L.Text = TargetPlayer.Name .. " | -- studs"
        L.TextColor3 = Color3.fromRGB(255, 255, 255)
        L.TextStrokeTransparency = .2
        L.Font = Enum.Font.GothamBold
        L.TextSize = 13
        L.Parent = B

        Entry.Label = L
        Entry.LabelCreating = false

        Entry.BillboardConnection = B.Destroying:Connect(function()
            QueuePlayerRepair(Character)
        end)

        Entry.LabelConnection = L.Destroying:Connect(function()
            QueuePlayerRepair(Character)
        end)
    end)
end

--==================================================
-- ENSURE PLAYER ESP EXISTS
--==================================================

local function AddPlayerCharacter(TargetPlayer, Character)
    if not PlayersEnabled or Closed then
        return
    end

    if not TargetPlayer or TargetPlayer == Player then
        return
    end

    if not Character or not Character.Parent then
        return
    end

    local Entry = PlayerESPTable[Character]

    if not Entry then
        Entry = {
            Player = TargetPlayer,
            Highlight = nil,
            Billboard = nil,
            Label = nil,
            LabelCreating = false,
            HighlightConnection = nil,
            BillboardConnection = nil,
            LabelConnection = nil
        }

        PlayerESPTable[Character] = Entry
    end

    CreatePlayerHighlight(Character, Entry)
    CreatePlayerLabel(TargetPlayer, Character, Entry)
end

--==================================================
-- PLAYER REPAIR WORKER
--==================================================

local function StartPlayerRepairWorker()
    if RepairWorkerRunning then
        return
    end

    RepairWorkerRunning = true

    task.spawn(function()
        while PlayersEnabled and not Closed do

            -- Repair queued characters first
            for Character in pairs(PlayerRepairQueue) do
                PlayerRepairQueue[Character] = nil

                local Entry = PlayerESPTable[Character]

                if Entry and Character.Parent then
                    CreatePlayerHighlight(Character, Entry)
                    CreatePlayerLabel(Entry.Player, Character, Entry)
                end
            end

            -- Check ALL tracked characters every 0.3 seconds
            for Character, Entry in pairs(PlayerESPTable) do
                if Character.Parent then

                    -- Recreate missing highlight
                    if not Entry.Highlight or not Entry.Highlight.Parent then
                        CreatePlayerHighlight(Character, Entry)
                    end

                    -- Recreate missing label
                    if not Entry.Billboard
                    or not Entry.Billboard.Parent
                    or not Entry.Label
                    or not Entry.Label.Parent then

                        CreatePlayerLabel(Entry.Player, Character, Entry)
                    end

                else
                    RemovePlayerCharacter(Character)
                end
            end

            task.wait(0.3)
        end

        RepairWorkerRunning = false
    end)
end

--==================================================
-- TRACK PLAYERS
--==================================================

local function RemovePlayer(TargetPlayer)
    for Character, Entry in pairs(PlayerESPTable) do
        if Entry.Player == TargetPlayer then
            RemovePlayerCharacter(Character)
        end
    end
end

local function TrackPlayer(TargetPlayer)
    if not TargetPlayer or TargetPlayer == Player then
        return
    end

    if PlayerConnections[TargetPlayer] then
        return
    end

    local C = {}
    PlayerConnections[TargetPlayer] = C

    C[#C + 1] = TargetPlayer.CharacterAdded:Connect(function(Character)
        if PlayersEnabled and not Closed then
            AddPlayerCharacter(TargetPlayer, Character)
        end
    end)

    C[#C + 1] = TargetPlayer.CharacterRemoving:Connect(function(Character)
        RemovePlayerCharacter(Character)
    end)

    if PlayersEnabled and TargetPlayer.Character then
        AddPlayerCharacter(TargetPlayer, TargetPlayer.Character)
    end
end

local function StopTrackingPlayer(TargetPlayer)
    RemovePlayer(TargetPlayer)

    local C = PlayerConnections[TargetPlayer]

    if C then
        for _, Connection in ipairs(C) do
            Connection:Disconnect()
        end

        PlayerConnections[TargetPlayer] = nil
    end
end

local function ClearPlayers()
    for Character in pairs(PlayerESPTable) do
        RemovePlayerCharacter(Character)
    end

    table.clear(PlayerRepairQueue)
end

--==================================================
-- PLAYER DISTANCE UPDATE
--==================================================

local DistanceAccumulator = 0

Connections[#Connections + 1] = RS.Heartbeat:Connect(function(DeltaTime)
    if not PlayersEnabled or Closed then
        return
    end

    DistanceAccumulator += DeltaTime

    if DistanceAccumulator < 0.2 then
        return
    end

    DistanceAccumulator = 0

    local LocalCharacter = Player.Character
    local LocalRoot = LocalCharacter
        and LocalCharacter:FindFirstChild("HumanoidRootPart")

    for Character, Entry in pairs(PlayerESPTable) do
        if not Character.Parent then
            RemovePlayerCharacter(Character)

        elseif Entry.Label and Entry.Label.Parent then
            local TargetRoot = Character:FindFirstChild("HumanoidRootPart")

            if LocalRoot and TargetRoot then
                local Distance =
                    (LocalRoot.Position - TargetRoot.Position).Magnitude

                Entry.Label.Text = Entry.Player.Name
                    .. " | "
                    .. tostring(math.floor(Distance + 0.5))
                    .. " studs"
            else
                Entry.Label.Text = Entry.Player.Name .. " | -- studs"
            end
        end
    end
end)

--==================================================
-- TRACK CURRENT PLAYERS
--==================================================

for _, TargetPlayer in ipairs(P:GetPlayers()) do
    TrackPlayer(TargetPlayer)
end

Connections[#Connections + 1] = P.PlayerAdded:Connect(function(TargetPlayer)
    TrackPlayer(TargetPlayer)
end)

Connections[#Connections + 1] = P.PlayerRemoving:Connect(function(TargetPlayer)
    StopTrackingPlayer(TargetPlayer)
end)

PlayerButton.MouseButton1Click:Connect(function()
    PlayersEnabled = not PlayersEnabled
    PlayerVisual(PlayersEnabled)

    if PlayersEnabled then
        for _, TargetPlayer in ipairs(P:GetPlayers()) do
            if TargetPlayer ~= Player then
                TrackPlayer(TargetPlayer)

                if TargetPlayer.Character then
                    AddPlayerCharacter(TargetPlayer, TargetPlayer.Character)
                end
            end
        end

        StartPlayerRepairWorker()
    else
        ClearPlayers()
    end
end)

--==================================================
-- FLIGHT SYSTEM
--==================================================

local Speed = 70
local MinSpeed = 10
local MaxSpeed = 1000

local Character, HRP, Humanoid
local BodyGyro, BodyVelocity
local OldCollide = {}
local FlyConnection

local SpeedChangeKey = nil
local SpeedChangeGeneration = 0

local function UpdateSpeedDisplay()
    SpeedValue.Text = tostring(Speed)
end

local function ChangeSpeed(Key)
    if Key == Enum.KeyCode.KeypadOne then
        Speed = math.max(MinSpeed, Speed - 10)
    elseif Key == Enum.KeyCode.KeypadTwo then
        Speed = math.min(MaxSpeed, Speed + 10)
    end

    UpdateSpeedDisplay()
end

local function StopSpeedChange()
    SpeedChangeKey = nil
    SpeedChangeGeneration += 1
end

local function RestoreCollision()
    for Part, Value in pairs(OldCollide) do
        if Part and Part.Parent then
            Part.CanCollide = Value
        end
    end

    table.clear(OldCollide)
end

local function StopFlying()
    if not Flying then
        return
    end

    Flying = false
    FlyVisual(false)
    StopSpeedChange()

    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end

    if BodyGyro then
        BodyGyro:Destroy()
        BodyGyro = nil
    end

    if BodyVelocity then
        BodyVelocity:Destroy()
        BodyVelocity = nil
    end

    RestoreCollision()

    if Humanoid and Humanoid.Parent then
        Humanoid.PlatformStand = false
    end
end

local function StartFlying()
    if Flying or Closed then
        return
    end

    Character = Player.Character

    if not Character then
        return
    end

    HRP = Character:FindFirstChild("HumanoidRootPart")
    Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not HRP or not Humanoid then
        return
    end

    Flying = true
    FlyVisual(true)

    local function DisableCollision()
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                if OldCollide[Part] == nil then
                    OldCollide[Part] = Part.CanCollide
                end

                Part.CanCollide = false
            end
        end
    end

    DisableCollision()

    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.P = 9e4
    BodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
    BodyGyro.CFrame = HRP.CFrame
    BodyGyro.Parent = HRP

    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Velocity = Vector3.zero
    BodyVelocity.Parent = HRP

    FlyConnection = RS.RenderStepped:Connect(function()
        if not Flying or not HRP or not HRP.Parent then
            StopFlying()
            return
        end

        DisableCollision()

        local Cam = workspace.CurrentCamera
        local Look = Cam.CFrame.LookVector
        local Forward = Vector3.new(Look.X, 0, Look.Z)

        if Forward.Magnitude > 0 then
            Forward = Forward.Unit
        end

        local Right = Vector3.new(
            Cam.CFrame.RightVector.X,
            0,
            Cam.CFrame.RightVector.Z
        )

        if Right.Magnitude > 0 then
            Right = Right.Unit
        end

        local Move = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            Move += Forward
        end

        if UIS:IsKeyDown(Enum.KeyCode.S) then
            Move -= Forward
        end

        if UIS:IsKeyDown(Enum.KeyCode.A) then
            Move -= Right
        end

        if UIS:IsKeyDown(Enum.KeyCode.D) then
            Move += Right
        end

        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            Move += Vector3.yAxis
        end

        if UIS:IsKeyDown(Enum.KeyCode.X) then
            Move -= Vector3.yAxis
        end

        if Move.Magnitude > 0 then
            Move = Move.Unit * Speed
        end

        BodyGyro.CFrame = CFrame.lookAt(
            Vector3.zero,
            Forward.Magnitude > 0 and Forward or Vector3.new(0, 0, -1)
        )

        BodyVelocity.Velocity = Move
    end)
end

local function ToggleFly()
    if Flying then
        StopFlying()
    else
        StartFlying()
    end
end

FlyButton.MouseButton1Click:Connect(ToggleFly)

--==================================================
-- KEYBINDS
--==================================================

Connections[#Connections + 1] = UIS.InputBegan:Connect(function(Input, Processed)

    if Closed then
        return
    end

    if Input.KeyCode == Enum.KeyCode.RightShift then
        ToggleMinimize()
        return
    end

    if Processed then
        return
    end

    if UIS:GetFocusedTextBox() then
        return
    end

    if Input.KeyCode == Enum.KeyCode.Y then
        ToggleFly()

    elseif Input.KeyCode == Enum.KeyCode.KeypadThree then
        AutoTeleportToDeadAnimal()
    end
end)

--==================================================
-- HOLD NUMPAD 1 / 2 TO CHANGE SPEED
--==================================================

Connections[#Connections + 1] = UIS.InputBegan:Connect(function(Input, Processed)
    if Processed or not Flying then
        return
    end

    local Key = Input.KeyCode

    if Key ~= Enum.KeyCode.KeypadOne
    and Key ~= Enum.KeyCode.KeypadTwo then
        return
    end

    if SpeedChangeKey == Key then
        return
    end

    StopSpeedChange()

    SpeedChangeKey = Key
    SpeedChangeGeneration += 1

    local CurrentGeneration = SpeedChangeGeneration

    ChangeSpeed(Key)

    task.spawn(function()
        while Flying
        and SpeedChangeKey == Key
        and CurrentGeneration == SpeedChangeGeneration do

            task.wait(0.08)

            if not Flying
            or SpeedChangeKey ~= Key
            or CurrentGeneration ~= SpeedChangeGeneration then
                break
            end

            ChangeSpeed(Key)
        end
    end)
end)

Connections[#Connections + 1] = UIS.InputEnded:Connect(function(Input)
    if Input.KeyCode == SpeedChangeKey then
        StopSpeedChange()
    end
end)

Connections[#Connections + 1] = Player.CharacterRemoving:Connect(function()
    StopFlying()
end)

--==================================================
-- DRAGGING MAIN GUI
--==================================================

local Drag, Start, Pos

Title.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1
    or I.UserInputType == Enum.UserInputType.Touch then

        Drag = true
        Start = I.Position
        Pos = Main.Position
    end
end)

Connections[#Connections + 1] = UIS.InputChanged:Connect(function(I)
    if Drag and (
        I.UserInputType == Enum.UserInputType.MouseMovement
        or I.UserInputType == Enum.UserInputType.Touch
    ) then

        local D = I.Position - Start

        Main.Position = UDim2.new(
            Pos.X.Scale,
            Pos.X.Offset + D.X,
            Pos.Y.Scale,
            Pos.Y.Offset + D.Y
        )
    end
end)

--==================================================
-- DRAG MINIMIZED DEER ICON
--==================================================

local MiniDrag = false
local MiniDragStart = nil
local MiniStartPosition = nil
local MiniMoved = false
local MiniInputType = nil

MiniButton.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1
    or I.UserInputType == Enum.UserInputType.Touch then

        MiniDrag = true
        MiniMoved = false
        MiniDragStart = I.Position
        MiniStartPosition = MiniButton.Position
        MiniInputType = I.UserInputType
    end
end)

Connections[#Connections + 1] = UIS.InputChanged:Connect(function(I)
    if not MiniDrag then
        return
    end

    if I.UserInputType == Enum.UserInputType.MouseMovement
    or (
        MiniInputType == Enum.UserInputType.Touch
        and I.UserInputType == Enum.UserInputType.Touch
    ) then

        local D = I.Position - MiniDragStart

        if D.Magnitude > 5 then
            MiniMoved = true
        end

        MiniButton.Position = UDim2.new(
            MiniStartPosition.X.Scale,
            MiniStartPosition.X.Offset + D.X,
            MiniStartPosition.Y.Scale,
            MiniStartPosition.Y.Offset + D.Y
        )
    end
end)

Connections[#Connections + 1] = UIS.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1
    or I.UserInputType == Enum.UserInputType.Touch then

        if MiniDrag then
            local WasDragged = MiniMoved

            MiniDrag = false
            MiniInputType = nil

            if WasDragged then

                MiniOriginalPosition = MiniButton.Position
            else
                ToggleMinimize()
            end

            MiniMoved = false
        end

        Drag = false
    end
end)

--==================================================
-- DISABLE GAMEPLAY PAUSED SCREEN
--==================================================

local CoreGui = game:GetService("CoreGui")

pcall(function()
    CoreGui.RobloxGui["CoreScripts/NetworkPause"]:Destroy()
end)

--==================================================
-- CLOSE / FULL CLEANUP
--==================================================

Close.MouseButton1Click:Connect(function()
    if Closed then
        return
    end

    Closed = true
    Minimized = false

    StopFlying()
    StopSpeedChange()

    Enabled = false
    ClearAnimals()

    PlayersEnabled = false
    ClearPlayers()

    for TargetPlayer, C in pairs(PlayerConnections) do
        for _, Connection in ipairs(C) do
            Connection:Disconnect()
        end

        PlayerConnections[TargetPlayer] = nil
    end

    for _, C in ipairs(Connections) do
        C:Disconnect()
    end

    table.clear(Connections)

    Gui:Destroy()
end)