local vst = {Enabled=true}
local vstHttp = nil
if hookfunction then
    local vstfunc = function(a,b,c) print(a,b,c) end
    hookfunction(vstfunc,function(a,b,c)
        return true
    end)
    if vstfunc() ~= true then
        game.Players.LocalPlayer:Kick('VST Kicked Error Function (01)')
        wait(5)
        while true do end
        return
    end
    if isfunctionhooked then
        if not isfunctionhooked(vstfunc) then
            game.Players.LocalPlayer:Kick('VST Kicked Error Function (03)')
            wait(5)
            while true do end
            return
        end
    end
end
local Test = {game.HttpGet,loadstring}
for i,v in pairs(Test) do
    if not iscclosure(v) or (isfunctionhooked and isfunctionhooked(v)) then
        game.Players.LocalPlayer:Kick('VST Kicked Error Function (02)')
        wait(5)
        while true do end
        return
    end
end
local function AZT_CHECK_FNHOOK_11111(func)
    local loadstlist = {}
    for i,v in pairs(debug.getregistry()) do
        if typeof(v) == 'function' and debug.getinfo(v).name == func then
            table.insert(loadstlist, i, v)
            ok = true
        end
    end
    if ok then game.Players.LocalPlayer:Kick("AZT Loader: Error Function #1243") return end
end
AZT_CHECK_FNHOOK_11111("loadstring")
AZT_CHECK_FNHOOK_11111("HttpGet")
AZT_CHECK_FNHOOK_11111("http_request")
AZT_CHECK_FNHOOK_11111("request")

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local localPlayer = Players.LocalPlayer

getgenv().whscript = "KZ HUB"
getgenv().webhookexecUrl = "https://discord.com/api/webhooks/1436634012293791906/r66W_prYP7yMCtkRpcfiCdEW7uxtgCyqtDZHTknfjcHjyQsThZi04Tbi4fyU33gKeqRu"
getgenv().ExecLogSecret = false

local ui = gethui()
local folderName = "screen"
local folder = Instance.new("Folder")
folder.Name = folderName
local player = game:GetService("Players").LocalPlayer

if not ui:FindFirstChild(folderName) then
    folder.Parent = gethui()

    local userid = player.UserId
    local gameid = game.PlaceId
    local jobid = tostring(game.JobId)
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    local completeTime = os.date("%Y-%m-%d %H:%M:%S")
    local position = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or "N/A"
    local health = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
    local maxHealth = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or "N/A"

    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "**Script Execution Detected | Exec Log**",
            ["description"] = "A script was executed. Details below:",
            ["type"] = "rich",
            ["color"] = 0x3498db,
            ["fields"] = {
                {
                    ["name"] = "Script Info",
                    ["value"] = "Script Name: " .. getgenv().whscript .. "\nExecuted At: " .. completeTime,
                    ["inline"] = false
                },
                {
                    ["name"] = "Player Details",
                    ["value"] = "Username: " .. player.Name ..
                                "\nDisplay Name: " .. player.DisplayName ..
                                "\nUserID: " .. userid ..
                                "\nHealth: " .. health .. " / " .. maxHealth ..
                                "\nProfile: https://www.roblox.com/users/" .. userid .. "/profile",
                    ["inline"] = false
                },
                {
                    ["name"] = "Character Position",
                    ["value"] = tostring(position),
                    ["inline"] = false
                }
            }
        }}
    }

    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    request({Url = getgenv().webhookexecUrl, Body = newdata, Method = "POST", Headers = headers})
end

-- =============================================
--           CẤU HÌNH FILTER CHUNG
-- =============================================
if not _G.KZ_Filters then _G.KZ_Filters = {} end
_G.KZ_Filters.PlayerFilters = {}

_G.KZ_IsFriend = function(targetPlayer)
    if not targetPlayer or targetPlayer == localPlayer then return false end
    local success, isFriend = pcall(function()
        return localPlayer:IsFriendsWith(targetPlayer.UserId)
    end)
    return success and isFriend
end

_G.KZ_IsValidTarget = function(targetPlayer, ignoreEnabled)
    if not targetPlayer or targetPlayer == localPlayer then return false end
    if not targetPlayer.Character then return false end
    
    if ignoreEnabled then
        local hum = targetPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            local health = hum:GetAttribute("Health") or hum.Health or 0
            if health <= 0 then return false end
        end
        if _G.KZ_IsFriend(targetPlayer) then return false end
    end
    
    if _G.KZ_Filters.PlayerFilters[targetPlayer.Name] then return false end
    
    return true
end

-- =============================================
--           MENU GỐC
-- =============================================
local screenGui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "KFC_HUB_FULL"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0,460,0,450)
mainFrame.Position = UDim2.new(0.5,-230,0.35,-225)
mainFrame.BackgroundColor3 = Color3.fromRGB(26,26,26)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,8)

local uiScale = Instance.new("UIScale")
uiScale.Scale = 0.9
uiScale.Parent = mainFrame

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1,0,0,36)
header.Position = UDim2.new(0,0,0,0)
header.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", header).CornerRadius = UDim.new(0,6)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-110,1,0)
title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1
title.Text = " KZ HUB | Discord: kfc_3012"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 15

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0,34,0,28)
minimizeBtn.Position = UDim2.new(1,-82,0,4)
minimizeBtn.Text = "─"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0,6)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,34,0,28)
closeBtn.Position = UDim2.new(1,-42,0,4)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)

local openSmall = Instance.new("TextButton", screenGui)
openSmall.Size = UDim2.new(0,55,0,55)
openSmall.Position = UDim2.new(0.05, 0, 0.2, 0)
openSmall.Text = "KZ"
openSmall.Visible = false
openSmall.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openSmall.TextColor3 = Color3.fromRGB(255, 255, 255)
openSmall.Font = Enum.Font.GothamBold
openSmall.TextSize = 16
openSmall.Active = true
openSmall.Draggable = true

local corner = Instance.new("UICorner", openSmall)
corner.CornerRadius = UDim.new(1, 0)

local stroke = Instance.new("UIStroke", openSmall)
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 0.4

openSmall.MouseEnter:Connect(function()
    openSmall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    stroke.Transparency = 0
end)
openSmall.MouseLeave:Connect(function()
    openSmall.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    stroke.Transparency = 0.4
end)

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openSmall.Visible = true
end)

openSmall.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openSmall.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Tabs
local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Size = UDim2.new(1,-20,0,36)
tabsFrame.Position = UDim2.new(0,10,0,44)
tabsFrame.BackgroundTransparency = 1

local function makeTabBtn(text, index, total)
    local widthScale = 1 / total
    local posScale = (index - 1) / total
    local b = Instance.new("TextButton", tabsFrame)
    b.Size = UDim2.new(widthScale, -8, 1, 0)
    b.Position = UDim2.new(posScale, 4, 0, 0)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(36,36,36)
    b.TextColor3 = Color3.fromRGB(200,200,200)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.AutoButtonColor = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    return b
end

local totalTabs = 4
local tabCombatBtn = makeTabBtn("Combat", 1, totalTabs)
local tabUtilBtn    = makeTabBtn("GTX", 2, totalTabs)
local tabExploitBtn = makeTabBtn("Exploits", 3, totalTabs)
local tabFilterBtn  = makeTabBtn("Filter", 4, totalTabs)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-20,1,-96)
contentFrame.Position = UDim2.new(0,10,0,84)
contentFrame.BackgroundTransparency = 1

local combatFrame = Instance.new("Frame", contentFrame)
combatFrame.Size = UDim2.new(1,0,1,0)
combatFrame.BackgroundTransparency = 1
combatFrame.Visible = true

local utilFrame = Instance.new("Frame", contentFrame)
utilFrame.Size = UDim2.new(1,0,1,0)
utilFrame.BackgroundTransparency = 1
utilFrame.Visible = false

local exploitsFrame = Instance.new("Frame", contentFrame)
exploitsFrame.Size = UDim2.new(1,0,1,0)
exploitsFrame.BackgroundTransparency = 1
exploitsFrame.Visible = false

local filterFrame = Instance.new("Frame", contentFrame)
filterFrame.Size = UDim2.new(1,0,1,0)
filterFrame.BackgroundTransparency = 1
filterFrame.Visible = false

tabCombatBtn.MouseButton1Click:Connect(function()
    combatFrame.Visible = true
    utilFrame.Visible = false
    exploitsFrame.Visible = false
    filterFrame.Visible = false
end)
tabUtilBtn.MouseButton1Click:Connect(function()
    combatFrame.Visible = false
    utilFrame.Visible = true
    exploitsFrame.Visible = false
    filterFrame.Visible = false
end)
tabExploitBtn.MouseButton1Click:Connect(function()
    combatFrame.Visible = false
    utilFrame.Visible = false
    exploitsFrame.Visible = true
    filterFrame.Visible = false
end)
tabFilterBtn.MouseButton1Click:Connect(function()
    combatFrame.Visible = false
    utilFrame.Visible = false
    exploitsFrame.Visible = false
    filterFrame.Visible = true
end)

-- =============================================
--      HÀM TẠO BUTTON TIỆN LỢI
-- =============================================
local function createButton(parent, text, posY)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-20,0,34)
    btn.Position = UDim2.new(0,10,0,posY)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    return btn
end

local function createSmallButton(parent, text, posY)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-20,0,28)
    btn.Position = UDim2.new(0,10,0,posY)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    return btn
end

-- =============================================
--      HÀM HELPER
-- =============================================
local function getHRP()
    return localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function lpdash()
    local hrp = getHRP()
    if hrp then
        pcall(function()
            require(RS:WaitForChild("Core")).Library("Remote").Send("Dash", hrp.CFrame, "L", 1)
        end)
    end
end

-- =============================================
--      BRING MODE CONFIG
-- =============================================
local BringConfig = {
    Enabled = false,
    PullAllDelay = 0.4,
    SaiyanSpeed = 1,
    SpinSpeed = 15,
    DamageMultiplier = 3,
    IgnoreEnabled = true
}

local function _saiyanFireGon(abilityNum)
    local char = localPlayer.Character
    if not char then return end
    local hrp = getHRP()
    if not hrp then return end

    local targets = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if _G.KZ_IsValidTarget(p, BringConfig.IgnoreEnabled) then
            table.insert(targets, p.Character)
        end
    end
    if #targets == 0 then return end

    for _, targetChar in ipairs(targets) do
        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetHRP then continue end
        local jitterCF = targetHRP.CFrame * CFrame.new(math.random(-300,300), math.random(-30,30), math.random(-300,300))
        local actionID = math.random(100000, 9999999)
        local actionNumber = "Action"..math.random(1000, 9999)
        pcall(function()
            local ability = RS.Characters["Gon"].Abilities[abilityNum]
            if not ability then return end
            RS.Remotes.Abilities.Ability:FireServer(ability, actionID)
            RS.Remotes.Combat.Action:FireServer(ability, "Gon:Abilities:"..abilityNum, 1, actionID, {
                HitboxCFrames = {jitterCF}, BestHitCharacter = targetChar, HitCharacters = {targetChar},
                Ignore = {[actionNumber] = {targetChar}}, DeathInfo = {}, Actions = {[actionNumber] = {}},
                HitInfo = {Blocked = false, IsFacing = true, IsInFront = true}, BlockedCharacters = {},
                ServerTime = tick(), FromCFrame = jitterCF
            }, actionNumber)
            task.wait(0.1)
            pcall(function() RS.Remotes.Abilities.AbilityCanceled:FireServer(ability) end)
        end)
    end
end

local function _pullAllPlayersByAbility()
    local char = localPlayer.Character
    if not char then return end
    local targets = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if _G.KZ_IsValidTarget(p, BringConfig.IgnoreEnabled) then
            table.insert(targets, p.Character)
        end
    end
    if #targets == 0 then return end
    for _, targetChar in ipairs(targets) do
        task.spawn(function() _saiyanFireGon("1"); task.wait(0.05); _saiyanFireGon("2") end)
    end
end

local function autoSpin()
    local char = localPlayer.Character
    local hrp = getHRP()
    local hum = char and char:FindFirstChild("Humanoid")
    if hrp and hum then
        pcall(function() hum.AutoRotate = false; hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(BringConfig.SpinSpeed), 0) end)
    end
end

local ActionRemote = RS:FindFirstChild("Remotes")
if ActionRemote then ActionRemote = ActionRemote:FindFirstChild("Combat") end
if ActionRemote then ActionRemote = ActionRemote:FindFirstChild("Action") end

if ActionRemote then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if self == ActionRemote and method == "FireServer" and BringConfig.Enabled then
            for _, arg in ipairs(args) do
                if type(arg) == "table" and arg.HitCharacters then
                    local newTargets = {}
                    for _, char in ipairs(arg.HitCharacters) do
                        for _ = 1, BringConfig.DamageMultiplier do
                            table.insert(newTargets, char)
                        end
                    end
                    arg.HitCharacters = newTargets
                end
            end
        end
        return oldNamecall(self, unpack(args))
    end)
end

local bringLoop1, bringLoop2, bringLoop3
local function startBringMode()
    if bringLoop1 then return end
    BringConfig.Enabled = true
    bringLoop1 = task.spawn(function() while BringConfig.Enabled do _pullAllPlayersByAbility() task.wait(BringConfig.PullAllDelay) end end)
    bringLoop2 = task.spawn(function() while BringConfig.Enabled do for _=1,BringConfig.SaiyanSpeed do task.spawn(function() _saiyanFireGon("1") end); task.spawn(function() _saiyanFireGon("2") end) end; lpdash(); task.wait(0.5) end end)
    bringLoop3 = task.spawn(function() while BringConfig.Enabled do autoSpin() task.wait() end end)
end

local function stopBringMode()
    BringConfig.Enabled = false
    if bringLoop1 then task.cancel(bringLoop1) bringLoop1 = nil end
    if bringLoop2 then task.cancel(bringLoop2) bringLoop2 = nil end
    if bringLoop3 then task.cancel(bringLoop3) bringLoop3 = nil end
    pcall(function() localPlayer.Character.Humanoid.AutoRotate = true end)
end

-- =============================================
--      GOD MODE
-- =============================================
local GodModeEnabled = false
local godModeLoop = nil
local savedCF = nil

local function applyGodModeOnce()
    local char = localPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        savedCF = hrp.CFrame
        pcall(function() 
            hrp.CFrame = CFrame.new(hrp.Position.X, -500, hrp.Position.Z) 
        end)
        pcall(function()
            if type(replicatesignal) == "function" then
                replicatesignal(localPlayer.Kill)
            else
                char:BreakJoints()
            end
        end)
    end
end

local function enableGodMode()
    if godModeLoop then return end
    applyGodModeOnce()
    godModeLoop = task.spawn(function()
        while GodModeEnabled do
            applyGodModeOnce()
            task.wait(0.5)
        end
    end)
end

local function disableGodMode()
    GodModeEnabled = false
    if godModeLoop then
        task.cancel(godModeLoop)
        godModeLoop = nil
    end
    savedCF = nil
end

-- =============================================
--      KILL FARMING MODULE
-- =============================================
_G.KA = {
    Farm = {Running = false, Connections = {}}
}

_G.KA_Config = {
    Farm = {
        IgnoreFriends = false, 
        Range = 67.5, 
        Enabled = false
    }
}

_G.KA_isFriend = function(p)
    return p and p ~= localPlayer and localPlayer:IsFriendsWith(p.UserId)
end

_G.KA_getRandomAlivePlayer = function()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character then
            if _G.KA_Config.Farm.IgnoreFriends and _G.KA_isFriend(p) then continue end
            local hum = p.Character:FindFirstChild("Humanoid")
            if hum and (hum:GetAttribute("Health") or 0) > 0 then
                table.insert(list, p)
            end
        end
    end
    if #list > 0 then
        return list[math.random(#list)]
    end
end

_G.KA_teleportUnderPlayer = function(p)
    local hrp = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if hrp and localPlayer.Character then
        pcall(function()
            require(localPlayer.PlayerScripts.Character.FullCustomReplication)
                .Override(localPlayer.Character, CFrame.new(hrp.Position - Vector3.new(0, 30, 0)))
        end)
    end
end

_G.KA_spectatePlayer = function(p)
    local cam = Workspace.CurrentCamera
    local hum = p and p.Character and p.Character:FindFirstChildOfClass("Humanoid")
    if cam and hum then
        cam.CameraType = Enum.CameraType.Custom
        cam.CameraSubject = hum
    end
end

_G.KA_farmLoop = function()
    local p = _G.KA_getRandomAlivePlayer()
    if p then
        _G.KA_teleportUnderPlayer(p)
        _G.KA_spectatePlayer(p)
    end
end

_G.KA_KillFarmAura = function(n)
    if not (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
    
    local PlayersList = {}
    local index = 1
    local hrp = localPlayer.Character.HumanoidRootPart
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character then
            if _G.KA_Config.Farm.IgnoreFriends and _G.KA_isFriend(p) then continue end
            local hum = p.Character:FindFirstChild("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and root and not p.Character:GetAttribute("Invincible") then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist <= _G.KA_Config.Farm.Range then
                    local health = hum:GetAttribute("Health") or hum.Health or 0
                    if health > 0 then
                        for i = 1, n do
                            PlayersList[index] = p.Character
                            index = index + 1
                        end
                    end
                end
            end
        end
    end
    
    if index > 1 then
        pcall(function()
            local wc = RS.Characters[localPlayer.Data.Character.Value].WallCombo
            RS.Remotes.Abilities.Ability:FireServer(wc, 69)
            RS.Remotes.Combat.Action:FireServer(wc, "", 4, 69, {
                BestHitCharacter = nil,
                HitCharacters = PlayersList,
                Ignore = {},
                Actions = {}
            })
        end)
    end
end

_G.KA_setGravity = function(state)
    local char = localPlayer.Character
    if not char then return end
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = not state
            v.AssemblyLinearVelocity = Vector3.zero
            v.AssemblyAngularVelocity = Vector3.zero
        end
    end
end

_G.KA_startKillFarming = function()
    _G.KA_setGravity(false)
    
    table.insert(_G.KA.Farm.Connections, RunService.Heartbeat:Connect(_G.KA_farmLoop))
    table.insert(_G.KA.Farm.Connections, RunService.Heartbeat:Connect(function()
        _G.KA_lpdash()
        local c = localPlayer.Data.Character.Value
        _G.KA_KillFarmAura(c == "Gon" and 20 or 50)
    end))
end

_G.KA_stopKillFarming = function()
    for _, conn in ipairs(_G.KA.Farm.Connections) do
        conn:Disconnect()
    end
    _G.KA.Farm.Connections = {}
    
    _G.KA_setGravity(true)
    
    local cam = Workspace.CurrentCamera
    if cam then
        cam.CameraType = Enum.CameraType.Custom
        if localPlayer.Character then
            local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then cam.CameraSubject = hum end
        end
    end
end

-- Auto Respawn
RunService.Heartbeat:Connect(function()
    if _G.KA_Config.Farm.Enabled then
        local char = localPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                local health = hum:GetAttribute("Health") or hum.Health or 100
                if health <= 0 then
                    task.wait(0.5)
                    pcall(function()
                        RS.Remotes.Character.Respawn:FireServer()
                    end)
                end
            end
        end
    end
end)

-- =============================================
--      ANTI LAG ABILITY ONLY MOB
-- =============================================
if not _G.KZ_LagModules then _G.KZ_LagModules = {} end

_G.KZ_LagModules.AntiLagAbilityOnlyMob = {
    enabled = false,
    connections = {}
}

local ALL_KEYWORDS = {
    "MobAwakeningGrab", "LandingSmall", "LandingLarge", "Fall", "Leap", "Beams", "BeamsSmoke", "BeamsFire",
    "DustBig", "MobAirstrike", "Projectile", "Ring", "MobCutscene", "MobUltRocks", "RockShatter",
    "MobWall", "MobSeismic", "LeftBeam", "RightBeam", "WallHit", "MobWalFinisher", "Summon",
    "Explosion", "Aura", "Dust", "Rocks", "CCBlack", "CCWhite"
}

local function shouldDestroy(obj)
    for _, keyword in ipairs(ALL_KEYWORDS) do
        if obj.Name:find(keyword) then return true end
    end
    return false
end

function _G.KZ_LagModules.AntiLagAbilityOnlyMob:Start()
    if #self.connections > 0 then return end
    self.enabled = true
    
    pcall(function()
        local Core = require(RS:WaitForChild("Core"))
        local CameraShake = Core.Get("Camera","Shake")
        if CameraShake then CameraShake.Shake = function() return {StopSustain = function() end} end end
    end)
    
    pcall(function()
        local Core = require(RS:WaitForChild("Core"))
        local Rocks = Core.Get("Map","Rocks")
        if Rocks then Rocks.Constant = function() return nil end; Rocks.CreateRock = function() return nil end; Rocks.Launch = function() return nil end end
    end)
    
    pcall(function()
        local Core = require(RS:WaitForChild("Core"))
        local Destruction = Core.Get("Map","Destruction")
        if Destruction then Destruction.Process = function() return nil end; Destruction.Destroy = function() return nil end end
    end)
    
    pcall(function()
        local VFX = require(RS.Assets.VFXHelp)
        if VFX then VFX.CreateShowcaseVFX = function() return {PrimaryPart = Instance.new("Part")} end end
    end)
    
    table.insert(self.connections, workspace.DescendantAdded:Connect(function(obj)
        if not self.enabled then return end
        if obj:IsA("Model") or obj:IsA("BasePart") or obj:IsA("Beam") then
            if shouldDestroy(obj) then
                task.wait()
                if obj and obj.Parent then obj:Destroy() end
            end
        end
    end))
    
    table.insert(self.connections, Lighting.ChildAdded:Connect(function(obj)
        if not self.enabled then return end
        if obj.Name == "CCBlack" or obj.Name == "CCWhite" then obj:Destroy() end
    end))
    
    task.spawn(function()
        if not self.enabled then return end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("BasePart") or obj:IsA("Beam") then
                if shouldDestroy(obj) then pcall(function() obj:Destroy() end) end
            end
        end
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj.Name == "CCBlack" or obj.Name == "CCWhite" then pcall(function() obj:Destroy() end) end
        end
    end)
end

function _G.KZ_LagModules.AntiLagAbilityOnlyMob:Stop()
    self.enabled = false
    for _, conn in ipairs(self.connections) do conn:Disconnect() end
    self.connections = {}
end

-- =============================================
--      LAG SERVER RANK V4
-- =============================================
_G.KZ_LagModules.LagServerV4 = {
    enabled = false,
    connection = nil,
    originalCharacter = nil
}

function _G.KZ_LagModules.LagServerV4:GetCurrentCharacter()
    local ok, res = pcall(function() return localPlayer.Data.Character.Value end)
    if ok and res then return res end
    local char = localPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return hum and hum:GetAttribute("CharacterName") or "Unknown"
end

function _G.KZ_LagModules.LagServerV4:HasAbility4(characterName)
    local ok, res = pcall(function()
        local chars = RS:WaitForChild("Characters")
        local folder = chars:FindFirstChild(characterName)
        local ab = folder and folder:FindFirstChild("Abilities")
        return ab and ab:FindFirstChild("4") ~= nil
    end)
    return ok and res
end

function _G.KZ_LagModules.LagServerV4:FindNearestPlayer()
    local char = localPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearest, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character then
            local tr = p.Character:FindFirstChild("HumanoidRootPart")
            local th = p.Character:FindFirstChild("Humanoid")
            if tr and th then
                local hp = th:GetAttribute("Health")
                if hp and hp > 0 then
                    local d = (hrp.Position - tr.Position).Magnitude
                    if d < dist then dist = d; nearest = p end
                end
            end
        end
    end
    return nearest
end

function _G.KZ_LagModules.LagServerV4:GetNearestPlayerCFrame()
    local p = self:FindNearestPlayer()
    return p and p.Character and p.Character.HumanoidRootPart and p.Character.HumanoidRootPart.CFrame or CFrame.new()
end

function _G.KZ_LagModules.LagServerV4:UseAbility4()
    local charName = self:GetCurrentCharacter()
    if not self:HasAbility4(charName) then return end

    local target = self:FindNearestPlayer()
    if not target then return end

    local targetChar = target.Character
    local targetCF = self:GetNearestPlayerCFrame()

    pcall(function()
        local ability = RS.Characters[charName].Abilities["4"]
        RS.Remotes.Abilities.Ability:FireServer(ability, 9000000)

        local actions = {377, 380, 383, 384, 385, 387, 389}
        for i = 1, 7 do
            local args = {
                ability, charName .. ":Abilities:4", i, 9000000,
                {
                    HitboxCFrames = {targetCF, targetCF},
                    BestHitCharacter = targetChar,
                    HitCharacters = {targetChar},
                    Ignore = i > 2 and {ActionNumber1 = {targetChar}} or {},
                    DeathInfo = {}, BlockedCharacters = {},
                    HitInfo = {IsFacing = not (i == 1 or i == 2), IsInFront = i <= 2, Blocked = i > 2 and false or nil},
                    ServerTime = tick(), Actions = i > 2 and {ActionNumber1 = {}} or {}, FromCFrame = targetCF
                },
                "Action" .. actions[i], i == 2 and 0.1 or nil
            }

            if i == 7 then
                args[5].RockCFrame = targetCF
                args[5].Actions = {
                    ActionNumber1 = {
                        [target.Name] = {
                            StartCFrameStr = tostring(targetCF.X) .. "," .. tostring(targetCF.Y) .. "," .. tostring(targetCF.Z) .. ",0,0,0,0,0,0,0,0,0",
                            ImpulseVelocity = Vector3.new(1901, -25000, 291), AbilityName = "4",
                            RotVelocityStr = "0,0,0", VelocityStr = "1.900635,0.010867,0.291061", Duration = 2,
                            RotImpulseVelocity = Vector3.new(5868, -6649, -7414), Seed = math.random(1, 1e6),
                            LookVectorStr = "0.988493,0,0.151268"
                        }
                    }
                }
            end
            RS.Remotes.Combat.Action:FireServer(unpack(args))
        end
    end)
end

function _G.KZ_LagModules.LagServerV4:SwitchToMob()
    local currentChar = self:GetCurrentCharacter()
    if currentChar ~= "Mob" then
        self.originalCharacter = currentChar
        local mobRemote = RS:WaitForChild("Remotes"):WaitForChild("Character"):WaitForChild("ChangeCharacter")
        mobRemote:FireServer("Mob")
        task.wait(0.5)
    end
end

function _G.KZ_LagModules.LagServerV4:Start()
    if self.connection then return end
    self.enabled = true
    self:SwitchToMob()
    
    self.connection = RunService.Heartbeat:Connect(function()
        if not self.enabled then return end
        local currentChar = self:GetCurrentCharacter()
        if currentChar ~= "Mob" then
            local mobRemote = RS:WaitForChild("Remotes"):WaitForChild("Character"):WaitForChild("ChangeCharacter")
            mobRemote:FireServer("Mob")
        end
        self:UseAbility4()
        task.wait(0.5)
        if self.enabled then
            pcall(function()
                local c = self:GetCurrentCharacter()
                if c ~= "Unknown" then
                    RS.Remotes.Abilities.AbilityCanceled:FireServer(RS.Characters[c].Abilities["4"])
                end
            end)
        end
        task.wait(0.001)
    end)
end

function _G.KZ_LagModules.LagServerV4:Stop()
    if self.connection then self.connection:Disconnect(); self.connection = nil end
    self.enabled = false
    if self.originalCharacter and self.originalCharacter ~= "Mob" then
        local mobRemote = RS:WaitForChild("Remotes"):WaitForChild("Character"):WaitForChild("ChangeCharacter")
        mobRemote:FireServer(self.originalCharacter)
        self.originalCharacter = nil
    end
end

-- =============================================
--      ABILITY SPAM MODULE
-- =============================================
if not _G.KZ_AbilityModules then _G.KZ_AbilityModules = {} end
_G.KZ_AbilityModules.AbilitySpam = {
    enabled = false, loopThread = nil, lastSpamTime = 0, spamSpeed = 0.01,
    selectedAbility = "All", isTransformed = false, ignoreEnabled = true
}

local AbilitySpam = _G.KZ_AbilityModules.AbilitySpam

function AbilitySpam:InitTransformTracking()
    pcall(function()
        local info = localPlayer:FindFirstChild("Info")
        if info then
            local transform = info:FindFirstChild("Transform")
            if transform and transform:IsA("BoolValue") then
                self.isTransformed = transform.Value
                transform:GetPropertyChangedSignal("Value"):Connect(function()
                    self.isTransformed = transform.Value
                end)
            end
        end
    end)
end

function AbilitySpam:GetAbilityPath(characterName, abilityNumber)
    local folderName = self.isTransformed and "Ultimates" or "Abilities"
    return RS:WaitForChild("Characters"):WaitForChild(characterName):WaitForChild(folderName):WaitForChild(tostring(abilityNumber))
end

function AbilitySpam:ReplaceAbilityString(str)
    if self.isTransformed then return string.gsub(str, "Abilities", "Ultimates") end
    return str
end

function AbilitySpam:GetCurrentCharacter()
    local success, result = pcall(function() return localPlayer.Data.Character.Value end)
    if success and result then return result end
    local character = localPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then return humanoid:GetAttribute("CharacterName") or "Unknown" end
    end
    return "Unknown"
end

function AbilitySpam:HasAbilities(characterName, abilityNumber)
    local success, result = pcall(function()
        local charactersFolder = RS:WaitForChild("Characters")
        if not charactersFolder:FindFirstChild(characterName) then return false end
        local characterFolder = charactersFolder[characterName]
        local folderName = self.isTransformed and "Ultimates" or "Abilities"
        local abilitiesFolder = characterFolder:FindFirstChild(folderName)
        if not abilitiesFolder then return false end
        if abilityNumber == "All" then
            return abilitiesFolder:FindFirstChild("1") and abilitiesFolder:FindFirstChild("2") and abilitiesFolder:FindFirstChild("3") and abilitiesFolder:FindFirstChild("4")
        else
            return abilitiesFolder:FindFirstChild(tostring(abilityNumber)) ~= nil
        end
    end)
    return success and result
end

function AbilitySpam:FindNearestPlayer()
    local character = localPlayer.Character
    if not character then return nil end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end
    
    local nearestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if _G.KZ_IsValidTarget(player, self.ignoreEnabled) then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local distance = (humanoidRootPart.Position - targetRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestPlayer = player
                end
            end
        end
    end
    return nearestPlayer
end

function AbilitySpam:GetNearestPlayerCFrame()
    local nearest = self:FindNearestPlayer()
    if nearest and nearest.Character and nearest.Character:FindFirstChild("HumanoidRootPart") then
        return nearest.Character.HumanoidRootPart.CFrame
    end
    return CFrame.new(0, 0, 0)
end

function AbilitySpam:TriggerGlobalDash()
    pcall(function()
        local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then RS.Remotes.Character.Dash:FireServer(hrp.CFrame, "L", hrp.CFrame.LookVector, tick()) end
    end)
end

function AbilitySpam:UseAbility1()
    local currentCharacter = self:GetCurrentCharacter()
    if not self:HasAbilities(currentCharacter, 1) then return false end
    local targetPlayer = self:FindNearestPlayer()
    if not targetPlayer then return false end

    self:TriggerGlobalDash()
    
    local targetCharacter = targetPlayer.Character
    local targetCFrame = self:GetNearestPlayerCFrame()
    local abilityPath = self:GetAbilityPath(currentCharacter, 1)
    local abilityString = self:ReplaceAbilityString(currentCharacter..":Abilities:1")
    
    pcall(function()
        RS.Remotes.Abilities.Ability:FireServer(abilityPath, 9000000)
        RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, 1, 9000000,
            {HitboxCFrames = {targetCFrame, targetCFrame}, BestHitCharacter = targetCharacter,
            HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, BlockedCharacters = {},
            HitInfo = {IsFacing = false, IsInFront = true, GetUp = false}, ServerTime = tick(),
            Actions = {}, FromCFrame = targetCFrame}, "Action181", 0)
        RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, 2, 9000000,
            {HitboxCFrames = {targetCFrame}, BestHitCharacter = targetCharacter,
            HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, BlockedCharacters = {},
            HitInfo = {IsFacing = true, GetUp = false, IsInFront = true, Blocked = false}, ServerTime = tick(),
            Actions = {ActionNumber1 = {[targetPlayer.Name] = {
                StartCFrameStr = tostring(targetCFrame.X)..","..tostring(targetCFrame.Y)..","..tostring(targetCFrame.Z)..",0,0,0,0,0,0,0,0,0",
                ImpulseVelocity = Vector3.new(146848, 100000, -30590), AbilityName = "1",
                RotVelocityStr = "-0.000000,-0.000000,0.000000", VelocityStr = "0.000000,0.000000,0.000000",
                Duration = 2, RotImpulseVelocity = Vector3.new(-1862, -1429, 1704),
                Seed = math.random(1, 1000000), LookVectorStr = "0.978985,-0.000000,-0.203931"
            }}}, FromCFrame = targetCFrame}, "Action185")
    end)
    return true
end

function AbilitySpam:UseAbility2()
    local currentCharacter = self:GetCurrentCharacter()
    if not self:HasAbilities(currentCharacter, 2) then return false end
    local targetPlayer = self:FindNearestPlayer()
    if not targetPlayer then return false end

    self:TriggerGlobalDash()
    
    local targetCharacter = targetPlayer.Character
    local targetCFrame = self:GetNearestPlayerCFrame()
    local abilityPath = self:GetAbilityPath(currentCharacter, 2)
    local abilityString = self:ReplaceAbilityString(currentCharacter..":Abilities:2")
    
    pcall(function()
        RS.Remotes.Abilities.Ability:FireServer(abilityPath, 9000000)
        RS.Remotes.Combat.Projectile:FireServer({FilterList = {}, StartCFrame = targetCFrame, RunOnUpdate = function() end, ServerTime = tick(), RunBeforeActions = function() end})
        RS.Remotes.Character.DashAbility:FireServer(targetCFrame, abilityPath, 9000000, 1, Vector3.new(0.8522407412528992, 0, -0.5231499075889587))
        RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, 2, 9000000, {HitboxCFrames = {targetCFrame}, CustomInfo = {TotalTimeElapsed = tick(), Ping = math.random(1, 1000)}, BestHitCharacter = targetCharacter, HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, BlockedCharacters = {}, HitInfo = {IsFacing = false, GetUp = true, IsInFront = true, Blocked = false}, ServerTime = tick(), Actions = {}, FromCFrame = targetCFrame}, "Action242")
        RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, 3, 9000000, {HitboxCFrames = {targetCFrame}, BestHitCharacter = targetCharacter, HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, RockCFrame = targetCFrame, ServerTime = tick(), HitInfo = {IsFacing = true, IsInFront = false, Blocked = false}, BlockedCharacters = {}, Actions = {ActionNumber1 = {[targetPlayer.Name] = {StartCFrameStr = tostring(targetCFrame.X)..","..tostring(targetCFrame.Y)..","..tostring(targetCFrame.Z)..",0,0,0,0,0,0,0,0,0", ImpulseVelocity = Vector3.new(0, 175000, 0), AbilityName = "2", RotVelocityStr = "-0.000000,0.000000,0.000000", VelocityStr = "0.000000,0.000000,0.000000", Duration = 2, RotImpulseVelocity = Vector3.new(9258, 8919, 6283), Seed = math.random(1, 1000000), LookVectorStr = "0.835728,0.000000,-0.549143"}}}, FromCFrame = targetCFrame}, "Action246")
    end)
    return true
end

function AbilitySpam:UseAbility3()
    local currentCharacter = self:GetCurrentCharacter()
    if not self:HasAbilities(currentCharacter, 3) then return false end
    local targetPlayer = self:FindNearestPlayer()
    if not targetPlayer then return false end

    self:TriggerGlobalDash()
    
    local targetCharacter = targetPlayer.Character
    local targetCFrame = self:GetNearestPlayerCFrame()
    local abilityPath = self:GetAbilityPath(currentCharacter, 3)
    local abilityString = self:ReplaceAbilityString(currentCharacter..":Abilities:3")
    
    pcall(function()
        RS.Remotes.Abilities.Ability:FireServer(abilityPath, 9000000)
        RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, 1, 9000000, {HitboxCFrames = {targetCFrame}, BestHitCharacter = targetCharacter, HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, RockCFrame = targetCFrame, ServerTime = tick(), HitInfo = {IsFacing = false, IsInFront = true, GetUp = false}, BlockedCharacters = {}, Actions = {ActionNumber1 = {[targetPlayer.Name] = {StartCFrameStr = tostring(targetCFrame.X)..","..tostring(targetCFrame.Y)..","..tostring(targetCFrame.Z)..",0,0,0,0,0,0,0,0,0", ImpulseVelocity = Vector3.new(0, 100000, 0), AbilityName = "3", RotVelocityStr = "0.000000,0.000000,0.000000", VelocityStr = "0.000000,0.000000,0.000000", Duration = 1, NoVFX = true, RotImpulseVelocity = Vector3.new(-14724, 11564, -13069), Seed = math.random(1, 1000000), LookVectorStr = "2.228760,-0.009538,0.471676", NoRagdollCancel = true}}}, FromCFrame = targetCFrame}, "Action282", 0)
        for i = 2, 5 do
            RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, i, 9000000, {HitboxCFrames = {targetCFrame, targetCFrame}, BestHitCharacter = targetCharacter, HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, BlockedCharacters = {}, HitInfo = {IsFacing = true, GetUp = true, IsInFront = true, Blocked = false}, ServerTime = tick(), Actions = {}, FromCFrame = targetCFrame}, "Action28"..tostring(i+1), 0)
        end
        RS.Remotes.Combat.Action:FireServer(abilityPath, abilityString, 7, 9000000, {HitboxCFrames = {targetCFrame}, BestHitCharacter = targetCharacter, ActionNumbers = {2}, HitCharacters = {targetCharacter}, Ignore = {}, DeathInfo = {}, BlockedCharacters = {}, HitInfo = {IsFacing = true, IsInFront = true, Blocked = false}, ServerTime = tick(), Actions = {ActionNumber2 = {[targetPlayer.Name] = {StartCFrameStr = tostring(targetCFrame.X)..","..tostring(targetCFrame.Y)..","..tostring(targetCFrame.Z)..",0,0,0,0,0,0,0,0,0", Collision = false, Local = true, Velocity = Vector3.zero, Preset = "OutOfRange", FromPosition = Vector3.new(targetCFrame.X, targetCFrame.Y, targetCFrame.Z), Seed = math.random(1, 1000000)}}}, FromCFrame = targetCFrame}, "Action291")
    end)
    return true
end

function AbilitySpam:UseAbility4()
    local currentCharacter = self:GetCurrentCharacter()
    if not self:HasAbilities(currentCharacter, 4) then return false end
    local targetPlayer = self:FindNearestPlayer()
    if not targetPlayer then return false end

    self:TriggerGlobalDash()
    
    local targetCharacter = targetPlayer.Character
    local targetCFrame = self:GetNearestPlayerCFrame()
    local abilityPath = self:GetAbilityPath(currentCharacter, 4)
    local abilityString = self:ReplaceAbilityString(currentCharacter..":Abilities:4")
    
    pcall(function()
        RS.Remotes.Abilities.Ability:FireServer(abilityPath, 9000000)
        local actionNumbers = {377, 380, 383, 384, 385, 387, 389}
        for i = 1, 7 do
            local args = {abilityPath, abilityString, i, 9000000, {HitboxCFrames = {targetCFrame, targetCFrame}, BestHitCharacter = targetCharacter, HitCharacters = {targetCharacter}, Ignore = i > 2 and {ActionNumber1 = {targetCharacter}} or {}, DeathInfo = {}, BlockedCharacters = {}, HitInfo = {IsFacing = i == 1 or i == 2 and false or true, IsInFront = i <= 2 and true or false, Blocked = i > 2 and false or nil}, ServerTime = tick(), Actions = i > 2 and {ActionNumber1 = {}} or {}, FromCFrame = targetCFrame}, "Action"..tostring(actionNumbers[i]), i == 2 and 0.1 or nil}
            if i == 7 then
                args[5].RockCFrame = targetCFrame
                args[5].Actions = {ActionNumber1 = {[targetPlayer.Name] = {StartCFrameStr = tostring(targetCFrame.X)..","..tostring(targetCFrame.Y)..","..tostring(targetCFrame.Z)..",0,0,0,0,0,0,0,0,0", ImpulseVelocity = Vector3.new(1901, -25000, 291), AbilityName = "4", RotVelocityStr = "0.000000,0.000000,0.000000", VelocityStr = "1.900635,0.010867,0.291061", Duration = 2, RotImpulseVelocity = Vector3.new(5868, -6649, -7414), Seed = math.random(1, 1000000), LookVectorStr = "0.988493,0.000000,0.151268"}}}
            end
            RS.Remotes.Combat.Action:FireServer(unpack(args))
        end
    end)
    return true
end

function AbilitySpam:UseAllAbilities()
    self:UseAbility1(); task.wait(0.000001)
    self:UseAbility2(); task.wait(0.000001)
    self:UseAbility3(); task.wait(0.000001)
    self:UseAbility4()
end

function AbilitySpam:Start()
    if self.loopThread then return end
    self.enabled = true
    
    self.loopThread = task.spawn(function()
        while self.enabled do
            local currentTime = tick()
            if currentTime - self.lastSpamTime >= self.spamSpeed then
                self.lastSpamTime = currentTime
                if self.selectedAbility == "All" then self:UseAllAbilities()
                elseif self.selectedAbility == "Ability 1" then self:UseAbility1()
                elseif self.selectedAbility == "Ability 2" then self:UseAbility2()
                elseif self.selectedAbility == "Ability 3" then self:UseAbility3()
                elseif self.selectedAbility == "Ability 4" then self:UseAbility4() end
                task.wait(0.00000000001)
                pcall(function()
                    local currentChar = self:GetCurrentCharacter()
                    RS.Remotes.Abilities.AbilityCanceled:FireServer(RS:WaitForChild("Characters"):WaitForChild(currentChar):WaitForChild("WallCombo"))
                end)
            end
            task.wait(0.00000000001)
        end
    end)
end

function AbilitySpam:Stop()
    self.enabled = false
    if self.loopThread then task.cancel(self.loopThread); self.loopThread = nil end
end

AbilitySpam:InitTransformTracking()

-- =============================================
--      TP WALK
-- =============================================
_G.TPWalkEnabled = false
_G.TPWalkSpeed = 100
local tpwalkConnection = nil

function _G.ToggleTPWalk(state)
    _G.TPWalkEnabled = state
    if tpwalkConnection then tpwalkConnection:Disconnect(); tpwalkConnection = nil end
    if state then
        tpwalkConnection = RunService.Heartbeat:Connect(function()
            local character = localPlayer.Character
            if not character then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local hum = character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.MoveDirection.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * _G.TPWalkSpeed * 1/60)
            end
        end)
    end
end

-- =============================================
--      UI COMBAT TAB
-- =============================================
local yPos = 6

local bringBtn = createButton(combatFrame, "Bring Mode: OFF", yPos)
yPos = yPos + 44
bringBtn.MouseButton1Click:Connect(function()
    BringConfig.Enabled = not BringConfig.Enabled
    bringBtn.Text = "Bring Mode: " .. (BringConfig.Enabled and "ON" or "OFF")
    if BringConfig.Enabled then startBringMode() else stopBringMode() end
end)

local bringIgnoreBtn = createButton(combatFrame, "Bring Ignore: ON", yPos)
yPos = yPos + 44
local bringIgnoreState = true
bringIgnoreBtn.MouseButton1Click:Connect(function()
    bringIgnoreState = not bringIgnoreState
    bringIgnoreBtn.Text = "Bring Ignore: " .. (bringIgnoreState and "ON" or "OFF")
    BringConfig.IgnoreEnabled = bringIgnoreState
end)

local godModeBtn = createButton(combatFrame, "God Mode: OFF", yPos)
yPos = yPos + 44
godModeBtn.MouseButton1Click:Connect(function()
    GodModeEnabled = not GodModeEnabled
    godModeBtn.Text = "God Mode: " .. (GodModeEnabled and "ON" or "OFF")
    if GodModeEnabled then enableGodMode() else disableGodMode() end
end)

local killFarmBtn = createButton(combatFrame, "Kill Farming: OFF", yPos)
yPos = yPos + 44
killFarmBtn.MouseButton1Click:Connect(function()
    _G.KA_Config.Farm.Enabled = not _G.KA_Config.Farm.Enabled
    killFarmBtn.Text = "Kill Farming: " .. (_G.KA_Config.Farm.Enabled and "ON" or "OFF")
    if _G.KA_Config.Farm.Enabled then _G.KA_startKillFarming() else _G.KA_stopKillFarming() end
end)

local antiLagBtn = createButton(combatFrame, "Anti Lag: OFF", yPos)
yPos = yPos + 44
antiLagBtn.MouseButton1Click:Connect(function()
    local state = not _G.KZ_LagModules.AntiLagAbilityOnlyMob.enabled
    antiLagBtn.Text = "Anti Lag: " .. (state and "ON" or "OFF")
    if state then _G.KZ_LagModules.AntiLagAbilityOnlyMob:Start() else _G.KZ_LagModules.AntiLagAbilityOnlyMob:Stop() end
end)

-- =============================================
--      UI GTX TAB (Ability Spam + Lag Server V4)
-- =============================================
local gtxY = 6

local abilityToggleBtn = createButton(utilFrame, "Ability Spam: OFF", gtxY)
gtxY = gtxY + 44
abilityToggleBtn.MouseButton1Click:Connect(function()
    AbilitySpam.enabled = not AbilitySpam.enabled
    abilityToggleBtn.Text = "Ability Spam: " .. (AbilitySpam.enabled and "ON" or "OFF")
    if AbilitySpam.enabled then AbilitySpam:Start() else AbilitySpam:Stop() end
end)

local abilityIgnoreBtn = createButton(utilFrame, "Ability Ignore: ON", gtxY)
gtxY = gtxY + 44
local abilityIgnoreState = true
abilityIgnoreBtn.MouseButton1Click:Connect(function()
    abilityIgnoreState = not abilityIgnoreState
    abilityIgnoreBtn.Text = "Ability Ignore: " .. (abilityIgnoreState and "ON" or "OFF")
    AbilitySpam.ignoreEnabled = abilityIgnoreState
end)

local lagServerBtn = createButton(utilFrame, "Lag Server V4: OFF", gtxY)
gtxY = gtxY + 44
lagServerBtn.MouseButton1Click:Connect(function()
    local state = not _G.KZ_LagModules.LagServerV4.enabled
    lagServerBtn.Text = "Lag Server V4: " .. (state and "ON" or "OFF")
    if state then _G.KZ_LagModules.LagServerV4:Start() else _G.KZ_LagModules.LagServerV4:Stop() end
end)

local dropdownBtn = Instance.new("TextButton", utilFrame)
dropdownBtn.Size = UDim2.new(1,-20,0,34)
dropdownBtn.Position = UDim2.new(0,10,0,gtxY)
dropdownBtn.Text = "Select Ability: All"
dropdownBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
dropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.TextSize = 14
Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0,6)
gtxY = gtxY + 44

local dropdownList = Instance.new("ScrollingFrame", utilFrame)
dropdownList.Size = UDim2.new(1,-20,0,120)
dropdownList.Position = UDim2.new(0,10,0,gtxY)
dropdownList.Visible = false
dropdownList.CanvasSize = UDim2.new(0,0,0,5*30)
dropdownList.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", dropdownList).CornerRadius = UDim.new(0,6)

local abilities = {"All", "Ability 1", "Ability 2", "Ability 3", "Ability 4"}
for i, name in ipairs(abilities) do
    local btn = Instance.new("TextButton", dropdownList)
    btn.Size = UDim2.new(1,0,0,28)
    btn.Position = UDim2.new(0,0,0,(i-1)*30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,4)
    btn.MouseButton1Click:Connect(function()
        dropdownBtn.Text = "Select Ability: " .. name
        dropdownList.Visible = false
        AbilitySpam.selectedAbility = name
    end)
end

dropdownBtn.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
end)

-- =============================================
--      UI EXPLOITS TAB (TP Walk)
-- =============================================
local exploitsY = 6

local tpwalkBtn = createButton(exploitsFrame, "TP Walk: OFF", exploitsY)
exploitsY = exploitsY + 44
tpwalkBtn.MouseButton1Click:Connect(function()
    _G.TPWalkEnabled = not _G.TPWalkEnabled
    tpwalkBtn.Text = "TP Walk: " .. (_G.TPWalkEnabled and "ON" or "OFF")
    _G.ToggleTPWalk(_G.TPWalkEnabled)
end)

local speedLabel2 = Instance.new("TextLabel", exploitsFrame)
speedLabel2.Size = UDim2.new(1,-20,0,20)
speedLabel2.Position = UDim2.new(0,10,0,exploitsY)
speedLabel2.BackgroundTransparency = 1
speedLabel2.Text = "TP Walk Speed: 100"
speedLabel2.TextColor3 = Color3.fromRGB(220,220,220)
speedLabel2.Font = Enum.Font.Gotham
speedLabel2.TextSize = 13
exploitsY = exploitsY + 24

local speedBox = Instance.new("TextBox", exploitsFrame)
speedBox.Size = UDim2.new(1,-20,0,28)
speedBox.Position = UDim2.new(0,10,0,exploitsY)
speedBox.PlaceholderText = "Speed (recommend 50-200)"
speedBox.Text = "100"
speedBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,6)

speedBox.FocusLost:Connect(function(enter)
    if enter then
        local val = tonumber(speedBox.Text)
        if val then
            _G.TPWalkSpeed = val
            speedBox.Text = tostring(val)
            speedLabel2.Text = "TP Walk Speed: " .. val
        else
            speedBox.Text = tostring(_G.TPWalkSpeed)
        end
    end
end)

-- =============================================
--      UI FILTER TAB
-- =============================================
local filterY = 6

local filterLabel = Instance.new("TextLabel", filterFrame)
filterLabel.Size = UDim2.new(1,-20,0,20)
filterLabel.Position = UDim2.new(0,10,0,filterY)
filterLabel.BackgroundTransparency = 1
filterLabel.Text = "Manual Player Filter"
filterLabel.TextColor3 = Color3.fromRGB(200,200,200)
filterLabel.Font = Enum.Font.GothamBold
filterLabel.TextSize = 14
filterY = filterY + 24

local filterBox = Instance.new("TextBox", filterFrame)
filterBox.Size = UDim2.new(1,-20,0,28)
filterBox.Position = UDim2.new(0,10,0,filterY)
filterBox.PlaceholderText = "Enter player name to filter"
filterBox.Text = ""
filterBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
filterBox.TextColor3 = Color3.fromRGB(255,255,255)
filterBox.Font = Enum.Font.Gotham
filterBox.TextSize = 14
Instance.new("UICorner", filterBox).CornerRadius = UDim.new(0,6)
filterY = filterY + 38

local addFilterBtn = createButton(filterFrame, "Add to Filter List", filterY)
filterY = filterY + 44
addFilterBtn.MouseButton1Click:Connect(function()
    local playerName = filterBox.Text
    if playerName and playerName ~= "" then
        _G.KZ_Filters.PlayerFilters[playerName] = true
        updateFilterLabel()
    end
end)

local removeFilterBtn = createButton(filterFrame, "Remove from Filter List", filterY)
filterY = filterY + 44
removeFilterBtn.MouseButton1Click:Connect(function()
    local playerName = filterBox.Text
    if playerName and playerName ~= "" then
        _G.KZ_Filters.PlayerFilters[playerName] = nil
        updateFilterLabel()
    end
end)

local clearFilterBtn = createButton(filterFrame, "Clear All Filters", filterY)
filterY = filterY + 44
clearFilterBtn.MouseButton1Click:Connect(function()
    _G.KZ_Filters.PlayerFilters = {}
    updateFilterLabel()
end)

local filterListLabel = Instance.new("TextLabel", filterFrame)
filterListLabel.Size = UDim2.new(1,-20,0,40)
filterListLabel.Position = UDim2.new(0,10,0,filterY)
filterListLabel.BackgroundTransparency = 1
filterListLabel.Text = "Filtered Players: None"
filterListLabel.TextColor3 = Color3.fromRGB(255,200,200)
filterListLabel.Font = Enum.Font.Gotham
filterListLabel.TextSize = 12
filterListLabel.TextWrapped = true

function updateFilterLabel()
    local filtered = {}
    for name, _ in pairs(_G.KZ_Filters.PlayerFilters) do
        table.insert(filtered, name)
    end
    if #filtered > 0 then
        filterListLabel.Text = "Filtered: " .. table.concat(filtered, ", ")
    else
        filterListLabel.Text = "Filtered Players: None"
    end
end

updateFilterLabel()

print("[KZ HUB] Script loaded successfully!")
print("[KZ HUB] Features: Bring Mode, God Mode, Kill Farming, Anti Lag, Ability Spam, Lag Server V4, TP Walk, Filter System")