--[[
    criador by trickzqww 
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local Activated = false
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "uwu"

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 140, 0, 50)
button.Position = UDim2.new(0, 30, 0, 30)
button.Text = "[OFF]"
button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
button.TextScaled = true
button.Active = true
button.Draggable = true

local function getNearbyEnemy()
    local closest = nil
    local shortest = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local distance = (Camera.CFrame.Position - head.Position).Magnitude

            if distance < 20 and distance < shortest then
                shortest = distance
                closest = head
            end
        end
    end

    return closest
end

local function aimAt(head)
    if head then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
    end
end

local function infiniteAmmo()
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        for _, v in ipairs(tool:GetDescendants()) do
            if v:IsA("IntValue") or v:IsA("NumberValue") then
                if v.Name:lower():find("ammo") or v.Name:lower():find("clip") then
                    v.Value = 99999
                end
            end
        end
    end
end

local function increaseDamage()
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        for _, v in ipairs(tool:GetDescendants()) do
            if v:IsA("IntValue") or v:IsA("NumberValue") then
                if v.Name:lower():find("damage") then
                    v.Value = 9999
                end
            end
        end
    end
end

local function teleportToEnemy()
    local target = getNearbyEnemy()
    if target then
        LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(target.Position))
    end
end

button.MouseButton1Click:Connect(function()
    Activated = not Activated
    button.Text = Activated and "[ON]" or "[OFF]"
    button.BackgroundColor3 = Activated and Color3.fromRGB(60, 220, 60) or Color3.fromRGB(255, 80, 80)
end)

RunService.RenderStepped:Connect(function()
    if Activated then
        teleportToEnemy()
        infiniteAmmo()
        increaseDamage()
    end
end)