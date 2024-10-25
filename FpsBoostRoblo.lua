-- Script para otimizar o jogo, deixar os personagens invisíveis e exibir uma tela preta

local function removeTextures(part)
    -- Verifica se a parte é um tipo de objeto BasePart e remove texturas
    if part:IsA("BasePart") then
        part.Material = Enum.Material.SmoothPlastic
        part.Color = Color3.new(0.5, 0.5, 0.5) -- Cor cinza padrão para reduzir detalhes
    end
end

local function makeCharacterInvisible(character)
    -- Remove roupas, acessórios e torna as partes do personagem invisíveis
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("Accessory") or item:IsA("ShirtGraphic") then
            item:Destroy()
        end
        if item:IsA("BasePart") and item.Name ~= "HumanoidRootPart" then
            item.Material = Enum.Material.SmoothPlastic
            item.Color = Color3.new(0.5, 0.5, 0.5) -- Cor cinza para as partes do personagem
            item.Transparency = 1 -- Deixa a parte invisível
        end
    end
end

local function optimizeGame()
    -- Remove texturas de todos os objetos no workspace
    for _, object in pairs(workspace:GetDescendants()) do
        removeTextures(object)
    end

    -- Remove texturas de novas partes adicionadas
    workspace.DescendantAdded:Connect(function(descendant)
        removeTextures(descendant)
    end)
end

local function onPlayerAdded(player)
    -- Deixa o personagem invisível
    player.CharacterAppearanceLoaded:Connect(makeCharacterInvisible)
end

-- Conecta para novos jogadores e objetos
game.Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        makeCharacterInvisible(player.Character)
    end
end

-- Otimiza o jogo
optimizeGame()

-- Cria uma tela preta cobrindo a visão do jogador
local function createBlackScreen()
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    local blackFrame = Instance.new("Frame")
    
    -- Configurações da tela preta
    screenGui.Name = "BlackScreenGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    blackFrame.Size = UDim2.new(1, 0, 1, 0)
    blackFrame.Position = UDim2.new(0, 0, 0, 0)
    blackFrame.BackgroundColor3 = Color3.new(0, 0, 0) -- Cor preta
    blackFrame.BorderSizePixel = 0
    blackFrame.Parent = screenGui
end

-- Cria a tela preta
createBlackScreen()
