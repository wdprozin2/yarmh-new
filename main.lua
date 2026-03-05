local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YARHM | Rayfield Full Edition",
   LoadingTitle = "Injetando Sistema Nebula...",
   LoadingSubtitle = "by wdprozin2",
   ConfigurationSaving = { Enabled = true, FileName = "YARHM_Full" }
})

local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")

-- ==========================================
-- UNIVERSAL (KWZT_routine)
-- ==========================================
local TabUniv = Window:CreateTab("Universal", "globe")

TabUniv:CreateSlider({
   Name = "WalkSpeed", Range = {16, 500}, Increment = 1, CurrentValue = 16,
   Callback = function(v) if lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = v end end,
})

TabUniv:CreateSlider({
   Name = "Field of View (FOV)", Range = {70, 120}, Increment = 1, CurrentValue = 70,
   Callback = function(v) workspace.CurrentCamera.FieldOfView = v end,
})

TabUniv:CreateToggle({
   Name = "Noclip", CurrentValue = false,
   Callback = function(v)
       _G.Noclip = v
       rs.Stepped:Connect(function()
           if _G.Noclip and lp.Character then
               for _, p in pairs(lp.Character:GetDescendants()) do
                   if p:IsA("BasePart") then p.CanCollide = false end
               end
           end
       end)
   end,
})

TabUniv:CreateButton({
   Name = "FPS Boost",
   Callback = function()
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.Plastic v.Reflectance = 0
           elseif v:IsA("Decal") then v:Destroy() end
       end
   end,
})

TabUniv:CreateInput({
   Name = "Teleportar para Player", PlaceholderText = "Nome do Player",
   Callback = function(t)
       local target = game.Players:FindFirstChild(t)
       if target and target.Character then lp.Character:MoveTo(target.Character.HumanoidRootPart.Position) end
   end,
})

-- ==========================================
-- MURDER MYSTERY 2 (IJIOJM_routine)
-- ==========================================
local TabMM2 = Window:CreateTab("MM2", "skull")

TabMM2:CreateSection("Combate")
TabMM2:CreateButton({
   Name = "Atirar no Murderer (Predict)",
   Callback = function()
       local m = nil
       for _, p in pairs(game.Players:GetPlayers()) do
           if p.Character and p.Character:FindFirstChild("Knife") then m = p break end
       end
       if m and lp.Character:FindFirstChild("Gun") then
           local pos = m.Character.HumanoidRootPart.Position + (m.Character.HumanoidRootPart.AssemblyLinearVelocity * 0.18)
           lp.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, pos, "AH2")
       end
   end,
})

TabMM2:CreateToggle({
   Name = "Kill Aura (Murderer)", CurrentValue = false,
   Callback = function(v)
       _G.KillAura = v
       task.spawn(function()
           while _G.KillAura do task.wait(0.1)
               for _, p in pairs(game.Players:GetPlayers()) do
                   if p ~= lp and p.Character and (p.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude < 10 then
                       if lp.Character:FindFirstChild("Knife") then
                           lp.Character.Knife.Stab:FireServer("Slash")
                       end
                   end
               end
           end
       end)
   end,
})

TabMM2:CreateSection("Farm & Map")
TabMM2:CreateToggle({
   Name = "Auto-Pegar Arma", CurrentValue = false,
   Callback = function(v)
       _G.AutoGun = v
       task.spawn(function()
           while _G.AutoGun do task.wait(0.5)
               local g = workspace:FindFirstChild("GunDrop") or (workspace.Normal and workspace.Normal:FindFirstChild("GunDrop"))
               if g and lp.Character then lp.Character.HumanoidRootPart.CFrame = g.CFrame end
           end
       end)
   end,
})

TabMM2:CreateButton({
   Name = "Teleport para Lobby",
   Callback = function() lp.Character:MoveTo(Vector3.new(-107, 152, 41)) end,
})

-- ==========================================
-- FLEE THE FACILITY (FKVEADO_routine)
-- ==========================================
local TabFTF = Window:CreateTab("Flee the Facility", "run")

TabFTF:CreateToggle({
   Name = "Anti-Erro de PC", CurrentValue = false,
   Callback = function(v)
       _G.AntiError = v
       local old; old = hookmetamethod(game, "__namecall", function(self, ...)
           local a = {...}
           if _G.AntiError and getnamecallmethod() == "FireServer" and a[1] == "SetPlayerMinigameResult" then a[2] = true end
           return old(self, unpack(a))
       end)
   end,
})

TabFTF:CreateButton({
   Name = "Ver Computadores & Saídas",
   Callback = function()
       for _, o in pairs(workspace:GetDescendants()) do
           if o.Name == "ComputerTable" or o.Name == "ExitDoor" then
               local h = Instance.new("Highlight", o)
               h.FillColor = (o.Name == "ExitDoor" and Color3.new(1,1,0) or o.Screen.Color)
           end
       end
   end,
})

-- ==========================================
-- FORSAKEN & OUTROS (ZUTHJ_routine)
-- ==========================================
local TabExtras = Window:CreateTab("Extras", "plus")

TabExtras:CreateToggle({
   Name = "Stamina Infinita (Forsaken)", CurrentValue = false,
   Callback = function(v)
       require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting).StaminaLossDisabled = v
   end,
})

TabExtras:CreateButton({
   Name = "Anti-AFK",
   Callback = function()
       local virtualUser = game:GetService("VirtualUser")
       lp.Idled:Connect(function() virtualUser:CaptureController() virtualUser:ClickButton2(Vector2.new()) end)
       Rayfield:Notify({Title = "Anti-AFK", Content = "Ativado!"})
   end,
})

Rayfield:LoadConfiguration()
