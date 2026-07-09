local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

_G.AnimeLifeSmartAutofarm = false
_G.ActionDelay = 7.0 
local isMinimized = false

-- GUI Interface in PlayerGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimeLife_HisokaHub_Pizza"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 255) 
MainFrame.Position = UDim2.new(0.15, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Top title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Anime Life: Auto farm pizza delivery man" -- Added "man" at the end
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Minimize button
local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 35, 1, 0)
MiniBtn.Position = UDim2.new(1, -35, 0, 0)
MiniBtn.BackgroundColor3 = Color3.fromRGB(211, 84, 0)
MiniBtn.BorderSizePixel = 0
MiniBtn.Text = "_"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.Font = Enum.Font.SourceSansBold
MiniBtn.TextSize = 16
MiniBtn.Parent = TitleBar

-- Container for inner elements
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local DelayLabel = Instance.new("TextLabel")
DelayLabel.Size = UDim2.new(0, 110, 0, 30)
DelayLabel.Position = UDim2.new(0, 12, 0, 10)
DelayLabel.BackgroundTransparency = 1
DelayLabel.Text = "Set Delay (sec):"
DelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DelayLabel.Font = Enum.Font.SourceSans
DelayLabel.TextSize = 13
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left
DelayLabel.Parent = ContentFrame

local DelayInput = Instance.new("TextBox")
DelayInput.Size = UDim2.new(0, 80, 0, 25)
DelayInput.Position = UDim2.new(0, 145, 0, 12)
DelayInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
DelayInput.Text = tostring(_G.ActionDelay)
DelayInput.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayInput.Font = Enum.Font.Code
DelayInput.TextSize = 12
DelayInput.BorderSizePixel = 0
DelayInput.Parent = ContentFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -24, 0, 40)
ToggleBtn.Position = UDim2.new(0, 12, 0, 50)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
ToggleBtn.Text = "START AUTOFARM"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = ContentFrame

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, -24, 0, 25)
LogLabel.Position = UDim2.new(0, 12, 0, 95)
LogLabel.BackgroundTransparency = 1
LogLabel.Text = "Status: Idle"
LogLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
LogLabel.TextSize = 12
LogLabel.Parent = ContentFrame

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -24, 0, 80)
InfoLabel.Position = UDim2.new(0, 12, 0, 125)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Notice: The game may pay differently depending on how fast the farm is, and the amount itself fluctuates (or the game has a protection for this case - if there is, unfortunately, no information is known to me about it)."
InfoLabel.TextColor3 = Color3.fromRGB(241, 196, 15) 
InfoLabel.Font = Enum.Font.SourceSansItalic
InfoLabel.TextSize = 11
InfoLabel.TextWrapped = true 
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.Parent = ContentFrame

-- Author watermark
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(0, 100, 0, 20)
CreditLabel.Position = UDim2.new(1, -110, 1, -18) 
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "by hisoka hub"
CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditLabel.TextTransparency = 0.75 
CreditLabel.Font = Enum.Font.SourceSansItalic
CreditLabel.TextSize = 11
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditLabel.Parent = ContentFrame

-- Minimize / Expand toggle logic
MiniBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        ContentFrame.Visible = false 
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 35), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
        MiniBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 255), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
        task.wait(0.15) 
        ContentFrame.Visible = true 
        MiniBtn.Text = "_"
    end
end)

-- Safe custom teleport method
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

-- Built-in Anti-AFK
LocalPlayer.Idled:Connect(function()
    if _G.AnimeLifeSmartAutofarm then
        VirtualUser:Button2Down(Vector3.new(0,0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector3.new(0,0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- Main Farm Loop
task.spawn(function()
    while true do
        local startWait = tick()
        while tick() - startWait < _G.ActionDelay do
            if _G.AnimeLifeSmartAutofarm then
                local timeLeft = string.format("%.1f", _G.ActionDelay - (tick() - startWait))
                LogLabel.Text = "Timer: " .. timeLeft .. " sec."
            end
            task.wait(0.1)
        end
        
        if _G.AnimeLifeSmartAutofarm then
            local zoneFound = false
            local zoneVector = nil
            
            pcall(function()
                local compRegion = workspace:FindFirstChild("CompletionRegion")
                if compRegion then
                    local driveZone = compRegion:FindFirstChild("DriveZone")
                    if driveZone and driveZone:IsA("BasePart") then
                        if driveZone.Position.Y > -50 then
                            zoneVector = driveZone.Position
                            zoneFound = true
                        end
                    end
                end
            end)
            
            if zoneFound and zoneVector then
                LogLabel.Text = "Status: Teleporting to DriveZone"
                physicsTeleport(zoneVector)
            else
                LogLabel.Text = "Status: Target missing. Returning to base..."
                
                local pizzaBase = nil
                for _, zone in pairs(workspace:GetDescendants()) do
                    if zone:IsA("BasePart") and (zone.Name:lower():match("pizza") or zone.Name:lower():match("delivery")) then
                        if zone.Size.Magnitude > 4 and not zone:IsDescendantOf(workspace:FindFirstChild("CompletionRegion") or workspace) then
                            pizzaBase = zone
                            break
                        end
                    end
                end
                
                if pizzaBase then 
                    physicsTeleport(pizzaBase.Position) 
                else
                    LogLabel.Text = "Error: Pizza spawn not found."
                end
            end
        end
    end
end)

-- Handler to save custom delay from input box
DelayInput.FocusLost:Connect(function(enterPressed)
    local checkNum = tonumber(DelayInput.Text)
    if checkNum and checkNum > 0 then
        _G.ActionDelay = checkNum
    else
        DelayInput.Text = tostring(_G.ActionDelay)
    end
end)

-- Button logic
ToggleBtn.MouseButton1Click:Connect(function()
    _G.AnimeLifeSmartAutofarm = not _G.AnimeLifeSmartAutofarm
    if _G.AnimeLifeSmartAutofarm then
        local checkNum = tonumber(DelayInput.Text)
        if checkNum and checkNum > 0 then _G.ActionDelay = checkNum end
        
        ToggleBtn.Text = "AUTOFARM: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    else
        ToggleBtn.Text = "START AUTOFARM"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
        LogLabel.Text = "Status: Stopped"
    end
end)
