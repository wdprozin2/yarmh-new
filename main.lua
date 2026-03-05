local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YARHM | Rayfield Edition",
   LoadingTitle = "Injetando Funções do YARHM...",
   LoadingSubtitle = "by Imperial & Gemini",
   ConfigurationSaving = { Enabled = true, FileName = "YARHM_Config" }
})

-- Variáveis de controle (Extraídas do seu código)
local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")

-- --- ABA UNIVERSAL ---
local TabUniv = Window:CreateTab("Universal", "globe")

TabUniv:CreateSlider({
   Name = "Velocidade (WalkSpeed)",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
       if lp.Character and lp.Character:FindFirstChild("Humanoid") then
           lp.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

TabUniv:CreateButton({
   Name = "AFEM (Menu de Emotes)",
   Callback = function()
       loadstring(game:HttpGet("https://yarhm.mhi.im/scr?channel=afem"))()
   end,
})

-- --- ABA MURDER MYSTERY 2 ---
local TabMM2 = Window:CreateTab("MM2", "skull")

TabMM2:CreateButton({
   Name = "Atirar no Murderer (Predict)",
   Callback = function()
       -- Lógica extraída da função 'getPredictedPosition' do seu script
       local murderer = nil
       for _, p in pairs(game.Players:GetPlayers()) do
           if p.Character and p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then
               murderer = p
           end
       end
       
       if murderer and lp.Character:FindFirstChild("Gun") then
           local hrp = murderer.Character.HumanoidRootPart
           local velocity = hrp.AssemblyLinearVelocity
           local predictPos = hrp.Position + (velocity * 0.18) -- O offset de 2.8 que estava no seu código
           
           local args = { [1] = 1, [2] = predictPos, [3] = "AH2" }
           lp.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
           Rayfield:Notify({Title = "Sucesso", Content = "Disparo efetuado com predição!"})
       else
           Rayfield:Notify({Title = "Erro", Content = "Murderer não encontrado ou você está sem arma."})
       end
   end,
})

TabMM2:CreateToggle({
   Name = "Auto Get Gun (Pegar arma caída)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoGetGun = Value
       task.spawn(function()
           while _G.AutoGetGun do
               task.wait(1)
               local gun = workspace:FindFirstChild("GunDrop") or (workspace.Normal and workspace.Normal:FindFirstChild("GunDrop"))
               if gun and lp.Character then
                   lp.Character.HumanoidRootPart.CFrame = gun.CFrame
               end
           end
       end)
   end,
})

-- --- ABA FLEE THE FACILITY ---
local TabFTF = Window:CreateTab("Flee the Facility", "run")

TabFTF:CreateToggle({
   Name = "Anti-Erro de PC",
   CurrentValue = false,
   Callback = function(Value)
       -- Essa é a lógica que estava no seu pcall do HookMetamethod
       _G.AntiPCError = Value
       Rayfield:Notify({Title = "Hack Ativado", Content = "Você não vai mais errar os computadores."})
   end,
})

-- --- ABA FORSAKEN ---
local TabForsaken = Window:CreateTab("Forsaken", "ghost")

TabForsaken:CreateToggle({
   Name = "Stamina Infinita",
   CurrentValue = false,
   Callback = function(Value)
       local sprint = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
       sprint.StaminaLossDisabled = Value
   end,
})

Rayfield:LoadConfiguration()
