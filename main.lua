-- Carrega a UI Rayfield primeiro
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Cria a janela principal
local Window = Rayfield:CreateWindow({
   Name = "YARHM | Rayfield Edition",
   LoadingTitle = "Carregando Scripts...",
   LoadingSubtitle = "by wdprozin2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YARHM_Configs",
      FileName = "MainConfig"
   },
   KeySystem = false
})

-- Cria a aba principal
local MainTab = Window:CreateTab("Início", "home")

MainTab:CreateSection("Carregamento Externo")

-- Botão que executa o seu script do GitHub
MainTab:CreateButton({
   Name = "Executar YARHM Custom",
   Callback = function()
       local success, err = pcall(function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/wdprozin2/yarmh-new/main/main.lua"))()
       end)
       
       if success then
           Rayfield:Notify({Title = "Sucesso", Content = "Script carregado!", Duration = 2})
       else
           Rayfield:Notify({Title = "Erro", Content = "Falha ao baixar script: " .. tostring(err), Duration = 5})
       end
   end,
})

-- Exemplo de função universal rápida (pra não ficar vazio)
local MiscTab = Window:CreateTab("Misc", "settings")
MiscTab:CreateSlider({
   Name = "Velocidade",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

Rayfield:LoadConfiguration()
