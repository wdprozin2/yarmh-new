local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YARHM Rayfield Edition",
   LoadingTitle = "Injetando Funções...",
   ConfigurationSaving = { Enabled = true, FileName = "YARHM_Config" }
})

local TabMM2 = Window:CreateTab("Murder Mystery 2", "skull")

TabMM2:CreateButton({
   Name = "Atirar no Murderer",
   Callback = function()
       -- APENAS A LÓGICA QUE ESTAVA NA ROUTINE DO MM2
       local murderer = nil
       for _, v in pairs(game.Players:GetPlayers()) do
           if v.Character and v.Character:FindFirstChild("Knife") then murderer = v break end
       end
       if murderer and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
           local pos = murderer.Character.HumanoidRootPart.Position + (murderer.Character.HumanoidRootPart.AssemblyLinearVelocity * 0.18)
           game.Players.LocalPlayer.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(1, pos, "AH2")
       end
   end,
})

-- Continue adicionando as abas e funções conforme eu te mandei antes...
