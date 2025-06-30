local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local AntiKick = false

local oldKick = LocalPlayer.Kick
LocalPlayer.Kick = function(...)
    if AntiKick then
        print("Kick prevented!")
    else
        oldKick(...)
    end
end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 150)
Frame.Position = UDim2.new(0, 10, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "🧠 Brainrot Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local function CreateToggle(name, y, callback)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(0, 200, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, y)
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.Text = name .. ": OFF"
    local toggled = false
    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        Button.Text = name .. ": " .. (toggled and "ON" or "OFF")
        callback(toggled)
    end)
end

CreateToggle("Anti Kick", 40, function(state)
    AntiKick = state
end)

CreateToggle("Anti AFK", 80, function(state)
    if state then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)
