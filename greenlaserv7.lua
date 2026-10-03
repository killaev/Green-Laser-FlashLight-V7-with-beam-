--[==[
    REDCLIFF CITY RP
    TACTICAL LASER + FLASHLIGHT SYSTEM

    CONFIGURAÇÃO:
    - Base visual mais para a esquerda
    - Laser acompanha exatamente a rotação da base
    - Laser permanece reto em relação ao módulo
    - Laser lateral original preservado
    - Laser apontando para baixo
    - Corpo preto fosco premium
    - Design tático detalhado
    - Trilho superior
    - Laterais em relevo
    - Placa traseira
    - Detalhes frontais
    - Marca OLIGHT
    - Laser verde
    - Aura verde fraca
    - Ponto verde no alvo
    - Ponto verde no módulo
    - FEIXE VERDE FÍSICO
    - Pequeno emissor inferior para a lanterna
    - Bola branca aparece ao ligar a lanterna
    - Lanterna sai fisicamente do emissor
]==]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

--==================================================
-- LASER
--==================================================

local LaserRange = 150
local LaserDotSize = 0.14

local LaserDotColor =
    Color3.fromRGB(
        0,
        255,
        0
    )

-- NEGATIVO = ESQUERDA
local LaserRightAngle = -3.5

local LaserDownAngle = 24.0

--==================================================
-- MÓDULO
--==================================================

local EmitterColor =
    Color3.fromRGB(18, 19, 19)

local EmitterTopColor =
    Color3.fromRGB(27, 28, 28)

local EmitterFrontColor =
    Color3.fromRGB(12, 13, 13)

local EmitterLensColor =
    Color3.fromRGB(3, 4, 4)

local EmitterDetailColor =
    Color3.fromRGB(9, 10, 10)

local EmitterEdgeColor =
    Color3.fromRGB(31, 32, 32)

local EmitterSize =
    Vector3.new(
        0.25,
        0.19,
        0.36
    )

local EmitterForwardOffset = 0.12

local EmitterSideOffset = 0.02

local EmitterVerticalOffset = 0.24

--==================================================
-- ÂNGULO VISUAL DA BASE
--==================================================

local EmitterRightAngle = -3.0

local ShowEmitter = true

--==================================================
-- MARCA
--==================================================

local BrandName = "OLIGHT"

--==================================================
-- LANTERNA
--==================================================

local FlashBrightness = 5
local FlashRange = 35
local FlashAngle = 55

local FlashColor =
    Color3.fromRGB(
        255,
        255,
        255
    )

local FlashEmitterSize =
    Vector3.new(
        0.075,
        0.045,
        0.025
    )

local FlashEmitterForwardOffset = 0.035

local FlashEmitterVerticalOffset = -0.065

--==================================================
-- ESTADO
--==================================================

local LaserEnabled = false
local FlashlightEnabled = false

local CurrentTool = nil
local CurrentHandle = nil

local CurrentFlashlight = nil
local CurrentFlashEmitter = nil
local CurrentFlashBall = nil

local CurrentDot = nil
local CurrentDotLight = nil

local CurrentEmitter = nil
local CurrentEmitterFront = nil
local CurrentEmitterTop = nil
local CurrentEmitterLens = nil
local CurrentEmitterRedDot = nil
local CurrentEmitterRedLight = nil

local CurrentBrandGui = nil

local CurrentLeftRail = nil
local CurrentRightRail = nil
local CurrentTopRail = nil
local CurrentRearPlate = nil
local CurrentFrontAccent = nil
local CurrentLowerAccent = nil
local CurrentSideDetail = nil
local CurrentScrew1 = nil
local CurrentScrew2 = nil

-- FEIXE
local CurrentLaserBeam = nil
local CurrentLaserBeamStart = nil
local CurrentLaserBeamEnd = nil

local RenderConnection = nil

--==================================================
-- GUI
--==================================================

local PlayerGui =
    Player:WaitForChild(
        "PlayerGui"
    )

local ScreenGui =
    Instance.new("ScreenGui")

ScreenGui.Name =
    "TacticalAttachmentUI"

ScreenGui.ResetOnSpawn =
    false

ScreenGui.Parent =
    PlayerGui

local MainFrame =
    Instance.new("Frame")

MainFrame.Name =
    "MainFrame"

MainFrame.Size =
    UDim2.new(
        0,
        210,
        0,
        180
    )

MainFrame.Position =
    UDim2.new(
        0,
        15,
        0.5,
        -90
    )

MainFrame.BackgroundColor3 =
    Color3.fromRGB(
        20,
        20,
        20
    )

MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner =
    Instance.new("UICorner")

MainCorner.CornerRadius =
    UDim.new(
        0,
        10
    )

MainCorner.Parent =
    MainFrame

local Title =
    Instance.new("TextLabel")

Title.Size =
    UDim2.new(
        1,
        -45,
        0,
        35
    )

Title.Position =
    UDim2.new(
        0,
        12,
        0,
        5
    )

Title.BackgroundTransparency = 1
Title.Text = "TACTICAL SYSTEM"

Title.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

Title.TextSize = 17
Title.Font =
    Enum.Font.GothamBold

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Parent =
    MainFrame

local CloseButton =
    Instance.new("TextButton")

CloseButton.Size =
    UDim2.new(
        0,
        30,
        0,
        30
    )

CloseButton.Position =
    UDim2.new(
        1,
        -35,
        0,
        5
    )

CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"

CloseButton.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

CloseButton.TextSize = 25
CloseButton.Font =
    Enum.Font.GothamBold

CloseButton.Parent =
    MainFrame

local function CreateButton(
    Name,
    Text,
    Y
)

    local Button =
        Instance.new("TextButton")

    Button.Name = Name

    Button.Size =
        UDim2.new(
            1,
            -24,
            0,
            38
        )

    Button.Position =
        UDim2.new(
            0,
            12,
            0,
            Y
        )

    Button.BackgroundColor3 =
        Color3.fromRGB(
            35,
            35,
            35
        )

    Button.BorderSizePixel = 0
    Button.Text = Text

    Button.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

    Button.TextSize = 14

    Button.Font =
        Enum.Font.GothamBold

    Button.AutoButtonColor = true
    Button.Parent = MainFrame

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            7
        )

    Corner.Parent = Button

    return Button
end

local LaserButton =
    CreateButton(
        "LaserButton",
        "LASER: OFF",
        45
    )

local FlashButton =
    CreateButton(
        "FlashButton",
        "LANTERNA: OFF",
        88
    )

local BothButton =
    CreateButton(
        "BothButton",
        "AMBOS: OFF",
        131
    )

--==================================================
-- BOTÃO DE ABRIR
--==================================================

local OpenButton =
    Instance.new("TextButton")

OpenButton.Name =
    "OpenButton"

OpenButton.Size =
    UDim2.new(
        0,
        55,
        0,
        55
    )

OpenButton.Position =
    UDim2.new(
        0,
        15,
        0.5,
        -27
    )

OpenButton.BackgroundColor3 =
    Color3.fromRGB(
        15,
        15,
        15
    )

OpenButton.BorderSizePixel = 0
OpenButton.Text = "⚙"

OpenButton.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

OpenButton.TextSize = 25
OpenButton.Font =
    Enum.Font.GothamBold

OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner =
    Instance.new("UICorner")

OpenCorner.CornerRadius =
    UDim.new(
        1,
        0
    )

OpenCorner.Parent =
    OpenButton

CloseButton.MouseButton1Click:Connect(
    function()

        MainFrame.Visible = false
        OpenButton.Visible = true

    end
)

OpenButton.MouseButton1Click:Connect(
    function()

        MainFrame.Visible = true
        OpenButton.Visible = false

    end
)

--==================================================
-- DETECTAR PISTOLA
--==================================================

local function IsPistol(Tool)

    if not Tool
        or not Tool:IsA("Tool") then

        return false
    end

    if Tool:GetAttribute("IsGun")
        == true then

        return true
    end

    if Tool:GetAttribute("IsPistol")
        == true then

        return true
    end

    local Name =
        string.lower(
            Tool.Name
        )

    local Keywords = {

        "pistol",
        "gun",
        "glock",
        "revolver",
        "deagle",
        "desert",
        "beretta",
        "usp",
        "1911",
        "handgun"

    }

    for _, Word in ipairs(
        Keywords
    ) do

        if string.find(
            Name,
            Word
        ) then

            return true

        end

    end

    if Tool:FindFirstChild(
        "Handle"
    ) then

        return true
    end

    return false
end

--==================================================
-- HANDLE
--==================================================

local function FindHandle(Tool)

    if not Tool then
        return nil
    end

    local Handle =
        Tool:FindFirstChild(
            "Handle"
        )

    if Handle
        and Handle:IsA("BasePart") then

        return Handle
    end

    for _, Object in ipairs(
        Tool:GetDescendants()
    ) do

        if Object:IsA("BasePart") then
            return Object
        end

    end

    return nil
end

--==================================================
-- MUZZLE
--==================================================

local function FindMuzzle(Tool)

    if not Tool then
        return nil
    end

    local Names = {

        "muzzle",
        "muzzleattachment",
        "laserpoint",
        "laserattachment"

    }

    for _, Object in ipairs(
        Tool:GetDescendants()
    ) do

        if Object:IsA(
            "Attachment"
        ) then

            local LowerName =
                string.lower(
                    Object.Name
                )

            for _, Name in ipairs(
                Names
            ) do

                if LowerName == Name then
                    return Object
                end

            end

        end

    end

    return nil
end

--==================================================
-- DIREÇÃO DA ARMA
--==================================================

local function CalculateWeaponDirection(
    Tool,
    Handle
)

    if not Handle then

        return Vector3.new(
            0,
            0,
            -1
        )

    end

    local Muzzle =
        FindMuzzle(Tool)

    if Muzzle then

        local Difference =
            Muzzle.WorldPosition
            - Handle.Position

        if Difference.Magnitude
            > 0.01 then

            return Difference.Unit
        end
    end

    local FurthestPart = nil
    local FurthestDistance = 0

    for _, Object in ipairs(
        Tool:GetDescendants()
    ) do

        if Object:IsA("BasePart")
            and Object ~= Handle then

            local LowerName =
                string.lower(
                    Object.Name
                )

            local Ignore =
                string.find(
                    LowerName,
                    "grip"
                )
                or
                string.find(
                    LowerName,
                    "handle"
                )
                or
                string.find(
                    LowerName,
                    "mag"
                )
                or
                string.find(
                    LowerName,
                    "trigger"
                )

            if not Ignore then

                local Distance =
                    (
                        Object.Position
                        - Handle.Position
                    ).Magnitude

                if Distance
                    > FurthestDistance then

                    FurthestDistance =
                        Distance

                    FurthestPart =
                        Object
                end
            end
        end
    end

    if FurthestPart then

        local Difference =
            FurthestPart.Position
            - Handle.Position

        if Difference.Magnitude
            > 0.01 then

            return Difference.Unit
        end
    end

    return Handle.CFrame.LookVector
end

--==================================================
-- AJUSTE DO LASER
--==================================================

local function ApplyLaserAdjustment(
    Direction,
    Handle
)

    if not Handle then
        return Direction
    end

    local RightAngle =
        math.rad(
            LaserRightAngle
        )

    Direction =
        (
            Direction
            *
            math.cos(
                RightAngle
            )
            +
            Handle.CFrame.RightVector
            *
            math.sin(
                RightAngle
            )
        ).Unit

    local DownAngle =
        math.rad(
            LaserDownAngle
        )

    Direction =
        (
            Direction
            *
            math.cos(
                DownAngle
            )
            -
            Handle.CFrame.UpVector
            *
            math.sin(
                DownAngle
            )
        ).Unit

    return Direction
end

--==================================================
-- ROTAÇÃO VISUAL DA BASE
--==================================================

local function ApplyEmitterVisualAngle(
    Direction,
    Handle
)

    if not Handle then
        return Direction
    end

    local Angle =
        math.rad(
            EmitterRightAngle
        )

    return (
        CFrame.fromAxisAngle(
            Handle.CFrame.UpVector,
            Angle
        ):VectorToWorldSpace(
            Direction
        )
    ).Unit
end

--==================================================
-- POSIÇÃO DO MÓDULO
--==================================================

local function CalculateEmitterPosition(
    Tool,
    Handle,
    Direction
)

    if not Handle then
        return Vector3.zero
    end

    local Muzzle =
        FindMuzzle(Tool)

    local Position

    if Muzzle then

        Position =
            Muzzle.WorldPosition

    else

        Position =
            Handle.Position
            +
            Direction
            *
            (
                Handle.Size.Z / 2
                +
                EmitterForwardOffset
            )
    end

    Position =
        Position
        +
        Direction
        *
        EmitterForwardOffset

    Position =
        Position
        +
        Handle.CFrame.RightVector
        *
        EmitterSideOffset

    Position =
        Position
        +
        Handle.CFrame.UpVector
        *
        EmitterVerticalOffset

    return Position
end

--==================================================
-- MARCA
--==================================================

local function CreateBrandMark(
    Emitter
)

    local BrandGui =
        Instance.new("SurfaceGui")

    BrandGui.Name =
        "TacticalBrandMark"

    BrandGui.Face =
        Enum.NormalId.Right

    BrandGui.SizingMode =
        Enum.SurfaceGuiSizingMode.PixelsPerStud

    BrandGui.PixelsPerStud = 120

    BrandGui.AlwaysOnTop = false
    BrandGui.LightInfluence = 1

    BrandGui.Parent =
        Emitter

    local Brand =
        Instance.new("TextLabel")

    Brand.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Brand.BackgroundTransparency = 1
    Brand.Text = BrandName

    Brand.TextColor3 =
        Color3.fromRGB(
            105,
            105,
            105
        )

    Brand.TextTransparency = 0.35
    Brand.TextScaled = true

    Brand.Font =
        Enum.Font.GothamBold

    Brand.TextStrokeTransparency = 1
    Brand.Parent = BrandGui

    return BrandGui
end

--==================================================
-- CRIAR PEÇA AUXILIAR
--==================================================

local function CreateDetailPart(
    Name,
    Size,
    Color,
    Material
)

    local Part =
        Instance.new("Part")

    Part.Name = Name
    Part.Size = Size
    Part.Color = Color
    Part.Material = Material

    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.CastShadow = false

    Part.Parent = Workspace

    return Part
end

--==================================================
-- CRIAR MÓDULO
--==================================================

local function CreateEmitter(
    Tool,
    Handle,
    Direction,
    EmitterDirection
)

    local Position =
        CalculateEmitterPosition(
            Tool,
            Handle,
            Direction
        )

    local Emitter =
        Instance.new("Part")

    Emitter.Name =
        "TacticalLaserBody"

    Emitter.Size =
        EmitterSize

    Emitter.Color =
        EmitterColor

    Emitter.Material =
        Enum.Material.SmoothPlastic

    Emitter.Transparency =
        ShowEmitter
        and 0
        or 1

    Emitter.Anchored = true
    Emitter.CanCollide = false
    Emitter.CanTouch = false
    Emitter.CanQuery = false
    Emitter.CastShadow = false

    Emitter.CFrame =
        CFrame.lookAt(
            Position,
            Position + EmitterDirection
        )

    Emitter.Parent =
        Workspace

    local BrandGui =
        CreateBrandMark(
            Emitter
        )

    local Top =
        CreateDetailPart(
            "TacticalLaserTop",
            Vector3.new(
                0.20,
                0.045,
                0.27
            ),
            EmitterTopColor,
            Enum.Material.SmoothPlastic
        )

    Top.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            0,
            EmitterSize.Y / 2
            + 0.015,
            0.015
        )

    local TopRail =
        CreateDetailPart(
            "TacticalLaserTopRail",
            Vector3.new(
                0.115,
                0.025,
                0.20
            ),
            EmitterDetailColor,
            Enum.Material.Metal
        )

    TopRail.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            0,
            EmitterSize.Y / 2
            + 0.042,
            0.025
        )

    local LeftRail =
        CreateDetailPart(
            "TacticalLaserLeftRail",
            Vector3.new(
                0.025,
                0.095,
                0.28
            ),
            EmitterDetailColor,
            Enum.Material.Metal
        )

    LeftRail.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            -EmitterSize.X / 2
            - 0.010,
            0,
            0.015
        )

    local RightRail =
        CreateDetailPart(
            "TacticalLaserRightRail",
            Vector3.new(
                0.025,
                0.095,
                0.28
            ),
            EmitterDetailColor,
            Enum.Material.Metal
        )

    RightRail.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            EmitterSize.X / 2
            + 0.010,
            0,
            0.015
        )

    local RearPlate =
        CreateDetailPart(
            "TacticalLaserRearPlate",
            Vector3.new(
                0.205,
                0.145,
                0.025
            ),
            EmitterFrontColor,
            Enum.Material.Metal
        )

    RearPlate.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            0,
            0,
            EmitterSize.Z / 2
            + 0.012
        )

    local Front =
        Instance.new("Part")

    Front.Name =
        "TacticalLaserFront"

    Front.Size =
        Vector3.new(
            0.17,
            0.12,
            0.055
        )

    Front.Color =
        EmitterFrontColor

    Front.Material =
        Enum.Material.SmoothPlastic

    Front.Anchored = true
    Front.CanCollide = false
    Front.CanTouch = false
    Front.CanQuery = false
    Front.CastShadow = false

    Front.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            0,
            0,
            -EmitterSize.Z / 2
            - 0.025
        )

    Front.Parent =
        Workspace

    local FrontAccent =
        CreateDetailPart(
            "TacticalLaserFrontAccent",
            Vector3.new(
                0.20,
                0.018,
                0.07
            ),
            EmitterEdgeColor,
            Enum.Material.Metal
        )

    FrontAccent.CFrame =
        Front.CFrame
        *
        CFrame.new(
            0,
            Front.Size.Y / 2
            - 0.015,
            -0.010
        )

    local LowerAccent =
        CreateDetailPart(
            "TacticalLaserLowerAccent",
            Vector3.new(
                0.16,
                0.022,
                0.24
            ),
            EmitterDetailColor,
            Enum.Material.Metal
        )

    LowerAccent.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            0,
            -EmitterSize.Y / 2
            - 0.010,
            0.015
        )

    local SideDetail =
        CreateDetailPart(
            "TacticalLaserSideDetail",
            Vector3.new(
                0.012,
                0.075,
                0.19
            ),
            EmitterEdgeColor,
            Enum.Material.Metal
        )

    SideDetail.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            EmitterSize.X / 2
            + 0.026,
            0,
            0.015
        )

    local Screw1 =
        CreateDetailPart(
            "TacticalLaserScrew1",
            Vector3.new(
                0.028,
                0.028,
                0.008
            ),
            Color3.fromRGB(
                45,
                45,
                45
            ),
            Enum.Material.Metal
        )

    Screw1.Shape =
        Enum.PartType.Cylinder

    Screw1.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            EmitterSize.X / 2
            + 0.014,
            0.045,
            0.06
        )
        *
        CFrame.Angles(
            0,
            math.rad(90),
            0
        )

    local Screw2 =
        CreateDetailPart(
            "TacticalLaserScrew2",
            Vector3.new(
                0.028,
                0.028,
                0.008
            ),
            Color3.fromRGB(
                45,
                45,
                45
            ),
            Enum.Material.Metal
        )

    Screw2.Shape =
        Enum.PartType.Cylinder

    Screw2.CFrame =
        Emitter.CFrame
        *
        CFrame.new(
            EmitterSize.X / 2
            + 0.014,
            -0.045,
            -0.06
        )
        *
        CFrame.Angles(
            0,
            math.rad(90),
            0
        )

    local Lens =
        Instance.new("Part")

    Lens.Name =
        "TacticalLaserLens"

    Lens.Shape =
        Enum.PartType.Cylinder

    Lens.Size =
        Vector3.new(
            0.075,
            0.075,
            0.025
        )

    Lens.Color =
        EmitterLensColor

    Lens.Material =
        Enum.Material.Glass

    Lens.Transparency = 0.15

    Lens.Anchored = true
    Lens.CanCollide = false
    Lens.CanTouch = false
    Lens.CanQuery = false
    Lens.CastShadow = false

    Lens.CFrame =
        Front.CFrame
        *
        CFrame.new(
            0,
            0,
            -0.040
        )
        *
        CFrame.Angles(
            0,
            math.rad(90),
            0
        )

    Lens.Parent =
        Workspace

    --==================================================
    -- PONTO VERDE NO MÓDULO
    --==================================================

    local GreenDot =
        Instance.new("Part")

    GreenDot.Name =
        "TacticalLaserGreenDot"

    GreenDot.Shape =
        Enum.PartType.Ball

    GreenDot.Size =
        Vector3.new(
            0.055,
            0.055,
            0.055
        )

    GreenDot.Color =
        Color3.fromRGB(
            0,
            255,
            0
        )

    GreenDot.Material =
        Enum.Material.Neon

    GreenDot.Anchored = true
    GreenDot.CanCollide = false
    GreenDot.CanTouch = false
    GreenDot.CanQuery = false
    GreenDot.CastShadow = false

    GreenDot.CFrame =
        Front.CFrame
        *
        CFrame.new(
            0,
            0,
            -0.050
        )

    GreenDot.Transparency = 1
    GreenDot.Parent = Workspace

    local GreenLight =
        Instance.new("PointLight")

    GreenLight.Name =
        "LaserEmitterGreenLight"

    GreenLight.Color =
        Color3.fromRGB(
            0,
            255,
            0
        )

    -- AURA VERDE BEM FRACA
    GreenLight.Brightness = 1
    GreenLight.Range = 1.5
    GreenLight.Enabled = false
    GreenLight.Parent = GreenDot

    --==================================================
    -- PEQUENO QUADRADO DA LANTERNA
    --==================================================

    local FlashEmitter =
        Instance.new("Part")

    FlashEmitter.Name =
        "TacticalFlashlightEmitter"

    FlashEmitter.Size =
        FlashEmitterSize

    FlashEmitter.Color =
        Color3.fromRGB(
            30,
            30,
            30
        )

    FlashEmitter.Material =
        Enum.Material.Metal

    FlashEmitter.Transparency = 0

    FlashEmitter.Anchored = true
    FlashEmitter.CanCollide = false
    FlashEmitter.CanTouch = false
    FlashEmitter.CanQuery = false
    FlashEmitter.CastShadow = false

    FlashEmitter.Parent =
        Workspace

    --==================================================
    -- BOLA BRANCA DA LANTERNA
    --==================================================

    local FlashBall =
        Instance.new("Part")

    FlashBall.Name =
        "TacticalFlashlightGlow"

    FlashBall.Shape =
        Enum.PartType.Ball

    FlashBall.Size =
        Vector3.new(
            0.075,
            0.075,
            0.075
        )

    FlashBall.Color =
        Color3.fromRGB(
            255,
            255,
            255
        )

    FlashBall.Material =
        Enum.Material.Neon

    FlashBall.Anchored = true
    FlashBall.CanCollide = false
    FlashBall.CanTouch = false
    FlashBall.CanQuery = false
    FlashBall.CastShadow = false

    FlashBall.Transparency = 1

    FlashBall.Parent =
        Workspace

    return
        Emitter,
        Front,
        Top,
        Lens,
        GreenDot,
        GreenLight,
        BrandGui,
        LeftRail,
        RightRail,
        TopRail,
        RearPlate,
        FrontAccent,
        LowerAccent,
        SideDetail,
        Screw1,
        Screw2,
        FlashEmitter,
        FlashBall
end

--==================================================
-- PONTO DO LASER
--==================================================

local function CreateLaserDot()

    local Dot =
        Instance.new("Part")

    Dot.Name =
        "TacticalLaserTarget"

    Dot.Shape =
        Enum.PartType.Ball

    Dot.Size =
        Vector3.new(
            LaserDotSize,
            LaserDotSize,
            LaserDotSize
        )

    Dot.Material =
        Enum.Material.Neon

    Dot.Color =
        LaserDotColor

    Dot.Anchored = true
    Dot.CanCollide = false
    Dot.CanTouch = false
    Dot.CanQuery = false
    Dot.CastShadow = false
    Dot.Transparency = 1

    Dot.Parent =
        Workspace

    local Light =
        Instance.new("PointLight")

    Light.Name =
        "LaserTargetGreenLight"

    Light.Color =
        LaserDotColor

    Light.Brightness = 2
    Light.Range = 3
    Light.Enabled = false
    Light.Parent = Dot

    return Dot, Light
end

--==================================================
-- LIMPAR
--==================================================

local function Cleanup()

    if RenderConnection then

        RenderConnection:Disconnect()
        RenderConnection = nil

    end

    local ObjectsToDestroy = {

        CurrentDot,

        CurrentEmitter,
        CurrentEmitterFront,
        CurrentEmitterTop,
        CurrentEmitterLens,
        CurrentEmitterRedDot,

        CurrentFlashEmitter,
        CurrentFlashBall,

        CurrentLaserBeamStart,
        CurrentLaserBeamEnd,

        CurrentLeftRail,
        CurrentRightRail,
        CurrentTopRail,
        CurrentRearPlate,
        CurrentFrontAccent,
        CurrentLowerAccent,
        CurrentSideDetail,
        CurrentScrew1,
        CurrentScrew2

    }

    for _, Object in ipairs(
        ObjectsToDestroy
    ) do

        if Object then
            Object:Destroy()
        end

    end

    CurrentDot = nil
    CurrentDotLight = nil

    CurrentEmitter = nil
    CurrentEmitterFront = nil
    CurrentEmitterTop = nil
    CurrentEmitterLens = nil

    CurrentEmitterRedDot = nil
    CurrentEmitterRedLight = nil

    CurrentFlashEmitter = nil
    CurrentFlashBall = nil

    CurrentLaserBeam = nil
    CurrentLaserBeamStart = nil
    CurrentLaserBeamEnd = nil

    CurrentLeftRail = nil
    CurrentRightRail = nil
    CurrentTopRail = nil
    CurrentRearPlate = nil
    CurrentFrontAccent = nil
    CurrentLowerAccent = nil
    CurrentSideDetail = nil
    CurrentScrew1 = nil
    CurrentScrew2 = nil

    CurrentBrandGui = nil
    CurrentFlashlight = nil

    CurrentTool = nil
    CurrentHandle = nil
end

--==================================================
-- CONFIGURAR ARMA
--==================================================

local function SetupTool(Tool)

    if not IsPistol(Tool) then
        return
    end

    Cleanup()

    local Handle =
        FindHandle(Tool)

    if not Handle then
        return
    end

    CurrentTool = Tool
    CurrentHandle = Handle

    local Direction =
        CalculateWeaponDirection(
            Tool,
            Handle
        )

    Direction =
        ApplyLaserAdjustment(
            Direction,
            Handle
        )

    local EmitterDirection =
        ApplyEmitterVisualAngle(
            Direction,
            Handle
        )

    local Emitter,
        Front,
        Top,
        Lens,
        GreenDot,
        GreenLight,
        BrandGui,
        LeftRail,
        RightRail,
        TopRail,
        RearPlate,
        FrontAccent,
        LowerAccent,
        SideDetail,
        Screw1,
        Screw2,
        FlashEmitter,
        FlashBall =
        CreateEmitter(
            Tool,
            Handle,
            Direction,
            EmitterDirection
        )

    CurrentEmitter = Emitter
    CurrentEmitterFront = Front
    CurrentEmitterTop = Top
    CurrentEmitterLens = Lens

    CurrentEmitterRedDot = GreenDot
    CurrentEmitterRedLight = GreenLight

    CurrentBrandGui = BrandGui

    CurrentLeftRail = LeftRail
    CurrentRightRail = RightRail
    CurrentTopRail = TopRail
    CurrentRearPlate = RearPlate
    CurrentFrontAccent = FrontAccent
    CurrentLowerAccent = LowerAccent
    CurrentSideDetail = SideDetail
    CurrentScrew1 = Screw1
    CurrentScrew2 = Screw2

    CurrentFlashEmitter =
        FlashEmitter

    CurrentFlashBall =
        FlashBall

    local Dot, DotLight =
        CreateLaserDot()

    CurrentDot = Dot
    CurrentDotLight = DotLight

    --==================================================
    -- FEIXE VERDE
    --==================================================

    local BeamStartPart =
        Instance.new("Part")

    BeamStartPart.Name =
        "TacticalLaserBeamStart"

    BeamStartPart.Size =
        Vector3.new(
            0.03,
            0.03,
            0.03
        )

    BeamStartPart.Transparency = 1
    BeamStartPart.Anchored = true
    BeamStartPart.CanCollide = false
    BeamStartPart.CanTouch = false
    BeamStartPart.CanQuery = false
    BeamStartPart.CastShadow = false

    BeamStartPart.Parent =
        Workspace

    local BeamEndPart =
        Instance.new("Part")

    BeamEndPart.Name =
        "TacticalLaserBeamEnd"

    BeamEndPart.Size =
        Vector3.new(
            0.03,
            0.03,
            0.03
        )

    BeamEndPart.Transparency = 1
    BeamEndPart.Anchored = true
    BeamEndPart.CanCollide = false
    BeamEndPart.CanTouch = false
    BeamEndPart.CanQuery = false
    BeamEndPart.CastShadow = false

    BeamEndPart.Parent =
        Workspace

    local BeamStartAttachment =
        Instance.new("Attachment")

    BeamStartAttachment.Name =
        "LaserBeamStartAttachment"

    BeamStartAttachment.Parent =
        BeamStartPart

    local BeamEndAttachment =
        Instance.new("Attachment")

    BeamEndAttachment.Name =
        "LaserBeamEndAttachment"

    BeamEndAttachment.Parent =
        BeamEndPart

    local Beam =
        Instance.new("Beam")

    Beam.Name =
        "TacticalGreenLaserBeam"

    Beam.Attachment0 =
        BeamStartAttachment

    Beam.Attachment1 =
        BeamEndAttachment

    Beam.Color =
        ColorSequence.new(
            Color3.fromRGB(
                0,
                255,
                0
            )
        )

    -- FEIXE FINO
    Beam.Width0 = 0.012
    Beam.Width1 = 0.006

    Beam.Transparency =
        NumberSequence.new({
            NumberSequenceKeypoint.new(
                0,
                0.12
            ),
            NumberSequenceKeypoint.new(
                0.85,
                0.18
            ),
            NumberSequenceKeypoint.new(
                1,
                0.35
            )
        })

    Beam.LightEmission = 0.65
    Beam.LightInfluence = 0

    Beam.FaceCamera = true
    Beam.Segments = 1

    Beam.Enabled = false

    Beam.Parent =
        BeamStartPart

    CurrentLaserBeam =
        Beam

    CurrentLaserBeamStart =
        BeamStartPart

    CurrentLaserBeamEnd =
        BeamEndPart

    --==================================================
    -- LANTERNA
    --==================================================

    local Flashlight =
        Instance.new("SpotLight")

    Flashlight.Name =
        "TacticalFlashlight"

    Flashlight.Brightness =
        FlashBrightness

    Flashlight.Range =
        FlashRange

    Flashlight.Angle =
        FlashAngle

    Flashlight.Color =
        FlashColor

    Flashlight.Face =
        Enum.NormalId.Front

    Flashlight.Enabled = false

    Flashlight.Parent =
        CurrentFlashEmitter

    CurrentFlashlight =
        Flashlight

    --==================================================
    -- RENDER
    --==================================================

    RenderConnection =
        RunService.RenderStepped:Connect(
            function()

                if not CurrentTool
                    or not CurrentHandle
                    or not CurrentTool.Parent then

                    Cleanup()
                    return
                end

                local Character =
                    Player.Character

                local WeaponDirection =
                    CalculateWeaponDirection(
                        CurrentTool,
                        CurrentHandle
                    )

                WeaponDirection =
                    ApplyLaserAdjustment(
                        WeaponDirection,
                        CurrentHandle
                    )

                local EmitterDirection =
                    ApplyEmitterVisualAngle(
                        WeaponDirection,
                        CurrentHandle
                    )

                local EmitterPosition =
                    CalculateEmitterPosition(
                        CurrentTool,
                        CurrentHandle,
                        WeaponDirection
                    )

                CurrentEmitter.CFrame =
                    CFrame.lookAt(
                        EmitterPosition,
                        EmitterPosition
                        + EmitterDirection
                    )

                CurrentEmitterTop.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        0,
                        EmitterSize.Y / 2
                        + 0.015,
                        0.015
                    )

                CurrentTopRail.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        0,
                        EmitterSize.Y / 2
                        + 0.042,
                        0.025
                    )

                CurrentLeftRail.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        -EmitterSize.X / 2
                        - 0.010,
                        0,
                        0.015
                    )

                CurrentRightRail.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        EmitterSize.X / 2
                        + 0.010,
                        0,
                        0.015
                    )

                CurrentRearPlate.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        0,
                        0,
                        EmitterSize.Z / 2
                        + 0.012
                    )

                CurrentEmitterFront.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        0,
                        0,
                        -EmitterSize.Z / 2
                        - 0.025
                    )

                CurrentFrontAccent.CFrame =
                    CurrentEmitterFront.CFrame
                    *
                    CFrame.new(
                        0,
                        CurrentEmitterFront.Size.Y / 2
                        - 0.015,
                        -0.010
                    )

                CurrentLowerAccent.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        0,
                        -EmitterSize.Y / 2
                        - 0.010,
                        0.015
                    )

                CurrentSideDetail.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        EmitterSize.X / 2
                        + 0.026,
                        0,
                        0.015
                    )

                CurrentScrew1.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        EmitterSize.X / 2
                        + 0.014,
                        0.045,
                        0.06
                    )
                    *
                    CFrame.Angles(
                        0,
                        math.rad(90),
                        0
                    )

                CurrentScrew2.CFrame =
                    CurrentEmitter.CFrame
                    *
                    CFrame.new(
                        EmitterSize.X / 2
                        + 0.014,
                        -0.045,
                        -0.06
                    )
                    *
                    CFrame.Angles(
                        0,
                        math.rad(90),
                        0
                    )

                CurrentEmitterLens.CFrame =
                    CurrentEmitterFront.CFrame
                    *
                    CFrame.new(
                        0,
                        0,
                        -0.040
                    )
                    *
                    CFrame.Angles(
                        0,
                        math.rad(90),
                        0
                    )

                CurrentEmitterRedDot.CFrame =
                    CurrentEmitterFront.CFrame
                    *
                    CFrame.new(
                        0,
                        0,
                        -0.050
                    )

                --==================================================
                -- EMISSOR INFERIOR DA LANTERNA
                --==================================================

                CurrentFlashEmitter.CFrame =
                    CurrentEmitterFront.CFrame
                    *
                    CFrame.new(
                        0,
                        FlashEmitterVerticalOffset,
                        -CurrentEmitterFront.Size.Z / 2
                        - FlashEmitterForwardOffset
                    )

                --==================================================
                -- BOLA BRANCA DA LANTERNA
                --==================================================

                CurrentFlashBall.CFrame =
                    CurrentFlashEmitter.CFrame
                    *
                    CFrame.new(
                        0,
                        0,
                        -FlashEmitterSize.Z / 2
                        - 0.035
                    )

                --==================================================
                -- RAYCAST
                --==================================================

                local Origin =
                    CurrentEmitter.CFrame.Position
                    +
                    EmitterDirection
                    *
                    (
                        -EmitterSize.Z / 2
                    )

                local Params =
                    RaycastParams.new()

                Params.FilterType =
                    Enum.RaycastFilterType.Exclude

                local IgnoreList = {

                    CurrentTool,

                    CurrentEmitter,
                    CurrentEmitterFront,
                    CurrentEmitterTop,
                    CurrentEmitterLens,
                    CurrentEmitterRedDot,

                    CurrentFlashEmitter,
                    CurrentFlashBall,

                    CurrentLaserBeamStart,
                    CurrentLaserBeamEnd,

                    CurrentLeftRail,
                    CurrentRightRail,
                    CurrentTopRail,
                    CurrentRearPlate,
                    CurrentFrontAccent,
                    CurrentLowerAccent,
                    CurrentSideDetail,
                    CurrentScrew1,
                    CurrentScrew2

                }

                if Character then

                    table.insert(
                        IgnoreList,
                        Character
                    )

                end

                Params.FilterDescendantsInstances =
                    IgnoreList

                Params.IgnoreWater = true

                local Result =
                    Workspace:Raycast(
                        Origin,
                        EmitterDirection
                        *
                        LaserRange,
                        Params
                    )

                --==================================================
                -- LASER + FEIXE
                --==================================================

                if LaserEnabled
                    and Result then

                    CurrentDot.Position =
                        Result.Position

                    CurrentDot.Transparency = 0

                    CurrentDotLight.Enabled = true

                    -- INÍCIO DO FEIXE
                    CurrentLaserBeamStart.Position =
                        Origin

                    -- FINAL DO FEIXE
                    CurrentLaserBeamEnd.Position =
                        Result.Position

                    CurrentLaserBeam.Enabled = true

                else

                    CurrentDot.Transparency = 1

                    CurrentDotLight.Enabled = false

                    CurrentLaserBeam.Enabled = false

                end

                --==================================================
                -- PONTO VERDE NO MÓDULO
                --==================================================

                CurrentEmitterRedDot.Transparency =
                    LaserEnabled
                    and 0
                    or 1

                CurrentEmitterRedLight.Enabled =
                    LaserEnabled

                --==================================================
                -- LANTERNA
                --==================================================

                CurrentFlashlight.Enabled =
                    FlashlightEnabled

                CurrentFlashBall.Transparency =
                    FlashlightEnabled
                    and 0
                    or 1

            end
        )
end

--==================================================
-- BOTÃO LASER
--==================================================

LaserButton.MouseButton1Click:Connect(
    function()

        LaserEnabled =
            not LaserEnabled

        LaserButton.Text =
            LaserEnabled
            and "LASER: ON"
            or "LASER: OFF"

    end
)

--==================================================
-- BOTÃO LANTERNA
--==================================================

FlashButton.MouseButton1Click:Connect(
    function()

        FlashlightEnabled =
            not FlashlightEnabled

        FlashButton.Text =
            FlashlightEnabled
            and "LANTERNA: ON"
            or "LANTERNA: OFF"

    end
)

--==================================================
-- BOTÃO AMBOS
--==================================================

BothButton.MouseButton1Click:Connect(
    function()

        local NewState =
            not (
                LaserEnabled
                and
                FlashlightEnabled
            )

        LaserEnabled =
            NewState

        FlashlightEnabled =
            NewState

        BothButton.Text =
            NewState
            and "AMBOS: ON"
            or "AMBOS: OFF"

        LaserButton.Text =
            NewState
            and "LASER: ON"
            or "LASER: OFF"

        FlashButton.Text =
            NewState
            and "LANTERNA: ON"
            or "LANTERNA: OFF"

    end
)

--==================================================
-- CHARACTER
--==================================================

local function SetupCharacter(
    Character
)

    Cleanup()

    for _, Tool in ipairs(
        Character:GetChildren()
    ) do

        if Tool:IsA("Tool")
            and IsPistol(Tool) then

            Tool.Equipped:Connect(
                function()

                    SetupTool(Tool)

                end
            )

            Tool.Unequipped:Connect(
                function()

                    if CurrentTool == Tool then
                        Cleanup()
                    end

                end
            )

        end

    end

    Character.ChildAdded:Connect(
        function(Child)

            if Child:IsA("Tool")
                and IsPistol(Child) then

                Child.Equipped:Connect(
                    function()

                        SetupTool(Child)

                    end
                )

                Child.Unequipped:Connect(
                    function()

                        if CurrentTool == Child then
                            Cleanup()
                        end

                    end
                )

            end

        end
    )

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if Humanoid then

        Humanoid.Died:Connect(
            function()

                Cleanup()

            end
        )

    end

end

--==================================================
-- INICIALIZAÇÃO
--==================================================

if Player.Character then

    SetupCharacter(
        Player.Character
    )

end

Player.CharacterAdded:Connect(
    function(Character)

        Character:WaitForChild(
            "Humanoid"
        )

        SetupCharacter(
            Character
        )

    end
)

Player.CharacterRemoving:Connect(
    function()

        Cleanup()

    end
)
