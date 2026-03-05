local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YARHM | Rayfield Edition",
   LoadingTitle = "Carregando Módulos...",
   LoadingSubtitle = "by wdprozin2",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "YARHM_Config"
   }
})

local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")

-- ==========================================
-- ABA UNIVERSAL
-- ==========================================
local TabUniv = Window:CreateTab("Universal", "globe")

TabUniv:CreateSection("Movimentação")
TabUniv:CreateSlider({
   Name = "WalkSpeed (Velocidade)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
       if lp.Character and lp.Character:FindFirstChild("Humanoid") then
           lp.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

TabUniv:CreateToggle({
   Name = "Noclip (Atravessar Paredes)",
   CurrentValue = false,
   Callback = function(Value)
       _G.Noclip = Value
       rs.Stepped:Connect(function()
           if _G.Noclip and lp.Character then
               for _, v in pairs(lp.Character:GetDescendants()) do
                   if v:IsA("BasePart") then v.CanCollide = false end
               end
           end
       end)
   end,
})

TabUniv:CreateSection("Gráficos")
TabUniv:CreateButton({
   Name = "FPS Boost",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("Part") or v:IsA("MeshPart") then
               v.Material = Enum.Material.Plastic
               v.Reflectance = 0
           elseif v:IsA("Decal") then v:Destroy() end
       end
   end,
})

-- ==========================================
-- ABA MURDER MYSTERY 2
-- ==========================================
local TabMM2 = Window:CreateTab("MM2", "skull")

TabMM2:CreateSection("Combate")
TabMM2:CreateButton({
   Name = "Atirar no Murderer (Predict)",
   Callback = function()
       local murderer = nil
       for _, v in pairs(game.Players:GetPlayers()) do
           if v.Character and v.Character:FindFirstChild("Knife") then murderer = v break end
       end
       if murderer and lp.Character:FindFirstChild("Gun") then
           local hrp = murderer.Character.HumanoidRootPart
           local pos = hrp.Position + (hrp.AssemblyLinearVelocity * 0.18)
           lp.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, pos, "AH2")
           Rayfield:Notify({Title = "MM2", Content = "Disparo feito no " .. murderer.Name})
       end
   end,
})

TabMM2:CreateToggle({
   Name = "Auto-Pegar Arma Caída",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoGun = Value
       task.spawn(function()
           while _G.AutoGun do
               task.wait(0.5)
               local gun = workspace:FindFirstChild("GunDrop") or (workspace.Normal and workspace.Normal:FindFirstChild("GunDrop"))
               if gun and lp.Character then lp.Character.HumanoidRootPart.CFrame = gun.CFrame end
           end
       end)
   end,
})

-- ==========================================
-- ABA FLEE THE FACILITY
-- ==========================================
local TabFTF = Window:CreateTab("Flee the Facility", "run")

TabFTF:CreateSection("Hacks")
TabFTF:CreateToggle({
   Name = "Anti-Erro de PC (Auto-Win Minigame)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AntiError = Value
       local old; old = hookmetamethod(game, "__namecall", function(self, ...)
           local args = {...}
           if _G.AntiError and getnamecallmethod() == "FireServer" and args[1] == "SetPlayerMinigameResult" then
               args[2] = true
           end
           return old(self, unpack(args))
       end)
   end,
})

TabFTF:CreateButton({
   Name = "Revelar Computadores (Highlight)",
   Callback = function()
       for _, obj in pairs(workspace:GetDescendants()) do
           if obj.Name == "ComputerTable" then
               local hl = Instance.new("Highlight", obj)
               hl.FillColor = obj.Screen.Color
           end
       end
   end,
})

-- ==========================================
-- ABA FORSAKEN
-- ==========================================
local TabForsaken = Window:CreateTab("Forsaken", "ghost")

TabForsaken:CreateToggle({
   Name = "Stamina Infinita",
   CurrentValue = false,
   Callback = function(Value)
       local sprint = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
       sprint.StaminaLossDisabled = Value
   end,
})

-- Carregamento Final
Rayfield:LoadConfiguration()
