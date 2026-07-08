local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local LoopBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")
local DefaultBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local PointsScroll = Instance.new("ScrollingFrame")

local SAVED_POINTS = {}
for i = 1, 20 do SAVED_POINTS[i] = Vector3.new(0,0,0) end

local DEFAULT_COORDS = {
    [1] = Vector3.new(-1103.7, 49.6, 1465.4),
    [2] = Vector3.new(-1407.6, 56.1, 1484.7),
    [3] = Vector3.new(-887.2, 43.6, 1437.0),
    [4] = Vector3.new(-1402.1, 51.6, 1429.1),
    [5] = Vector3.new(-1181.6, 49.6, 1698.6),
    [6] = Vector3.new(-1276.1, 49.6, 1875.6),
    [7] = Vector3.new(-822.9, 49.6, 1839.6),
    [8] = Vector3.new(-1418.1, 51.6, 1265.9),
    [9] = Vector3.new(-1086.9, 63.6, 1984.9),
    [10] = Vector3.new(-1179.8, 49.6, 1699.4),
    [11] = Vector3.new(-793.6, 41.6, 1263.8),
    [12] = Vector3.new(-1341.9, 63.6, 2006.8),
    [13] = Vector3.new(-1418.5, 51.6, 1268.4),
    [14] = Vector3.new(-982.9, 49.1, 1671.7),
    [15] = Vector3.new(-743.9, 49.6, 1617.9),
    [16] = Vector3.new(-751.1, 49.6, 1889.3),
    [17] = Vector3.new(-1273.8, 49.6, 1873.9),
    [18] = Vector3.new(-1466.3, 51.6, 1199.2),
    [19] = Vector3.new(-832.0, 49.6, 1664.1), -- Новые исправленные координаты
}

local TELEPORT_INTERVAL = 5.0 
local isLooping = false
local LocalPlayer = game.Players.LocalPlayer

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "AnimeLifeDefaultHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 24, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 290, 0, 390) 
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "Anime Life: Slide-Route v2.8"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14

StatusLabel.Parent = MainFrame
StatusLabel.Position = UDim2.new(0, 0, 0.09, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Text = "Status: Route is empty"
StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 12

DefaultBtn.Parent = MainFrame
DefaultBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
DefaultBtn.Size = UDim2.new(0.9, 0, 0, 30)
DefaultBtn.Text = "⚙️ LOAD DEFAULT PRESET"
DefaultBtn.BackgroundColor3 = Color3.fromRGB(142, 68, 173) 
DefaultBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DefaultBtn.Font = Enum.Font.SourceSansBold
DefaultBtn.TextSize = 12

LoopBtn.Parent = MainFrame
LoopBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
LoopBtn.Size = UDim2.new(0.42, 0, 0, 35)
LoopBtn.Text = "START"
LoopBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
LoopBtn.Font = Enum.Font.SourceSansBold
LoopBtn.TextSize = 13

SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.53, 0, 0.25, 0)
SpeedBtn.Size = UDim2.new(0.42, 0, 0, 35)
SpeedBtn.Text = "CD: 5 sec"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.TextSize = 13

PointsScroll.Parent = MainFrame
PointsScroll.Position = UDim2.new(0.05, 0, 0.36, 0)
PointsScroll.Size = UDim2.new(0.9, 0, 0, 235)
PointsScroll.BackgroundTransparency = 1
PointsScroll.CanvasSize = UDim2.new(0, 0, 0, 720) 
PointsScroll.ScrollBarThickness = 5

local function physicsTeleport(targetVector)
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    local vehicle = humanoid and humanoid.SeatPart and humanoid.SeatPart.Parent
    local safeCFrame = CFrame.new(targetVector + Vector3.new(0, 3, 0))
    
    if vehicle then
        for _, part in pairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") then
                part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
        vehicle:PivotTo(safeCFrame)
        task.wait(0.05)
        if vehicle:FindFirstChild("HumanoidRootPart") then
            vehicle.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, -2, 0)
        end
    else
        if rootPart then
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            char:PivotTo(safeCFrame)
        end
    end
end

local ButtonsTable = {}
for i = 1, 20 do
    local ItemFrame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local ActionBtn = Instance.new("TextButton")
    
    ItemFrame.Parent = PointsScroll
    ItemFrame.Size = UDim2.new(1, 0, 0, 30) 
    ItemFrame.Position = UDim2.new(0, 0, 0, (i-1) * 35) 
    ItemFrame.BackgroundTransparency = 1
    
    Label.Parent = ItemFrame
    Label.Size = UDim2.new(0.3, 0, 1, 0)
    Label.Text = "Point " .. i .. ":"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    ActionBtn.Parent = ItemFrame
    ActionBtn.Position = UDim2.new(0.3, 0, 0.05, 0)
    ActionBtn.Size = UDim2.new(0.7, 0, 0.9, 0)
    ActionBtn.Text = "[0.0, 0.0, 0.0]"
    ActionBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ActionBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
    ActionBtn.Font = Enum.Font.Code
    ActionBtn.TextSize = 10 
    
    ButtonsTable[i] = ActionBtn
    
    ActionBtn.MouseButton1Click:Connect(function()
        if isLooping then return end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local currentPos = char.HumanoidRootPart.Position
            SAVED_POINTS[i] = currentPos
            ActionBtn.Text = string.format("[X:%.1f, Y:%.1f, Z:%.1f]", currentPos.X, currentPos.Y, currentPos.Z)
            ActionBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
            ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
end

DefaultBtn.MouseButton1Click:Connect(function()
    if isLooping then return end
    TELEPORT_INTERVAL = 1.0
    SpeedBtn.Text = "CD: 1.0 sec"
    
    for i = 1, 19 do
        local pos = DEFAULT_COORDS[i]
        if pos then
            SAVED_POINTS[i] = pos
            ButtonsTable[i].Text = string.format("[X:%.1f, Y:%.1f, Z:%.1f]", pos.X, pos.Y, pos.Z)
            ButtonsTable[i].BackgroundColor3 = Color3.fromRGB(39, 174, 96) 
            ButtonsTable[i].TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    
    StatusLabel.Text = "Status: 19 points loaded! CD 1s."
    StatusLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
end)

SpeedBtn.MouseButton1Click:Connect(function()
    if TELEPORT_INTERVAL == 5.0 then TELEPORT_INTERVAL = 10.0
    elseif TELEPORT_INTERVAL == 10.0 then TELEPORT_INTERVAL = 1.0
    elseif TELEPORT_INTERVAL == 1.0 then TELEPORT_INTERVAL = 3.0
    elseif TELEPORT_INTERVAL == 3.0 then TELEPORT_INTERVAL = 5.0 end
    SpeedBtn.Text = "CD: " .. TELEPORT_INTERVAL .. " sec"
end)

LoopBtn.MouseButton1Click:Connect(function()
    isLooping = not isLooping
    if isLooping then
        LoopBtn.Text = "STOP"
        LoopBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
        
        task.spawn(function()
            while isLooping do
                for i = 1, 20 do
                    if not isLooping then break end
                    local coords = SAVED_POINTS[i]
                    
                    if coords and coords ~= Vector3.new(0, 0, 0) then
                        StatusLabel.Text = "Teleporting to Point " .. i
                        physicsTeleport(coords)
                        
                        local startWait = tick()
                        while tick() - startWait < TELEPORT_INTERVAL do
                            if not isLooping then break end
                            task.wait(0.1)
                        end
                    end
                end
                task.wait(0.1)
            end
            StatusLabel.Text = "Status: Loop stopped"
            StatusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
        end)
    else
        LoopBtn.Text = "START"
        LoopBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        StatusLabel.Text = "Status: Set custom points (1-20)"
    end
end)
