-- ABA CRÉDITOS - Godzilla Hub
return function(ContentContainer, LocalPlayer, Players, RunService, MarketplaceService, startTime)
    
    local function createLabel(text, parent, size, bold)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, size or 20)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
        label.TextSize = size or 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextWrapped = true
        label.Parent = parent
        return label
    end
    
    local function createSpacer(height, parent)
        local spacer = Instance.new("Frame")
        spacer.Size = UDim2.new(1, 0, 0, height)
        spacer.BackgroundTransparency = 1
        spacer.Parent = parent
        return spacer
    end
    
    local function createButton(text, callback, parent)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 40)
        button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 18
        button.Parent = parent
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = button
        
        button.MouseButton1Click:Connect(callback)
        
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(0, 140, 235)
        end)
        
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        end)
        
        return button
    end
    
    -- Link Discord no topo
    local discordTop = createLabel("https://discord.gg/PDc8bHsT", ContentContainer, 12, false)
    discordTop.TextColor3 = Color3.fromRGB(200, 200, 200)
    discordTop.TextXAlignment = Enum.TextXAlignment.Center
    
    createSpacer(3, ContentContainer)
    
    -- Imagem Discord
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, 350, 0, 200)
    img.Position = UDim2.new(0.5, -175, 0, 0)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://110586608819666"
    img.ScaleType = Enum.ScaleType.Fit
    img.Parent = ContentContainer
    
    createSpacer(205, ContentContainer)
    
    -- Título
    local title = createLabel("Godzilla Hub", ContentContainer, 24, true)
    title.TextXAlignment = Enum.TextXAlignment.Center
    
    -- Discord link
    local discordBottom = createLabel("https://discord.gg/PDc8bHsT", ContentContainer, 12, false)
    discordBottom.TextColor3 = Color3.fromRGB(200, 200, 200)
    discordBottom.TextXAlignment = Enum.TextXAlignment.Center
    
    createSpacer(10, ContentContainer)
    
    -- Botão
    createButton("Copy Link", function()
        setclipboard("https://discord.gg/PDc8bHsT")
        game.StarterGui:SetCore("SendNotification", {
            Title = "Godzilla Hub",
            Text = "Link copiado!",
            Duration = 3
        })
    end, ContentContainer)
    
    createSpacer(20, ContentContainer)
    
    -- Informações do Script
    createLabel("Informações do Script", ContentContainer, 20, true)
    createSpacer(5, ContentContainer)
    createLabel("Criadores:", ContentContainer, 14, true)
    createLabel("sereireconhecido", ContentContainer, 14, false)
    createLabel("Godzilla_eoking1", ContentContainer, 14, false)
    createSpacer(5, ContentContainer)
    createLabel("By:", ContentContainer, 14, true)
    createLabel("Godzilla Studios", ContentContainer, 14, false)
    createSpacer(5, ContentContainer)
    createLabel("Você está usando:", ContentContainer, 14, true)
    createLabel("Godzilla Hub", ContentContainer, 14, false)
    createSpacer(5, ContentContainer)
    createLabel("Executor Utilizado:", ContentContainer, 14, true)
    local execLabel = createLabel("Detectando...", ContentContainer, 14, false)
    
    spawn(function()
        wait(0.5)
        local exec = "Executor Desconhecido"
        if identifyexecutor then
            exec = identifyexecutor()
        end
        execLabel.Text = exec
    end)
    
    createSpacer(20, ContentContainer)
    
    -- Informações
    createLabel("Informações", ContentContainer, 20, true)
    createSpacer(5, ContentContainer)
    
    createLabel("Hoje é dia:", ContentContainer, 14, true)
    local dateLabel = createLabel(os.date("%d/%m/%Y - %H:%M:%S"), ContentContainer, 14, false)
    
    spawn(function()
        while ContentContainer and dateLabel and dateLabel.Parent do
            dateLabel.Text = os.date("%d/%m/%Y - %H:%M:%S")
            wait(1)
        end
    end)
    
    createSpacer(3, ContentContainer)
    
    createLabel("Seu Nickname:", ContentContainer, 14, true)
    createLabel(LocalPlayer.Name, ContentContainer, 14, false)
    createSpacer(3, ContentContainer)
    
    createLabel("Seu ID:", ContentContainer, 14, true)
    createLabel(tostring(LocalPlayer.UserId), ContentContainer, 14, false)
    createSpacer(3, ContentContainer)
    
    createLabel("Seu Jogo:", ContentContainer, 14, true)
    local gameLabel = createLabel("Carregando...", ContentContainer, 14, false)
    spawn(function()
        local s, info = pcall(function()
            return MarketplaceService:GetProductInfo(game.PlaceId)
        end)
        if s and info then
            gameLabel.Text = info.Name
        else
            gameLabel.Text = "Erro ao carregar"
        end
    end)
    createSpacer(3, ContentContainer)
    
    createLabel("Tempo de uso do script:", ContentContainer, 14, true)
    local timeLabel = createLabel("00:00:00", ContentContainer, 14, false)
    spawn(function()
        while ContentContainer and timeLabel and timeLabel.Parent do
            local elapsed = tick() - startTime
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = math.floor(elapsed % 60)
            timeLabel.Text = string.format("%02d:%02d:%02d", h, m, s)
            wait(1)
        end
    end)
    createSpacer(3, ContentContainer)
    
    createLabel("Seu Fps:", ContentContainer, 14, true)
    local fpsLabel = createLabel("0", ContentContainer, 14, false)
    spawn(function()
        local lastTime = tick()
        local frames = 0
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not ContentContainer or not fpsLabel or not fpsLabel.Parent then
                conn:Disconnect()
                return
            end
            frames = frames + 1
            local now = tick()
            if now - lastTime >= 1 then
                fpsLabel.Text = tostring(frames)
                frames = 0
                lastTime = now
            end
        end)
    end)
    createSpacer(3, ContentContainer)
    
    createLabel("Quantidade de jogadores no serv:", ContentContainer, 14, true)
    local playerLabel = createLabel(#Players:GetPlayers() .. " jogadores", ContentContainer, 14, false)
    
    Players.PlayerAdded:Connect(function()
        if ContentContainer and playerLabel and playerLabel.Parent then
            playerLabel.Text = #Players:GetPlayers() .. " jogadores"
        end
    end)
    
    Players.PlayerRemoving:Connect(function()
        wait(0.1)
        if ContentContainer and playerLabel and playerLabel.Parent then
            playerLabel.Text = #Players:GetPlayers() .. " jogadores"
        end
    end)
    
    print("Aba Creditos carregada!")
end
