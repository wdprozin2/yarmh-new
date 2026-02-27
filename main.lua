-- Carrega a biblioteca WindUI (main.lua)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/src/init.lua"))()

-- Cria a janela principal
local Window = WindUI:CreateWindow({
    Title = "YARHM 1.20 - Nova UI",
    Icon = "rbxassetid://17864987433", -- Seu ícone original
    Author = "Imperial",
    Folder = "YARHM_Configs"
})

-- Cria as abas (Tabs)
local TabUniversal = Window:AddTab({ Title = "Universal", Icon = "globe" })
local TabGames = Window:AddTab({ Title = "Games", Icon = "gamepad-2" })
local TabSettings = Window:AddTab({ Title = "Config", Icon = "settings" })

-- --- CONTEÚDO DA ABA UNIVERSAL ---
TabUniversal:AddButton({
    Title = "Ativar Fly",
    Desc = "Ativa o utilitário de voo",
    Callback = function()
        -- Aqui vai a lógica da sua FUNCTIONSmodule original
        print("Fly ativado!")
    end
})

TabUniversal:AddSlider({
    Title = "WalkSpeed",
    Desc = "Muda a velocidade do boneco",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

-- --- CONTEÚDO DA ABA GAMES ---
TabGames:AddButton({
    Title = "Flee the Facility",
    Desc = "Carrega scripts específicos para FTF",
    Callback = function()
        -- Lógica que estava no seu local Converted["_Flee the Facility"]
    end
})

TabGames:AddButton({
    Title = "Murder Mystery 2",
    Desc = "Carrega scripts para MM2",
    Callback = function()
        -- Lógica que estava no seu local Converted["_Murder Mystery 2"]
    end
})

-- --- ABA DE CONFIGURAÇÕES ---
TabSettings:AddDropdown({
    Title = "Tema da UI",
    Multi = false,
    Options = {"Dark", "Light", "Rainbow", "Rose", "Midnight"},
    Default = "Dark",
    Callback = function(t)
        WindUI:SetTheme(t)
    end
})

-- Notificação de sucesso ao carregar
WindUI:Notify({
    Title = "Script Carregado!",
    Content = "YARHM agora está usando a WindUI.",
    Duration = 5
})
