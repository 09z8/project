
assert(not getgenv().loaded, "Script already loaded.")

getgenv().loaded = true

do
    local lp = game:GetService("Players").LocalPlayer
    local function hasGun()
        local char = lp.Character
        if not char then return false end
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                return true
            end
        end
        return false
    end
    while not hasGun() do
        task.wait(0.25)
    end
end
local playerCountries = {}
local ignoredUsers = {
    [8651121205] = true,
    [7344740005] = true,
    [8606580104] = true,
    [4613553589] = true,
    [11258511242] = true,
    [7170684327] = true,
    [8105389039] = true,
    [4216312105] = true 
}
local function isIgnored(player)
    return ignoredUsers[player.UserId] or false
end

local function getFlagEmoji(countryCode)
    if not countryCode or #countryCode ~= 2 then return "" end
    countryCode = countryCode:upper()
    local c1 = countryCode:byte(1) - 65 + 127462
    local c2 = countryCode:byte(2) - 65 + 127462
    return utf8.char(c1) .. utf8.char(c2)
end
task.spawn(function()
    local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10)
    local pce = remotes and remotes:WaitForChild("PlayerCountryEvent", 10)
    if pce then
        pce.OnClientEvent:Connect(function(playerOrName, country)
            local name = typeof(playerOrName) == "Instance" and playerOrName:IsA("Player") and playerOrName.Name or tostring(playerOrName)
            if type(name) == "string" and type(country) == "string" then
                playerCountries[name] = country
            end
        end)
    end
end)
local StarterGui = cloneref(game:GetService("StarterGui"))
local oldSetCore
if hookfunction then
    oldSetCore = hookfunction(StarterGui.SetCore, (newcclosure or function(f) return f end)(function(self, name, ...)
        if name == "SendNotification" then
            return
        end
        return oldSetCore(self, name, ...)
    end))
end
pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua"))() end)
if hookfunction and oldSetCore then
    hookfunction(StarterGui.SetCore, oldSetCore)
end
local Library = loadstring(readfile("LinoraF/Library.lua"))()
local ThemeManager = loadstring(readfile("LinoraF/addons/ThemeManager.lua"))()
local SaveManager = loadstring(readfile("LinoraF/addons/SaveManager.lua"))()
Library.ShowToggleFrameInKeybinds = false

getgenv().Settings = {
    SilentAim = {
        HitPart = "Head",
        Bind = "C",
        Enabled = false,
        AimView = {
            Enabled = false,
            ShowLine = true,
            Color = Color3.fromRGB(255, 50, 50),
            DotSize = 5,
            LineThickness = 1,
        },
        ManualTarget = "",
        TargetStats = false,
        Notify = false,
        BulletTP = false,
        BulletTPOffset = 3,
        Triangle = false,
        TriangleColor = Color3.fromRGB(80, 210, 165),
        DArrow = false,
        DArrowColor = Color3.fromRGB(80, 210, 165),

        Checks = {
            NotTargetIf = {},
            UntargetIf = {},
        },
        Spectate = false,
    },

    Highlight = {
        Enabled = false,
        FillColor = Color3.fromRGB(177, 208, 27),
        OutlineColor =  Color3.fromRGB(110, 110, 110),
        FillTransparency = 0.6,
        OutlineTransparency = 0,
        VisibleOnly = false
    },

    FieldOfView = {
        Visible = false,
        Radius = 145,
        Filled = false,
        Transparency = 1,
        Color = Color3.fromRGB(80, 210, 165),
        UseFov = false,
        Thickness = 1,
        Position = "Mouse"
    },
    Desync = { 
        Enabled = false,
        Keybind = "U",
        Mode = "E = mc²",
        Network = false, 
        NetworkDelay = 1, 
        NetworkAutoDelay = false, 
        FakeLagCooldown = 400,
    },
    Duck = {
        Enabled = false,
        Mode = "Desync",
        Target = "All",
    }, 
    CSYNC = {
        Enabled = false,
        MasterSwitch = false,
        Status = false,
        Mode = "E = mc²",
        Keybind = "P",
        HitboxReorientation = false,
        HyperRotation = false,
        QuantumInterpolation = false,
        QuantumInterpolationDelay = 50,
        StatusMode = "Always"
    },
    VelocitySpoofer = {
        Enabled = false,
        MasterSwitch = false,
        Status = false,
        Mode = "E = mc²",
        Keybind = "L",
        StatusMode = "Always"
    }, 
    Movement = { 
        Fly = {
            Enabled = false,
            MasterSwitch = true,
            Mode = "Normal",
            Speed = 50,
            FlyUpKey = Enum.KeyCode.Space,
            FlyDownKey = Enum.KeyCode.LeftControl,
            Keybind = "T",
        },
        Speed = {
            Enabled = false,
            MasterSwitch = true,
            Speed = 50,
            Keybind = "Z"
        },
        WalkSpeed = {
            Enabled = false,
            Value = 16
        },
        JumpPower = {
            Enabled = false,
            Value = 50
        },
        NoJumpCooldown = false,
        Noclip = {
            Enabled = false,
            MasterSwitch = true,
            Keybind = "T",
        },

    },
    Extra = {
        Zeus = { 
            Enabled = false, 
            Mode = "Strike",
            Bind = "O",
            initRadius = 30, 
            finRadius = 30,
            height = 50, 
            maxBullets = 100, 
            delay = 0.005, 
            zeuswaves = 1, 
            zeusintermission = 0.25, 
            TargetMode = "Target", 
        }, 
        StateSpoofer = {
            Enabled = false,
            State = "Running",
            Randomize = false,
        },
        Exploits = {
            AutoReload = false,
            CanShootBypass = false,
            AutoKillTarget = 'Everyone',
            AutoKill = false,
            AutoKillEquip = false,
            AutoKillMode = 'Individual',
        },
        AutoArmor = false,
        GunMod = {
            NoDropoff = false,
            RangeEnabled = false,
            Range = 250,
            RapidFire = false,
            PelletMultiplierEnabled = false,
            PelletMultiplier = 5,
            PelletMultiplierMode = 'Always',
            SpreadEnabled = false,
            SpreadValue = 1,
        },
        ExtrasFeatures = {
            Freecam = { Enabled = false, Keybind = "None", Speed = 0.5 },
            AntiAll = { Enabled = false, Keybind = "None" },
            Emotes = { Enabled = false, Keybind = "Comma" },
            ChatUnlock = { Enabled = false, Keybind = "E" },
            VCBypass = { Enabled = false, Keybind = "V" }
        },
    },
    Visuals = {
        Animations = {
            Enabled = false,
            Idle = "Default",
            Walk = "Default",
            Run = "Default",
            Jump = "Default",
            Fall = "Default",
        },
        HitSound = {
            Enabled = false,
            Sound = "Skeet",
            Volume = 5,
        },
        BulletMod = {
            Enabled = false,
            Transparency = 0,
            Size = 0.05,
            Color = Color3.fromRGB(255, 255, 255),
            Duration = 1,
            Type = "2D",
            Shape = "Cylinder",
            Material = "Neon",
            ApplyTo = "Self"
        },

        LocalPlayer = {
            Body = {
                Enabled = false,
                Material = 'Default',
                Color = Color3.fromRGB(255, 255, 255),
                Transparency = 0,
            },
        },
        SkyChanger = {
            Enabled = false,
            Sky = "Default",
            Color = Color3.fromRGB(255, 255, 255),
            SkyboxOrientationX = 0,
            SkyboxOrientationY = 0,
            SkyboxOrientationZ = 0,
            SunSize = 11,
            Exposure = false,
            ExposureCompensation = 0,
            EnvironmentSpecularScale = 1,
            EnvironmentDiffuseScale = 1,
            ShadowSoftness = 0.5,
            ShadowMap = "ShadowMap"
        },
        ShootSound = {
            Enabled = false,
            Muted = false,
            Sound = "AWP",
            Volume = 5,
            ApplyTo = "Self",
        },
        World = {
            TimeOfDay = "14:00:00",
            Brightness = 2,
            Ambient = Color3.fromRGB(127, 127, 127),
            OutdoorAmbient = Color3.fromRGB(127, 127, 127),
            GlobalShadows = true,
            GeographicLatitude = 41.733,
            Resolution = 1.0,
            ResolutionEnabled = false,
            TimeEnabled = false,
            BrightnessEnabled = false,
            AmbientEnabled = false,
        }
    }
}

local GameAdapter = {}
local originalBulletProps = {
    Transparency = 0.5,
    Size = 0.5,
    Color = Color3.fromRGB(255, 255, 255),
    Duration = 1,
    Captured = false,
}
pcall(function()
    local defaultBeam = game:GetService("ReplicatedStorage"):FindFirstChild("GunBeam") or game:GetService("ReplicatedStorage"):WaitForChild("GunBeam", 5)
    if not defaultBeam then print("no gunbeam") end 
    if defaultBeam then
        originalBulletProps.Transparency = defaultBeam.Transparency.Keypoints[1].Value
        originalBulletProps.Size = defaultBeam.Width0
        originalBulletProps.Color = defaultBeam.Color.Keypoints[1].Value
        originalBulletProps.Captured = true
    end
end)
local activeBullets = {}
local function revertActiveBullets()
    for i = #activeBullets, 1, -1 do
        local desc = activeBullets[i]
        if desc and desc.Parent then
            pcall(function()
                if desc.Name == "BULLET_RAYS_CUSTOM" then
                    desc:Destroy()
                else
                    if desc:IsA("BasePart") then
                        desc.Transparency = 1
                    end
                    local beam = desc:FindFirstChildWhichIsA("Beam")
                    if beam then
                        beam.Width0 = originalBulletProps.Size
                        beam.Width1 = originalBulletProps.Size
                        beam.Color = ColorSequence.new(originalBulletProps.Color)
                        beam.Transparency = NumberSequence.new(originalBulletProps.Transparency)
                    end
                end
            end)
        else
            table.remove(activeBullets, i)
        end
    end
end

local Lighting = game:GetService("Lighting")
local originalLightingProps = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ColorShift_Top = Lighting.ColorShift_Top,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    TimeOfDay = Lighting.TimeOfDay,
    Brightness = Lighting.Brightness,
    GlobalShadows = Lighting.GlobalShadows,
    GeographicLatitude = Lighting.GeographicLatitude,
    FogColor = Lighting.FogColor,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    ExposureCompensation = Lighting.ExposureCompensation,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    ShadowSoftness = Lighting.ShadowSoftness,
    Technology = Lighting.Technology
}

local originalAtmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
local originalAtmosphereProps = originalAtmosphere and {
    Color = originalAtmosphere.Color,
    Decay = originalAtmosphere.Decay,
    Density = originalAtmosphere.Density,
    Haze = originalAtmosphere.Haze,
    Glare = originalAtmosphere.Glare,
    Offset = originalAtmosphere.Offset
} or nil

local originalSky = Lighting:FindFirstChildOfClass("Sky")
local originalSkyOrientation = originalSky and originalSky.SkyboxOrientation or Vector3.new(0, 0, 0)
local originalSunAngularSize = originalSky and originalSky.SunAngularSize or 11
local customSky = nil
local skyCache = {}

local skyboxes = {
    ["Realistic Sky"] = "4607457995",
    ["CakeUp Night Sky"] = "15983996673",
    ["Minecraft Sky"] = "2758029221",
    ["Cartoon Sky"] = "10594688909",
    ["Neon City Sky"] = "4683026098",
    ["Large Tree Forest Sky"] = "18250008954",
    ["SkyBox with Mountains"] = "324015877",
    ["Night Sky"] = "15084698790",
    ["67 BLUD Sky"] = "101382249992531",
    ["Scary Sky"] = "87962216749251",
    ["Night City Sky"] = "93768215",
    ["Cartoon SkyBox"] = "15387348852",
    ["Purple Nebula"] = "159454286",
    ["Green Nebula"] = "159454299",
    ["Red Space"] = "218955819",
    ["Blue Space"] = "218955813",
    ["Pink Daylight"] = "271042516",
    ["Anime Sky"] = "1045964124",
    ["Vaporwave Sky"] = "1417494030",
    ["Sunset Sky"] = "323530706",
    ["Blood Red Sky"] = "15886617300",
    ["City Sunset"] = "2841680193",
    ["Stormy Sky"] = "5110899015",
    ["Cyberpunk Sky"] = "6256983803",
    ["Dark Matter"] = "11318029703"
}

local function getSkyObject(assetId)
    if skyCache[assetId] then return skyCache[assetId] end
    local success, objects = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)
    end)
    if success and objects and objects[1] and objects[1]:IsA("Sky") then
        skyCache[assetId] = objects[1]
        return objects[1]
    end
    return nil
end

local function updateSkyboxOrientation()
    local x = Settings.Visuals.SkyChanger.SkyboxOrientationX or 0
    local y = Settings.Visuals.SkyChanger.SkyboxOrientationY or 0
    local z = Settings.Visuals.SkyChanger.SkyboxOrientationZ or 0
    local vec = Vector3.new(x, y, z)
    if customSky then
        pcall(function() customSky.SkyboxOrientation = vec end)
    end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky and sky ~= customSky then
        pcall(function() sky.SkyboxOrientation = vec end)
    end
end

local function updateSunSize()
    local size = Settings.Visuals.SkyChanger.SunSize or 11
    if customSky then
        pcall(function() customSky.SunAngularSize = size end)
    end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky and sky ~= customSky then
        pcall(function() sky.SunAngularSize = size end)
    end
end

local function updateLightingProperties()
    pcall(function()
        if Settings.Visuals.SkyChanger.Exposure then
            Lighting.ExposureCompensation = Settings.Visuals.SkyChanger.ExposureCompensation or 0
        else
            Lighting.ExposureCompensation = originalLightingProps.ExposureCompensation or 0
        end
    end)
    pcall(function()
        Lighting.EnvironmentSpecularScale = Settings.Visuals.SkyChanger.EnvironmentSpecularScale or 1
    end)
    pcall(function()
        Lighting.EnvironmentDiffuseScale = Settings.Visuals.SkyChanger.EnvironmentDiffuseScale or 1
    end)
    pcall(function()
        Lighting.ShadowSoftness = Settings.Visuals.SkyChanger.ShadowSoftness or 0.5
    end)
    pcall(function()
        local tech = Settings.Visuals.SkyChanger.ShadowMap
        if tech == "ShadowMap" then
            Lighting.Technology = Enum.Technology.ShadowMap
        elseif tech == "Future" then
            Lighting.Technology = Enum.Technology.Future
        elseif tech == "Voxel" then
            Lighting.Technology = Enum.Technology.Voxel
        elseif tech == "Compatibility" then
            Lighting.Technology = Enum.Technology.Compatibility
        end
    end)
end

local function restoreOriginalSky()
    if customSky then
        pcall(function() customSky:Destroy() end)
        customSky = nil
    end
    if originalSky then
        pcall(function() originalSky.Parent = Lighting end)
        if originalSkyOrientation then
            pcall(function() originalSky.SkyboxOrientation = originalSkyOrientation end)
        end
        if originalSunAngularSize then
            pcall(function() originalSky.SunAngularSize = originalSunAngularSize end)
        end
    end
end

local function updateSky()
    restoreOriginalSky()
    if not Settings.Visuals.SkyChanger.Enabled then
        return
    end

    local skyName = Settings.Visuals.SkyChanger.Sky
    if skyName == "Default" then return end
    local assetId = skyboxes[skyName]
    if not assetId then return end

    task.spawn(function()
        local newSky = getSkyObject(assetId)
        if not Settings.Visuals.SkyChanger.Enabled or Settings.Visuals.SkyChanger.Sky ~= skyName then
            return
        end
        
        local currentSky = Lighting:FindFirstChildOfClass("Sky")
        if currentSky and currentSky ~= customSky then
            originalSky = currentSky
            pcall(function() originalSky.Parent = nil end)
        end

        if customSky then
            pcall(function() customSky:Destroy() end)
        end

        if newSky then
            customSky = newSky:Clone()
            customSky.Parent = Lighting
            updateSkyboxOrientation()
            updateSunSize()
        end
    end)
end

local function applySkyColor(color)
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if not atmosphere then
        atmosphere = Instance.new("Atmosphere")
        atmosphere.Parent = Lighting
    end
    atmosphere.Color = color
    atmosphere.Decay = color
end

local function restoreOriginalAtmosphere()
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmosphere then
        if originalAtmosphereProps then
            atmosphere.Color = originalAtmosphereProps.Color
            atmosphere.Decay = originalAtmosphereProps.Decay
            atmosphere.Density = originalAtmosphereProps.Density
            atmosphere.Haze = originalAtmosphereProps.Haze
            atmosphere.Glare = originalAtmosphereProps.Glare
            atmosphere.Offset = originalAtmosphereProps.Offset
        else
            atmosphere:Destroy()
        end
    end
end

local function restoreOriginalLighting()
    Lighting.Ambient = originalLightingProps.Ambient
    Lighting.OutdoorAmbient = originalLightingProps.OutdoorAmbient
    Lighting.ColorShift_Top = originalLightingProps.ColorShift_Top
    Lighting.ColorShift_Bottom = originalLightingProps.ColorShift_Bottom
    Lighting.TimeOfDay = originalLightingProps.TimeOfDay
    Lighting.Brightness = originalLightingProps.Brightness
    Lighting.GlobalShadows = originalLightingProps.GlobalShadows
    Lighting.GeographicLatitude = originalLightingProps.GeographicLatitude
    Lighting.FogColor = originalLightingProps.FogColor
    Lighting.FogStart = originalLightingProps.FogStart
    Lighting.FogEnd = originalLightingProps.FogEnd
    
    if originalSunAngularSize then
        pcall(function()
            local sky = Lighting:FindFirstChildOfClass("Sky")
            if sky then sky.SunAngularSize = originalSunAngularSize end
        end)
    end
    pcall(function() Lighting.ExposureCompensation = originalLightingProps.ExposureCompensation end)
    pcall(function() Lighting.EnvironmentSpecularScale = originalLightingProps.EnvironmentSpecularScale end)
    pcall(function() Lighting.EnvironmentDiffuseScale = originalLightingProps.EnvironmentDiffuseScale end)
    pcall(function() Lighting.ShadowSoftness = originalLightingProps.ShadowSoftness end)
    pcall(function() Lighting.Technology = originalLightingProps.Technology end)

    restoreOriginalAtmosphere()
end

local SHOOTSOUND_IDS = {
    AWP         = { id = "rbxassetid://87904630045583", dur = 0.8 },
    Warthog     = { id = "rbxassetid://75639514375940", dur = 1.5 },
    ["SSG-08"]  = { id = "rbxassetid://135106301001744", dur = 0.8 },
    ["Trench Gun"] = { id = "rbxassetid://139929281329173", dur = 1.0 },
    Gunshot     = { id = "rbxassetid://138353739506455", dur = 1.0 },
    ["Gun Hit"] = { id = "rbxassetid://138242013444402", dur = 1.0 },
    Realistic   = { id = "rbxassetid://137940451698389", dur = 1.0 },
    ["Gun Shot"] = { id = "rbxassetid://136365595975777", dur = 1.0 },
    ["Rifle"] = { id = "rbxassetid://140374131796632", dur = 1.0 },
}

local function getSoundOwner(sound)
    local ancestor = sound
    while ancestor and ancestor ~= workspace do
        if ancestor:IsA("Tool") then
            local parent = ancestor.Parent
            if parent then
                if parent:IsA("Backpack") then
                    return parent.Parent
                else
                    local ply = game:GetService("Players"):GetPlayerFromCharacter(parent)
                    if ply then
                        return ply
                    end
                end
            end
        end
        ancestor = ancestor.Parent
    end
    return nil
end

local hookedSoundConnections = {}
local function hookShootSound(sound)
    if not sound:IsA("Sound") then return end
    
    if not sound:GetAttribute("OriginalSoundId") then
        sound:SetAttribute("OriginalSoundId", sound.SoundId)
    end
    if not sound:GetAttribute("OriginalVolume") then
        sound:SetAttribute("OriginalVolume", sound.Volume)
    end

    local owner = getSoundOwner(sound)
    local isSelf = (owner == LocalPlayer)
    local SS = Settings.Visuals.ShootSound
    local applyTo = SS.ApplyTo or "Self"
    local active = SS.Enabled and (applyTo == "Everyone" or (applyTo == "Self" and isSelf))

    if active and SS.Muted then
        sound.Volume = 0
    else
        local entry = active and SHOOTSOUND_IDS[SS.Sound]
        if entry then
            sound.SoundId = entry.id
            sound.Volume = tonumber(SS.Volume) or 1
        else
            sound.SoundId = sound:GetAttribute("OriginalSoundId") or sound.SoundId
            sound.Volume = sound:GetAttribute("OriginalVolume") or sound.Volume
        end
    end

    if not hookedSoundConnections[sound] then
        hookedSoundConnections[sound] = true
        
        local playConn
        playConn = sound:GetPropertyChangedSignal("Playing"):Connect(function()
            if sound.Playing then
                local owner = getSoundOwner(sound)
                local isSelf = (owner == LocalPlayer)
                local SS = Settings.Visuals.ShootSound
                local applyTo = SS.ApplyTo or "Self"
                local active = SS.Enabled and (applyTo == "Everyone" or (applyTo == "Self" and isSelf))

                if active and SS.Muted then
                    sound.Volume = 0
                else
                    local entry = active and SHOOTSOUND_IDS[SS.Sound]
                    if entry then
                        sound.SoundId = entry.id
                        sound.Volume = tonumber(SS.Volume) or 1
                        task.delay(entry.dur, function()
                            if sound.Playing and sound.SoundId == entry.id then
                                sound:Stop()
                            end
                        end)
                    end
                end
            end
        end)

        sound.Destroying:Connect(function()
            if playConn then playConn:Disconnect() end
            hookedSoundConnections[sound] = nil
        end)
    end
end

local function updateShootSound(tool)
    if not tool or not tool:IsA("Tool") then return end
    for _, child in ipairs(tool:GetDescendants()) do
        if child:IsA("Sound") and child.Name == "ShootSound" then
            hookShootSound(child)
        end
    end
    tool.DescendantAdded:Connect(function(child)
        if child:IsA("Sound") and child.Name == "ShootSound" then
            hookShootSound(child)
        end
    end)
end

local function applyAllShootSounds()
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        local char = player.Character
        if char then
            for _, child in ipairs(char:GetChildren()) do
                if child:IsA("Tool") then
                    updateShootSound(child)
                end
            end
        end
        local bp = player:FindFirstChildOfClass("Backpack")
        if bp then
            for _, child in ipairs(bp:GetChildren()) do
                if child:IsA("Tool") then
                    updateShootSound(child)
                end
            end
        end
    end
end

do
    local _remote, _charsFolder
    local _gameName = "Da Hood"

    local _sharedWeapons = {
        ["Revolver"]=true,["Double-Barrel SG"]=true,["Double-Barrel"]=true,
        ["Double Barrel"]=true,["TacticalShotgun"]=true,["Tactical Shotgun"]=true,
        ["Shotgun"]=true,["SMG"]=true,["Uzi"]=true,["Flintlock"]=true,
        ["Silencer"]=true,["Sniper"]=true,
        ["[Revolver]"]=true,["[Double-Barrel SG]"]=true,["[Double-Barrel]"]=true,
        ["[Double Barrel]"]=true,["[TacticalShotgun]"]=true,["[Tactical Shotgun]"]=true,
        ["[Shotgun]"]=true,["[SMG]"]=true,["[Uzi]"]=true,["[Flintlock]"]=true,
        ["[Silencer]"]=true,["[Sniper]"]=true,
    }

    local _sharedIgnore = {
        Movement=true,Down=true,LANDED=true,Dead=true,Shooting=true,Carrier=true,
        Reload=true,Bought=true,Shield=true,Attacking=true,Fired=true,
        BoughtShield=true,TouchedPlayer=true,Reload_CLIENT=true,Reload_SERVER=true,
        MultiTouchedPlayer=true,Shooting_CLIENT=true,Carried=true,Shoot=true,
    }

    local _fullCaps = {
        HasRemote         = true,
        HasGunHandler     = true,
        HasCSYNC          = true,
        HasBodyEffects    = true,
        HasCharactersFolder = true,
    }

    -- ── Dynamic config ────────────────────────────────────────────────
    -- Starts with sensible Da Hood defaults.  The in-memory parser
    -- (runAutoUpdate) decompiles GunClient/GunHandler on every join,
    -- detects the real remote event + argument layout, and hot-patches
    -- this config via GameAdapter.ApplyDetectedConfig() automatically.
    -- No PlaceId whitelist is needed.
    local _cfg = {
        ShootEventName    = "ShootGun",
        ReloadEventName   = "Reload",
        MousePosEventName = "MousePos",
        RemoteFolder      = "GameRemotes",
        RemoteName        = "MainGameEvent",
        GunHandlerPath    = {"Modules", "GunHandler"},
        CharactersFolder  = "Players",
        WeaponNames       = _sharedWeapons,
        IgnoreRemoteNames = _sharedIgnore,
        Capabilities      = _fullCaps,
    }
    local _caps = _cfg.Capabilities

    GameAdapter.GameName          = _gameName
    GameAdapter.ShootEventName    = _cfg.ShootEventName or ""
    GameAdapter.ReloadEventName   = _cfg.ReloadEventName or ""
    GameAdapter.MousePosEventName = _cfg.MousePosEventName or ""
    GameAdapter.WeaponNames       = _cfg.WeaponNames or {}
    GameAdapter.IgnoreRemoteNames = _cfg.IgnoreRemoteNames or {}
    GameAdapter.Capabilities      = _caps
    GameAdapter.AimPosArgIndex    = _cfg.AimPosArgIndex or nil

    function GameAdapter.GetRemote()
        if not _caps.HasRemote then return nil end
        if _remote then return _remote end
        local rs = game:GetService("ReplicatedStorage")
        if not _cfg.RemoteFolder or _cfg.RemoteFolder == "" then
            _remote = rs:WaitForChild(_cfg.RemoteName, 10)
        else
            local gr = rs:WaitForChild(_cfg.RemoteFolder, 10)
            _remote = gr and gr:WaitForChild(_cfg.RemoteName, 10)
        end
        return _remote
    end

    -- Allow runtime hot-patching of the adapter (used by the Auto-Update feature)
    function GameAdapter.ApplyDetectedConfig(newCfg)
        _cfg = newCfg
        _caps = newCfg.Capabilities or _caps
        _remote = nil -- force re-fetch with new remote path
        GameAdapter.ShootEventName    = newCfg.ShootEventName    or GameAdapter.ShootEventName
        GameAdapter.ReloadEventName   = newCfg.ReloadEventName   or GameAdapter.ReloadEventName
        GameAdapter.MousePosEventName = newCfg.MousePosEventName or GameAdapter.MousePosEventName
        GameAdapter.WeaponNames       = newCfg.WeaponNames       or GameAdapter.WeaponNames
        GameAdapter.IgnoreRemoteNames = newCfg.IgnoreRemoteNames or GameAdapter.IgnoreRemoteNames
        GameAdapter.Capabilities      = _caps
        GameAdapter.AimPosArgIndex    = newCfg.AimPosArgIndex    or nil
        -- Reconnect to the newly detected remote event
        if _caps.HasRemote then
            task.spawn(function()
                local r = GameAdapter.GetRemote()
                if r then
                    MainRemoteEvent = r
                    notify("Auto Update: Connected to " .. tostring(r.Name), 4)
                else
                    notify("Auto Update: Remote not found after update!", 4)
                end
            end)
        end
    end

    function GameAdapter.GetCharactersFolder()
        if not _caps.HasCharactersFolder or not _cfg.CharactersFolder then return nil end
        if not _charsFolder or not _charsFolder.Parent then
            _charsFolder = workspace:FindFirstChild(_cfg.CharactersFolder)
        end
        return _charsFolder
    end

    function GameAdapter.GetBodyEffects(char)
        if not char then return nil end
        local cf = GameAdapter.GetCharactersFolder()
        if cf then
            local p = cf:FindFirstChild(char.Name)
            if p then return p:FindFirstChild("BodyEffects") end
        end
        return nil
    end

    function GameAdapter.GetHitbox(char)
        if not char then return nil end
        return char:FindFirstChild("Hitbox", true)
    end

    function GameAdapter.GetGunHandler()
        if not _caps.HasGunHandler or not _cfg.GunHandlerPath then return nil end
        local ok, mod = pcall(function()
            local rs = game:GetService("ReplicatedStorage")
            local node = rs
            for _, key in ipairs(_cfg.GunHandlerPath) do
                node = node[key]
            end
            return require(node)
        end)
        return ok and mod or nil
    end

    function GameAdapter.IsWeapon(tool)
        if not tool or not tool:IsA("Tool") then return false end
        return tool:FindFirstChild("Ammo") ~= nil or GameAdapter.WeaponNames[tool.Name] == true
    end

    local grabbedCache = {}
    local lastGrabbedTick = 0
    function GameAdapter.IsPlayerGrabbed(playerName)
        local now = tick()
        if now - lastGrabbedTick > 0.05 then
            table.clear(grabbedCache)
            lastGrabbedTick = now
            local cf = GameAdapter.GetCharactersFolder()
            if cf then
                for _, char in ipairs(cf:GetChildren()) do
                    local be = char:FindFirstChild("BodyEffects")
                    if be then
                        local grab = be:FindFirstChild("Grabbed")
                        if grab and grab.Value ~= nil and tostring(grab.Value) ~= "" then
                            grabbedCache[tostring(grab.Value)] = true
                        end
                    end
                end
            end
        end
        return grabbedCache[playerName] or false
    end

    function GameAdapter.IsAlive(player)
        local cf = GameAdapter.GetCharactersFolder()
        local char = (cf and player and cf:FindFirstChild(player.Name)) or (player and player.Character)
        
        if char then
            local be = char:FindFirstChild("BodyEffects")
            if be then
                local dead = be:FindFirstChild("Dead")
                local ko   = be:FindFirstChild("K.O")
                if (dead and dead.Value == true) or (ko and ko.Value == true) then
                    return false
                end
            end
            local hum = char:FindFirstChildOfClass("Humanoid")
            return hum and hum.Health > 0 or false
        end
        return false
    end

    function GameAdapter.FireShoot(handle, origin, pellets, hitPos, hitPart, normal, range, dmg)
        local remote = GameAdapter.GetRemote()
        if remote then
            getgenv().FiringGhostShot = true
            remote:FireServer(GameAdapter.ShootEventName, handle, origin, pellets, hitPos, hitPart, normal, range, dmg)
            getgenv().FiringGhostShot = nil
        end
    end

    function GameAdapter.Reload(tool)
        local remote = GameAdapter.GetRemote()
        if remote then
            remote:FireServer(GameAdapter.ReloadEventName, tool)
        end
    end

    function GameAdapter.FindBestWeapon(char, backpack, preferName)
        local containers = {}
        if char then table.insert(containers, char) end
        if backpack then table.insert(containers, backpack) end
        local bestTool = nil
        local bestScore = -1
        for _, c in ipairs(containers) do
            for _, child in ipairs(c:GetChildren()) do
                if child:IsA("Tool") and GameAdapter.IsWeapon(child) then
                    local maxAmmoVal = child:FindFirstChild("MaxAmmo")
                    local maxAmmo = maxAmmoVal and maxAmmoVal.Value or 0
                    local cooldownVal = child:FindFirstChild("ShootingCooldown")
                    local cooldown = cooldownVal and cooldownVal.Value or 1
                    local score = (maxAmmo * 10) + (1 / math.max(cooldown, 0.001))
                    if preferName and child.Name == preferName then
                        score = score + 1
                    end
                    if score > bestScore then
                        bestScore = score
                        bestTool = child
                    end
                end
            end
        end
        return bestTool
    end
end

local shotgunTools = {}
local Settings = getgenv().Settings
local GunHandlerModule = nil
pcall(function()
    GunHandlerModule = GameAdapter.GetGunHandler()
    if GunHandlerModule then
        local canShootFunc = GunHandlerModule.GetCanShoot and "GetCanShoot" or (GunHandlerModule.getCanShoot and "getCanShoot")
        if canShootFunc then
            local oldCanShoot = GunHandlerModule[canShootFunc]
            GunHandlerModule[canShootFunc] = function(...)
                if Settings.Extra.Exploits.CanShootBypass then
                    return true
                end
                return oldCanShoot(...)
            end
        end

        local aimFunc = GunHandlerModule.GetAim and "GetAim" or (GunHandlerModule.getAim and "getAim")
        if aimFunc then
            local oldGetAim = GunHandlerModule[aimFunc]
            GunHandlerModule[aimFunc] = function(origin, ...)
                if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled and saved then
                    origin = savedGunHandlePos or (saved.Position + Vector3.new(0, 1.5, 0))
                end
                local S = Settings.SilentAim
                local target = Target
                if S.Enabled and target and target.Parent then
                    if S.BulletTP or Settings.Extra.GunMod.NoDropoff then
                        return oldGetAim(origin, ...)
                    end

                    local targetPos = target.Position
                    local dir = (targetPos - origin)
                    return dir.Unit, dir.Magnitude
                end
                return oldGetAim(origin, ...)
            end
        end

        local shootFunc = GunHandlerModule.Shoot and "Shoot" or (GunHandlerModule.shoot and "shoot")
        if shootFunc then
            local oldShoot = GunHandlerModule[shootFunc]
            GunHandlerModule[shootFunc] = function(tbl, ...)
                if typeof(tbl) == "table" and tbl.Shooter == game:GetService("Players").LocalPlayer.Character then
                    local tool = tbl.Handle and tbl.Handle.Parent
                    local isShotgun = tool and (shotgunTools[tool] or tool.Name:lower():find("shotgun") or tool.Name:lower():find("double"))
                    local range = (tbl.Range and tbl.Range > 0) and tbl.Range or 250
                    local GM = Settings.Extra.GunMod
                    
                    local rawClientMuzzle = tbl.ForcedOrigin
                    if (not rawClientMuzzle or rawClientMuzzle.Magnitude == 0) and tool then
                        local muzzle = tool:FindFirstChild("Muzzle", true)
                        if muzzle then
                            rawClientMuzzle = muzzle.WorldPosition
                        end
                    end
                    if (not rawClientMuzzle or rawClientMuzzle.Magnitude == 0) and tbl.Handle then
                        rawClientMuzzle = tbl.Handle.Position
                    end

                    local getAimMethod = GunHandlerModule.GetAim or GunHandlerModule.getAim or function(pos) return (tbl.AimPosition - pos).Unit end

                    if Settings.SilentAim.Enabled and Target and Target.Parent then
                        tbl.AimPosition = Target.Position
                        tbl.Hit = Target
                        tbl.Normal = Vector3.new(0, 1, 0)
                    end

                    if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled and saved then
                        local savedOrigin = savedGunHandlePos or (saved.Position + Vector3.new(0, 1.5, 0))
                        tbl.ForcedOrigin = savedOrigin
                        local aimDir = getAimMethod(savedOrigin)
                        if isShotgun and tbl.AimPosition then
                            local muzzlePos = rawClientMuzzle
                            local muzzleAimDir = getAimMethod(muzzlePos)
                            local clientDir = (tbl.AimPosition - muzzlePos).Magnitude > 0 and (tbl.AimPosition - muzzlePos).Unit or muzzleAimDir
                            local naturalOffset = clientDir - muzzleAimDir
                            local scale = GM.SpreadEnabled and GM.SpreadValue or 1
                            tbl.AimPosition = savedOrigin + (aimDir + naturalOffset * scale).Unit * range
                        else
                            tbl.AimPosition = savedOrigin + aimDir * range
                        end
                    elseif isShotgun and GM.SpreadEnabled and tbl.AimPosition then
                        local muzzlePos = rawClientMuzzle
                        local aimDir = getAimMethod(muzzlePos)
                        local clientDir = (tbl.AimPosition - muzzlePos).Magnitude > 0 and (tbl.AimPosition - muzzlePos).Unit or aimDir
                        local naturalOffset = clientDir - aimDir
                        tbl.AimPosition = muzzlePos + (aimDir + naturalOffset * GM.SpreadValue).Unit * range
                    end
                end
                return oldShoot(tbl, ...)
            end
        end
    end
end)
workspace.FallenPartsDestroyHeight = -math.huge


Target = nil
initTick = tick()
Players = cloneref(game:GetService("Players"))
RunService = cloneref(game:GetService("RunService"))
ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
MainRemoteEvent = GameAdapter.GetRemote()

VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
UserInputService = cloneref(game:GetService("UserInputService"))
CoreGui = cloneref(game:GetService("CoreGui"))
TweenService = cloneref(game:GetService("TweenService"))
Workspace = cloneref(game:GetService("Workspace"))

Camera = Workspace.CurrentCamera
LocalPlayer = Players.LocalPlayer

local whoHitMeDebounces = {}

if MainRemoteEvent then
    MainRemoteEvent.OnClientEvent:Connect(function(action, shooterName, arg3, arg4, arg5, hitTarget, ...)
        if action == "ClientBullet" and getgenv().DmgNotifierEnabled then
                if hitTarget and typeof(hitTarget) == "Instance" then
                    if hitTarget == LocalPlayer.Character or hitTarget:IsDescendantOf(LocalPlayer.Character) or hitTarget.Name == LocalPlayer.Name then
                        if shooterName ~= LocalPlayer.Name then
                            local now = tick()
                            local lastHit = whoHitMeDebounces[shooterName]
                            if not lastHit or (now - lastHit) > 0.1 then
                                whoHitMeDebounces[shooterName] = now
                                local shooterPlr = Players:FindFirstChild(tostring(shooterName))
                                local displayName = shooterPlr and shooterPlr.DisplayName or tostring(shooterName)
                                Library:Notify(displayName .. " hit you!", 3)
                            end
                        end
                    end
                end
            end
    end)
end

Circle = Drawing.new("Circle")
Circle.Thickness = 1

-- AimView: dot on target + line from crosshair to target
local AimDot = Drawing.new("Circle")
AimDot.Radius = 5
AimDot.Filled = true
AimDot.Visible = false
AimDot.ZIndex = 10
AimDot.Color = Color3.fromRGB(255, 50, 50)
AimDot.Transparency = 1

local AimLine = Drawing.new("Line")
AimLine.Thickness = 1
AimLine.Visible = false
AimLine.ZIndex = 9
AimLine.Color = Color3.fromRGB(255, 50, 50)
AimLine.Transparency = 1

HighlightTarget = Instance.new("Highlight")
local _cg = game:GetService("CoreGui")
if _cg then
    HighlightTarget.Parent = _cg
else
    HighlightTarget.Parent = workspace.CurrentCamera or workspace
end
local function getHitbox(char) return GameAdapter.GetHitbox(char) end

alreadyhasbeenreloadingforthebypass = false


local originalCooldowns = {}
local originalRanges = {}

local function updateToolMods(tool)
    if not tool or not tool:IsA("Tool") then return end
    
    local cd = tool:FindFirstChild("ShootingCooldown")
    if cd then
        if not originalCooldowns[tool] then
            originalCooldowns[tool] = cd.Value
        end
        if Settings.Extra.GunMod.RapidFire then
            cd.Value = 0.05
        else
            cd.Value = originalCooldowns[tool]
        end
    end

    local rangeObj = tool:FindFirstChild("Range")
    if rangeObj then
        if not originalRanges[tool] then
            originalRanges[tool] = rangeObj.Value
        end
        if Settings.Extra.GunMod.RangeEnabled then
            rangeObj.Value = Settings.Extra.GunMod.Range or 250
        else
            rangeObj.Value = originalRanges[tool]
        end
    end
    updateShootSound(tool)
end

function applyAllToolMods()
    local char = LocalPlayer.Character
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") then
                updateToolMods(child)
            end
        end
    end
    for _, child in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if child:IsA("Tool") then
            updateToolMods(child)
        end
    end
end

task.spawn(function()
    while not LocalPlayer or not LocalPlayer:FindFirstChild("Backpack") do task.wait(0.5) end
    
    local toolConnections = {}
    local otherPlayersConnections = {}

    local function setupOtherPlayersListeners()
        for _, c in ipairs(otherPlayersConnections) do c:Disconnect() end
        table.clear(otherPlayersConnections)

        local function hookOtherPlayer(player)
            if player == LocalPlayer then return end

            local function hookContainer(container)
                if not container then return end
                table.insert(otherPlayersConnections, container.ChildAdded:Connect(function(child)
                    task.wait(0.1)
                    updateShootSound(child)
                end))
                for _, child in ipairs(container:GetChildren()) do
                    updateShootSound(child)
                end
            end

            local bp = player:FindFirstChildOfClass("Backpack")
            if bp then hookContainer(bp) end
            table.insert(otherPlayersConnections, player.ChildAdded:Connect(function(child)
                if child:IsA("Backpack") then hookContainer(child) end
            end))

            if player.Character then hookContainer(player.Character) end
            table.insert(otherPlayersConnections, player.CharacterAdded:Connect(function(char)
                hookContainer(char)
            end))
        end

        for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
            hookOtherPlayer(p)
        end
        table.insert(otherPlayersConnections, game:GetService("Players").PlayerAdded:Connect(function(p)
            hookOtherPlayer(p)
        end))
    end

    local function setupInventoryListeners()
        for _, c in ipairs(toolConnections) do c:Disconnect() end
        table.clear(toolConnections)

        local function hookContainer(container)
            if not container then return end
            table.insert(toolConnections, container.ChildAdded:Connect(function(child)
                task.wait(0.1)
                updateToolMods(child)
            end))
            for _, child in ipairs(container:GetChildren()) do
                updateToolMods(child)
            end
        end

        hookContainer(LocalPlayer.Backpack)
        if LocalPlayer.Character then
            hookContainer(LocalPlayer.Character)
        end
        table.insert(toolConnections, LocalPlayer.CharacterAdded:Connect(function(char)
            hookContainer(char)
        end))
    end
    setupInventoryListeners()
    setupOtherPlayersListeners()
    applyAllShootSounds()
end) 


Characters = GameAdapter.GetCharactersFolder()
names = { "Dex", "Hook", "Inf", "LocalScript" }

function disableAC(char)
	for _, d in ipairs(char:GetDescendants()) do
		if d:IsA("LocalScript") then
			for _, name in ipairs(names) do
				if d.Name == name then
					pcall(function()
                        d.Disabled = true
                    end)
                    
				end
			end
		end
	end
	char.DescendantAdded:Connect(function(d)
		if d:IsA("LocalScript") then
			for _, name in ipairs(names) do
				if d.Name == name then
					pcall(function()
                        d.Disabled = true
                    end)                    
				end
			end
		end
	end)
end


local oldIndex

oldIndex = hookmetamethod(game, "__index", function(self, key)
	if self == LocalPlayer and key:lower() == "kick" then
		return function() return end
	end
	return oldIndex(self, key)
end)




if Characters then
	Characters.ChildAdded:Connect(function(c)
		if c.Name == LocalPlayer.Name then disableAC(c) end
	end)
	local char = Characters:FindFirstChild(LocalPlayer.Name)
	if char then disableAC(char) end
else
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then disableAC(p.Character) end
		p.CharacterAdded:Connect(disableAC)
	end
	Players.PlayerAdded:Connect(function(p)
		p.CharacterAdded:Connect(disableAC)
	end)
end

if CoreGui:FindFirstChild("TargetStatsHUD") then
	CoreGui.TargetStatsHUD:Destroy()
end


triangle = Drawing.new("Triangle")
triangle.Thickness = 1
triangle.Filled = true
triangle.Transparency = 1
triangle.Visible = false

outline = Drawing.new("Triangle")
outline.Color = Color3.fromRGB(0, 0, 0)
outline.Thickness = 1
outline.Filled = false
outline.Transparency = 1
outline.Visible = false

arrow = Drawing.new("Triangle")
arrow.Visible = false
arrow.Filled = true
arrow.Thickness = 1
arrow.Transparency = 1

local function makeDraggable(GuiObject, optionKey)
    GuiObject.Active = true
    local dragToggle = false
    local dragStart = nil
    local startPos = nil

    GuiObject.InputBegan:Connect(function(input)
        if not Library.Toggled then return end
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
            dragToggle = true
            dragStart = input.Position
            startPos = GuiObject.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                    connection:Disconnect()
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not Library.Toggled then return end
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = input.Position - dragStart
            GuiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            if optionKey and Library.Options and Library.Options[optionKey] then
                local posStr = string.format("%f,%d,%f,%d", GuiObject.Position.X.Scale, GuiObject.Position.X.Offset, GuiObject.Position.Y.Scale, GuiObject.Position.Y.Offset)
                Library.Options[optionKey]:SetValue(posStr)
            end
        end
    end)
end

screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "TargetStatsHUD"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

frame = Instance.new("Frame", screenGui)
frame.AnchorPoint = Vector2.new(0.5, 1)
frame.Position = UDim2.new(0.5, 0, 1, -120)
frame.Size = UDim2.new(0, 360, 0, 115)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 1
frame.Visible = false
makeDraggable(frame, "TargetStatsPos")

local innerFrame = Instance.new("Frame", frame)
innerFrame.Size = UDim2.new(1, -2, 1, -2)
innerFrame.Position = UDim2.new(0, 1, 0, 1)
innerFrame.BackgroundColor3 = Library.BackgroundColor
innerFrame.BorderColor3 = Library.OutlineColor
innerFrame.BorderMode = Enum.BorderMode.Inset
Library:AddToRegistry(innerFrame, {
    BackgroundColor3 = "BackgroundColor",
    BorderColor3 = "OutlineColor"
}, true)

local topBar = Instance.new("Frame", innerFrame)
topBar.Size = UDim2.new(1, 0, 0, 2)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.new(1, 1, 1)
topBar.BorderSizePixel = 0

local topBarGradient = Instance.new("UIGradient", topBar)
topBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Library.AccentColor),
    ColorSequenceKeypoint.new(1, Library.AccentColor:Lerp(Color3.fromRGB(0, 0, 0), 0.3))
})
Library:AddToRegistry(topBarGradient, {
    Color = function()
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library.AccentColor),
            ColorSequenceKeypoint.new(1, Library.AccentColor:Lerp(Color3.fromRGB(0, 0, 0), 0.3))
        })
    end
}, true)

barWidth, barHeight, barX = 243, 14, 105

nameLabel = Instance.new("TextLabel", innerFrame)
nameLabel.Size = UDim2.new(0, barWidth, 0, 20)
nameLabel.Position = UDim2.new(0, barX, 0, 10)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Library.Font
nameLabel.TextSize = 14
nameLabel.TextColor3 = Library.FontColor
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
Library:AddToRegistry(nameLabel, {
    TextColor3 = "FontColor"
}, true)

function createBar(yPos, color)
    local outerBar = Instance.new("Frame", innerFrame)
    outerBar.Position = UDim2.new(0, barX, 0, yPos)
    outerBar.Size = UDim2.new(0, barWidth, 0, barHeight)
    outerBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    outerBar.BorderSizePixel = 1

    local innerBar = Instance.new("Frame", outerBar)
    innerBar.Size = UDim2.new(1, -2, 1, -2)
    innerBar.Position = UDim2.new(0, 1, 0, 1)
    innerBar.BackgroundColor3 = Library.BackgroundColor
    innerBar.BorderColor3 = Library.OutlineColor
    innerBar.BorderMode = Enum.BorderMode.Inset
    Library:AddToRegistry(innerBar, {
        BackgroundColor3 = "BackgroundColor",
        BorderColor3 = "OutlineColor"
    }, true)

    local barFill = Instance.new("Frame", innerBar)
    barFill.Size = UDim2.new(1, 0, 1, 0)
    barFill.BackgroundColor3 = color
    barFill.BorderSizePixel = 0

    local overlay = Instance.new("TextLabel", innerBar)
    overlay.Size = UDim2.new(1, -4, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Font = Library.Font
    overlay.TextSize = 10
    overlay.TextColor3 = Color3.fromRGB(255, 255, 255)
    overlay.TextXAlignment = Enum.TextXAlignment.Right
    overlay.TextYAlignment = Enum.TextYAlignment.Center
    overlay.TextStrokeTransparency = 0.2
    overlay.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    return barFill, overlay
end

healthBarFill, healthBarOverlay = createBar(35, Color3.fromRGB(219, 79, 79))
armorBarFill, armorBarOverlay = createBar(55, Color3.fromRGB(37, 150, 190))

extraLabel = Instance.new("TextLabel", innerFrame)
extraLabel.Size = UDim2.new(0, barWidth, 0, 20)
extraLabel.Position = UDim2.new(0, barX, 0, 78)
extraLabel.BackgroundTransparency = 1
extraLabel.Font = Library.Font
extraLabel.TextSize = 12
extraLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
extraLabel.TextXAlignment = Enum.TextXAlignment.Left

avatarOuter = Instance.new("Frame", innerFrame)
avatarOuter.Size = UDim2.new(0, 84, 0, 84)
avatarOuter.Position = UDim2.new(0, 12, 0, 16)
avatarOuter.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
avatarOuter.BorderSizePixel = 1

avatarInner = Instance.new("Frame", avatarOuter)
avatarInner.Size = UDim2.new(1, -2, 1, -2)
avatarInner.Position = UDim2.new(0, 1, 0, 1)
avatarInner.BackgroundColor3 = Library.BackgroundColor
avatarInner.BorderColor3 = Library.OutlineColor
avatarInner.BorderMode = Enum.BorderMode.Inset
Library:AddToRegistry(avatarInner, {
    BackgroundColor3 = "BackgroundColor",
    BorderColor3 = "OutlineColor"
}, true)

avatar = Instance.new("ImageLabel", avatarInner)
avatar.Size = UDim2.new(1, 0, 1, 0)
avatar.BackgroundTransparency = 1
avatar.ImageTransparency = 1


function lerp(a, b, t) return a + (b - a) * t end


indicatorGui = Instance.new("ScreenGui", CoreGui)
indicatorGui.Name = "FeatureIndicatorHUD"
indicatorGui.IgnoreGuiInset = true
indicatorGui.ResetOnSpawn = false
indicatorGui.Parent = CoreGui

container = Instance.new("Frame", indicatorGui)
container.Position = UDim2.new(0, 8, 0.5, -100)
container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
container.BorderSizePixel = 1
container.Size = UDim2.new(0, 280, 0, 0)
container.Visible = false
makeDraggable(container, "FeatureIndPos")

local indInner = Instance.new("Frame", container)
indInner.Size = UDim2.new(1, -2, 1, -2)
indInner.Position = UDim2.new(0, 1, 0, 1)
indInner.BackgroundColor3 = Library.BackgroundColor
indInner.BorderColor3 = Library.OutlineColor
indInner.BorderMode = Enum.BorderMode.Inset
Library:AddToRegistry(indInner, {
    BackgroundColor3 = "BackgroundColor",
    BorderColor3 = "OutlineColor"
}, true)

local indTopBar = Instance.new("Frame", indInner)
indTopBar.Size = UDim2.new(1, 0, 0, 2)
indTopBar.Position = UDim2.new(0, 0, 0, 0)
indTopBar.BackgroundColor3 = Color3.new(1, 1, 1)
indTopBar.BorderSizePixel = 0

local indTopBarGradient = Instance.new("UIGradient", indTopBar)
indTopBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Library.AccentColor),
    ColorSequenceKeypoint.new(1, Library.AccentColor:Lerp(Color3.fromRGB(0, 0, 0), 0.3))
})
Library:AddToRegistry(indTopBarGradient, {
    Color = function()
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library.AccentColor),
            ColorSequenceKeypoint.new(1, Library.AccentColor:Lerp(Color3.fromRGB(0, 0, 0), 0.3))
        })
    end
}, true)

local indHeader = Instance.new("TextLabel", indInner)
indHeader.Size = UDim2.new(1, -10, 0, 20)
indHeader.Position = UDim2.new(0, 5, 0, 2)
indHeader.BackgroundTransparency = 1
indHeader.Font = Library.Font
indHeader.TextSize = 13
indHeader.TextColor3 = Library.FontColor
indHeader.TextXAlignment = Enum.TextXAlignment.Left
indHeader.Text = "Indicators"
Library:AddToRegistry(indHeader, {
    TextColor3 = "FontColor"
}, true)

local rowContainer = Instance.new("Frame", indInner)
rowContainer.BackgroundTransparency = 1
rowContainer.Position = UDim2.new(0, 0, 0, 22)
rowContainer.Size = UDim2.new(1, 0, 1, -22)

INDICATOR_HEIGHT = 18
indicators = {}
indicatorOrder = {}
pendingUpdates = {}

local containerSizeTween
local containerSizeConn

local indicatorPriority = {
    ["Desync"] = 1,
    ["C Position"] = 2,
    ["Htb Pos "] = 3,
    ["Velocity"] = 4,
    ["Rotation"] = 5
}

function refreshIndicatorList()
	local visibleCount = 0
    table.sort(indicatorOrder, function(a, b)
        local pa = indicatorPriority[a] or 99
        local pb = indicatorPriority[b] or 99
        return pa < pb
    end)
	for _, name in ipairs(indicatorOrder) do
		local entry = indicators[name]
		if entry.Visible then
			entry.Frame.Position = UDim2.new(0, 0, 0, visibleCount * INDICATOR_HEIGHT)
			entry.Frame.Visible = true
			visibleCount = visibleCount + 1
		else
			entry.Frame.Visible = false
		end
	end

	local contentHeight = 22 + (visibleCount * INDICATOR_HEIGHT) + (visibleCount > 0 and 10 or 0)

	if containerSizeTween then
		containerSizeTween:Cancel()
	end
	if containerSizeConn then
		containerSizeConn:Disconnect()
		containerSizeConn = nil
	end

	local shouldBeVisible = visibleCount > 0
	if shouldBeVisible then
		container.Visible = true
	end

	containerSizeTween = TweenService:Create(container, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 280, 0, contentHeight)
	})

	if not shouldBeVisible then
		containerSizeConn = containerSizeTween.Completed:Connect(function()
			container.Visible = false
			containerSizeConn = nil
		end)
	end

	containerSizeTween:Play()
end


local function formatVector3(v)
	local function baseFormat(n)
		local absN = math.abs(n)
		if absN >= 1e9 then
			return string.format("%.1fB", n / 1e9)
		elseif absN >= 1e6 then
			return string.format("%.1fM", n / 1e6)
		elseif absN >= 1e4 then
			return string.format("%.1fK", n / 1e3)
		else
			if math.floor(n) == n then
				return tostring(math.floor(n))
			else
				return string.format("%.1f", n)
			end
		end
	end
	return baseFormat(v.X) .. ", " .. baseFormat(v.Y) .. ", " .. baseFormat(v.Z)
end



function formatValue(value)
	local t = typeof(value)
	if t == "boolean" then
		return value and "[ON]" or "[OFF]"
	elseif t == "number" then
		if math.floor(value) == value then
			return "[" .. tostring(math.floor(value)) .. "]"
		else
			return "[" .. tostring(value) .. "]"
		end
	elseif t == "Vector3" then
		return "[" .. formatVector3(value) .. "]"
	else
		return "[" .. tostring(value) .. "]"
	end
end

function getColorForValue(value)
	if typeof(value) == "boolean" then
		return value and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 70, 70)
	end
	return Library.FontColor
end

function applyUpdate(name, value)
	local entry = indicators[name]
	if not entry then return end

	local displayText = formatValue(value)
	entry.Right.Text = displayText

	Library:RemoveFromRegistry(entry.Right)
	if typeof(value) == "boolean" then
		if value then
			entry.Right.TextColor3 = Color3.fromRGB(0, 255, 120)
		else
			entry.Right.TextColor3 = Color3.fromRGB(255, 70, 70)
		end
	else
		entry.Right.TextColor3 = Library.FontColor
		Library:AddToRegistry(entry.Right, {
			TextColor3 = "FontColor"
		}, true)
	end

	entry.Value = value
	entry.Type = typeof(value)
end

function addIndicator(name, initialValue)
	if indicators[name] then return end

	local frame = Instance.new("Frame", rowContainer)
	frame.Size = UDim2.new(1, 0, 0, INDICATOR_HEIGHT)
	frame.BackgroundTransparency = 1

	local left = Instance.new("TextLabel", frame)
	left.Size = UDim2.new(0.35, -6, 1, 0)
	left.Position = UDim2.new(0, 6, 0, 0)
	left.BackgroundTransparency = 1
	left.Font = Library.Font
	left.TextSize = 13
	left.TextXAlignment = Enum.TextXAlignment.Left
	left.TextStrokeTransparency = 1
	left.TextColor3 = Library.FontColor
	left.Text = name
	Library:AddToRegistry(left, {
		TextColor3 = "FontColor"
	}, true)

	local right = Instance.new("TextLabel", frame)
	right.Size = UDim2.new(0.65, -6, 1, 0)
	right.Position = UDim2.new(0.35, 0, 0, 0)
	right.BackgroundTransparency = 1
	right.Font = Library.Font
	right.TextSize = 13
	right.TextXAlignment = Enum.TextXAlignment.Right
	right.TextStrokeTransparency = 1
	right.TextColor3 = getColorForValue(initialValue)
	right.TextTruncate = Enum.TextTruncate.AtEnd
	right.Text = formatValue(initialValue)

	if typeof(initialValue) ~= "boolean" then
		Library:AddToRegistry(right, {
			TextColor3 = "FontColor"
		}, true)
	end

	indicators[name] = {
		Frame = frame,
		Left = left,
		Right = right,
		Value = initialValue,
		Visible = true,
		Type = typeof(initialValue),
	}
	table.insert(indicatorOrder, name)
	refreshIndicatorList()
end

function setIndicator(name, newValue)
	if not indicators[name] then return end
	if pendingUpdates[name] then return end

	pendingUpdates[name] = true
	task.delay(0.125, function()
		applyUpdate(name, newValue)
		pendingUpdates[name] = nil
	end)
end


function hideIndicator(name)
	local entry = indicators[name]
	if not entry then return end
	entry.Visible = false
	refreshIndicatorList()
end

function showIndicator(name)
	local entry = indicators[name]
	if not entry then return end
	entry.Visible = true
	refreshIndicatorList()
end

function indicatorExists(name)
	return indicators[name] ~= nil
end

function indicatorVisible(name)
	local entry = indicators[name]
	if not entry then return false end
	return entry.Visible
end

function notify(text, duration)
    Library:Notify(text, duration or 2)
end

local parttween1 = Instance.new("Part")
parttween1.Transparency = 1
parttween1.Anchored = true
parttween1.CanCollide = false
local parttween2 = Instance.new("Part")
parttween2.Transparency = 1
parttween2.Anchored = true
parttween2.CanCollide = false

local function isToolWeapon(tool) return GameAdapter.IsWeapon(tool) end
local bodyParts = {
    "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local essentialNames = {
    Walk = true,
    Run = true,
    Jump = true,
    Idle = true,
    Climb = true,
    Fall = true,
    Swim = true,
    SwimIdle = true,
    SwimForward = true,
    Land = true,
    FallDown = true,
    Freefall = true,
    Seated = true,
    GettingUp = true,
    Flying = true,
    Hover = true, 
    WalkAnim = true, 
    RunAnim = true, 
    JumpAnim = true, 
    Animation1 = true,
    Animation2 = true,
    ToolNoneAnim = true, 
    SmallGunShot = true,
    Reload = true,
    FallAnim = true,
    SmallGunAim = true,  
    ["Dancing 1"] = true, 
    ["Dancing 2 "] = true, 
    ["Getting Sturdy"] = true, 
    Greeting = true, 
    Laying = true, 
    Leaning = true, 
    Praying = true, 
    SmallGunAimShot = true, 
    ClimbAnim = true, 
    Animation = true,
    Crouching = true, 
    walk = true,
    idle = true, 
}

local lastAnimStop = 0
local lastIndicatorUpdate = 0

function stopAnims()
    local char = LocalPlayer.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        local animName = track.Name or ""
        if not essentialNames[animName] then
            track:Stop()
        end
    end
end
local bypasscountcool = 0 
function bypassCooldown(bypass)
    if alreadyhasbeenreloadingforthebypass and not bypass then return end

    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
    if not tool or not isToolWeapon(tool) then return end
    
    bypasscountcool = bypasscountcool + 1
    if bypasscountcool >= 3 then
        tool:Activate()
        bypasscountcool = 0
    end

    alreadyhasbeenreloadingforthebypass = true
    Reload()

    task.delay(2, function()
        alreadyhasbeenreloadingforthebypass = false
    end)
end


local RP = RaycastParams.new()
RP.FilterType = Enum.RaycastFilterType.Blacklist
RP.IgnoreWater = true

local HITSOUND_IDS = {
    Skeet     = "rbxassetid://83717596220569",
    NeverLose = "rbxassetid://139452805868562",
    Fatality  = "rbxassetid://115982072912004",
    TF2       = "rbxassetid://138901307926331",
    Ouch      = "rbxassetid://119713732135343",
    Snap      = "rbxassetid://125409047699942",
    Bell      = "rbxassetid://110241936966089",
    Splash    = "rbxassetid://140727221118804",
    Ricochet  = "rbxassetid://137227002846790",
    Slip      = "rbxassetid://136774133309136",
    Hammer    = "rbxassetid://134712572791297",
    ["Shield Break"] = "rbxassetid://130919835188323",
    ["Gold Pump"]    = "rbxassetid://119138528020256",
    ["Knocked"]      = "rbxassetid://118171751820277",
}



local SoundService = cloneref(game:GetService("SoundService"))

local lastHitSoundTime = 0
local function playHitSound()
    local HS = Settings.Visuals.HitSound
    if not HS.Enabled then return end
    local now = tick()
    if now - lastHitSoundTime < 0.05 then return end
    lastHitSoundTime = now
    local id = HITSOUND_IDS[HS.Sound]
    if not id then return end
    local sound = Instance.new("Sound")
    sound.SoundId = id
    sound.Volume = HS.Volume or 0.5
    sound.Parent = SoundService
    SoundService.PlayLocalSound(SoundService, sound)
    task.delay(2, function()
        sound.Destroy(sound)
    end)
end

local HitSoundRP = RaycastParams.new()
HitSoundRP.FilterType = Enum.RaycastFilterType.Exclude
HitSoundRP.IgnoreWater = true

local function getPlayerFromCharacter(char)
    if not char then return nil end
    local name = char.Name
    local player = Players.FindFirstChild(Players, name)
    if player then return player end
    return Players.GetPlayerFromCharacter(Players, char)
end

local function getPlayerFromInstance(instance)
    if not instance or not instance:IsDescendantOf(workspace) then return nil end
    local current = instance
    while current and current ~= workspace do
        local player = getPlayerFromCharacter(current)
        if player then
            return player
        end
        current = current.Parent
    end
    return nil
end

local function checkAndPlayHitSound(targetPartOrPellets, origin, targetPos)
    if not Settings.Visuals.HitSound.Enabled then return end

    local hitDetected = false
    local activeTarget = Target

    if activeTarget and activeTarget.Parent then
        local isGhostShot = Settings.Extra.GhostShot.Enabled
        if isGhostShot or not Settings.SilentAim.Checks.NotTargetIf["Behind Wall"] then
            hitDetected = true
        else
            local localChar = LocalPlayer.Character
            HitSoundRP.FilterDescendantsInstances = localChar and {localChar} or {}
            local dir = activeTarget.Position - origin
            if dir.Magnitude > 0.001 then
                local result = workspace.Raycast(workspace, origin, dir.Unit * math.min(dir.Magnitude + 2, 500), HitSoundRP)
                if result and result.Instance then
                    local hitPlayer = getPlayerFromInstance(result.Instance)
                    if hitPlayer and hitPlayer ~= LocalPlayer then
                        hitDetected = true
                    end
                end
            else
                hitDetected = true
            end
        end
    else
        if typeof(targetPartOrPellets) == "table" then
            for _, pellet in ipairs(targetPartOrPellets) do
                local pPart = pellet.Result2
                local hitPlayer = getPlayerFromInstance(pPart)
                if hitPlayer and hitPlayer ~= LocalPlayer then
                    hitDetected = true
                    break
                end
            end
        elseif typeof(targetPartOrPellets) == "Instance" then
            local hitPlayer = getPlayerFromInstance(targetPartOrPellets)
            if hitPlayer and hitPlayer ~= LocalPlayer then
                hitDetected = true
            end
        end

        if not hitDetected and targetPos and origin then
            local v6 = RaycastParams.new()
            local t_filter = {}
            local ok, Ignored = pcall(function() return require(ReplicatedStorage.MainModule).Ignored end)
            local localChar = LocalPlayer.Character
            if localChar then table.insert(t_filter, localChar) end
            if ok and Ignored then
                for _, v in ipairs(Ignored) do
                    table.insert(t_filter, v)
                end
            end
            v6.FilterDescendantsInstances = t_filter
            v6.FilterType = Enum.RaycastFilterType.Exclude
            v6.IgnoreWater = true

            local dir = targetPos - origin
            local result = workspace.Raycast(workspace, origin, dir.Unit * math.min(dir.Magnitude + 2, 500), v6)
            if result and result.Instance then
                local hitPlayer = getPlayerFromInstance(result.Instance)
                if hitPlayer and hitPlayer ~= LocalPlayer then
                    hitDetected = true
                end
            end
        end
    end

    if hitDetected then
        playHitSound()
    end
end



local function isCharacterAlive(char)
    if not char or not char.Parent then return false end
    local be = char:FindFirstChild("BodyEffects")
    if be then
        local ko = be:FindFirstChild("K.O")
        if ko and ko.Value == true then return false end
        local dead = be:FindFirstChild("Dead")
        if dead and dead.Value == true then return false end
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health <= 0 then return false end
    return true
end

local UP_VECTOR = Vector3.new(0, 1, 0)
local CF_OFFSET = CFrame.new(-1, 0.4, 0)

local function getWeaponStats(fireTool, character)
    local handle = fireTool:FindFirstChild("Handle")
    local range = fireTool:FindFirstChild("Range") and fireTool.Range.Value or 200
    local dmg = fireTool:FindFirstChild("Damage") and fireTool.Damage.Value or 30
    local head = character:FindFirstChild("Head")
    local origin = head and head.Position
    if not origin and handle then
        origin = (handle.CFrame * CF_OFFSET).Position
    end
    return handle, origin, range, dmg
end

local function isAlive(player)
    local pFolder = GameAdapter.GetCharactersFolder()
    local char = (pFolder and pFolder:FindFirstChild(player.Name)) or player.Character
    return isCharacterAlive(char)
end

local function cannotShoot(...)
    local chars = {...}
    for _, c in ipairs(chars) do
        if c then
            local be = c:FindFirstChild("BodyEffects")
            if be then
                local r = be:FindFirstChild("Reload")
                if r and r.Value == true then return true end
                if GameAdapter.IsPlayerGrabbed(c.Name) then return true end
                local cr = be:FindFirstChild("Crouching")
                if cr and cr.Value == true then return true end
            end
        end
    end
    return false
end




local WallCheckRP = RaycastParams.new()
WallCheckRP.FilterType = Enum.RaycastFilterType.Exclude
WallCheckRP.IgnoreWater = true

function WallCheck(to)
    local char = LocalPlayer.Character
    if char then
        WallCheckRP.FilterDescendantsInstances = {char}
    end
    local fovCenter
    local f = Settings.FieldOfView
    if f.Position == "Center" then
        local camSize = Camera.ViewportSize
        fovCenter = camSize / 2
    else
        fovCenter = UserInputService:GetMouseLocation()
    end
    local ray = Camera:ViewportPointToRay(fovCenter.X, fovCenter.Y)
    local dir = to - ray.Origin

    local result = workspace:Raycast(ray.Origin, dir.Unit * math.min(dir.Magnitude, 500), WallCheckRP)

    if result then
        local hit = result.Instance
        local distToHit = (result.Position - ray.Origin).Magnitude
        local distToTarget = dir.Magnitude

        if hit.CanCollide and hit.Transparency < 0.5 and distToHit < distToTarget then
            return false
        end
    end

    return true
end




function getMousePos()
    local mouse = LocalPlayer:GetMouse()
    local unitRay = Workspace.CurrentCamera:ScreenPointToRay(mouse.X, mouse.Y)
    local result = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)
    return result and result.Position or (unitRay.Origin + unitRay.Direction * 1000)
end

function GetClosestTarget()
    local S = Settings.SilentAim
    local f = Settings.FieldOfView
    local fovCenter
    local mp = UserInputService:GetMouseLocation()
    fovCenter = Vector2.new(mp.X, mp.Y)
    local cam = workspace.CurrentCamera
    local maxD = f.UseFov and f.Radius or math.huge
    
    local potentialTargets = {}

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer and not isIgnored(pl) then
            local c = pl.Character
            local part = c and c:FindFirstChild(S.HitPart)
            local hum = c and c:FindFirstChild("Humanoid")

            local healthCheckPassed = true
            local be = c and c:FindFirstChild("BodyEffects")
            local isDead = (hum and hum.Health <= 0) or (be and ((be:FindFirstChild("K.O") and be["K.O"].Value) or (be:FindFirstChild("Dead") and be.Dead.Value)))
            local isGrabbed = GameAdapter.IsPlayerGrabbed(pl.Name)
            local hasForcefield = c and c:FindFirstChildOfClass("ForceField") ~= nil

            if S.Checks.NotTargetIf["Dead"] and isDead then healthCheckPassed = false end
            if S.Checks.NotTargetIf["Grabbed"] and isGrabbed then healthCheckPassed = false end
            if S.Checks.NotTargetIf["Forcefield"] and hasForcefield then healthCheckPassed = false end

            if part and healthCheckPassed and part:IsDescendantOf(c) then
                local sp, on = cam:WorldToScreenPoint(part.Position)
                if on then
                    local screenPos = Vector2.new(sp.X, sp.Y)
                    local d = (fovCenter - screenPos).Magnitude
                    if d <= maxD then
                        table.insert(potentialTargets, {
                            Player = pl,
                            Part = part,
                            Distance = d,
                            Char = c
                        })
                    end
                end
            end
        end
    end

    table.sort(potentialTargets, function(a, b) return a.Distance < b.Distance end)

    for _, targetData in ipairs(potentialTargets) do
        if not (S.Checks.NotTargetIf["Behind Wall"] and targetData.Char:FindFirstChild("Head") and not WallCheck(targetData.Part.Position)) then
            return targetData.Player, targetData.Part
        end
    end

    return nil, nil
end




local reloadDebounce = false 
function Reload()
    if reloadDebounce then return end
    reloadDebounce = true

    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not tool or not isToolWeapon(tool) then
        reloadDebounce = false
        return
    end

    GameAdapter.Reload(tool)

    task.delay(1.5, function()
        reloadDebounce = false
    end)
end


function updateDesync()
end



TargetPlayer = nil
Target = nil

function clearTarget()
    Target = nil
    TargetPlayer = nil
end

function resetTracking()
    Target = nil
    TargetPlayer = nil
end

function findManualTarget()
    local mt = (Settings.SilentAim.ManualTarget or ""):lower()
    if mt == "" then return end
    local best, score = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not isIgnored(p) and p.Character:FindFirstChild("HumanoidRootPart") then
            local n1 = p.DisplayName:lower():find(mt, 1, true)
            local n2 = p.Name:lower():find(mt, 1, true)
            local s = n1 or n2 or math.huge
            if s < score then best, score = p, s end
        end
    end
    if best then
        local part = best.Character:FindFirstChild(Settings.SilentAim.HitPart or "HumanoidRootPart")
        if part then
            Target, TargetPlayer = part, best
        end
    end
end

task.spawn(function()
    while getgenv().loaded and task.wait(0.1) do
        if not Settings.SilentAim.Enabled then continue end
        if not TargetPlayer then continue end

        local newPlayerInst = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == TargetPlayer.Name then
                newPlayerInst = p
                break
            end
        end

        if not newPlayerInst then
            notify(TargetPlayer.DisplayName .. " left the game", 3)
            clearTarget()
            continue
        elseif TargetPlayer ~= newPlayerInst then
            TargetPlayer = newPlayerInst
        end

        local hitName = Settings.SilentAim.HitPart or "Head"
        local wpFolder = GameAdapter.GetCharactersFolder()
        local currentChar = (wpFolder and wpFolder:FindFirstChild(TargetPlayer.Name)) or TargetPlayer.Character

        local part = nil
        if currentChar and currentChar.Parent then
            part = currentChar:FindFirstChild(hitName)
        end

        if not part then
            Target = nil
        end

        local aliveCheckPassed = true
        local be = currentChar and currentChar:FindFirstChild("BodyEffects")
        local isDead = not GameAdapter.IsAlive(TargetPlayer) or (be and ((be:FindFirstChild("K.O") and be["K.O"].Value) or (be:FindFirstChild("Dead") and be.Dead.Value)))
        local isGrabbed = GameAdapter.IsPlayerGrabbed(TargetPlayer.Name)
        local hasForcefield = currentChar and currentChar:FindFirstChildOfClass("ForceField") ~= nil

        if Settings.SilentAim.Checks.UntargetIf["Dead"] and isDead then aliveCheckPassed = false end
        if Settings.SilentAim.Checks.UntargetIf["Grabbed"] and isGrabbed then aliveCheckPassed = false end
        if Settings.SilentAim.Checks.UntargetIf["Forcefield"] and hasForcefield then aliveCheckPassed = false end
        if Settings.SilentAim.Checks.UntargetIf["Behind Wall"] and part and not WallCheck(part.Position) then aliveCheckPassed = false end

        if part and aliveCheckPassed then
            Target = part
        else
            Target = nil
        end
    end
end)


local States = {"Jumping","Freefall","Climbing","Swimming","Running","Flying","StrafingNoPhysics", "Seated"}

task.spawn(function()
    while getgenv().loaded and task.wait(0.1) do
        local st = Settings.Extra.StateSpoofer
        if st and st.Enabled then
            local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if h then
                pcall(function()
                    if st.Randomize then
                        h:ChangeState(Enum.HumanoidStateType[States[math.random(#States)]])
                    else
                        h:ChangeState(Enum.HumanoidStateType[st.State] or Enum.HumanoidStateType.Running)
                    end
                end)
            end
        end
    end
end)


UserInputService.InputBegan:Connect(
    function(input, processed)
        if processed then
            return
        end
        if input.KeyCode ~= Enum.KeyCode[Settings.SilentAim.Bind] then
            return
        end
        if not Settings.SilentAim.Enabled then
            resetTracking()
            return
        end
        if Settings.SilentAim.ManualTarget ~= "" then
            resetTracking()
            Settings.SilentAim.ManualTarget = ""
            return
        end
        if TargetPlayer then
            resetTracking()
            if Settings.SilentAim.Notify then
                notify("Unfocused", 2)
            end
        else
            local np, npart = GetClosestTarget()
            if np and npart then
                if Settings.SilentAim.Notify then
                    notify("Focused on: " .. np.DisplayName, 2)
                end
                TargetPlayer, Target = np, npart
            end
        end
    end
)

if not getgenv().AutoKillStates then getgenv().AutoKillStates = {} end
if not getgenv().AutoKillLastShotTime then getgenv().AutoKillLastShotTime = 0 end
if getgenv().AutoKillHeartbeat then getgenv().AutoKillHeartbeat:Disconnect(); getgenv().AutoKillHeartbeat = nil end

function updateAutoKill()
    if not getgenv().loaded then return end
    local S = Settings
    if not S.Extra.Exploits.AutoKill then return end

    local localChar = LocalPlayer.Character
    if not localChar then return end
    local localHum = localChar:FindFirstChildOfClass("Humanoid")
    if not localHum or localHum.Health <= 0 then return end
    if not localChar:FindFirstChild("FULLY_LOADED_CHAR") then return end

    local fireTool = localChar:FindFirstChildOfClass("Tool")
    if fireTool then
        local cdVal = fireTool:FindFirstChild("ShootingCooldown")
        local gunCd = cdVal and cdVal.Value or 0.1
        local ping = LocalPlayer:GetNetworkPing()
        local realCd = math.max(0.1, gunCd + ping)
        if tick() - getgenv().AutoKillLastShotTime < realCd then return end
    end

    local pFolder = GameAdapter.GetCharactersFolder()
    local hitName = S.SilentAim.HitPart or "Head"

    local function getTargetData(p)
        local c = (pFolder and pFolder:FindFirstChild(p.Name)) or p.Character
        if not c or not c.Parent then return nil end
        if not c:FindFirstChild("FULLY_LOADED_CHAR") then return nil end
        if c:FindFirstChildOfClass("ForceField") then return nil end
        if c:FindFirstChild("GRABBING_CONSTRAINT") then return nil end
        
        local be = c:FindFirstChild("BodyEffects")
        if be then
            local ko = be:FindFirstChild("K.O")
            local dead = be:FindFirstChild("Dead")
            if (ko and ko.Value) or (dead and dead.Value) or GameAdapter.IsPlayerGrabbed(p.Name) then return nil end
        end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 or hum.Health == math.huge then return nil end
        
        local hitPart = c:FindFirstChild(hitName) or c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
        if not hitPart then return nil end
        
        return { Player = p, Character = c, HitPart = hitPart }
    end

    if not getgenv().AutoKillEligibleTargets then getgenv().AutoKillEligibleTargets = {} end
    local eligibleTargets = getgenv().AutoKillEligibleTargets

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl == LocalPlayer or isIgnored(pl) then continue end
        local d = getTargetData(pl)
        local found = false
        for i, et in ipairs(eligibleTargets) do
            if et.Player == pl then
                found = true
                if d then
                    eligibleTargets[i].Data = d
                else
                    table.remove(eligibleTargets, i)
                end
                break
            end
        end
        if not found and d then
            table.insert(eligibleTargets, {Player = pl, Data = d})
        end
    end
    for i = #eligibleTargets, 1, -1 do
        local p = eligibleTargets[i].Player
        if not p.Parent or not Players:FindFirstChild(p.Name) then
            table.remove(eligibleTargets, i)
        end
    end

    local localPChar = pFolder and pFolder:FindFirstChild(LocalPlayer.Name)
    if localPChar then
        local be = localPChar:FindFirstChild("BodyEffects")
        if be then
            local ko = be:FindFirstChild("K.O")
            local dead = be:FindFirstChild("Dead")
            if (ko and ko.Value) or (dead and dead.Value) then return end
            
            local r = be:FindFirstChild("Reload")
            if r and r.Value == true then return end
            if GameAdapter.IsPlayerGrabbed(LocalPlayer.Name) then return end
            local cr = be:FindFirstChild("Crouching")
            if cr and cr.Value == true then return end
        end
    end

    local mode = S.Extra.Exploits.AutoKillTarget or 'Everyone'
    local GM = S.Extra.GunMod
    local fireTool = localChar:FindFirstChildOfClass("Tool")
    
    if fireTool then
        getgenv().LastWeaponName = fireTool.Name
    end
    
    local shouldEquip = false
    if mode == 'Target' and TargetPlayer then shouldEquip = true end
    if mode == 'Everyone' then shouldEquip = true end
    if mode == 'Select' and getgenv().AutoKillSelectList and next(getgenv().AutoKillSelectList) then shouldEquip = true end

    if S.Extra.Exploits.AutoKillEquip and shouldEquip then
        if not fireTool then
            local targetWeapon = GameAdapter.FindBestWeapon(nil, LocalPlayer.Backpack, getgenv().LastWeaponName)
            if targetWeapon then
                targetWeapon.Parent = localChar
                fireTool = targetWeapon
            end
        else
            local targetWeapon = GameAdapter.FindBestWeapon(localChar, LocalPlayer.Backpack, getgenv().LastWeaponName)
            if targetWeapon and targetWeapon ~= fireTool then
                fireTool.Parent = LocalPlayer.Backpack
                targetWeapon.Parent = localChar
                fireTool = targetWeapon
            end
        end
    end

    if not fireTool then return end
    
    local mult = GM.PelletMultiplier or 5
    local shouldMultiply = GM.PelletMultiplierEnabled and GM.PelletMultiplierMode == 'Always'

    local function executeFire(targets)
        if not targets or #targets == 0 then return end

        if GM.PelletMultiplierEnabled and GM.PelletMultiplierMode:find('target') then
            shouldMultiply = true
        end

        local ammoObj = fireTool:FindFirstChild("Ammo")
        if ammoObj then
            if ammoObj.Value > 0 then
                local handle = fireTool:FindFirstChild("Handle")
                local range = fireTool:FindFirstChild("Range") and fireTool.Range.Value or 200
                local dmg = fireTool:FindFirstChild("Damage") and fireTool.Damage.Value or 30
                local origin = (localChar and localChar:FindFirstChild("Head") and localChar.Head.Position) or (handle and (handle.CFrame * CFrame.new(-1, 0.4, 0)).Position)

                local cdVal = fireTool:FindFirstChild("ShootingCooldown")
                local gunCd = cdVal and cdVal.Value or 0.1
                -- For multiple targets, use a tighter cooldown so we can fire fast enough
                local akMode2 = S.Extra.Exploits.AutoKillMode or 'Individual'
                local ping = LocalPlayer:GetNetworkPing()
                local realCd = (akMode2 == 'Multiple') and math.max(0.05, gunCd) or math.max(0.1, gunCd + ping)

                if tick() - getgenv().AutoKillLastShotTime < realCd then return end
                getgenv().AutoKillLastShotTime = tick()

                local isShotgun = fireTool.Name:lower():find("shotgun") or fireTool.Name:lower():find("double")
                local useFireShoot = shouldMultiply or S.Extra.GhostShot.Enabled or isShotgun or #targets > 1

                local pellets = nil
                local hitPos = nil
                local hitPart = nil
                local normal = nil

                if useFireShoot then
                    pellets = {}
                    for _, tData in ipairs(targets) do
                        local tPos = tData.HitPart.Position
                        for i = 1, mult do
                            table.insert(pellets, {
                                Result1 = tPos,
                                Result2 = tData.HitPart,
                                AimPosition = tPos,
                                Result3 = Vector3.new(0, 1, 0)
                            })
                        end
                    end
                else
                    local tData = targets[1]
                    hitPos = tData.HitPart.Position
                    hitPart = tData.HitPart
                    normal = Vector3.new(0, 1, 0)
                end

                if useFireShoot and handle and origin then
                    GameAdapter.FireShoot(handle, origin, pellets, hitPos, hitPart, normal, range, dmg)
                    ammoObj.Value = ammoObj.Value - 1
                else
                    fireTool:Activate()
                    ammoObj.Value = ammoObj.Value - 1
                end

                for _, tData in ipairs(targets) do
                    local pName = tData.Player.Name
                    if not getgenv().NotifiedKills then getgenv().NotifiedKills = {} end
                    if not getgenv().NotifiedKills[pName] or tick() - getgenv().NotifiedKills[pName] > 3 then
                        getgenv().NotifiedKills[pName] = tick()
                        local dName = tData.Player.DisplayName
                        notify("Killed: " .. dName, 2)
                    end
                end
            else
                GameAdapter.Reload(fireTool)
            end
        end
    end

    local mode = S.Extra.Exploits.AutoKillTarget or 'Everyone'

    if mode == 'Target' then
        if TargetPlayer then
            local d = getTargetData(TargetPlayer)
            if d then
                executeFire({d})
            else
                local ammoObj = fireTool:FindFirstChild("Ammo")
                if ammoObj and ammoObj.Value < (fireTool:FindFirstChild("MaxAmmo") and fireTool.MaxAmmo.Value or 1) then
                    GameAdapter.Reload(fireTool)
                end
            end
        end
    elseif mode == 'Select' then
        local selectList = getgenv().AutoKillSelectList or {}
        local fired = false
        for playerName, _ in pairs(selectList) do
            local pl = Players:FindFirstChild(playerName)
            if pl and pl ~= LocalPlayer then
                local d = getTargetData(pl)
                if d then
                    TargetPlayer = pl
                    Target = d.HitPart
                    executeFire({d})
                    fired = true
                    break
                end
            end
        end
        if not fired then
            local ammoObj = fireTool:FindFirstChild("Ammo")
            if ammoObj and ammoObj.Value < (fireTool:FindFirstChild("MaxAmmo") and fireTool.MaxAmmo.Value or 1) then
                GameAdapter.Reload(fireTool)
            end
        end
    elseif mode == 'Everyone' then
        if #getgenv().AutoKillEligibleTargets == 0 then
            local ammoObj = fireTool:FindFirstChild("Ammo")
            if ammoObj then
                local allDead = true
                for _, pl in ipairs(Players:GetPlayers()) do
                    if pl == LocalPlayer or isIgnored(pl) then continue end
                    local pChar = pl.Character
                    if pChar then
                        local pHum = pChar:FindFirstChildOfClass("Humanoid")
                        local pBe = pChar:FindFirstChild("BodyEffects")
                        local isDead = false
                        if pHum and pHum.Health <= 0 then isDead = true end
                        if pBe then
                            local pKo = pBe:FindFirstChild("K.O")
                            local pDead = pBe:FindFirstChild("Dead")
                            if (pKo and pKo.Value) or (pDead and pDead.Value) then isDead = true end
                        end
                        if not isDead then
                            allDead = false
                            break
                        end
                    end
                end
                if (allDead or ammoObj.Value <= 0) and ammoObj.Value < (fireTool:FindFirstChild("MaxAmmo") and fireTool.MaxAmmo.Value or 1) then
                    GameAdapter.Reload(fireTool)
                end
            end
            return
        end
        
        local sorted = {}
        for _, et in ipairs(getgenv().AutoKillEligibleTargets) do
            table.insert(sorted, et)
        end
        table.sort(sorted, function(a,b) return a.Player.Name < b.Player.Name end)
        
        local akMode = S.Extra.Exploits.AutoKillMode or 'Individual'
        if akMode == 'Individual' then
            local t = sorted[1]
            if t then
                TargetPlayer = t.Player
                Target = t.Data.HitPart
                executeFire({t.Data})
            end
        else
            local targets = {}
            for _, t in ipairs(sorted) do
                table.insert(targets, t.Data)
            end
            if #targets > 0 then
                executeFire(targets)
            end
        end
    end
end

if getgenv().SilentAimConnection then getgenv().SilentAimConnection:Disconnect() end
getgenv().SilentAimConnection = RunService.RenderStepped:Connect(function()
    if not getgenv().loaded then return end
    local T, S = Target, Settings
    
    local cf = GameAdapter.GetCharactersFolder()
    local tgtChar = TargetPlayer and ((cf and cf:FindFirstChild(TargetPlayer.Name)) or TargetPlayer.Character)

    if not S.SilentAim.Enabled and TargetPlayer then
        clearTarget()
    end
    if S.SilentAim.Enabled and TargetPlayer and tgtChar then
        local c = tgtChar
        local be = c:FindFirstChild("BodyEffects")
        local isDead = not GameAdapter.IsAlive(TargetPlayer) or (be and ((be:FindFirstChild("K.O") and be["K.O"].Value) or (be:FindFirstChild("Dead") and be.Dead.Value)))
        local isGrabbed = GameAdapter.IsPlayerGrabbed(TargetPlayer.Name)
        local hasForcefield = c and c:FindFirstChildOfClass("ForceField") ~= nil
        
        local untarget = false
        if S.SilentAim.Checks.UntargetIf["Dead"] and isDead then untarget = true end
        if S.SilentAim.Checks.UntargetIf["Grabbed"] and isGrabbed then untarget = true end
        if S.SilentAim.Checks.UntargetIf["Forcefield"] and hasForcefield then untarget = true end
        if S.SilentAim.Checks.UntargetIf["Behind Wall"] and Target and not WallCheck(Target.Position) then untarget = true end
        
        if untarget then Target = nil end
    end
    local fov = S.FieldOfView
    if Circle.Visible ~= fov.Visible then Circle.Visible = fov.Visible end
    if fov.Visible then
        local pos = UserInputService:GetMouseLocation()
        if Circle.Position ~= pos then Circle.Position = pos end
        if Circle.Color ~= fov.Color then Circle.Color = fov.Color end
        if Circle.Radius ~= fov.Radius then Circle.Radius = fov.Radius end
        if Circle.Filled ~= fov.Filled then Circle.Filled = fov.Filled end
        if Circle.Transparency ~= fov.Transparency then Circle.Transparency = fov.Transparency end
        local t = fov.Thickness or 1
        if Circle.Thickness ~= t then Circle.Thickness = t end
    end

    -- AimView: ray from gun muzzle along gun's LookVector (classic aimline)
    do
        local av = Settings.SilentAim and Settings.SilentAim.AimView
        local showAimView = av and av.Enabled and Settings.SilentAim.Enabled and TargetPlayer and tgtChar
        if showAimView then
            local tChar = tgtChar
            local muzzlePos, muzzleCF = nil, nil

            -- Find tool handle for muzzle origin + direction
            local tool = tChar:FindFirstChildOfClass("Tool")
            if tool then
                local handle = tool:FindFirstChild("Handle")
                if handle then
                    local muzzleAtt = handle:FindFirstChild("Muzzle")
                    if muzzleAtt and muzzleAtt:IsA("Attachment") then
                        muzzlePos = muzzleAtt.WorldPosition
                        muzzleCF  = muzzleAtt.WorldCFrame
                    else
                        muzzlePos = handle.Position
                        muzzleCF  = handle.CFrame
                    end
                end
            end
            -- Fallback: use Head look direction (tracks up/down aiming perfectly in Da Hood)
            if not muzzlePos then
                local head = tChar:FindFirstChild("Head")
                if head then
                    muzzlePos = head.Position + head.CFrame.LookVector * 1.5
                    muzzleCF  = head.CFrame
                end
            end

            if muzzlePos and muzzleCF then
                local beamEnd = muzzlePos + muzzleCF.LookVector * 50
                
                -- Get actual mouse position (replicating Auto Duck's logic inline)
                local be = GameAdapter.GetBodyEffects and GameAdapter.GetBodyEffects(tChar) or tChar:FindFirstChild("BodyEffects")
                if be then
                    local mp = be:FindFirstChild("MousePos")
                    if mp and mp:IsA("Vector3Value") then
                        beamEnd = mp.Value
                    end
                end
                
                local camCF = Camera.CFrame
                local rel0 = camCF:PointToObjectSpace(muzzlePos)
                local rel1 = camCF:PointToObjectSpace(beamEnd)
                
                if rel0.Z > 0 and rel1.Z > 0 then
                    AimDot.Visible = false
                    AimLine.Visible = false
                else
                    -- Clip the line to the camera's near clipping plane (Z = -0.1)
                    local function clip(p0, p1)
                        if p0.Z > -0.1 then
                            local t = (-0.1 - p0.Z) / (p1.Z - p0.Z)
                            p0 = p0:Lerp(p1, t)
                        end
                        if p1.Z > -0.1 then
                            local t = (-0.1 - p1.Z) / (p0.Z - p1.Z)
                            p1 = p1:Lerp(p0, t)
                        end
                        return p0, p1
                    end
                    
                    local cRel0, cRel1 = clip(rel0, rel1)
                    local cWorld0 = camCF:PointToWorldSpace(cRel0)
                    local cWorld1 = camCF:PointToWorldSpace(cRel1)
                    
                    local sp0 = Camera:WorldToViewportPoint(cWorld0)
                    local sp1 = Camera:WorldToViewportPoint(cWorld1)
                    
                    local avColor = av.Color or Color3.fromRGB(255, 50, 50)
                    local p0 = Vector2.new(sp0.X, sp0.Y)
                    local p1 = Vector2.new(sp1.X, sp1.Y)
                    
                    AimDot.Position = p0
                    AimDot.Color    = avColor
                    AimDot.Radius   = av.DotSize or 4
                    AimDot.Transparency = 1
                    AimDot.Visible  = (rel0.Z <= 0)
                    
                    AimLine.From    = p0
                    AimLine.To      = p1
                    AimLine.Color   = avColor
                    AimLine.Thickness = av.LineThickness or 1
                    AimLine.Transparency = 1
                    AimLine.Visible = av.ShowLine
                end
            else
                AimDot.Visible = false
                AimLine.Visible = false
            end
        else
            AimDot.Visible = false
            AimLine.Visible = false
        end
    end

    if S.SilentAim.Spectate then
        if TargetPlayer and tgtChar and tgtChar:FindFirstChildOfClass("Humanoid") then
            local tgtHum = tgtChar:FindFirstChildOfClass("Humanoid")
            if workspace.CurrentCamera.CameraSubject ~= tgtHum then
                workspace.CurrentCamera.CameraSubject = tgtHum
            end
        else
            local localHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if localHum and workspace.CurrentCamera.CameraSubject ~= localHum then
                workspace.CurrentCamera.CameraSubject = localHum
            end
        end
    else
        local localHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if localHum and workspace.CurrentCamera.CameraSubject ~= localHum then
            workspace.CurrentCamera.CameraSubject = localHum
        end
    end
    local H = S.Highlight
    -- Target highlight: adornee = target's character (not just hitbox part)
    if H.Enabled then
        local Ad = tgtChar or nil
        if HighlightTarget.Adornee ~= Ad then
            HighlightTarget.Adornee = Ad
        end
        if HighlightTarget.FillColor ~= H.FillColor then HighlightTarget.FillColor = H.FillColor end
        if HighlightTarget.OutlineColor ~= H.OutlineColor then HighlightTarget.OutlineColor = H.OutlineColor end
        if HighlightTarget.FillTransparency ~= H.FillTransparency then HighlightTarget.FillTransparency = H.FillTransparency end
        if HighlightTarget.OutlineTransparency ~= H.OutlineTransparency then HighlightTarget.OutlineTransparency = H.OutlineTransparency end
        local depth = H.VisibleOnly and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
        if HighlightTarget.DepthMode ~= depth then HighlightTarget.DepthMode = depth end
        local en = (tgtChar ~= nil)
        if HighlightTarget.Enabled ~= en then HighlightTarget.Enabled = en end
    else
        if HighlightTarget.Enabled then HighlightTarget.Enabled = false end
        if HighlightTarget.Adornee ~= nil then HighlightTarget.Adornee = nil end
    end
end)



Vertical = 0

UserInputService.InputBegan:Connect(function(input, processed)
    if not getgenv().loaded then return end
    if processed then return end
    local S = Settings
    local F = S.Movement.Fly
    local M = S.Movement
    local C = S.CSYNC
    local N = S.Movement.Noclip
    local kc = input.KeyCode
    if kc == (F.FlyUpKey or Enum.KeyCode.Space) then
        Vertical = 1
    elseif kc == (F.FlyDownKey or Enum.KeyCode.LeftControl) then
        Vertical = -1
    end 


end)

UserInputService.InputEnded:Connect(function(input)
    if not getgenv().loaded then return end
    local kc = input.KeyCode
    local F = Settings.Movement.Fly
    if kc == (F.FlyUpKey or Enum.KeyCode.Space) or kc == (F.FlyDownKey or Enum.KeyCode.LeftControl) then
        Vertical = 0
    end
end)



local function getAimingVectors(c)
    local a = {}
    local be = GameAdapter.GetBodyEffects(c)
    if be then
        local mp = be:FindFirstChild("MousePos")
        if mp and mp:IsA("Vector3Value") then
            a[#a+1] = mp
        end
    end
    return a
end

local currentTween
local desyncTask
local chLastDist = {}


local lastLegitDodgeTime = 0
local LEGIT_DODGE_COOLDOWN = 0.35

local function reactMovement(mode, incomingOrigin, incomingUnit)
    if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled then return end

    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not (hrp and hum) then return end

    if mode == "Legit" then
        local now = tick()
        if now - lastLegitDodgeTime < LEGIT_DODGE_COOLDOWN then return end
        lastLegitDodgeTime = now

        local right = hrp.CFrame.RightVector
        local vel = hrp.AssemblyLinearVelocity
        local movingRight = right:Dot(vel) >= 0

        local sideDir
        if incomingOrigin and incomingUnit then
            local toSelf = (hrp.Position - incomingOrigin)
            local crossDot = right:Dot(toSelf - incomingUnit * toSelf:Dot(incomingUnit))
            sideDir = crossDot >= 0 and right or -right
        else
            sideDir = movingRight and -right or right
        end

        local nudge = sideDir * (1.2 + math.random() * 0.6)

        if currentTween then currentTween:Cancel() end
        currentTween = TweenService:Create(hrp, TweenInfo.new(
            0.18 + math.random() * 0.07,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out
        ), { Position = hrp.Position + nudge })
        currentTween:Play()

    elseif mode == "Desync" then
        if not Settings.Duck.Enabled then return end
        if desyncTask then return end

        local s = Settings
        local target = Target
        local duck = s.Duck
        local threshold = 5
        local csyncWasEnabled = s.CSYNC.Enabled
        local masterWasEnabled = s.CSYNC.MasterSwitch

        desyncTask = task.spawn(function()
            local csyncActive = false
            local rp = RaycastParams.new()
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.IgnoreWater = true

            while getgenv().loaded and Settings.Duck.Enabled do
                if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled and not csyncActive then
                    task.wait(0.05)
                    continue
                end

                local chars = {}
                local pFolder = GameAdapter.GetCharactersFolder()

                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and not isIgnored(p) then
                        local tChar = (pFolder and pFolder:FindFirstChild(p.Name)) or p.Character
                        if tChar then
                            table.insert(chars, tChar)
                        end
                    end
                end

                local threat = false
                local selfChar = LocalPlayer.Character
                if not selfChar then break end
                local hrp = selfChar:FindFirstChild("HumanoidRootPart")
                if not hrp then task.wait(0.05) continue end

                for _, ch in ipairs(chars) do
                    local aimVecs = getAimingVectors(ch)
                    local tool = ch:FindFirstChildOfClass("Tool")
                    local handle = tool and tool:FindFirstChild("Handle")
                    if not handle then continue end

                    local origin = handle.Position

                    for _, v in ipairs(aimVecs) do
                        local dir = v.Value - origin
                        local len = math.min(dir.Magnitude, 500)
                        local unit = dir.Unit

                        rp.FilterDescendantsInstances = {selfChar, ch}
                        local rayResult = workspace:Raycast(origin, hrp.Position - origin, rp)
                        local clearPath = (rayResult == nil)

                        local targeted = false
                        if clearPath then
                            local toSelf = hrp.Position - origin
                            local proj = toSelf:Dot(unit)
                            if proj >= 0 and proj <= len then
                                local closestPoint = origin + unit * proj
                                local dist = (hrp.Position - closestPoint).Magnitude
                                
                                local lastDist = chLastDist[ch.Name]
                                chLastDist[ch.Name] = dist
                                
                                if dist < 12 or (dist < 45 and lastDist and dist < lastDist - 0.2) then
                                    targeted = true
                                end
                            else
                                chLastDist[ch.Name] = nil
                            end
                        else
                            chLastDist[ch.Name] = nil
                        end

                        if targeted then
                            threat = true
                            break
                        end
                    end

                    if threat then break end
                end

                if threat then
                    if not csyncActive then
                        if not csyncWasEnabled then s.CSYNC.Enabled = true end
                        if not masterWasEnabled then s.CSYNC.MasterSwitch = true end
                        csyncActive = true
                    end
                else
                    if csyncActive then
                        if not csyncWasEnabled then s.CSYNC.Enabled = false end
                        if not masterWasEnabled then s.CSYNC.MasterSwitch = false end
                        csyncActive = false
                    end
                end

                task.wait(0.05)
            end

            if csyncActive then
                if not csyncWasEnabled then s.CSYNC.Enabled = false end
                if not masterWasEnabled then s.CSYNC.MasterSwitch = false end
            end
            desyncTask = nil
        end)
    end
end






local offset = 0
local direction = 1
local originalCollisions = {}


local lerpInProgress = false
local lerpProgress = 0

function updateSilentAim(dt)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local htb = getHitbox(char)
    local Target = Target


    local S = Settings.SilentAim
    if not (hum and hrp) then return end

    if Settings.Movement.Noclip.MasterSwitch and Settings.Movement.Noclip.Enabled then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                if originalCollisions[part] == nil then
                    originalCollisions[part] = part.CanCollide
                end
                if part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    else
        for part, original in pairs(originalCollisions) do
            if part and part:IsA("BasePart") then
                if part.CanCollide ~= original then
                    part.CanCollide = original
                end
            end
            originalCollisions[part] = nil
        end
    end
    if Settings.Movement.Fly.Enabled and Settings.Movement.Fly.MasterSwitch then
        if UserInputService:GetFocusedTextBox() then return end

        local speed = Settings.Movement.Fly.Speed * (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 2 or 1)
        local dir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end

        if Vertical ~= 0 then dir += Vector3.new(0, Vertical, 0) end

        if dir.Magnitude > 0 then
            dir = dir.Unit
            hrp.Anchored = false
        else
            hrp.Anchored = true
        end

        hrp.AssemblyLinearVelocity = dir * speed
    elseif Settings.Movement.Speed.Enabled and Settings.Movement.Speed.MasterSwitch then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then
            local m = Vector3.new(dir.X,0,dir.Z).Unit * Settings.Movement.Speed.Speed * dt
            hrp.CFrame += Vector3.new(m.X,0,m.Z)
        end
        hrp.Anchored = false
    else
        hrp.Anchored = false
    end

    local now = tick()
    local updateIndicators = false
    if now - lastIndicatorUpdate >= 0.1 then
        lastIndicatorUpdate = now
        updateIndicators = true
    end

    local shouldShowIndicators = Settings.CSYNC.Status and (Settings.CSYNC.StatusMode == "Always" or (Settings.CSYNC.Enabled and Settings.CSYNC.MasterSwitch))

    if shouldShowIndicators then
        if not indicatorVisible("Desync") then showIndicator("Desync") end
        if not indicatorVisible("C Position") then showIndicator("C Position") end
        if not indicatorVisible("Htb Pos ") then showIndicator("Htb Pos ") end
        if not indicatorVisible("Rotation") and Settings.CSYNC.HyperRotation then showIndicator("Rotation") end

        if updateIndicators then
            local cpos = Vector3.new(math.round(hrp.Position.X), math.round(hrp.Position.Y), math.round(hrp.Position.Z))
            local hb = getHitbox(LocalPlayer.Character)
            local spos = hb and Vector3.new(math.round(hb.Position.X), math.round(hb.Position.Y), math.round(hb.Position.Z))

            if not Settings.CSYNC.Enabled or not Settings.CSYNC.MasterSwitch then
                setIndicator("Desync", Settings.CSYNC.Enabled)
                setIndicator("C Position", cpos)
                setIndicator("Htb Pos ", spos)
                if Settings.CSYNC.HyperRotation then setIndicator("Rotation", "Not Swapped") end
            end
        end
    else
        hideIndicator("Desync")
        hideIndicator("C Position")
        hideIndicator("Htb Pos ")
        hideIndicator("Rotation")
    end

    local shouldShowVelIndicators = Settings.VelocitySpoofer.Status and (Settings.VelocitySpoofer.StatusMode == "Always" or (Settings.VelocitySpoofer.Enabled and Settings.VelocitySpoofer.MasterSwitch))

    if shouldShowVelIndicators then
        if not indicatorVisible("Velocity") then showIndicator("Velocity") end

        if updateIndicators then
            if not Settings.VelocitySpoofer.Enabled or not Settings.VelocitySpoofer.MasterSwitch then
                local vel = hrp.AssemblyLinearVelocity
                setIndicator("Velocity", Vector3.new(math.round(vel.X), math.round(vel.Y), math.round(vel.Z)))
            end
        end
    else
        hideIndicator("Velocity")
    end

    if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled then
        if tick() - lastAnimStop >= 0.1 then
            lastAnimStop = tick()
            stopAnims()
        end
        local mode = Settings.CSYNC.Mode

        local desyncCFrame = (mode == "E = mc²" and CFrame.new(
                (math.random(0, 1) == 0 and -214721483648 or 214721483648),
                (math.random(0, 1) == 0 and -214721483648 or 214721483648),
                (math.random(0, 1) == 0 and -214721483648 or 214721483648)
            ) * CFrame.Angles(
                math.rad(math.random(0, 720)),
                math.rad(math.random(0, 720)),
                math.rad(math.random(0, 720))
            )) 
               
        local reorientatehtb = mode == "E = mc²" and (CFrame.new(
            (math.random(0, 1) == 0 and -214721483648 or 214721483648),
            (math.random(0, 1) == 0 and -214721483648 or 214721483648),
            (math.random(0, 1) == 0 and -214721483648 or 214721483648)
        ) * CFrame.Angles(
            math.rad(math.random(0, 720)),
            math.rad(math.random(0, 720)),
            math.rad(math.random(0, 720))
        )) or nil

        if htb then savedhtb = htb.CFrame end
        saved = hrp.CFrame
        local tool = char and char:FindFirstChildOfClass("Tool")
        savedGunHandlePos = (tool and tool:FindFirstChild("Handle") and tool.Handle.Position) or (hrp.Position + Vector3.new(0, 1.5, 0))

        local dual = tick() % 0.1 < 0.05

        if mode == "E = mc²" then
            if not lerpInProgress or lerpProgress >= 1 then
                lerpInProgress = true
                lerpProgress = 0
            end

            lerpProgress = lerpProgress + dt / (math.clamp(Settings.CSYNC.QuantumInterpolationDelay, 1, 500) / 1000)
            if lerpProgress > 1 then lerpProgress = 1 end

            lerpedhrp = desyncCFrame:Lerp(reorientatehtb, lerpProgress)
            lerpedhtb = desyncCFrame:Lerp(reorientatehtb, lerpProgress)

            if lerpProgress >= 1 then
                lerpInProgress = false
            end
        end

        if shouldShowIndicators and GameAdapter.IsAlive(LocalPlayer) then
            setIndicator("Desync", Settings.CSYNC.Enabled)
            if Settings.CSYNC.QuantumInterpolation and mode == "E = mc²" then
                setIndicator("C Position", Vector3.new(math.round(lerpedhrp.Position.X), math.round(lerpedhrp.Position.Y), math.round(lerpedhrp.Position.Z)))
            else 
                setIndicator("C Position", Vector3.new(math.round(desyncCFrame.Position.X), math.round(desyncCFrame.Position.Y), math.round(desyncCFrame.Position.Z)))
            end 
            if Settings.CSYNC.HitboxReorientation and mode == "E = mc²" then
                if Settings.CSYNC.QuantumInterpolation then 
                    setIndicator("Htb Pos ", Vector3.new(math.round(lerpedhtb.Position.X), math.round(lerpedhtb.Position.Y), math.round(lerpedhtb.Position.Z)))
                else 
                    setIndicator("Htb Pos ", Vector3.new(math.round(reorientatehtb.Position.X), math.round(reorientatehtb.Position.Y), math.round(reorientatehtb.Position.Z)))
                end 
            else
                setIndicator("Htb Pos ", htb and Vector3.new(math.round(htb.Position.X), math.round(htb.Position.Y), math.round(htb.Position.Z)) or "N/A")
            end
        elseif shouldShowIndicators then
            setIndicator("Desync", Settings.CSYNC.Enabled)
            setIndicator("C Position", Vector3.new(math.round(hrp.Position.X), math.round(hrp.Position.Y), math.round(hrp.Position.Z)))
            setIndicator("Htb Pos ", htb and Vector3.new(math.round(htb.Position.X), math.round(htb.Position.Y), math.round(htb.Position.Z)) or "N/A")
            if Settings.CSYNC.HyperRotation and not dual then
                if not indicatorVisible("Rotation") then showIndicator("Rotation") end 
                setIndicator("Rotation", "Swapped")
            elseif Settings.CSYNC.HyperRotation then
                if not indicatorVisible("Rotation") then showIndicator("Rotation") end 
                setIndicator("Rotation", "Not Swapped")
            end
        end
        if shouldShowIndicators then
            if (mode ~= "E = mc²" or not Settings.CSYNC.HyperRotation) and indicatorVisible("Rotation") then 
                hideIndicator("Rotation")
            elseif mode == "E = mc²" and Settings.CSYNC.HyperRotation then 
                if not indicatorVisible("Rotation") then showIndicator("Rotation") end 
                setIndicator("Rotation", not dual and "Swapped" or "Not Swapped")
            end 
        end 
        if mode == "E = mc²" then
            hrp.CFrame = Settings.CSYNC.QuantumInterpolation and lerpedhrp or (Settings.CSYNC.HyperRotation and (dual and desyncCFrame or reorientatehtb) or desyncCFrame)
            if htb and Settings.CSYNC.HitboxReorientation then
                htb.CFrame = Settings.CSYNC.QuantumInterpolation and lerpedhtb or (Settings.CSYNC.HyperRotation and (dual and reorientatehtb or desyncCFrame) or reorientatehtb)
            end
        else
            hrp.CFrame = desyncCFrame
            if htb and Settings.CSYNC.HitboxReorientation and mode == "E = mc²" then htb.CFrame = reorientatehtb end
        end

        RunService:BindToRenderStep("Restore", 199, function()
            hrp.CFrame = saved
            if htb and Settings.CSYNC.HitboxReorientation and mode == "E = mc²" then htb.CFrame = savedhtb end
            RunService:UnbindFromRenderStep("Restore")
        end)
    elseif not Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled then
        Settings.CSYNC.Enabled = false
        stoppedanim = true 
    end

    if Settings.VelocitySpoofer.MasterSwitch and Settings.VelocitySpoofer.Enabled then
        local desyncVelocity = Vector3.new(
            (math.random(0, 1) == 0 and -214721483648 or 214721483648),
            (math.random(0, 1) == 0 and -214721483648 or 214721483648),
            (math.random(0, 1) == 0 and -214721483648 or 214721483648)
        )

        local savedVelocity = hrp.AssemblyLinearVelocity
        hrp.AssemblyLinearVelocity = desyncVelocity

        if shouldShowVelIndicators and updateIndicators then
            setIndicator("Velocity", Vector3.new(math.round(desyncVelocity.X), math.round(desyncVelocity.Y), math.round(desyncVelocity.Z)))
        end

        RunService:BindToRenderStep("RestoreVelocity", 200, function()
            hrp.AssemblyLinearVelocity = savedVelocity
            RunService:UnbindFromRenderStep("RestoreVelocity")
        end)
    elseif not Settings.VelocitySpoofer.MasterSwitch and Settings.VelocitySpoofer.Enabled then
        Settings.VelocitySpoofer.Enabled = false
    end


    local T = Target
    local isSpectatingTarget = false
    if T and T.Parent then
        local targetPl = Players:GetPlayerFromCharacter(T.Parent)
        if targetPl and targetPl.Character and Camera.CameraSubject then
            if Camera.CameraSubject:IsDescendantOf(targetPl.Character) then
                isSpectatingTarget = true
            end
        end
    end

    if S.Enabled and S.Triangle and T and T:IsA("BasePart") and not isSpectatingTarget then
        triangle.Color = Library.AccentColor
        outline.Color = Library.OutlineColor
        local c = Camera.ViewportSize/2
        local vp, on = Camera:WorldToViewportPoint(T.Position)
        
        local screenDir
        if on then
            screenDir = Vector2.new(vp.X, vp.Y) - c
        else
            local localPos = Camera.CFrame:PointToObjectSpace(T.Position)
            local angle = math.atan2(localPos.X, localPos.Z)
            screenDir = Vector2.new(math.sin(angle), math.cos(angle)) * 100
        end

        if screenDir.Magnitude > 12 then
            local d2 = screenDir.Unit
            local base = d2*90+c
            local ang = math.atan2(d2.X,-d2.Y)
            local tip = base+Vector2.new(math.sin(ang),-math.cos(ang))*26
            local l = base+Vector2.new(math.sin(ang+math.rad(135)),-math.cos(ang+math.rad(135)))*22
            local r = base+Vector2.new(math.sin(ang-math.rad(135)),-math.cos(ang-math.rad(135)))*22
            outline.PointA,outline.PointB,outline.PointC=tip,l,r
            triangle.PointA,triangle.PointB,triangle.PointC=tip,l,r
            outline.Visible=true; triangle.Visible=true
        else
            outline.Visible=false; triangle.Visible=false
        end
    else
        outline.Visible=false; triangle.Visible=false
    end

    if S.TargetStats and T and T.Parent and T.Parent:FindFirstChildOfClass("Humanoid") then
        local hum2 = T.Parent:FindFirstChildOfClass("Humanoid")
        local pl = Players:GetPlayerFromCharacter(T.Parent)
        local hp, mh = hum2.Health, hum2.MaxHealth
        local ratio = 1
        if mh > 0 then
            local r = hp / mh
            if r == r and r ~= math.huge and r >= 0 then
                ratio = math.clamp(r, 0, 1)
            end
        end
        local currentScale = healthBarFill.Size.X.Scale
        if currentScale ~= currentScale then
            currentScale = 0
        end
        healthBarFill.Size = UDim2.new(lerp(currentScale, ratio, 0.15), 0, 1, 0)
        local hp_text = (hp == math.huge or hp ~= hp) and "inf" or tostring(math.round(hp))
        local mh_text = (mh == math.huge or mh ~= mh) and "inf" or tostring(math.round(mh))
        healthBarOverlay.Text = hp_text .. " / " .. mh_text
        local sh = 0
        local tBE = pl and (function()
            local cf = GameAdapter.GetCharactersFolder()
            local pf = cf and cf:FindFirstChild(pl.Name)
            return pf and pf:FindFirstChild("BodyEffects")
        end)()
        if tBE then
            local value = tBE:FindFirstChild("Armor")
            sh = value and value.Value or 0
        end
        local ms = 200
        local sh_ratio = 0
        if ms > 0 then
            local r = sh / ms
            if r == r and r ~= math.huge and r >= 0 then
                sh_ratio = math.clamp(r, 0, 1)
            end
        end
        local currentArmorScale = armorBarFill.Size.X.Scale
        if currentArmorScale ~= currentArmorScale then
            currentArmorScale = 0
        end
        armorBarFill.Size = UDim2.new(lerp(currentArmorScale, sh_ratio, 0.15), 0, 1, 0)
        local sh_text = (sh == math.huge or sh ~= sh) and "INF" or tostring(math.round(sh))
        armorBarOverlay.Text = sh_text .. " / " .. tostring(ms)
        local displayName = pl and pl.DisplayName or "Target"
        local country = pl and playerCountries[pl.Name]
        if country then
            local flag = getFlagEmoji(country)
            displayName = displayName .. " (" .. flag .. ")"
        end
        nameLabel.Text = displayName
        
        local weapon = "None"
        local tool = T.Parent:FindFirstChildOfClass("Tool")
        if tool then
            weapon = tool.Name
        end
        local formattedWeapon = (weapon:sub(1, 1) == "[" and weapon:sub(-1) == "]") and weapon or ("[" .. weapon .. "]")
        local targetHrp = T.Parent:FindFirstChild("HumanoidRootPart")
        local dist = 0
        if targetHrp then
            local origin = (Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled) and saved.Position or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position or Vector3.zero)
            dist = math.round((origin - targetHrp.Position).Magnitude)
        end
        extraLabel.Text = "Weapon: " .. formattedWeapon .. " | Dist: [" .. dist .. "m]"

        if pl then task.spawn(function()
            avatar.Image = Players:GetUserThumbnailAsync(pl.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)
            avatar.ImageTransparency = 0
        end) end
        frame.Visible = true
    else
        frame.Visible = false
    end
    if Settings and S and S.DArrow and not isSpectatingTarget then
    local target = Target
        if target and target:IsA("BasePart") and target:IsDescendantOf(workspace) then
            local color = Library.AccentColor
            local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if not head then arrow.Visible = false return end

            offset += direction * 0.25
            if offset > 6 then direction = -1 elseif offset < -6 then direction = 1 end

            local yOffset = 4 + offset / 10
            local targetPos = target.Position + Vector3.new(0, yOffset, 0)
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)

            if not onScreen then arrow.Visible = false return end
            if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled then 
                distance = (saved.Position - target.Position).Magnitude
            else 
                distance = (head.Position - target.Position).Magnitude
            end 

            if not onScreen then
                arrow.Visible = false
                return
            end

            local size = math.clamp(20 - distance * 0.1, 6, 20)

            local base = Vector2.new(screenPos.X, screenPos.Y)
            local tip = base + Vector2.new(0, size)
            local left = base + Vector2.new(-size * 0.6, -size * 0.6)
            local right = base + Vector2.new(size * 0.6, -size * 0.6)

            arrow.Color = color
            arrow.PointA = tip
            arrow.PointB = left
            arrow.PointC = right
            arrow.Visible = true
            return
        else
            arrow.Visible = false
        end
    else
        arrow.Visible = false
    end
end

local lastDuckCheck = 0
function updateDuck()
    local ST = Settings.Duck
    if not ST.Enabled then return end

    local duckM = ST.Mode
    -- Desync mode uses CSync reactMovement — only works when CSync is OFF
    if duckM == "Desync" then
        if not (Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled) then
            reactMovement("Desync")
        end
        return
    end

    -- Legit mode: works independently of CSync state
    local now = tick()
    if now - lastDuckCheck < 0.05 then return end
    lastDuckCheck = now

    local selfChar = LocalPlayer.Character
    if not selfChar then return end
    local hrp = selfChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Use real server-side position when desynced
    local selfPos = (Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled and saved) and saved.Position or hrp.Position

    local pFolder = GameAdapter.GetCharactersFolder()
    local radius = (duckM == "Legit") and 1.5 or 4

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local pChar = (pFolder and pFolder:FindFirstChild(player.Name)) or player.Character
        if not pChar then continue end

        local aimV = getAimingVectors(pChar)
        local tool = pChar:FindFirstChildOfClass("Tool")
        local handle = tool and tool:FindFirstChild("Handle")
        if not handle then continue end

        local origin = handle.Position

        for _, aimVec in ipairs(aimV) do
            local aimTarget = aimVec.Value
            local direction = aimTarget - origin
            local length = math.min(direction.Magnitude, 500)
            if length < 1 then continue end
            local unit = direction.Unit

            -- Check against all body parts using server-side position offset
            local posOffset = selfPos - hrp.Position
            for _, partName in ipairs(bodyParts) do
                local bp = hrp.Parent:FindFirstChild(partName)
                if bp then
                    local checkPos = bp.Position + posOffset
                    local proj = (checkPos - origin):Dot(unit)
                    if proj >= 0 and proj <= length then
                        local closestPoint = origin + unit * proj
                        if (closestPoint - checkPos).Magnitude <= radius then
                            reactMovement(duckM, origin, unit)
                            return
                        end
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.05)
        if not getgenv().loaded then break end
        local char = LocalPlayer.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end
        local M = Settings.Movement
        if M.JumpPower.Enabled then
            if hum.JumpPower ~= M.JumpPower.Value then
                hum.JumpPower = M.JumpPower.Value
            end
        end
        if M.WalkSpeed.Enabled then
            if hum.WalkSpeed ~= M.WalkSpeed.Value then
                hum.WalkSpeed = M.WalkSpeed.Value
            end
        end
    end
end)


local lp = game:GetService("Players").LocalPlayer
local old_newindex
old_newindex = hookmetamethod(game, "__newindex", newcclosure(function(self, key, value)
    if key == "JumpPower" or key == "WalkSpeed" then
        local char = lp.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and self == humanoid then
                if key == "JumpPower" then
                    if Settings.Movement.JumpPower.Enabled then
                        return old_newindex(self, key, Settings.Movement.JumpPower.Value)
                    end
                    if value == 0 and Settings.Movement.NoJumpCooldown then
                        return
                    end
                elseif key == "WalkSpeed" then
                    if Settings.Movement.WalkSpeed.Enabled then
                        return old_newindex(self, key, Settings.Movement.WalkSpeed.Value)
                    end
                end
            end
        end
    end
    return old_newindex(self, key, value)
end))

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local methodL = method:lower()

    if self == LocalPlayer and methodL == "kick" then
        return
    end
    if methodL == "fireserver" or methodL == "invokeserver" then
        local sName = typeof(self) == "Instance" and self.Name or nil
        if sName and (sName:lower():find("checker") or sName:lower():find("detection")) then
            return
        end
        local passArgs = {...}
        for _, arg in ipairs(passArgs) do
            if type(arg) == "string" and (arg:lower():find("checker") or arg:lower():find("detection")) then
                return
            end
        end
    end

    local args = table.pack(...)


    if method == "FireServer" and typeof(self) == "Instance" then
        local eventName = tostring(args[1])
        local target = Target
        local S = Settings.SilentAim

        if eventName == GameAdapter.ShootEventName then
            local handle = args[2]
            local tool = handle and handle.Parent
            if tool and typeof(args[4]) == "table" then
                shotgunTools[tool] = true
            end
            if getgenv().CSYNC_Shooting then
                return
            end
            local GM = Settings.Extra.GunMod
            local activeTarget = target
            local _noSilent = false -- silent aim enabled for all approved games
            local origin = args[3]
            if typeof(origin) ~= "Vector3" then
                return oldNamecall(self, ...)
            end
            local range = args[8] or 250

            if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled and saved then
                origin = saved.Position + Vector3.new(0, 1.5, 0)
                args[3] = origin
            end

            local function simulateShoot(shootOrigin, AimPosition)
                local Unit = (AimPosition - shootOrigin).Unit
                local v6 = RaycastParams.new()
                local t_filter = {}
                local ok, Ignored = pcall(function() return require(ReplicatedStorage.MainModule).Ignored end)
                t_filter[1] = LocalPlayer.Character
                if ok and Ignored then t_filter[2] = unpack(Ignored) end
                v6.FilterDescendantsInstances = t_filter
                v6.FilterType = Enum.RaycastFilterType.Exclude
                v6.IgnoreWater = true
                local v10 = workspace.Raycast(workspace, shootOrigin, Unit * range, v6)
                if v10 then
                    return v10.Instance, v10.Position, v10.Normal
                else
                    return nil, shootOrigin + Unit * range, nil
                end
            end

            if S.Enabled and not _noSilent and activeTarget and activeTarget.Parent then
                if S.Checks.NotTargetIf["Behind Wall"] and not S.BulletTP then
                    local savedOrigin = (Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled and saved) and (savedGunHandlePos or (saved.Position + Vector3.new(0, 1.5, 0))) or origin
                    local hitPart, hitPos, hitNormal = simulateShoot(savedOrigin, activeTarget.Position)
                    if hitPart and not hitPart:IsDescendantOf(activeTarget.Parent) then
                        activeTarget = nil
                    end
                end
            end

            local posIndex = 5
            local partIndex = 6
            local normalIndex = 7

            local targetPos = (S.Enabled and not _noSilent) and activeTarget and activeTarget.Parent and activeTarget.Position or args[posIndex]
            if typeof(targetPos) ~= "Vector3" then
                targetPos = origin
            end
            local hitTarget = (S.Enabled and not _noSilent) and activeTarget and activeTarget.Parent and activeTarget or args[partIndex]

            if S.Enabled and not _noSilent and activeTarget and activeTarget.Parent then
                if GM.NoDropoff then
                    args[3] = targetPos
                elseif S.BulletTP then
                    local off = S.BulletTPOffset or 3
                    args[3] = targetPos + Vector3.new(0, off, 0)
                end
            end

            if GM.RangeEnabled then
                args[8] = GM.Range
            end

            local shouldMultiply = false
            if GM.PelletMultiplierEnabled then
                if GM.PelletMultiplierMode == "Always" then
                    shouldMultiply = true
                elseif GM.PelletMultiplierMode == "Only when targeted" and activeTarget and activeTarget.Parent then
                    shouldMultiply = true
                end
            end

            if shouldMultiply then
                if targetPos then
                    local mult = GM.PelletMultiplier or 5
                    local newPellets = {}
                    if typeof(args[4]) == "table" then
                        for _, pellet in ipairs(args[4]) do
                            for j = 1, mult do
                                table.insert(newPellets, {
                                    Result1 = targetPos,
                                    Result2 = hitTarget,
                                    AimPosition = targetPos,
                                    Result3 = Vector3.new(0, 1, 0)
                                })
                            end
                        end
                    else
                        for i = 1, mult do
                            table.insert(newPellets, {
                                Result1 = targetPos,
                                Result2 = hitTarget,
                                AimPosition = targetPos,
                                Result3 = Vector3.new(0, 1, 0)
                            })
                        end
                    end
                    args[4] = newPellets
                    args[5] = nil
                    args[6] = nil
                    args[7] = nil
                else
                    -- single-shot gun: multiply via repeated FireServer calls
                    local origArgs = table.clone and table.clone(args) or {}
                    if not table.clone then for k,v in pairs(args) do origArgs[k]=v end end
                    local mult2 = GM.PelletMultiplier or 5
                    origArgs[5] = targetPos
                    origArgs[6] = hitTarget
                    origArgs[7] = Vector3.new(0,1,0)
                    for _i = 2, mult2 do
                        pcall(function() self:FireServer(table.unpack(origArgs, 1, origArgs.n or 9)) end)
                    end
                    args[5] = targetPos
                    args[6] = hitTarget
                    args[7] = Vector3.new(0,1,0)
                end
            else
                if typeof(args[4]) == "table" then
                    if S.Enabled and activeTarget and activeTarget.Parent then
                        for _, pellet in ipairs(args[4]) do
                            pellet.Result1 = targetPos
                            pellet.Result2 = hitTarget
                            pellet.AimPosition = targetPos
                            pellet.Result3 = Vector3.new(0, 1, 0)
                        end
                    end
                else
                    if S.Enabled and not _noSilent and activeTarget and activeTarget.Parent then
                        args[posIndex] = targetPos
                        args[partIndex] = hitTarget
                        args[normalIndex] = Vector3.new(0, 1, 0)
                        -- Zee: patch aimPos arg (arg[10]) so server AimLock also points at target
                        if GameAdapter.AimPosArgIndex and typeof(args[GameAdapter.AimPosArgIndex]) == "Vector3" then
                            args[GameAdapter.AimPosArgIndex] = targetPos
                        end
                    end
                end
            end

            local _pelletOrPart = typeof(args[4]) == "table" and args[4] or hitTarget
            checkAndPlayHitSound(_pelletOrPart, origin, targetPos)



            setnamecallmethod(method)
            local result = oldNamecall(self, table.unpack(args, 1, args.n))



            return result
        end

        if eventName:find(GameAdapter.MousePosEventName, 1, true) then
            local activeTarget = target
            if S.Enabled and activeTarget and activeTarget.Parent then
                args[2] = activeTarget.Position
            end
            setnamecallmethod(method)
            return oldNamecall(self, table.unpack(args, 1, args.n))
        end
    end

    setnamecallmethod(method)
    return oldNamecall(self, ...)
end))

task.spawn(function()
    local rf = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction", 10)
    if not rf then print("no rf 1") end 
    local rf2 = rf and rf:WaitForChild("RemoteFunction", 10)
    if not rf2 then print("no rf2 1") end 
    if rf2 then
        local oldCallback
        local function hookCallback(self, callback)
            oldCallback = callback
            return function(p1, ...)
                local S = Settings.SilentAim
                local activeTarget = Target

                if S.Enabled and activeTarget and activeTarget.Parent then
                    if p1 == "MOUSEPOS" then
                        return activeTarget.Position
                    elseif p1 == "Aim" then
                        local args = {...}
                        local origin = args[1]
                        if origin then
                            return (activeTarget.Position - origin).Unit
                        end
                    end
                end
                if oldCallback then
                    return oldCallback(p1, ...)
                end
            end
        end

        pcall(function()
            local raw_newindex
            raw_newindex = hookmetamethod(game, "__newindex", function(self, key, value)
                if self == rf2 and key == "OnClientInvoke" and typeof(value) == "function" then
                    return raw_newindex(self, key, hookCallback(self, value))
                end
                return raw_newindex(self, key, value)
            end)
        end)
    end
end)




local Window = Library:CreateWindow({
    Title = 'E = mc²',
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(380, 220)
})

Window.TabArea.Visible = false
Window.TabContainer.Position = UDim2.new(0, 8, 0, 4)
Window.TabContainer.Size = UDim2.new(1, -16, 1, -12)

local loaderFinished = false
Library.AllowToggle = false
local loadVisualsValue = false

local LoaderGroup = Window:AddTab('__Loader'):AddLeftGroupbox('Options')

local VisualsLoadOptions = { 'ESP', 'Sounds', 'LocalPlayer', 'World' }
getgenv().LoadedVisualFeatures = {
    ESP = true, Sounds = true, LocalPlayer = true, World = true
}

pcall(function()
    local HttpService = game:GetService("HttpService")
    if isfile and isfile("Skibidinos/configs/settings/autosave.json") then
        local data = HttpService:JSONDecode(readfile("Skibidinos/configs/settings/autosave.json"))
        if data and data.objects then
            for _, obj in ipairs(data.objects) do
                if type(obj) == "table" and obj.idx == "LOADER_VISUALS_TG" and obj.value ~= nil then
                    loadVisualsValue = obj.value
                elseif type(obj) == "table" and obj.idx == "LOADER_VISUALS_OPTIONS" and type(obj.value) == "table" then
                    for k, v in pairs(obj.value) do
                        getgenv().LoadedVisualFeatures[k] = v
                    end
                end
            end
        end
    end
end)

local LOADER_VISUALS_TG = LoaderGroup:AddToggle('LOADER_VISUALS_TG', {
    Text = 'Load Visuals',
    Default = loadVisualsValue,
    Callback = function(v)
        loadVisualsValue = v
    end
})

local LoaderVisualsDepBox = LoaderGroup:AddDependencyBox()

local VisualsDropdown = LoaderVisualsDepBox:AddDropdown('LOADER_VISUALS_OPTIONS', {
    Values = VisualsLoadOptions,
    Default = 1,
    Multi = true,
    Text = 'Visuals to Load',
    Callback = function(v)
        for k, _ in pairs(getgenv().LoadedVisualFeatures) do
            getgenv().LoadedVisualFeatures[k] = v[k] or false
        end
    end
})
VisualsDropdown:SetValue(getgenv().LoadedVisualFeatures)

LoaderVisualsDepBox:SetupDependencies({
    { LOADER_VISUALS_TG, true }
})

LoaderGroup:AddButton('Launch', function()
    if loaderFinished then return end
    loaderFinished = true
    initTick = tick()
    Library.AllowToggle = true
    getgenv().LoadVisuals = loadVisualsValue

    for _, child in ipairs(Window.TabArea:GetChildren()) do
        if child:IsA('UIListLayout') then continue end
        child:Destroy()
    end
    for _, child in ipairs(Window.TabContainer:GetChildren()) do
        if child:IsA('VideoFrame') or child:IsA('ImageLabel') then continue end
        child:Destroy()
    end

    Window.Holder.Size = UDim2.fromOffset(550, 600)
    Window.TabArea.Visible = true
    Window.TabContainer.Position = UDim2.new(0, 8, 0, 30)
    Window.TabContainer.Size = UDim2.new(1, -16, 1, -38)

    local _noopStub
    _noopStub = setmetatable({}, {
        __index = function() return function() return _noopStub end end
    })

    local Tabs = {
        Main = Window:AddTab('Main'),
        Misc = Window:AddTab('Misc'),
        Exploits = Window:AddTab('Exploits'),
        Visuals = Window:AddTab('Visuals'),
        Extras = Window:AddTab('Extras'),
        ['UI Settings'] = Window:AddTab('UI Settings'),
        Talking = Window:AddTab('Talking')
    }
    getgenv().AZTabs = Tabs


;(function()
local SilentAimBox = Tabs.Main:AddLeftTabbox('Silent Aim')

local SilentAimBx = SilentAimBox:AddTab('Silent Aim')
local FOVBox = SilentAimBox:AddTab('FOV')
local VisualisationBox = SilentAimBox:AddTab('Visualize')

local SilentToggle = SilentAimBx:AddToggle('SilentToggle', {
    Text = 'Enabled',
    Default = Settings.SilentAim.Enabled,
    Callback = function(v)
        Settings.SilentAim.Enabled = v
    end
})

local SilentBind = SilentToggle:AddKeyPicker('SilentBind', {
    Default = Settings.SilentAim.Bind,
    Mode = 'Toggle',
    Text = 'Silent Aim',
    NoUI = false,
    Callback = function()
        Settings.SilentAim.Bind = Library.Options.SilentBind.Value
    end
})

local TPToTargetToggle = SilentAimBx:AddToggle('TPToTargetToggle', {
    Text = 'TP to Target',
    Default = false,
})

local tpToTargetConn
TPToTargetToggle:OnChanged(function(v)
    if tpToTargetConn then tpToTargetConn:Disconnect(); tpToTargetConn = nil end
    if v then
        tpToTargetConn = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local tpBind = Library.Options.TPToTargetBind
                if tpBind and input.KeyCode.Name == tpBind.Value then
                    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local targetRoot = TargetPlayer.Character.HumanoidRootPart
                            pcall(function()
                            if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled then 
                                savedhtb = targetRoot.CFrame * CFrame.new(0, 0, 4)
                            else 
                                LocalPlayer.Character.HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 4)
                            end 
                            end)
                        end
                    end
                end
            end
        end)
    end
end)

TPToTargetToggle:AddKeyPicker('TPToTargetBind', {
    Default = 'N',
    Mode = 'Hold',
    Text = 'TP to Target',
    NoUI = false
})

local HitDropdown = SilentAimBx:AddDropdown('HitPart', {
    Values = { "Head", "HumanoidRootPart", "UpperTorso", "Server Pos" },
    Default = Settings.SilentAim.HitPart,
    Text = "Hit Part",
    Callback = function(v)
        Settings.SilentAim.HitPart = (v == "Server Pos") and "Hitbox" or v
    end
})


local Manualtargettbx = SilentAimBx:AddInput('ManualTarget', {
    Default = Settings.SilentAim.ManualTarget,
    Numeric = false,
    Finished = true,
    Text = "Manual Target",
    Placeholder = "Target's user",
    Callback = function(v)
        Settings.SilentAim.ManualTarget = v
        findManualTarget()
    end
})

SilentAimBx:AddButton({
    Text = 'Target Self',
    Func = function()
        Target = LocalPlayer.Character:FindFirstChild(Settings.SilentAim.HitPart)
        TargetPlayer = LocalPlayer
    end
})

local HighlightToggle = VisualisationBox:AddToggle('HighlightEnabled', {
    Text = 'Highlight',
    Default = Settings.Highlight.Enabled,
    Callback = function(v)
        Settings.Highlight.Enabled = v
    end
})

local FillColor = HighlightToggle:AddColorPicker('FillColor', {
    Default = Settings.Highlight.FillColor,
    Title = 'Fill Color',
    Callback = function(Value)
        Settings.Highlight.FillColor = Value
    end
})

local OutlineColor = HighlightToggle:AddColorPicker('OutlineColor', {
    Default = Settings.Highlight.OutlineColor,
    Title = 'Outline Color',
    Callback = function(Value)
        Settings.Highlight.OutlineColor = Value
    end
})

local AimViewToggle = VisualisationBox:AddToggle('AimViewEnabled', {
    Text = 'Aim View (Dot & Line)',
    Default = Settings.SilentAim.AimView.Enabled,
    Callback = function(v)
        Settings.SilentAim.AimView.Enabled = v
    end
})
local AimViewLineToggle = VisualisationBox:AddToggle('AimViewLineEnabled', {
    Text = 'Aim View Line',
    Default = Settings.SilentAim.AimView.ShowLine,
    Callback = function(v)
        Settings.SilentAim.AimView.ShowLine = v
    end
})
local AimViewColor = AimViewToggle:AddColorPicker('AimViewColor', {
    Default = Settings.SilentAim.AimView.Color,
    Title = 'Aim View Color',
    Callback = function(v)
        Settings.SilentAim.AimView.Color = v
    end
})

local TargetStatsTG = VisualisationBox:AddToggle('TargetStatsTGEnabled', {
    Text = 'Stats',
    Default = Settings.SilentAim.TargetStats,
    Callback = function(v)
        Settings.SilentAim.TargetStats = v
    end
})

local NotifyTGG = VisualisationBox:AddToggle('NotifyTGEnabled', {
    Text = 'Notify',
    Default = Settings.SilentAim.Notify,
    Callback = function(v)
        Settings.SilentAim.Notify = v
    end
})

local ArrowTG = VisualisationBox:AddToggle('ArrowTGEnabled', {
    Text = 'Arrow',
    Default = Settings.SilentAim.Triangle,
    Callback = function(v)
        Settings.SilentAim.Triangle = v
    end
})

local DARROWTG = VisualisationBox:AddToggle('3DARROWTG', {
    Text = '3D Arrow',
    Default = Settings.SilentAim.DArrow,
    Callback = function(v)
        Settings.SilentAim.DArrow = v
    end
})

local SpectateTG = VisualisationBox:AddToggle('SpectateTGEnabled', {
    Text = 'Spectate',
    Default = Settings.SilentAim.Spectate,
    Callback = function(v)
        Settings.SilentAim.Spectate = v
    end
})
SpectateTG:AddKeyPicker('SpectateBind', {
    Default = 'V',
    Mode = 'Toggle',
    Text = 'Spectate',
    NoUI = false,
})

local FOVEnabled = FOVBox:AddToggle('FOVEnabled', {
    Text = 'Use Fov',
    Default = Settings.FieldOfView.UseFov,
    Callback = function(v)
        Settings.FieldOfView.UseFov = v
    end
})

local FOVToggle = FOVBox:AddToggle('FOVVisible', {
    Text = 'Visible',
    Default = Settings.FieldOfView.Visible,
    Callback = function(v)
        Settings.FieldOfView.Visible = v
    end
})

local FOVColor = FOVToggle:AddColorPicker('FOVColor', {
    Default = Settings.FieldOfView.Color,
    Title = 'FOV Color',
    Callback = function(Value)
        Settings.FieldOfView.Color = Value
    end
})

local FOVRadiusDep = FOVBox:AddDependencyBox()
local FOVVisibleDep = FOVBox:AddDependencyBox()

local FOVFilled = FOVVisibleDep:AddToggle('FOVFilled', {
    Text = 'Filled',
    Default = Settings.FieldOfView.Filled,
    Callback = function(v)
        Settings.FieldOfView.Filled = v
    end
})

local FOVRadius = FOVRadiusDep:AddSlider('FOVRadius', {
    Text = 'FOV Radius',
    Min = 0,
    Max = 500,
    Default = Settings.FieldOfView.Radius,
    Rounding = 0,
    Callback = function(v)
        Settings.FieldOfView.Radius = v
    end
})

local FOVTransparency = FOVVisibleDep:AddSlider('FOVTransparency', {
    Text = 'Transparency',
    Min = 0,
    Max = 1,
    Default = Settings.FieldOfView.Transparency,
    Rounding = 2,
    Callback = function(v)
        Settings.FieldOfView.Transparency = v
    end
})

local FOVThickness = FOVVisibleDep:AddSlider('FOVThickness', {
    Text = 'Thickness',
    Min = 1,
    Max = 5,
    Default = Settings.FieldOfView.Thickness,
    Rounding = 1,
    Callback = function(v)
        Settings.FieldOfView.Thickness = v
    end
})

FOVVisibleDep:SetupDependencies({
    { FOVToggle, true }
})

FOVRadiusDep:SetupDependencies({
    { function() return FOVEnabled.Value or FOVToggle.Value end, true }
})
end)()

local ChecksBox = Tabs.Main:AddRightGroupbox('Checks')

-- L/J Notifier
local LJNotifierEnabled = false
local _ljNotifyConns = {}
ChecksBox:AddToggle('LJNotifierToggle', {
    Text = 'L/J Notifier',
    Default = false,
    Callback = function(v)
        LJNotifierEnabled = v
        -- cleanup old connections
        for _, c in ipairs(_ljNotifyConns) do pcall(function() c:Disconnect() end) end
        _ljNotifyConns = {}
        if v then
            table.insert(_ljNotifyConns, Players.PlayerAdded:Connect(function(p)
                if LJNotifierEnabled then
                    task.wait(0.1) -- wait for DisplayName to load
                    notify(p.DisplayName .. " (" .. p.Name .. ") joined", 4)
                end
            end))
            table.insert(_ljNotifyConns, Players.PlayerRemoving:Connect(function(p)
                if LJNotifierEnabled then
                    notify(p.DisplayName .. " (" .. p.Name .. ") left", 4)
                end
            end))
        end
    end
})

getgenv().DmgNotifierEnabled = false
ChecksBox:AddToggle('DmgNotifierToggle', {
    Text = 'Damage Notifier',
    Default = false,
    Callback = function(v)
        getgenv().DmgNotifierEnabled = v
    end
})

local MovementBox = Tabs.Misc:AddLeftGroupbox('Movement')
local StateBox = Tabs.Misc:AddLeftCollapsibleGroupbox('State Spoofer')
local CSYNCBOX = GameAdapter.Capabilities.HasCSYNC and Tabs.Misc:AddRightGroupbox('C-Sync') or nil
local VELOCITYSPOOFERBOX = Tabs.Misc:AddRightGroupbox('Velocity Spoofer')
local GunModBox = GameAdapter.Capabilities.HasGunHandler and Tabs.Exploits:AddRightGroupbox('Gun Modifications') or nil
local ExploitsBox = Tabs.Exploits:AddLeftGroupbox('Exploits')
local AutoDuckBox = Tabs.Misc:AddLeftCollapsibleGroupbox('Auto Duck')
local AFKBox = nil -- Fake AFK removed

local ExtrasLeftBox  = Tabs.Extras:AddLeftGroupbox('Scripts & Features')
local ExtrasRightBox = Tabs.Extras:AddRightGroupbox('Chat & Voice')

;(function()
local FreecamTG = ExtrasLeftBox:AddToggle('FreecamToggle', {
    Text = 'Freecam',
    Default = Settings.Extra.ExtrasFeatures.Freecam.Enabled,
    Callback = function(v)
        Settings.Extra.ExtrasFeatures.Freecam.Enabled = v
        getgenv()._AZFreecamActive = v
        if v then
            notify("Freecam ON — RMB to rotate, WASD to move", 3)
            task.spawn(function()
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local cam = workspace.CurrentCamera
                local UIS = game:GetService("UserInputService")
                local RS  = game:GetService("RunService")
                local keysDown = {}
                local rotating = false
                local speed = Settings.Extra.ExtrasFeatures.Freecam.Speed
                local sens  = 0.3
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if humanoid then
                    humanoid.PlatformStand = true
                end
                if hrp then
                    hrp.Anchored = true
                end
                cam.CameraType = Enum.CameraType.Scriptable
                local pitch, yaw = 0, 0
                local rx, ry, rz = cam.CFrame:ToEulerAnglesYXZ()
                pitch, yaw = rx, ry
                local conn = RS.RenderStepped:Connect(function()
                    if not getgenv()._AZFreecamActive then return end
                    speed = Settings.Extra.ExtrasFeatures.Freecam.Speed
                    if rotating then
                        local delta = UIS:GetMouseDelta()
                        pitch = math.clamp(pitch - math.rad(delta.Y * sens), -math.rad(89), math.rad(89))
                        yaw = yaw - math.rad(delta.X * sens)
                        UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
                    else
                        UIS.MouseBehavior = Enum.MouseBehavior.Default
                    end
                    cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
                    if keysDown[Enum.KeyCode.W] then cam.CFrame *= CFrame.new(0,0,-speed) end
                    if keysDown[Enum.KeyCode.S] then cam.CFrame *= CFrame.new(0,0, speed) end
                    if keysDown[Enum.KeyCode.A] then cam.CFrame *= CFrame.new(-speed,0,0) end
                    if keysDown[Enum.KeyCode.D] then cam.CFrame *= CFrame.new( speed,0,0) end
                end)
                UIS.InputBegan:Connect(function(i, gp) if gp then return end
                    if i.UserInputType == Enum.UserInputType.MouseButton2 then rotating = true end
                    keysDown[i.KeyCode] = true
                end)
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton2 then rotating = false end
                    keysDown[i.KeyCode] = false
                end)
                repeat task.wait(0.1) until not getgenv()._AZFreecamActive
                conn:Disconnect()
                pcall(function()
                    if humanoid then humanoid.PlatformStand = false end
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Anchored = false end
                    cam.CameraType = Enum.CameraType.Custom
                    UIS.MouseBehavior = Enum.MouseBehavior.Default
                end)
            end)
        else
            notify("Freecam OFF", 2)
        end
    end
})
FreecamTG:AddKeyPicker('FreecamBind', {
    Default = Settings.Extra.ExtrasFeatures.Freecam.Keybind,
    Mode = 'Toggle',
    Text = 'Freecam',
    NoUI = false
})
ExtrasLeftBox:AddSlider('FreecamSpeed', {
    Text = 'Freecam Speed',
    Default = Settings.Extra.ExtrasFeatures.Freecam.Speed,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Callback = function(v)
        Settings.Extra.ExtrasFeatures.Freecam.Speed = v
    end
})

local AntiAllTG = ExtrasLeftBox:AddToggle('AntiAllToggle', {
    Text = 'Anti-All (anti-void/fling)',
    Default = Settings.Extra.ExtrasFeatures.AntiAll.Enabled,
    Callback = function(v)
        Settings.Extra.ExtrasFeatures.AntiAll.Enabled = v
        getgenv()._AZAntiAllActive = v
        if v then
            notify("Anti-All ON", 2)
            workspace.FallenPartsDestroyHeight = -math.huge
            task.spawn(function()
                while getgenv()._AZAntiAllActive and task.wait(0.05) do
                    pcall(function()
                        local lp = game.Players.LocalPlayer
                        local char = lp.Character
                        if not char then return end
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hrp.Position.Y < -50 then
                            local savedPos = hrp.CFrame
                            workspace.Camera.CameraType = Enum.CameraType.Fixed
                            hrp.CFrame = savedPos + Vector3.new(0,-1e3,0)
                            task.wait(0.1)
                            hrp.CFrame = savedPos
                            workspace.Camera.CameraType = Enum.CameraType.Custom
                        end
                    end)
                end
            end)
        else
            workspace.FallenPartsDestroyHeight = -1e4
            notify("Anti-All OFF", 2)
        end
    end
})
AntiAllTG:AddKeyPicker('AntiAllBind', {
    Default = Settings.Extra.ExtrasFeatures.AntiAll.Keybind,
    Mode = 'Toggle',
    Text = 'Anti-All',
    NoUI = false
})

local EmotesTG = ExtrasLeftBox:AddToggle('EmotesToggle', {
    Text = 'Emotes UI',
    Default = Settings.Extra.ExtrasFeatures.Emotes.Enabled,
    Callback = function(v)
        Settings.Extra.ExtrasFeatures.Emotes.Enabled = v
        if getgenv()._AZEmotesGui then
            getgenv()._AZEmotesGui.Enabled = v
        elseif v then
            getgenv()._AZEmotesLoaded = true
            task.spawn(function()
                local IsStudio = false
                local ContextActionService = game:GetService("ContextActionService")
                local HttpService = game:GetService("HttpService")
                local GuiService = game:GetService("GuiService")
                local CoreGui2 = game:GetService("CoreGui")
                local AvatarEditorService = game:GetService("AvatarEditorService")
                local Players2 = game:GetService("Players")
                local StarterGui2 = game:GetService("StarterGui")
                local UserInputService2 = game:GetService("UserInputService")
                local LocalPlayer2 = Players2.LocalPlayer
                local Emotes2 = {}
                local function AddEmote2(name,id,price)
                    if not(name and id) then return end
                    table.insert(Emotes2,{name=name,id=id,icon="rbxthumb://type=Asset&id="..id.."&w=150&h=150",price=price or 0,index=#Emotes2+1,sort={}})
                end
                local CurrentSort2="newestfirst"
                local FavoriteOff2="rbxassetid://10651060677"
                local FavoriteOn2="rbxassetid://10651061109"
                local FavoritedEmotes2={}
                local ScreenGui2=Instance.new("ScreenGui")
                ScreenGui2.Name="AZEmotes"
                ScreenGui2.DisplayOrder=2
                ScreenGui2.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
                ScreenGui2.ResetOnSpawn=false
                ScreenGui2.Enabled=true
                getgenv()._AZEmotesGui = ScreenGui2
                local BackFrame2=Instance.new("Frame")
                BackFrame2.Size=UDim2.new(0.8,0,0.45,0)
                BackFrame2.AnchorPoint=Vector2.new(0.5,0.5)
                BackFrame2.Position=UDim2.new(0.5,0,0.5,0)
                BackFrame2.SizeConstraint=Enum.SizeConstraint.RelativeYY
                BackFrame2.BackgroundTransparency=1
                BackFrame2.BorderSizePixel=0
                BackFrame2.Parent=ScreenGui2
                local Corner2=Instance.new("UICorner")
                Corner2.CornerRadius=UDim.new(0.1,0)
                local EmoteName2=Instance.new("TextLabel")
                EmoteName2.Name="EmoteName"
                EmoteName2.TextScaled=true
                EmoteName2.AnchorPoint=Vector2.new(0.5,0.5)
                EmoteName2.Position=UDim2.new(-0.1,0,0.5,0)
                EmoteName2.Size=UDim2.new(0.18,0,0.18,0)
                EmoteName2.SizeConstraint=Enum.SizeConstraint.RelativeYY
                EmoteName2.BackgroundColor3=Color3.fromRGB(30,30,30)
                EmoteName2.TextColor3=Color3.new(1,1,1)
                EmoteName2.BorderSizePixel=0
                EmoteName2.Parent=BackFrame2
                Corner2:Clone().Parent=EmoteName2
                local Frame2=Instance.new("ScrollingFrame")
                Frame2.Size=UDim2.new(1,0,1,0)
                Frame2.CanvasSize=UDim2.new(0,0,0,0)
                Frame2.AutomaticCanvasSize=Enum.AutomaticSize.Y
                Frame2.ScrollingDirection=Enum.ScrollingDirection.Y
                Frame2.AnchorPoint=Vector2.new(0.5,0.5)
                Frame2.Position=UDim2.new(0.5,0,0.5,0)
                Frame2.BackgroundTransparency=1
                Frame2.ScrollBarThickness=4
                Frame2.BorderSizePixel=0
                Frame2.Parent=BackFrame2
                local Grid2=Instance.new("UIGridLayout")
                Grid2.CellSize=UDim2.new(0.1,0,0,0)
                Grid2.CellPadding=UDim2.new(0.006,0,0.006,0)
                Grid2.SortOrder=Enum.SortOrder.LayoutOrder
                Grid2.Parent=Frame2
                local CloseButton2=Instance.new("TextButton")
                CloseButton2.BorderSizePixel=0
                CloseButton2.AnchorPoint=Vector2.new(0.5,0.5)
                CloseButton2.Position=UDim2.new(0.075,0,-0.075,0)
                CloseButton2.Size=UDim2.new(0.15,0,0.1,0)
                CloseButton2.TextScaled=true
                CloseButton2.TextColor3=Color3.new(1,1,1)
                CloseButton2.BackgroundColor3=Color3.new(0,0,0)
                CloseButton2.BackgroundTransparency=0.3
                CloseButton2.Text="Close"
                CloseButton2.MouseButton1Click:Connect(function() 
                    Settings.Extra.ExtrasFeatures.Emotes.Enabled = false
                    if Library.Toggles.EmotesToggle then Library.Toggles.EmotesToggle:SetValue(false) end
                end)
                Corner2:Clone().Parent=CloseButton2
                CloseButton2.Parent=BackFrame2
                local function HumanoidPlayEmote2(hum,name,id)
                    return hum:PlayEmoteAndGetAnimTrackById(id)
                end
                local function PlayEmote2(name,id)
                    local Humanoid2=LocalPlayer2.Character:FindFirstChildOfClass("Humanoid")
                    local Description2=Humanoid2 and Humanoid2:FindFirstChildOfClass("HumanoidDescription")
                    if not Description2 then return end
                    if LocalPlayer2.Character.Humanoid.RigType~=Enum.HumanoidRigType.R6 then
                        local s,e=pcall(function() HumanoidPlayEmote2(Humanoid2,name,id) end)
                        if not s then Description2:AddEmote(name,id) HumanoidPlayEmote2(Humanoid2,name,id) end
                    end
                end
                local params2=CatalogSearchParams.new()
                params2.AssetTypes={Enum.AvatarAssetType.EmoteAnimation}
                params2.SortType=Enum.CatalogSortType.RecentlyCreated
                params2.SortAggregation=Enum.CatalogSortAggregation.AllTime
                params2.IncludeOffSale=true
                params2.CreatorName="Roblox"
                params2.Limit=120
                local function getCatalogPage2()
                    local s,p=pcall(function() return AvatarEditorService:SearchCatalog(params2) end)
                    if not s then task.wait(5) return getCatalogPage2() end
                    return p
                end
                local catalogPage2=getCatalogPage2()
                local pages2={}
                while true do
                    local cp=catalogPage2:GetCurrentPage()
                    table.insert(pages2,cp)
                    if catalogPage2.IsFinished then break end
                    local function Adv() local s=pcall(function() catalogPage2:AdvanceToNextPageAsync() end) if not s then task.wait(5) Adv() end end
                    Adv()
                end
                for _,page in pairs(pages2) do for _,emote in pairs(page) do AddEmote2(emote.Name,emote.Id,emote.Price) end end
                AddEmote2("Arm Wave",5915773155) AddEmote2("Head Banging",5915779725) AddEmote2("Face Calisthenics",9830731012)
                table.sort(Emotes2,function(a,b) return a.index<b.index end)
                for i,v in pairs(Emotes2) do v.sort.newestfirst=i end
                local function CharacterAdded2(Character2)
                    for i,v in pairs(Frame2:GetChildren()) do if not v:IsA("UIGridLayout") then v:Destroy() end end
                    local Humanoid2=Character2:WaitForChild("Humanoid",5)
                    local Description2=Humanoid2 and (Humanoid2:WaitForChild("HumanoidDescription",5) or Instance.new("HumanoidDescription",Humanoid2))
                    for i,Emote2 in pairs(Emotes2) do
                        if Description2 then Description2:AddEmote(Emote2.name,Emote2.id) end
                        local EmoteButton2=Instance.new("ImageButton")
                        EmoteButton2.LayoutOrder=i
                        EmoteButton2.Name=tostring(Emote2.id)
                        Corner2:Clone().Parent=EmoteButton2
                        EmoteButton2.Image=Emote2.icon
                        EmoteButton2.BackgroundTransparency=0.5
                        EmoteButton2.BackgroundColor3=Color3.new(0,0,0)
                        EmoteButton2.BorderSizePixel=0
                        local Ratio2=Instance.new("UIAspectRatioConstraint")
                        Ratio2.AspectType=Enum.AspectType.ScaleWithParentSize
                        Ratio2.Parent=EmoteButton2
                        EmoteButton2.Parent=Frame2
                        EmoteButton2.MouseButton1Click:Connect(function() PlayEmote2(Emote2.name,Emote2.id) end)
                        EmoteButton2.MouseEnter:Connect(function() EmoteName2.Text=Emote2.name end)
                    end
                end
                ScreenGui2.Parent=CoreGui2
                if LocalPlayer2.Character then CharacterAdded2(LocalPlayer2.Character) end
                LocalPlayer2.CharacterAdded:Connect(CharacterAdded2)
                notify("Emotes loaded! Use Keybind to toggle",3)
            end)
        end
    end
})
EmotesTG:AddKeyPicker('EmotesBind', {
    Default = Settings.Extra.ExtrasFeatures.Emotes.Keybind,
    Mode = 'Toggle',
    Text = 'Emotes UI',
    NoUI = false
})



local ChatUnlockTG = ExtrasRightBox:AddToggle('ChatUnlockToggle', {
    Text = 'Chat Unlock & Drawing',
    Default = Settings.Extra.ExtrasFeatures.ChatUnlock.Enabled,
    Callback = function(v)
        Settings.Extra.ExtrasFeatures.ChatUnlock.Enabled = v
        if getgenv()._AZChatDrawingGui then
            getgenv()._AZChatDrawingGui.Enabled = v
        elseif v then
            getgenv()._AZChatUnlockActive = true
            task.spawn(function()
                while getgenv()._AZChatUnlockActive and task.wait(0.1) do
                    pcall(function()
                        local StarterGui4=game:GetService("StarterGui")
                        StarterGui4:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)
                        StarterGui4:SetCore("ChatActive",true)
                        local tcs = game:GetService("TextChatService")
                        if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
                            tcs.ChatWindowConfiguration.Enabled = true
                            tcs.ChatInputBarConfiguration.Enabled = true
                        end
                        
                        -- Hide fake custom chat GUIs
                        for _, gui in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
                            if gui:IsA("ScreenGui") and gui.Enabled then
                                -- Check for common fake chat text or names
                                local isFakeChat = false
                                if gui.Name:lower():find("chat") and not gui.Name:lower():find("bubble") then isFakeChat = true end
                                for _, d in ipairs(gui:GetDescendants()) do
                                    if d:IsA("TextBox") and (d.PlaceholderText:find("To chat click here") or d.PlaceholderText:find("press ! key")) then
                                        isFakeChat = true
                                        break
                                    end
                                end
                                if isFakeChat then
                                    gui.Enabled = false
                                end
                            end
                        end
                    end)
                end
            end)
            getgenv()._AZChatLogsLoaded=true
            task.spawn(function()
                local TextChatService4=game:GetService("TextChatService")
                local ReplicatedStorage4=game:GetService("ReplicatedStorage")
                local Players4=game:GetService("Players")
                local UserInputService4=game:GetService("UserInputService")
                local TweenService4=game:GetService("TweenService")
                local ContextActionService4=game:GetService("ContextActionService")
                local CoreGui4=game:GetService("CoreGui")
                local HttpService4=game:GetService("HttpService")
                local INVISIBLE_CHAR4="\u{001E}"
                local NEWLINE4="\u{000D}"
                local function chatMessage4(str)
                    str=tostring(str)
                    if TextChatService4.ChatVersion==Enum.ChatVersion.TextChatService then
                        TextChatService4.TextChannels.RBXGeneral:SendAsync(str)
                    else
                        ReplicatedStorage4.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str,"All")
                    end
                end
                local gui4=Instance.new("ScreenGui")
                gui4.Name="AZDrawingInterface"
                gui4.DisplayOrder=2
                gui4.ResetOnSpawn=false
                gui4.Parent=CoreGui4
                getgenv()._AZChatDrawingGui=gui4
                local GRID_SIZE4=7 local CELL_SIZE4=35
                local grid4={} local cells4={}
                local selectedEmoji4="⬜"
                local drawing4=false
                local mainFrame4=Instance.new("Frame")
                mainFrame4.Size=UDim2.new(0,300,0,490)
                mainFrame4.Position=UDim2.new(0.5,-150,0.5,-245)
                mainFrame4.BackgroundColor3=Color3.fromRGB(30,30,30)
                mainFrame4.BorderSizePixel=0
                mainFrame4.Parent=gui4
                local corner4=Instance.new("UICorner")
                corner4.CornerRadius=UDim.new(0,10)
                corner4.Parent=mainFrame4
                local titleBar4=Instance.new("Frame")
                titleBar4.Size=UDim2.new(1,0,0,30)
                titleBar4.BackgroundColor3=Color3.fromRGB(40,40,40)
                titleBar4.BorderSizePixel=0
                titleBar4.Parent=mainFrame4
                local tc4=Instance.new("UICorner") tc4.CornerRadius=UDim.new(0,10) tc4.Parent=titleBar4
                local titleText4=Instance.new("TextLabel")
                titleText4.Text="AZ Drawing / Chat Art"
                titleText4.Size=UDim2.new(1,-40,1,0)
                titleText4.Position=UDim2.new(0,10,0,0)
                titleText4.BackgroundTransparency=1
                titleText4.Font=Enum.Font.Gotham
                titleText4.TextSize=13
                titleText4.TextColor3=Color3.fromRGB(255,255,255)
                titleText4.TextXAlignment=Enum.TextXAlignment.Left
                titleText4.Parent=titleBar4
                local closeBtn4=Instance.new("TextButton")
                closeBtn4.Size=UDim2.new(0,30,0,30)
                closeBtn4.Position=UDim2.new(1,-30,0,0)
                closeBtn4.BackgroundColor3=Color3.fromRGB(220,50,50)
                closeBtn4.BorderSizePixel=0
                closeBtn4.Text="X"
                closeBtn4.TextColor3=Color3.fromRGB(255,255,255)
                closeBtn4.Font=Enum.Font.GothamBold
                closeBtn4.TextSize=14
                closeBtn4.MouseButton1Click:Connect(function() 
                    Settings.Extra.ExtrasFeatures.ChatUnlock.Enabled = false
                    getgenv()._AZChatUnlockActive = false
                    if Library.Toggles.ChatUnlockToggle then Library.Toggles.ChatUnlockToggle:SetValue(false) end
                end)
                local cc4=Instance.new("UICorner") cc4.CornerRadius=UDim.new(0,6) cc4.Parent=closeBtn4
                closeBtn4.Parent=titleBar4
                local gridFrame4=Instance.new("Frame")
                gridFrame4.Size=UDim2.new(0,GRID_SIZE4*CELL_SIZE4,0,GRID_SIZE4*CELL_SIZE4)
                gridFrame4.Position=UDim2.new(0.5,-(GRID_SIZE4*CELL_SIZE4)/2,0,40)
                gridFrame4.BackgroundTransparency=1
                gridFrame4.Parent=mainFrame4
                local function updateCell4(cell,i,j) grid4[i][j]=selectedEmoji4 cell.Text=selectedEmoji4 end
                for i=1,GRID_SIZE4 do
                    grid4[i]={} cells4[i]={}
                    for j=1,GRID_SIZE4 do
                        local cell=Instance.new("TextButton")
                        cell.Size=UDim2.new(0,CELL_SIZE4-2,0,CELL_SIZE4-2)
                        cell.Position=UDim2.new(0,(j-1)*CELL_SIZE4+1,0,(i-1)*CELL_SIZE4+1)
                        cell.BackgroundColor3=Color3.fromRGB(45,45,45)
                        cell.BorderSizePixel=0
                        cell.Font=Enum.Font.Gotham
                        cell.TextSize=20
                        cell.Text=""
                        grid4[i][j]=""
                        cells4[i][j]=cell
                        cell.InputBegan:Connect(function(input)
                            if input.UserInputType==Enum.UserInputType.MouseButton1 then drawing4=true updateCell4(cell,i,j) end
                        end)
                        cell.InputChanged:Connect(function(input)
                            if input.UserInputType==Enum.UserInputType.MouseMovement and drawing4 then updateCell4(cell,i,j) end
                        end)
                        cell.InputEnded:Connect(function(input)
                            if input.UserInputType==Enum.UserInputType.MouseButton1 then drawing4=false end
                        end)
                        cell.Parent=gridFrame4
                    end
                end
                local emojis4={"⬜","⬛","🔴","🔵","💜","❤️","💛","💚","🔥","⭐","✨","🌙","❓","❗","💯"}
                local emojiScrollFrame4=Instance.new("ScrollingFrame")
                emojiScrollFrame4.Size=UDim2.new(0.95,0,0,40)
                emojiScrollFrame4.Position=UDim2.new(0.025,0,0,295)
                emojiScrollFrame4.BackgroundColor3=Color3.fromRGB(40,40,40)
                emojiScrollFrame4.BorderSizePixel=0
                emojiScrollFrame4.ScrollBarThickness=4
                emojiScrollFrame4.ScrollingDirection=Enum.ScrollingDirection.X
                emojiScrollFrame4.CanvasSize=UDim2.new(0,#emojis4*35,0,0)
                emojiScrollFrame4.Parent=mainFrame4
                local ec4=Instance.new("UICorner") ec4.CornerRadius=UDim.new(0,4) ec4.Parent=emojiScrollFrame4
                local emojiButtons4={}
                for i,emoji in ipairs(emojis4) do
                    local eb=Instance.new("TextButton")
                    eb.Size=UDim2.new(0,30,0,30)
                    eb.Position=UDim2.new(0,(i-1)*35+5,0,5)
                    eb.BackgroundColor3=Color3.fromRGB(60,60,60)
                    eb.BorderSizePixel=0
                    eb.Font=Enum.Font.Gotham
                    eb.TextSize=20
                    eb.Text=emoji
                    eb.TextColor3=Color3.fromRGB(255,255,255)
                    local ebc=Instance.new("UICorner") ebc.CornerRadius=UDim.new(0,4) ebc.Parent=eb
                    eb.MouseButton1Click:Connect(function()
                        selectedEmoji4=emoji
                        for _,b in ipairs(emojiButtons4) do b.BackgroundColor3=Color3.fromRGB(60,60,60) end
                        eb.BackgroundColor3=Color3.fromRGB(100,200,100)
                    end)
                    table.insert(emojiButtons4,eb)
                    eb.Parent=emojiScrollFrame4
                end
                local actionButtons4=Instance.new("Frame")
                actionButtons4.Size=UDim2.new(0.95,0,0,35)
                actionButtons4.Position=UDim2.new(0.025,0,0,340)
                actionButtons4.BackgroundTransparency=1
                actionButtons4.Parent=mainFrame4
                local sendBtn4=Instance.new("TextButton")
                sendBtn4.Size=UDim2.new(0.48,0,1,0)
                sendBtn4.Position=UDim2.new(0,0,0,0)
                sendBtn4.BackgroundColor3=Color3.fromRGB(70,170,70)
                sendBtn4.BorderSizePixel=0
                sendBtn4.Font=Enum.Font.GothamSemibold
                sendBtn4.TextSize=14
                sendBtn4.Text="Send"
                sendBtn4.TextColor3=Color3.fromRGB(255,255,255)
                local sbc=Instance.new("UICorner") sbc.CornerRadius=UDim.new(0,6) sbc.Parent=sendBtn4
                sendBtn4.MouseButton1Click:Connect(function()
                    local art=""
                    for x=1,GRID_SIZE4 do
                        for y=1,GRID_SIZE4 do art=art..(grid4[x][y]~="" and grid4[x][y] or "⬜") end
                        if x<GRID_SIZE4 then art=art..NEWLINE4 end
                    end
                    chatMessage4(INVISIBLE_CHAR4..string.rep(NEWLINE4,8)..art)
                end)
                sendBtn4.Parent=actionButtons4
                local clrBtn4=Instance.new("TextButton")
                clrBtn4.Size=UDim2.new(0.48,0,1,0)
                clrBtn4.Position=UDim2.new(0.52,0,0,0)
                clrBtn4.BackgroundColor3=Color3.fromRGB(170,70,70)
                clrBtn4.BorderSizePixel=0
                clrBtn4.Font=Enum.Font.GothamSemibold
                clrBtn4.TextSize=14
                clrBtn4.Text="Clear"
                clrBtn4.TextColor3=Color3.fromRGB(255,255,255)
                local cbc=Instance.new("UICorner") cbc.CornerRadius=UDim.new(0,6) cbc.Parent=clrBtn4
                clrBtn4.MouseButton1Click:Connect(function()
                    for x=1,GRID_SIZE4 do for y=1,GRID_SIZE4 do grid4[x][y]="" cells4[x][y].Text="" end end
                end)
                clrBtn4.Parent=actionButtons4
                local dragging4=false local dragInput4 local dragStart4 local startPos4
                titleBar4.InputBegan:Connect(function(input)
                    if input.UserInputType==Enum.UserInputType.MouseButton1 then
                        dragging4=true dragStart4=input.Position startPos4=mainFrame4.Position
                        input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging4=false end end)
                    end
                end)
                titleBar4.InputChanged:Connect(function(input)
                    if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput4=input end
                end)
                UserInputService4.InputChanged:Connect(function(input)
                    if input==dragInput4 and dragging4 then
                        local delta=input.Position-dragStart4
                        mainFrame4.Position=UDim2.new(startPos4.X.Scale,startPos4.X.Offset+delta.X,startPos4.Y.Scale,startPos4.Y.Offset+delta.Y)
                    end
                end)
                notify("Chat Unlock + Drawing loaded! Use Keybind to toggle",3)
            end)
        end
    end
})
ChatUnlockTG:AddKeyPicker('ChatUnlockBind', {
    Default = Settings.Extra.ExtrasFeatures.ChatUnlock.Keybind,
    Mode = 'Toggle',
    Text = 'Chat Unlock',
    NoUI = false
})

local VCBypassTG = ExtrasRightBox:AddToggle('VCBypassToggle', {
    Text = 'VC Bypass',
    Default = Settings.Extra.ExtrasFeatures.VCBypass.Enabled,
    Callback = function(v)
        Settings.Extra.ExtrasFeatures.VCBypass.Enabled = v
        if v then
            if not getgenv()._AZVCBypassLoaded then
                getgenv()._AZVCBypassLoaded=true
                task.spawn(function()
                    local Players5=game:GetService("Players")
                    local UserInputService5=game:GetService("UserInputService")
                    local TweenService5=game:GetService("TweenService")
                    local player5=Players5.LocalPlayer
                    local playerGui5=player5:WaitForChild("PlayerGui")
                    local screenGui5=Instance.new("ScreenGui")
                    screenGui5.Name="AZVoiceChatToggleGui"
                    screenGui5.Parent=playerGui5
                    screenGui5.ResetOnSpawn=false
                    if not UserInputService5.TouchEnabled then screenGui5.Enabled=false end
                    local container5=Instance.new("Frame")
                    container5.Name="Container"
                    container5.Size=UDim2.new(0,65,0,65)
                    container5.Position=UDim2.new(0.9,-30,0.7,-30)
                    container5.BackgroundTransparency=1
                    container5.Parent=screenGui5
                    local toggleButton5=Instance.new("TextButton")
                    toggleButton5.Name="ToggleButton"
                    toggleButton5.Text="🎤"
                    toggleButton5.Size=UDim2.new(1,-5,1,-5)
                    toggleButton5.Position=UDim2.new(0,2.5,0,2.5)
                    toggleButton5.BackgroundColor3=Color3.fromRGB(0,170,0)
                    toggleButton5.BackgroundTransparency=0.1
                    toggleButton5.Font=Enum.Font.GothamBold
                    toggleButton5.TextSize=28
                    toggleButton5.TextColor3=Color3.fromRGB(255,255,255)
                    toggleButton5.Parent=container5
                    local bc5=Instance.new("UICorner") bc5.CornerRadius=UDim.new(1,0) bc5.Parent=toggleButton5
                    local isRunning5=false local loopTask5
                    local function startVC5()
                        isRunning5=true
                        TweenService5:Create(toggleButton5,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(170,0,0)}):Play()
                        loopTask5=coroutine.create(function()
                            while isRunning5 do game:GetService("VoiceChatService"):joinVoice() task.wait(3) end
                        end)
                        coroutine.resume(loopTask5)
                    end
                    local function stopVC5()
                        isRunning5=false
                        TweenService5:Create(toggleButton5,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(0,170,0)}):Play()
                    end
                    getgenv()._ToggleVC = function(force)
                        if force == nil then force = not isRunning5 end
                        if force then startVC5() else stopVC5() end
                    end
                    toggleButton5.MouseButton1Click:Connect(function()
                        Settings.Extra.ExtrasFeatures.VCBypass.Enabled = not Settings.Extra.ExtrasFeatures.VCBypass.Enabled
                        if Library.Toggles.VCBypassToggle then Library.Toggles.VCBypassToggle:SetValue(Settings.Extra.ExtrasFeatures.VCBypass.Enabled) end
                    end)
                    notify("VC Bypass loaded! Use Keybind to toggle",3)
                end)
            end
            if getgenv()._ToggleVC then getgenv()._ToggleVC(true) end
        else
            if getgenv()._ToggleVC then getgenv()._ToggleVC(false) end
        end
    end
})
VCBypassTG:AddKeyPicker('VCBypassBind', {
    Default = Settings.Extra.ExtrasFeatures.VCBypass.Keybind,
    Mode = 'Toggle',
    Text = 'VC Bypass',
    NoUI = false
})

-- ────────────────────────────────────────────────────────────────
-- AUTO UPDATE  (Dynamic Silent-Aim Detector)
-- ────────────────────────────────────────────────────────────────
local AutoUpdateBox = ExtrasRightBox

local function runAutoUpdate()
    if not (decompile) then
        notify("Auto Update requires an executor with decompile()!", 5)
        return
    end

    notify("Auto Update: Scanning gun scripts...", 3)

    task.spawn(function()
        local LP      = game:GetService("Players").LocalPlayer
        local RS      = game:GetService("ReplicatedStorage")
        local backpack = LP:WaitForChild("Backpack", 5)

        -- ── Step 1: find GunHandler module ──────────────────────
        local ghModule = RS:FindFirstChild("Modules") and RS.Modules:FindFirstChild("GunHandler")
        if not ghModule then
            notify("Auto Update: GunHandler not found in ReplicatedStorage.Modules", 5)
            return
        end

        local ghSource = ""
        pcall(function() ghSource = decompile(ghModule) end)
        if ghSource == "" then
            notify("Auto Update: Could not decompile GunHandler", 5)
            return
        end

        -- Parse remote folder + name from GunHandler source
        -- Looks for patterns like: ReplicatedStorage.GameRemotes.MainGameEvent
        -- or ReplicatedStorage:FindFirstChild("GameRemotes")
        local detectedFolder, detectedName

        -- Pattern 1: ReplicatedStorage.FolderName.RemoteName
        detectedFolder, detectedName = ghSource:match(
            "ReplicatedStorage%s*%.%s*([%w_]+)%s*%.%s*([%w_]+)%s*[:%.]%s*FireServer"
        )
        if not detectedFolder then
            -- Pattern 2: FindFirstChild("FolderName")...FindFirstChild("RemoteName")
            detectedFolder = ghSource:match('FindFirstChild%s*%(%s*["\']([%w_]+)["\']%s*%).-FireServer')
            detectedName   = ghSource:match('FindFirstChild%s*%(%s*["\']([%w_]+)["\']%s*%)%s*%.%s*FireServer')
        end
        if not detectedFolder then
            -- Pattern 3: direct :FireServer on a RemoteEvent variable - look for common names
            detectedName = ghSource:match('["\']([%w_]+)["\']%s*,.-FireServer') or
                           ghSource:match('RemoteEvent["\']([%w_]+)["\']')
        end

        -- ── Step 2: find a weapon script to figure out arg layout ──
        local gunScript
        local weaponPriority = {
            {"[Revolver]",          "GunClient"},
            {"[Double-Barrel SG]",  "GunClientShotgun"},
            {"[TacticalShotgun]",   "GunClientShotgun"},
        }
        local gunSource = ""
        local isShotgun = false

        for _, entry in ipairs(weaponPriority) do
            local toolName, scriptName = entry[1], entry[2]
            local tool = backpack:FindFirstChild(toolName)
            if not tool then
                -- Also check character
                local char = LP.Character
                tool = char and char:FindFirstChild(toolName)
            end
            if tool then
                local sc = tool:FindFirstChild(scriptName)
                if sc then
                    gunScript = sc
                    isShotgun = (scriptName == "GunClientShotgun")
                    pcall(function() gunSource = decompile(sc) end)
                    break
                end
            end
        end

        if gunSource == "" then
            -- Try any weapon in backpack
            if backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, sc in ipairs(tool:GetChildren()) do
                            if sc.Name:find("GunClient") then
                                isShotgun = sc.Name:find("Shotgun") ~= nil
                                pcall(function() gunSource = decompile(sc) end)
                                if gunSource ~= "" then break end
                            end
                        end
                    end
                    if gunSource ~= "" then break end
                end
            end
        end

        if gunSource == "" then
            notify("Auto Update: Could not find or decompile a gun script. Equip a weapon first!", 6)
            return
        end

        -- Parse ShootGun FireServer call from gun script
        -- Looks for: MainGameEvent:FireServer("ShootGun", Handle, origin, pellets/nil, hitPos, hitPart, normal, range, damage)
        local shootEventName = gunSource:match(':FireServer%s*%(%s*["\']([%w_]+)["\']') or "ShootGun"

        -- Try to detect remote folder/name from the gun script too (more reliable)
        local gf, gn = gunSource:match("ReplicatedStorage%s*%.%s*([%w_]+)%s*%.%s*([%w_]+)%s*:FireServer")
        if gf and gn then
            detectedFolder = gf
            detectedName   = gn
        end

        -- Build the new config
        local newCfg = {
            ShootEventName    = shootEventName,
            ReloadEventName   = "Reload",
            MousePosEventName = "MousePos",
            RemoteFolder      = detectedFolder or "GameRemotes",
            RemoteName        = detectedName   or "MainGameEvent",
            GunHandlerPath    = {"Modules", "GunHandler"},
            CharactersFolder  = "Players",
            WeaponNames       = GameAdapter.WeaponNames,
            IgnoreRemoteNames = GameAdapter.IgnoreRemoteNames,
            Capabilities      = {
                HasRemote           = true,
                HasGunHandler       = true,
                HasCSYNC            = true,
                HasBodyEffects      = true,
                HasCharactersFolder = true,
            },
        }

        local info = string.format(
            "Auto Update Done!\nEvent: %s\nRemote: %s/%s\nShotgun: %s",
            newCfg.ShootEventName,
            newCfg.RemoteFolder,
            newCfg.RemoteName,
            tostring(isShotgun)
        )
        notify(info, 7)
        print("[AutoUpdate]", info)

        GameAdapter.ApplyDetectedConfig(newCfg)
    end)
end

local AutoUpdateBox = Tabs.Extras:AddRightGroupbox('Auto Update')
AutoUpdateBox:AddLabel('1. Turn ON toggle below\n2. Equip gun\n3. Turn OFF toggle to stop', true)

getgenv()._AutoUpdateActive = false
AutoUpdateBox:AddToggle('AutoUpdateToggle', {
    Text = 'Monitor For Guns',
    Default = false,
    Callback = function(v)
        getgenv()._AutoUpdateActive = v
    end
})

AutoUpdateBox:AddButton('Force Manual Update', function()
    runAutoUpdate()
end)

task.spawn(function()
    local _LP = game:GetService("Players").LocalPlayer
    local _backpack = _LP:WaitForChild("Backpack", 15)
    local _lastAutoUpdate = 0
    local AUTO_UPDATE_COOLDOWN = 10 -- seconds between auto updates
    
    local function monitorChildAdded(parent)
        parent.ChildAdded:Connect(function(child)
            if getgenv()._AutoUpdateActive and child:IsA("Tool") then
                local now = tick()
                if now - _lastAutoUpdate < AUTO_UPDATE_COOLDOWN then return end
                _lastAutoUpdate = now
                task.wait(0.5)
                -- Only run if monitor is still active
                if getgenv()._AutoUpdateActive then
                    runAutoUpdate()
                end
            end
        end)
    end
    
    if _backpack then monitorChildAdded(_backpack) end
    if _LP.Character then monitorChildAdded(_LP.Character) end
    _LP.CharacterAdded:Connect(monitorChildAdded)
end)

end)()




;(function()
local StateSpoofer = StateBox:AddToggle('Statespooft', {
    Text = 'Enabled',
    Default = Settings.Extra.StateSpoofer.Enabled,
    Callback = function(v)
        Settings.Extra.StateSpoofer.Enabled = v
    end
})

local Statespoorazo = StateBox:AddToggle('Stateranzo', {
    Text = 'Randomize',
    Default = Settings.Extra.StateSpoofer.Randomize,
    Callback = function(v)
        Settings.Extra.StateSpoofer.Randomize = v
    end
})

local STATEMODEDROPDOWN = StateBox:AddDropdown('TSModeDropdown', {
    Values = {"Jumping","Freefall","Climbing","Swimming","Running","Flying","StrafingNoPhysics","Seated"},
    Default = "Jumping",
    Text = "State",
    Callback = function(v)
        Settings.Extra.StateSpoofer.State = v
    end
})
end)()



;(function()
local FLYTOGLE = MovementBox:AddToggle('flytg', {
    Text = 'Fly',
    Default = Settings.Movement.Fly.MasterSwitch,
    Callback = function(v)
        Settings.Movement.Fly.MasterSwitch = v
    end
})

local FlyBind = FLYTOGLE:AddKeyPicker('FlyBind', {
    Default = Settings.Movement.Fly.Keybind,
    Mode = 'Toggle',
    Text = 'Fly',
    NoUI = false
})

local FlySpeedchange = MovementBox:AddSlider('FlySpeed', {
    Text = 'Studs/s',
    Min = 1,
    Max = 1000,
    Default = Settings.Movement.Fly.Speed,
    Rounding = 0,
    Callback = function(v)
        Settings.Movement.Fly.Speed = v
    end
})

local SPEEDTOGGLE = MovementBox:AddToggle('speedtg', {
    Text = 'Speed',
    Default = Settings.Movement.Speed.MasterSwitch,
    Callback = function(v)
        Settings.Movement.Speed.MasterSwitch = v
    end
})

local SpeedBind = SPEEDTOGGLE:AddKeyPicker('SpeedBind', {
    Default = Settings.Movement.Speed.Keybind,
    Mode = 'Toggle',
    Text = 'Speed',
    NoUI = false
})

local SpeedSlider = MovementBox:AddSlider('SpeedSlider', {
    Text = 'Studs/s',
    Min = 1,
    Max = 500,
    Default = Settings.Movement.Speed.Speed,
    Rounding = 0,
    Callback = function(v)
        Settings.Movement.Speed.Speed = v
    end
})

local NoclipTG = MovementBox:AddToggle('noclipp', {
    Text = 'Noclip',
    Default = Settings.Movement.Noclip.MasterSwitch,
    Callback = function(v)
        Settings.Movement.Noclip.MasterSwitch = v
    end
})

local NoclipBind = NoclipTG:AddKeyPicker('NoclipBind', {
    Default = Settings.Movement.Noclip.Keybind,
    Mode = 'Toggle',
    Text = 'Noclip',
    NoUI = false
})



local NoJumpCooldownToggle = MovementBox:AddToggle('NoJumpCooldownToggle', {
    Text = 'No Jump Cooldown',
    Default = Settings.Movement.NoJumpCooldown,
    Callback = function(v)
        Settings.Movement.NoJumpCooldown = v
    end
})
NoJumpCooldownToggle:AddKeyPicker('NoJumpCooldownBind', {
    Default = 'None',
    Mode = 'Toggle',
    Text = 'No Jump Cooldown',
    NoUI = false
})

local JumpPowerToggle = MovementBox:AddToggle('JumpPowerToggle', {
    Text = 'JumpPower',
    Default = Settings.Movement.JumpPower.Enabled,
    Callback = function(v)
        Settings.Movement.JumpPower.Enabled = v
        if v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = Settings.Movement.JumpPower.Value
        end
    end
})
JumpPowerToggle:AddKeyPicker('JumpPowerBind', {
    Default = 'None',
    Mode = 'Toggle',
    Text = 'JumpPower',
    NoUI = false
})

MovementBox:AddSlider('JumpPowerSlider', {
    Text = 'JumpPower Value',
    Default = Settings.Movement.JumpPower.Value,
    Min = 0,
    Max = 250,
    Rounding = 0,
    Callback = function(v)
        Settings.Movement.JumpPower.Value = v
        if Settings.Movement.JumpPower.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = v
        end
    end
})

local WalkSpeedToggle = MovementBox:AddToggle('WalkSpeedToggle', {
    Text = 'WalkSpeed',
    Default = Settings.Movement.WalkSpeed.Enabled,
    Callback = function(v)
        Settings.Movement.WalkSpeed.Enabled = v
        if v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Settings.Movement.WalkSpeed.Value
        end
    end
})
WalkSpeedToggle:AddKeyPicker('WalkSpeedBind', {
    Default = 'None',
    Mode = 'Toggle',
    Text = 'WalkSpeed',
    NoUI = false
})

MovementBox:AddSlider('WalkSpeedSlider', {
    Text = 'WalkSpeed Value',
    Default = Settings.Movement.WalkSpeed.Value,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        Settings.Movement.WalkSpeed.Value = v
        if Settings.Movement.WalkSpeed.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
        end
    end
})

local htpConn
local HTPToggle = MovementBox:AddToggle('HTPToggle', {
    Text = 'H-TP',
    Default = false,
    Callback = function(v)
        if htpConn then htpConn:Disconnect(); htpConn = nil end
        if v then
            local mouse = LocalPlayer:GetMouse()
            htpConn = UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local htpBind = Library.Options.HTPBind
                    if htpBind and htpBind:GetState() then
                        if mouse and mouse.Hit then
                            if Settings.CSYNC.MasterSwitch and Settings.CSYNC.Enabled then
                                -- CSYNC mode: overwrite the saved position so desync ghost warps there
                                pcall(function() saved = mouse.Hit end)
                            else
                                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    pcall(function() LocalPlayer.Character:MoveTo(mouse.Hit.Position) end)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})
HTPToggle:AddKeyPicker('HTPBind', {
    Default = 'H',
    Mode = 'Hold',
    Text = 'H-TP Key',
    NoUI = false
})
end)()


if GameAdapter.Capabilities.HasCSYNC then
(function()
local CSYNCTOGGLE = CSYNCBOX:AddToggle('CSYNCTOGGLE', {
    Text = 'Enabled',
    Default = Settings.CSYNC.MasterSwitch,
    Callback = function(v)
        Settings.CSYNC.MasterSwitch = v
    end
})

local StatusTGGG = CSYNCBOX:AddToggle('CSYNCStatus', {
    Text = 'Status',
    Default = Settings.CSYNC.Status,
    Callback = function(v)
        Settings.CSYNC.Status = v
        if not indicatorExists("Desync") then 
            addIndicator("Desync", Settings.CSYNC.Enabled)
        end
        if not indicatorExists("C Position") then 
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local cpos = hrp and hrp.Position or Vector3.zero
            addIndicator("C Position", Vector3.new(math.round(cpos.X), math.round(cpos.Y), math.round(cpos.Z)))
        end
        if not indicatorExists("Htb Pos ") then 
            local hb = getHitbox(LocalPlayer.Character)
            local spos = hb and hb.Position or Vector3.zero
            addIndicator("Htb Pos ", Vector3.new(math.round(spos.X), math.round(spos.Y), math.round(spos.Z)))
        end 
        if not indicatorExists("Rotation") then 
            addIndicator("Rotation", "Not Swapped")
            if not Settings.CSYNC.HyperRotation then 
                hideIndicator("Rotation")
            end 
        end 
    end
})

local CSYNCStatusModeDep = CSYNCBOX:AddDependencyBox()

local CSYNCStatusMode = CSYNCStatusModeDep:AddDropdown('CSYNCStatusMode', {
    Values = {"Always", "When Desynced"},
    Default = Settings.CSYNC.StatusMode,
    Text = "Show Indicator",
    Callback = function(v)
        Settings.CSYNC.StatusMode = v
    end
})

CSYNCStatusModeDep:SetupDependencies({
    { StatusTGGG, true }
})

local CSYNCBIND = CSYNCTOGGLE:AddKeyPicker('CSYNCBIND', {
    Default = Settings.CSYNC.Keybind,
    Mode = 'Toggle',
    Text = 'C-SYNC',
    NoUI = false
})

local CSYNCDropDep = CSYNCBOX:AddDependencyBox()

local CHITBOXREORIENTATION = CSYNCDropDep:AddToggle('CHITBOXREORIENTATION', {
    Text = 'Newtonian Hitbox Adjustment',
    Default = Settings.CSYNC.HitboxReorientation,
    Callback = function(v)
        Settings.CSYNC.HitboxReorientation = v
    end
})

local HYPERROTTG = CSYNCDropDep:AddToggle('HYPERROTTG', {
    Text = 'Hyper Rotation',
    Default = Settings.CSYNC.HyperRotation,
    Callback = function(v)
        Settings.CSYNC.HyperRotation = v
        if indicatorExists("Rotation") then 
            if v and not indicatorVisible("Rotation") then 
                showIndicator("Rotation")
            elseif not v and indicatorVisible("Rotation") then 
                hideIndicator("Rotation")
            end  
        end 
    end
})

local QUANTUMINTERPOLTG = CSYNCDropDep:AddToggle('QUANTUMINTERPOLTG', {
    Text = 'Quantum Interpolation',
    Default = Settings.CSYNC.QuantumInterpolation,
    Callback = function(v)
        Settings.CSYNC.QuantumInterpolation = v
    end
})

local QuantumDelayDep = CSYNCDropDep:AddDependencyBox()

local QUANTUMINTDELAY = QuantumDelayDep:AddSlider('QUANTUMINTDELAY', {
    Text = 'Repeat Interval (ms)',
    Min = 1,
    Max = 500,
    Default = Settings.CSYNC.QuantumInterpolationDelay,
    Rounding = 0,
    Callback = function(v)
        Settings.CSYNC.QuantumInterpolationDelay = v
    end
})

local CSYNCDROP = CSYNCBOX:AddDropdown('CSYNCDROPDOWN', {
    Values = {"E = mc²"},
    Default = "E = mc²",
    Text = "Mode",
    Callback = function(v)
        Settings.CSYNC.Mode = v
    end
})

CSYNCDropDep:SetupDependencies({
    { CSYNCDROP, "E = mc²" }
})

QuantumDelayDep:SetupDependencies({
    { CSYNCDROP, "E = mc²" },
    { QUANTUMINTERPOLTG, true }
})
end)()
end

;(function()
local VelocityToggle = VELOCITYSPOOFERBOX:AddToggle('VelocitySpooferToggle', {
    Text = 'Enabled',
    Default = Settings.VelocitySpoofer.MasterSwitch,
    Callback = function(v)
        Settings.VelocitySpoofer.MasterSwitch = v
    end
})

local VelStatusTGGG = VELOCITYSPOOFERBOX:AddToggle('VelocityStatus', {
    Text = 'Status',
    Default = Settings.VelocitySpoofer.Status,
    Callback = function(v)
        Settings.VelocitySpoofer.Status = v
        if not indicatorExists("Velocity") then 
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local vel = hrp and hrp.AssemblyLinearVelocity or Vector3.zero
            addIndicator("Velocity", Vector3.new(math.round(vel.X), math.round(vel.Y), math.round(vel.Z)))
        end
    end
})

local VelStatusModeDep = VELOCITYSPOOFERBOX:AddDependencyBox()

local VelStatusMode = VelStatusModeDep:AddDropdown('VelocityStatusMode', {
    Values = {"Always", "When Desynced"},
    Default = Settings.VelocitySpoofer.StatusMode,
    Text = "Show Indicator",
    Callback = function(v)
        Settings.VelocitySpoofer.StatusMode = v
    end
})

VelStatusModeDep:SetupDependencies({
    { VelStatusTGGG, true }
})

local VelocitySpooferBind = VelocityToggle:AddKeyPicker('VelocitySpooferBind', {
    Default = Settings.VelocitySpoofer.Keybind,
    Mode = 'Toggle',
    Text = 'Velocity Spoofer',
    NoUI = false
})


end)()

if GameAdapter.Capabilities.HasGunHandler then
(function()
local RangeOverrideTG = GunModBox:AddToggle('RANGE_OVERRIDE_TG', {
    Text = 'Range Override',
    Default = false,
    Callback = function(v)
        Settings.Extra.GunMod.RangeEnabled = v
        if applyAllToolMods then applyAllToolMods() end
    end
})



local RangeOverrideDepBox = GunModBox:AddDependencyBox()
RangeOverrideDepBox:SetupDependencies({
    { RangeOverrideTG, true }
})

RangeOverrideDepBox:AddSlider('RANGE_SLIDER', {
    Text = 'Range',
    Min = 1,
    Max = 9999,
    Default = 250,
    Rounding = 0,
    Callback = function(v)
        Settings.Extra.GunMod.Range = v
        if applyAllToolMods then applyAllToolMods() end
    end
})

local PelletToggle = GunModBox:AddToggle('PELLET_MULT_ENABLED', {
    Text = 'Pellet Multiplier',
    Default = false,
    Callback = function(v)
        Settings.Extra.GunMod.PelletMultiplierEnabled = v
    end
})

local PelletDepBox = GunModBox:AddDependencyBox()
PelletDepBox:SetupDependencies({
    { PelletToggle, true }
})

PelletDepBox:AddSlider('PELLET_MULT', {
    Text = 'Multiplier',
    Default = Settings.Extra.GunMod.PelletMultiplier,
    Min = 2,
    Max = 20,
    Rounding = 0,
    Callback = function(v)
        Settings.Extra.GunMod.PelletMultiplier = v
    end
})

PelletDepBox:AddDropdown('PELLET_MULT_MODE', {
    Values = { 'Always', 'Only when targeted' },
    Default = 1,
    Multi = false,
    Text = 'Activation Mode',
    Callback = function(v)
        Settings.Extra.GunMod.PelletMultiplierMode = v
    end
})

local SpreadToggle = GunModBox:AddToggle('SPREAD_MOD_ENABLED', {
    Text = 'Spread Modifier',
    Default = false,
    Callback = function(v)
        Settings.Extra.GunMod.SpreadEnabled = v
    end
})

local SpreadDepBox = GunModBox:AddDependencyBox()
SpreadDepBox:SetupDependencies({
    { SpreadToggle, true }
})

SpreadDepBox:AddSlider('SPREAD_VAL', {
    Text = 'Spread Value',
    Min = 0,
    Max = 5,
    Default = 1,
    Rounding = 2,
    Callback = function(v)
        Settings.Extra.GunMod.SpreadValue = v
    end
})
end)()
end

;(function()
local AutoReloadTG = ExploitsBox:AddToggle('Reload_TG', {
    Text = 'Auto Reload',
    Default = Settings.Extra.Exploits.AutoReload,
    Callback = function(v)
        Settings.Extra.Exploits.AutoReload = v
    end
})






local AutoKillSubbox = ExploitsBox:AddSubbox('Auto Kill')

local AutoKillTG = AutoKillSubbox:AddToggle('AUTOKILL_TG', {
    Text = 'Auto Kill',
    Default = Settings.Extra.Exploits.AutoKill,
    Callback = function(v)
        Settings.Extra.Exploits.AutoKill = v
    end
})

if not getgenv().AutoKillSelectList then getgenv().AutoKillSelectList = {} end

local AutoKillTargetDD
AutoKillTargetDD = AutoKillSubbox:AddDropdown('AUTOKILL_TARGET_DD', {
    Values = { 'Target', 'Everyone', 'Select' },
    Default = 2,
    Multi = false,
    Text = 'Target',
    Callback = function(v)
        Settings.Extra.Exploits.AutoKillTarget = v
    end
})

-- Select-mode player picker (shown only when 'Select' is chosen)
local AutoKillSelectDep = AutoKillSubbox:AddDependencyBox()

local function refreshSelectPlayerList()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not isIgnored(p) then
            table.insert(names, p.Name)
        end
    end
    if Library.Options.AUTOKILL_SELECT_PLAYERS then
        Library.Options.AUTOKILL_SELECT_PLAYERS:SetValues(names)
    end
end

local AutoKillSelectDD = AutoKillSelectDep:AddDropdown('AUTOKILL_SELECT_PLAYERS', {
    Values = {},
    Multi = true,
    AllowNull = true,
    Text = 'Select Players',
    Callback = function(v)
        getgenv().AutoKillSelectList = {}
        for playerName, selected in pairs(v) do
            if selected then
                getgenv().AutoKillSelectList[playerName] = true
            end
        end
    end
})

AutoKillSelectDep:SetupDependencies({
    { AutoKillTargetDD, 'Select' }
})

-- Refresh player list when Select mode is active
Players.PlayerAdded:Connect(function()
    task.wait(0.1)
    refreshSelectPlayerList()
end)
Players.PlayerRemoving:Connect(function(p)
    getgenv().AutoKillSelectList[p.Name] = nil
    refreshSelectPlayerList()
end)
refreshSelectPlayerList()

local AutoKillEquipTG
AutoKillEquipTG = AutoKillSubbox:AddToggle('AUTOKILL_EQUIP_TG', {
    Text = 'Auto Equip',
    Default = Settings.Extra.Exploits.AutoKillEquip,
    Callback = function(v)
        Settings.Extra.Exploits.AutoKillEquip = v
    end
})

local AutoKillModeDD
AutoKillModeDD = AutoKillSubbox:AddDropdown('AUTOKILL_MODE_DD', {
    Values = { 'Individual', 'Multiple' },
    Default = 1,
    Multi = false,
    Text = 'Mode',
    Callback = function(v)
        Settings.Extra.Exploits.AutoKillMode = v
    end
})
end)()

if GameAdapter.Capabilities.HasGunHandler then
(function()
local BulletTPBox = Tabs.Exploits:AddLeftGroupbox('Bullet TP')

local BulletTPToggle = BulletTPBox:AddToggle('BULLETTP_TOGGLE', {
    Text = 'Enabled',
    Default = false,
    Callback = function(v)
        Settings.SilentAim.BulletTP = v
    end
})

local BulletTPOffset = BulletTPBox:AddSlider('BULLETTP_OFFSET', {
    Text = 'Origin Offset',
    Min = 0.5,
    Max = 20,
    Default = 3,
    Rounding = 1,
    Callback = function(v)
        Settings.SilentAim.BulletTPOffset = v
    end
})
end)()
end


local autoReloadDebounce = false
lastalive = {}
function updateGrip(dt)
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then
        tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    end

    if Settings.Extra.Exploits.AutoReload then
        if tool and isToolWeapon(tool) and not autoReloadDebounce then
            local ammo = tool:FindFirstChild("Ammo")
            local maxAmmo = tool:FindFirstChild("MaxAmmo")

            if ammo then
                local currentVal = ammo.Value
                if currentVal <= 0 then
                    autoReloadDebounce = true
                    Reload()
                    task.spawn(function()
                        repeat task.wait(0.1)
                        until not tool:IsDescendantOf(LocalPlayer) or not tool:FindFirstChild("Ammo") or tool.Ammo.Value >= (maxAmmo and maxAmmo.Value or 1)
                        autoReloadDebounce = false
                    end)
                end
            end
        end
    else
        autoReloadDebounce = false
    end
end

local NotTargetIf = ChecksBox:AddDropdown('NotTargetIf', {
    Values = {'Grabbed', 'Dead', 'Behind Wall', 'Forcefield'},
    Default = 0,
    Multi = true,
    Text = 'Not Target If:',
    Callback = function(v)
        Settings.SilentAim.Checks.NotTargetIf = v
    end
})

local UntargetIf = ChecksBox:AddDropdown('UntargetIf', {
    Values = {'Grabbed', 'Dead', 'Behind Wall', 'Forcefield'},
    Default = 0,
    Multi = true,
    Text = 'Untarget If:',
    Callback = function(v)
        Settings.SilentAim.Checks.UntargetIf = v
    end
})

local AutoDuckTG = AutoDuckBox:AddToggle('AutoTG', {
    Text = 'Enabled',
    Default = Settings.Duck.Enabled,
    Callback = function(v)
        Settings.Duck.Enabled = v
    end
})

local AutoDuckMode = AutoDuckBox:AddDropdown('AUTODUCKMODE', {
    Values = {"Desync", "Legit"},
    Default = Settings.Duck.Mode == "HVH" and "Desync" or Settings.Duck.Mode,
    Text = "Mode",
    Callback = function(v)
        Settings.Duck.Mode = v
    end
})


-- AFK Feature (Des Hood [BACK!] only)
-- AFK removed

local VisualsFWTabbox = Tabs.Visuals:AddFullWidthTabbox()
local lvf = getgenv().LoadedVisualFeatures or {}
local ESPTab = lvf.ESP and VisualsFWTabbox:AddTab('ESP') or nil

;(function()
    if not ESPTab then return end

    -- ── Drawing-based ESP ──────────────────────────────────────────────────────
    local ESPState = {
        Enabled      = false,
        EnemyColor   = Color3.fromRGB(255, 60, 60),
        TeamColor    = Color3.fromRGB(60, 255, 100),
        BoxMode      = "2D",        -- "2D" | "3D" | "Corner"
        ShowBoxes    = true,
        ShowName     = true,
        ShowHealth   = true,
        ShowDistance = true,
        ShowTracer   = true,
        ShowHighlight= true,
        HighlightFill= Color3.fromRGB(255, 60, 60),
        HighlightFillTrans = 0.7,
        HighlightOutline   = Color3.fromRGB(255, 255, 255),
        HighlightOutlineTrans = 0,
        TextSize     = 13,
        MaxDist      = 2500,
        ShowTeam     = false,
        -- Blacklist: players in this table are HIDDEN from ESP
        Blacklist    = {},
    }

    local espObjects = {}
    local espHLs     = {}  -- Highlight instances per player

    -- gethui folder for persistent Highlights
    local _hui = (pcall(gethui) and gethui()) or game:GetService("CoreGui")
    local espHLFolder = Instance.new("Folder")
    espHLFolder.Name  = "ESP_Highlights"
    pcall(function() espHLFolder.Parent = _hui end)

    local function isTeammate(player)
        if not ESPState.ShowTeam then return false end
        return player.Team and player.Team == LocalPlayer.Team
    end
    local function getESPColor(player)
        return isTeammate(player) and ESPState.TeamColor or ESPState.EnemyColor
    end

    -- ── Drawing helpers ───────────────────────────────────────────────────────
    local function ln()
        local d = Drawing.new("Line")
        d.Visible = false; d.Thickness = 1; d.ZIndex = 5
        return d
    end
    local function tx()
        local d = Drawing.new("Text")
        d.Visible = false; d.Size = ESPState.TextSize; d.Font = 2
        d.Center = true; d.Outline = true; d.ZIndex = 6
        return d
    end

    -- Each ESP object has lines for 2D box (4), 3D edges (12), corner ticks (16),
    -- text labels, and tracer. We allocate all and show/hide as needed.
    local function newESPDrawings()
        local obj = {
            -- 2D / Corner box  (4 full lines)
            b = { ln(), ln(), ln(), ln() },
            -- Corner ticks: 8 corners x 2 lines = 16, stored as 16-element array
            -- We reuse the same lines; corner mode uses first 16, 2D uses first 4
            ctop = {}, -- 4 corners top
            cbot = {}, -- 4 corners bot (for 3D)
            -- 3D extra vertical edges (4)
            ev = { ln(), ln(), ln(), ln() },
            -- Labels
            name     = tx(),
            health   = tx(),
            distance = tx(),
            tracer   = ln(),
        }
        for i = 1, 8 do obj.ctop[i] = ln() end
        for i = 1, 8 do obj.cbot[i] = ln() end
        return obj
    end

    local function removeESPDrawings(obj)
        if not obj then return end
        for _, d in pairs(obj.b)    do pcall(function() d:Remove() end) end
        for _, d in pairs(obj.ctop) do pcall(function() d:Remove() end) end
        for _, d in pairs(obj.cbot) do pcall(function() d:Remove() end) end
        for _, d in pairs(obj.ev)   do pcall(function() d:Remove() end) end
        pcall(function() obj.name:Remove()     end)
        pcall(function() obj.health:Remove()   end)
        pcall(function() obj.distance:Remove() end)
        pcall(function() obj.tracer:Remove()   end)
    end

    local function hideAll(obj)
        for _, d in pairs(obj.b)    do d.Visible = false end
        for _, d in pairs(obj.ctop) do d.Visible = false end
        for _, d in pairs(obj.cbot) do d.Visible = false end
        for _, d in pairs(obj.ev)   do d.Visible = false end
        obj.name.Visible     = false
        obj.health.Visible   = false
        obj.distance.Visible = false
        obj.tracer.Visible   = false
    end

    local function clearESP(player)
        if espObjects[player] then
            removeESPDrawings(espObjects[player])
            espObjects[player] = nil
        end
        if espHLs[player] then
            pcall(function() espHLs[player]:Destroy() end)
            espHLs[player] = nil
        end
    end

    -- ── Box drawing helpers ────────────────────────────────────────────────────
    local function setLine(d, x1,y1, x2,y2, col)
        d.From = Vector2.new(x1,y1); d.To = Vector2.new(x2,y2)
        d.Color = col; d.Visible = true
    end
    local function hideLine(d) d.Visible = false end

    -- Project 8 corners of a 3D box onto screen
    local function get8ScreenCorners(char, hrp)
        -- Calculate bounding box extents from character parts
        local head   = char:FindFirstChild("Head")
        local top    = head and (head.Position.Y + 0.7) or (hrp.Position.Y + 3.2)
        local bottom = hrp.Position.Y - 3.0  -- feet
        -- Width/depth from HRP size or default
        local hrpSize = hrp.Size
        local hw = hrpSize.X * 0.5 + 0.2
        local hd = hrpSize.Z * 0.5 + 0.2
        local cf = hrp.CFrame
        -- 8 corners in world space
        local corners = {
            cf * Vector3.new( hw, top    - hrp.Position.Y,  hd),
            cf * Vector3.new(-hw, top    - hrp.Position.Y,  hd),
            cf * Vector3.new(-hw, top    - hrp.Position.Y, -hd),
            cf * Vector3.new( hw, top    - hrp.Position.Y, -hd),
            cf * Vector3.new( hw, bottom - hrp.Position.Y,  hd),
            cf * Vector3.new(-hw, bottom - hrp.Position.Y,  hd),
            cf * Vector3.new(-hw, bottom - hrp.Position.Y, -hd),
            cf * Vector3.new( hw, bottom - hrp.Position.Y, -hd),
        }
        local sc = {}
        local allVis = true
        for i, wPos in ipairs(corners) do
            local sp, vis = Camera:WorldToViewportPoint(wPos)
            sc[i] = Vector2.new(sp.X, sp.Y)
            if not vis then allVis = false end
        end
        return sc, allVis
    end

    local function get2DBounds(sc8)
        local minX, minY = math.huge,  math.huge
        local maxX, maxY = -math.huge, -math.huge
        for _, p in ipairs(sc8) do
            if p.X < minX then minX = p.X end
            if p.X > maxX then maxX = p.X end
            if p.Y < minY then minY = p.Y end
            if p.Y > maxY then maxY = p.Y end
        end
        return minX, minY, maxX, maxY
    end

    -- ── Main ESP update ────────────────────────────────────────────────────────
    local function updateESPs()
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer or isIgnored(player) then
                if espObjects[player] then clearESP(player) end
                continue
            end

            -- Blacklisted or ESP disabled → clear and skip
            if not ESPState.Enabled or ESPState.Blacklist[player.Name] then
                clearESP(player)
                continue
            end

            -- Character lookup
            local pFolder = GameAdapter.GetCharactersFolder()
            local char = (pFolder and pFolder:FindFirstChild(player.Name)) or player.Character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")

            if not char or not hrp or not hum or hum.Health <= 0 then
                clearESP(player)
                continue
            end

            local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
            if dist > ESPState.MaxDist then
                clearESP(player)
                continue
            end

            -- Allocate drawings on first sight
            if not espObjects[player] then
                espObjects[player] = newESPDrawings()
            end
            local obj   = espObjects[player]
            local color = getESPColor(player)

            -- ── Highlight (body) ───────────────────────────────────────────────
            local isTarget = (TargetPlayer and player == TargetPlayer)
            if ESPState.ShowHighlight and not isTarget then
                if not espHLs[player] or not espHLs[player].Parent then
                    local hl = Instance.new("Highlight")
                    hl.Name = "ESP_HL"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    pcall(function() hl.Parent = espHLFolder end)
                    espHLs[player] = hl
                end
                local hl = espHLs[player]
                hl.Adornee            = char
                hl.FillColor          = ESPState.HighlightFill
                hl.FillTransparency   = ESPState.HighlightFillTrans
                hl.OutlineColor       = ESPState.HighlightOutline
                hl.OutlineTransparency= ESPState.HighlightOutlineTrans
                hl.Enabled = true
            else
                if espHLs[player] then
                    espHLs[player].Enabled = false
                end
            end

            -- ── Project 8 corners ─────────────────────────────────────────────
            local sc8, anyVis = get8ScreenCorners(char, hrp)
            if not anyVis then
                hideAll(obj)
                continue
            end

            local minX, minY, maxX, maxY = get2DBounds(sc8)
            local cx = (minX + maxX) * 0.5
            local mode = ESPState.BoxMode

            -- Hide all lines then re-enable what's needed
            hideAll(obj)

            if ESPState.ShowBoxes then
                if mode == "2D" then
                    -- Simple rectangle
                    setLine(obj.b[1], minX, minY, maxX, minY, color) -- top
                    setLine(obj.b[2], minX, maxY, maxX, maxY, color) -- bottom
                    setLine(obj.b[3], minX, minY, minX, maxY, color) -- left
                    setLine(obj.b[4], maxX, minY, maxX, maxY, color) -- right

                elseif mode == "Corner" then
                    -- Corner ticks (1/4 of each edge)
                    local cw = (maxX - minX) * 0.25
                    local ch = (maxY - minY) * 0.25
                    -- Top-left
                    setLine(obj.ctop[1], minX, minY, minX+cw, minY, color)
                    setLine(obj.ctop[2], minX, minY, minX, minY+ch, color)
                    -- Top-right
                    setLine(obj.ctop[3], maxX, minY, maxX-cw, minY, color)
                    setLine(obj.ctop[4], maxX, minY, maxX, minY+ch, color)
                    -- Bottom-left
                    setLine(obj.ctop[5], minX, maxY, minX+cw, maxY, color)
                    setLine(obj.ctop[6], minX, maxY, minX, maxY-ch, color)
                    -- Bottom-right
                    setLine(obj.ctop[7], maxX, maxY, maxX-cw, maxY, color)
                    setLine(obj.ctop[8], maxX, maxY, maxX, maxY-ch, color)

                elseif mode == "3D" then
                    -- Top face
                    setLine(obj.b[1], sc8[1].X,sc8[1].Y, sc8[2].X,sc8[2].Y, color)
                    setLine(obj.b[2], sc8[2].X,sc8[2].Y, sc8[3].X,sc8[3].Y, color)
                    setLine(obj.b[3], sc8[3].X,sc8[3].Y, sc8[4].X,sc8[4].Y, color)
                    setLine(obj.b[4], sc8[4].X,sc8[4].Y, sc8[1].X,sc8[1].Y, color)
                    -- Bottom face
                    setLine(obj.cbot[1], sc8[5].X,sc8[5].Y, sc8[6].X,sc8[6].Y, color)
                    setLine(obj.cbot[2], sc8[6].X,sc8[6].Y, sc8[7].X,sc8[7].Y, color)
                    setLine(obj.cbot[3], sc8[7].X,sc8[7].Y, sc8[8].X,sc8[8].Y, color)
                    setLine(obj.cbot[4], sc8[8].X,sc8[8].Y, sc8[5].X,sc8[5].Y, color)
                    -- Vertical edges
                    setLine(obj.ev[1], sc8[1].X,sc8[1].Y, sc8[5].X,sc8[5].Y, color)
                    setLine(obj.ev[2], sc8[2].X,sc8[2].Y, sc8[6].X,sc8[6].Y, color)
                    setLine(obj.ev[3], sc8[3].X,sc8[3].Y, sc8[7].X,sc8[7].Y, color)
                    setLine(obj.ev[4], sc8[4].X,sc8[4].Y, sc8[8].X,sc8[8].Y, color)
                end
            end

            -- Name
            obj.name.Visible = ESPState.ShowName
            if ESPState.ShowName then
                obj.name.Text     = player.Name
                obj.name.Size     = ESPState.TextSize
                obj.name.Color    = color
                obj.name.Position = Vector2.new(cx, minY - ESPState.TextSize - 2)
            end

            -- Health (green→red)
            obj.health.Visible = ESPState.ShowHealth
            if ESPState.ShowHealth then
                local ratio   = math.clamp(hum.Health / math.max(hum.MaxHealth,1), 0, 1)
                obj.health.Text     = string.format("%d HP", math.floor(hum.Health))
                obj.health.Size     = ESPState.TextSize - 1
                obj.health.Color    = Color3.fromRGB(255 - ratio*255, ratio*255, 0)
                obj.health.Position = Vector2.new(cx, maxY + 2)
            end

            -- Distance
            obj.distance.Visible = ESPState.ShowDistance
            if ESPState.ShowDistance then
                obj.distance.Text     = string.format("[%dm]", math.floor(dist))
                obj.distance.Size     = ESPState.TextSize - 1
                obj.distance.Color    = Color3.fromRGB(200,200,200)
                obj.distance.Position = Vector2.new(cx, maxY + ESPState.TextSize + 4)
            end

            -- Tracer
            obj.tracer.Visible = ESPState.ShowTracer
            if ESPState.ShowTracer then
                local vp = Camera.ViewportSize
                obj.tracer.From  = Vector2.new(vp.X/2, vp.Y)
                obj.tracer.To    = Vector2.new(cx, maxY)
                obj.tracer.Color = color
            end
        end
    end

    if getgenv().ESPConnection then
        getgenv().ESPConnection:Disconnect()
        getgenv().ESPConnection = nil
    end
    getgenv().ESPConnection = RunService.RenderStepped:Connect(updateESPs)

    Players.PlayerRemoving:Connect(function(p) clearESP(p) end)

    -- ── UI ────────────────────────────────────────────────────────────────────
    local ESPBox       = ESPTab:AddLeftGroupbox('Settings')
    local ESPHLBox     = ESPTab:AddLeftGroupbox('Body Highlight')
    local ESPSelectBox = ESPTab:AddRightGroupbox('Player Filter')

    ESPBox:AddToggle('ESP_ENABLED', {
        Text = 'Enabled', Default = ESPState.Enabled,
        Callback = function(v) ESPState.Enabled = v end
    })
    ESPBox:AddDropdown('ESP_BOX_MODE', {
        Text = 'Box Mode', Values = {"2D", "3D", "Corner"}, Default = ESPState.BoxMode,
        Callback = function(v) ESPState.BoxMode = v end
    })
    ESPBox:AddToggle('ESP_BOXES', {
        Text = 'Boxes', Default = ESPState.ShowBoxes,
        Callback = function(v) ESPState.ShowBoxes = v end
    }):AddColorPicker('ESP_ENEMY_COLOR', {
        Default = ESPState.EnemyColor, Title = 'Enemy Color',
        Callback = function(v) ESPState.EnemyColor = v end
    }):AddColorPicker('ESP_TEAM_COLOR_PICK', {
        Default = ESPState.TeamColor, Title = 'Team Color',
        Callback = function(v) ESPState.TeamColor = v end
    })
    ESPBox:AddToggle('ESP_NAMES',    { Text = 'Names',    Default = ESPState.ShowName,     Callback = function(v) ESPState.ShowName     = v end })
    ESPBox:AddToggle('ESP_HEALTH',   { Text = 'Health',   Default = ESPState.ShowHealth,   Callback = function(v) ESPState.ShowHealth   = v end })
    ESPBox:AddToggle('ESP_DISTANCE', { Text = 'Distance', Default = ESPState.ShowDistance, Callback = function(v) ESPState.ShowDistance = v end })
    ESPBox:AddToggle('ESP_TRACER',   { Text = 'Tracer',   Default = ESPState.ShowTracer,   Callback = function(v) ESPState.ShowTracer   = v end })
    ESPBox:AddToggle('ESP_SHOW_TEAM',{ Text = 'Show Teammates', Default = ESPState.ShowTeam, Callback = function(v) ESPState.ShowTeam = v end })
    ESPBox:AddSlider('ESP_TEXTSIZE', { Text = 'Text Size', Min = 9, Max = 22, Default = ESPState.TextSize, Rounding = 0,
        Callback = function(v) ESPState.TextSize = v end })
    ESPBox:AddSlider('ESP_MAX_DIST', { Text = 'Max Distance', Min = 100, Max = 5000, Default = ESPState.MaxDist, Rounding = 0,
        Callback = function(v) ESPState.MaxDist = v end })

    -- Body Highlight
    ESPHLBox:AddToggle('ESP_HL_ENABLED', {
        Text = 'Body Highlight', Default = ESPState.ShowHighlight,
        Callback = function(v) ESPState.ShowHighlight = v end
    }):AddColorPicker('ESP_HL_FILL', {
        Default = ESPState.HighlightFill, Title = 'Fill Color',
        Callback = function(v) ESPState.HighlightFill = v end
    }):AddColorPicker('ESP_HL_OUTLINE', {
        Default = ESPState.HighlightOutline, Title = 'Outline Color',
        Callback = function(v) ESPState.HighlightOutline = v end
    })
    ESPHLBox:AddSlider('ESP_HL_FILL_T', {
        Text = 'Fill Transparency', Min = 0, Max = 1, Default = ESPState.HighlightFillTrans, Rounding = 2,
        Callback = function(v) ESPState.HighlightFillTrans = v end
    })
    ESPHLBox:AddSlider('ESP_HL_OUT_T', {
        Text = 'Outline Transparency', Min = 0, Max = 1, Default = ESPState.HighlightOutlineTrans, Rounding = 2,
        Callback = function(v) ESPState.HighlightOutlineTrans = v end
    })

    -- Player filter: everyone visible by default; use blacklist dropdown to hide people
    -- New joiners are NOT auto-shown — user must remove them from blacklist manually
    local ESPBlacklistDD = ESPSelectBox:AddDropdown('ESP_BLACKLIST', {
        Values = {}, Multi = true, AllowNull = true, Text = 'Hide Players',
        Callback = function(selected)
            ESPState.Blacklist = {}
            for name, on in pairs(selected) do
                if on then ESPState.Blacklist[name] = true end
            end
            -- Clear hidden players' drawings immediately
            for _, p in ipairs(Players:GetPlayers()) do
                if ESPState.Blacklist[p.Name] then clearESP(p) end
            end
        end
    })

    ESPSelectBox:AddButton('Hide All', function()
        local current = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not isIgnored(p) then
                current[p.Name] = true
            end
        end
        ESPBlacklistDD:SetValue(current)
    end)
    ESPSelectBox:AddButton('Show All', function()
        ESPBlacklistDD:SetValue({})
    end)

    local function refreshBlacklistDD()
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not isIgnored(p) then table.insert(names, p.Name) end
        end
        if ESPBlacklistDD then ESPBlacklistDD:SetValues(names) end
    end

    -- New joiners added to the blacklist dropdown but NOT selected (so they're hidden
    -- from ESP until user deselects them from the blacklist)
    Players.PlayerAdded:Connect(function(p)
        task.wait(0.5)
        refreshBlacklistDD()
        -- Auto-hide new joiners: add to blacklist
        ESPState.Blacklist[p.Name] = true
        -- Reflect in the dropdown selection
        local current = {}
        for name, _ in pairs(ESPState.Blacklist) do current[name] = true end
        pcall(function() ESPBlacklistDD:SetValue(current) end)
    end)
    Players.PlayerRemoving:Connect(function(p)
        ESPState.Blacklist[p.Name] = nil
        refreshBlacklistDD()
    end)
    refreshBlacklistDD()
end)()

local SoundsTab = lvf.Sounds and VisualsFWTabbox:AddTab('Sounds') or nil
local LocalPlayerTab = lvf.LocalPlayer and VisualsFWTabbox:AddTab('LocalPlayer') or nil
local WorldTab = lvf.World and VisualsFWTabbox:AddTab('World') or nil
;(function()
if not SoundsTab then return end
local HitSoundBox = SoundsTab:AddLeftGroupbox('Hit Sound')

local HitSoundTG = HitSoundBox:AddToggle('HitSoundEnabled', {
    Text = 'Enabled',
    Default = Settings.Visuals.HitSound.Enabled,
    Callback = function(v)
        Settings.Visuals.HitSound.Enabled = v
    end
})

local HitSoundDropdown = HitSoundBox:AddDropdown('HitSoundSelect', {
    Values = {"Skeet", "NeverLose", "Fatality", "TF2", "Ouch", "Snap", "Bell", "Splash", "Ricochet", "Slip", "Hammer", "Shield Break", "Gold Pump", "Knocked"},
    Default = Settings.Visuals.HitSound.Sound,
    Text = "Sound",
    Callback = function(v)
        Settings.Visuals.HitSound.Sound = v
    end
})

local HitSoundVolume = HitSoundBox:AddSlider('HitSoundVolume', {
    Text = 'Volume',
    Default = Settings.Visuals.HitSound.Volume,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(v)
        Settings.Visuals.HitSound.Volume = v
    end
})
end)()

;(function()
if not SoundsTab then return end
local ShootSoundBox = SoundsTab:AddRightGroupbox('Shoot Sound')

local ShootSoundTG = ShootSoundBox:AddToggle('SHOOTSOUND_TG', {
    Text = 'Enabled',
    Default = Settings.Visuals.ShootSound.Enabled,
    Callback = function(v)
        Settings.Visuals.ShootSound.Enabled = v
        applyAllShootSounds()
    end
})

local MuteShootSoundTG = ShootSoundBox:AddToggle('MUTE_SHOOTSOUND_TG', {
    Text = 'Mute',
    Default = Settings.Visuals.ShootSound.Muted,
    Callback = function(v)
        Settings.Visuals.ShootSound.Muted = v
        applyAllShootSounds()
    end
})

local ShootSoundSelect = ShootSoundBox:AddDropdown('SHOOTSOUND_SELECT', {
    Values = { "AWP", "Warthog", "SSG-08", "Trench Gun", "Gunshot", "Gun Hit", "Realistic", "Gun Shot", "Rifle" },
    Default = Settings.Visuals.ShootSound.Sound,
    Text = 'Sound',
    Callback = function(v)
        Settings.Visuals.ShootSound.Sound = v
        applyAllShootSounds()
    end
})

local ShootSoundApplyTo = ShootSoundBox:AddDropdown('SHOOTSOUND_APPLYTO', {
    Values = { "Everyone", "Self" },
    Default = Settings.Visuals.ShootSound.ApplyTo,
    Text = 'Apply to',
    Callback = function(v)
        Settings.Visuals.ShootSound.ApplyTo = v
        applyAllShootSounds()
    end
})

local ShootSoundVolume = ShootSoundBox:AddSlider('SHOOTSOUND_VOLUME', {
    Text = 'Volume',
    Default = Settings.Visuals.ShootSound.Volume,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(v)
        Settings.Visuals.ShootSound.Volume = v
        applyAllShootSounds()
    end
})
end)()

;(function()
if not LocalPlayerTab then return end
local LocalBodyBox = LocalPlayerTab:AddLeftGroupbox('Body Modifications')
LocalBodyBox:AddToggle('LocalBodyEnabled', {
    Text = 'Enabled',
    Default = Settings.Visuals.LocalPlayer.Body.Enabled,
    Callback = function(v)
        Settings.Visuals.LocalPlayer.Body.Enabled = v
    end
}):AddColorPicker('LocalBodyColor', {
    Default = Settings.Visuals.LocalPlayer.Body.Color,
    Title = 'Color',
    Callback = function(v)
        Settings.Visuals.LocalPlayer.Body.Color = v
    end
})

LocalBodyBox:AddDropdown('LocalBodyMaterial', {
    Values = {'Default', 'Neon', 'ForceField', 'Glass', 'Wood', 'SmoothPlastic', 'Metal', 'DiamondPlate', 'Foil'},
    Default = Settings.Visuals.LocalPlayer.Body.Material,
    Text = 'Material',
    Callback = function(v)
        Settings.Visuals.LocalPlayer.Body.Material = v
    end
})

LocalBodyBox:AddSlider('LocalBodyTrans', {
    Text = 'Transparency',
    Min = 0, Max = 1, Default = Settings.Visuals.LocalPlayer.Body.Transparency, Rounding = 2,
    Callback = function(v)
        Settings.Visuals.LocalPlayer.Body.Transparency = v
    end
})
end)()

;(function()
if not WorldTab then return end
local SkyChangerBox = WorldTab:AddLeftGroupbox('Sky Changer')

local SkyChangerTG = SkyChangerBox:AddToggle('SKYCHANGER_TG', {
    Text = 'Enabled',
    Default = Settings.Visuals.SkyChanger.Enabled,
    Callback = function(v)
        Settings.Visuals.SkyChanger.Enabled = v
        updateSky()
        if not v then
            restoreOriginalLighting()
        else
            applySkyColor(Settings.Visuals.SkyChanger.Color)
        end
    end
})

local SkyColorPicker = SkyChangerTG:AddColorPicker('SKYCHANGER_COLOR', {
    Default = Settings.Visuals.SkyChanger.Color,
    Title = 'Sky Color',
    Callback = function(v)
        Settings.Visuals.SkyChanger.Color = v
        if Settings.Visuals.SkyChanger.Enabled then
            applySkyColor(v)
        end
    end
})

local SkyChangerDepBox = SkyChangerBox:AddDependencyBox()

local SkyChangerDropdown = SkyChangerDepBox:AddDropdown('SKYCHANGER_SELECT', {
    Values = {
        "Default", "Realistic Sky", "CakeUp Night Sky", "Minecraft Sky", "Cartoon Sky",
        "Neon City Sky", "Large Tree Forest Sky", "SkyBox with Mountains",
        "Night Sky", "67 BLUD Sky", "Scary Sky", "Night City Sky", "Cartoon SkyBox",
        "Purple Nebula", "Green Nebula", "Red Space", "Blue Space", "Pink Daylight",
        "Anime Sky", "Vaporwave Sky", "Sunset Sky", "Blood Red Sky", "City Sunset",
        "Stormy Sky", "Cyberpunk Sky", "Dark Matter"
    },
    Default = Settings.Visuals.SkyChanger.Sky,
    Text = 'Sky',
    Callback = function(v)
        Settings.Visuals.SkyChanger.Sky = v
        updateSky()
    end
})

local SkyBoxOrientationX = SkyChangerDepBox:AddSlider('SKYCHANGER_ORIENT_X', {
    Text = 'Orientation X',
    Min = 0,
    Max = 360,
    Default = Settings.Visuals.SkyChanger.SkyboxOrientationX,
    Rounding = 0,
    Callback = function(v)
        Settings.Visuals.SkyChanger.SkyboxOrientationX = v
        updateSkyboxOrientation()
    end
})

local SkyBoxOrientationY = SkyChangerDepBox:AddSlider('SKYCHANGER_ORIENT_Y', {
    Text = 'Orientation Y',
    Min = 0,
    Max = 360,
    Default = Settings.Visuals.SkyChanger.SkyboxOrientationY,
    Rounding = 0,
    Callback = function(v)
        Settings.Visuals.SkyChanger.SkyboxOrientationY = v
        updateSkyboxOrientation()
    end
})

local SkyBoxOrientationZ = SkyChangerDepBox:AddSlider('SKYCHANGER_ORIENT_Z', {
    Text = 'Orientation Z',
    Min = 0,
    Max = 360,
    Default = Settings.Visuals.SkyChanger.SkyboxOrientationZ,
    Rounding = 0,
    Callback = function(v)
        Settings.Visuals.SkyChanger.SkyboxOrientationZ = v
        updateSkyboxOrientation()
    end
})

local SunSize = SkyChangerDepBox:AddSlider('SKYCHANGER_SUN_SIZE', {
    Text = 'Sun Size',
    Min = 0,
    Max = 90,
    Default = Settings.Visuals.SkyChanger.SunSize,
    Rounding = 0,
    Callback = function(v)
        Settings.Visuals.SkyChanger.SunSize = v
        updateSunSize()
    end
})

local ExposureTG = SkyChangerDepBox:AddToggle('SKYCHANGER_EXPOSURE', {
    Text = 'Exposure',
    Default = Settings.Visuals.SkyChanger.Exposure,
    Callback = function(v)
        Settings.Visuals.SkyChanger.Exposure = v
        updateLightingProperties()
    end
})

local ExposureDepBox = SkyChangerDepBox:AddDependencyBox()

local ExposureCompensation = ExposureDepBox:AddSlider('SKYCHANGER_EXPOSURE_COMP', {
    Text = 'Value',
    Min = -5,
    Max = 5,
    Default = Settings.Visuals.SkyChanger.ExposureCompensation,
    Rounding = 2,
    Callback = function(v)
        Settings.Visuals.SkyChanger.ExposureCompensation = v
        updateLightingProperties()
    end
})

ExposureDepBox:SetupDependencies({
    { ExposureTG, true }
})

local EnvironmentSpecularScale = SkyChangerDepBox:AddSlider('SKYCHANGER_SPECULAR', {
    Text = 'Specular Scale',
    Min = 0,
    Max = 1,
    Default = Settings.Visuals.SkyChanger.EnvironmentSpecularScale,
    Rounding = 2,
    Callback = function(v)
        Settings.Visuals.SkyChanger.EnvironmentSpecularScale = v
        updateLightingProperties()
    end
})

local EnvironmentDiffuseScale = SkyChangerDepBox:AddSlider('SKYCHANGER_DIFFUSE', {
    Text = 'Diffuse Scale',
    Min = 0,
    Max = 1,
    Default = Settings.Visuals.SkyChanger.EnvironmentDiffuseScale,
    Rounding = 2,
    Callback = function(v)
        Settings.Visuals.SkyChanger.EnvironmentDiffuseScale = v
        updateLightingProperties()
    end
})

local ShadowSoftness = SkyChangerDepBox:AddSlider('SKYCHANGER_SHADOW_SOFT', {
    Text = 'Shadow Softness',
    Min = 0,
    Max = 1,
    Default = Settings.Visuals.SkyChanger.ShadowSoftness,
    Rounding = 2,
    Callback = function(v)
        Settings.Visuals.SkyChanger.ShadowSoftness = v
        updateLightingProperties()
    end
})

local ShadowMap = SkyChangerDepBox:AddDropdown('SKYCHANGER_SHADOW_MAP', {
    Values = { "ShadowMap", "Future", "Voxel", "Compatibility" },
    Default = Settings.Visuals.SkyChanger.ShadowMap,
    Text = 'Lighting Technology',
    Callback = function(v)
        Settings.Visuals.SkyChanger.ShadowMap = v
        updateLightingProperties()
    end
})

SkyChangerDepBox:AddButton({
    Text = 'Revert All',
    Func = function()
        restoreOriginalSky()
        restoreOriginalLighting()
        
        Settings.Visuals.SkyChanger.Color = originalLightingProps.Ambient
        Settings.Visuals.SkyChanger.SkyboxOrientationX = originalSkyOrientation.X
        Settings.Visuals.SkyChanger.SkyboxOrientationY = originalSkyOrientation.Y
        Settings.Visuals.SkyChanger.SkyboxOrientationZ = originalSkyOrientation.Z
        Settings.Visuals.SkyChanger.SunSize = originalSunAngularSize
        Settings.Visuals.SkyChanger.Exposure = false
        Settings.Visuals.SkyChanger.ExposureCompensation = originalLightingProps.ExposureCompensation
        Settings.Visuals.SkyChanger.EnvironmentSpecularScale = originalLightingProps.EnvironmentSpecularScale
        Settings.Visuals.SkyChanger.EnvironmentDiffuseScale = originalLightingProps.EnvironmentDiffuseScale
        Settings.Visuals.SkyChanger.ShadowSoftness = originalLightingProps.ShadowSoftness
        Settings.Visuals.SkyChanger.ShadowMap = "ShadowMap"

        Library.Options.SKYCHANGER_COLOR:SetValueRGB(originalLightingProps.Ambient)
        Library.Options.SKYCHANGER_ORIENT_X:SetValue(originalSkyOrientation.X)
        Library.Options.SKYCHANGER_ORIENT_Y:SetValue(originalSkyOrientation.Y)
        Library.Options.SKYCHANGER_ORIENT_Z:SetValue(originalSkyOrientation.Z)
        Library.Options.SKYCHANGER_SUN_SIZE:SetValue(originalSunAngularSize)
        Library.Options.SKYCHANGER_EXPOSURE:SetValue(false)
        Library.Options.SKYCHANGER_EXPOSURE_COMP:SetValue(originalLightingProps.ExposureCompensation)
        Library.Options.SKYCHANGER_SPECULAR:SetValue(originalLightingProps.EnvironmentSpecularScale)
        Library.Options.SKYCHANGER_DIFFUSE:SetValue(originalLightingProps.EnvironmentDiffuseScale)
        Library.Options.SKYCHANGER_SHADOW_SOFT:SetValue(originalLightingProps.ShadowSoftness)
        Library.Options.SKYCHANGER_SHADOW_MAP:SetValue("ShadowMap")
    end
})

SkyChangerDepBox:SetupDependencies({
    { SkyChangerTG, true }
})
end)()

;(function()
if not WorldTab then return end
local BulletModBox = WorldTab:AddRightGroupbox('Bullet Modification')

local BulletModToggle = BulletModBox:AddToggle('BulletModEnabled', {
    Text = 'Enabled',
    Default = Settings.Visuals.BulletMod.Enabled,
    Callback = function(v)
        Settings.Visuals.BulletMod.Enabled = v
        if not v then
            revertActiveBullets()
        end
    end
})

local BulletColor = BulletModToggle:AddColorPicker('BulletColor', {
    Default = Settings.Visuals.BulletMod.Color,
    Title = 'Bullet Color',
    Callback = function(Value)
        Settings.Visuals.BulletMod.Color = Value
    end
})

local BulletApplyTo = BulletModBox:AddDropdown('BulletApplyTo', {
    Values = { "Self", "Everyone" },
    Default = Settings.Visuals.BulletMod.ApplyTo,
    Text = 'Apply to',
    Callback = function(v)
        Settings.Visuals.BulletMod.ApplyTo = v
    end
})

local BulletTransparency = BulletModBox:AddSlider('BulletTransparency', {
    Text = 'Transparency',
    Min = 0,
    Max = 1,
    Default = Settings.Visuals.BulletMod.Transparency,
    Rounding = 2,
    Callback = function(v)
        Settings.Visuals.BulletMod.Transparency = v
    end
})

local BulletSize = BulletModBox:AddSlider('BulletSize', {
    Text = 'Size',
    Min = 0.01,
    Max = 5,
    Default = Settings.Visuals.BulletMod.Size,
    Rounding = 2,
    Callback = function(v)
        Settings.Visuals.BulletMod.Size = v
    end
})

local BulletDuration = BulletModBox:AddSlider('BulletDuration', {
    Text = 'Duration',
    Min = 0.1,
    Max = 15,
    Default = Settings.Visuals.BulletMod.Duration,
    Rounding = 1,
    Callback = function(v)
        Settings.Visuals.BulletMod.Duration = v
    end
})

local BulletType = BulletModBox:AddDropdown('BulletType', {
    Values = { "2D", "3D" },
    Default = Settings.Visuals.BulletMod.Type,
    Text = 'Bullet Type',
    Callback = function(v)
        Settings.Visuals.BulletMod.Type = v
    end
})

local Bullet3DOptionsDep = BulletModBox:AddDependencyBox()

local BulletShape = Bullet3DOptionsDep:AddDropdown('BulletShape', {
    Values = { "Cylinder", "Block", "Ball" },
    Default = Settings.Visuals.BulletMod.Shape,
    Text = 'Shape',
    Callback = function(v)
        Settings.Visuals.BulletMod.Shape = v
    end
})

local BulletMaterial = Bullet3DOptionsDep:AddDropdown('BulletMaterial', {
    Values = { "Neon", "ForceField", "Glass", "SmoothPlastic", "Plastic", "Wood" },
    Default = Settings.Visuals.BulletMod.Material,
    Text = 'Material',
    Callback = function(v)
        Settings.Visuals.BulletMod.Material = v
    end
})

Bullet3DOptionsDep:SetupDependencies({
    { BulletType, "3D" }
})

BulletModBox:AddButton({
    Text = 'Reset to Default',
    Func = function()
        Settings.Visuals.BulletMod.Transparency = originalBulletProps.Transparency
        Settings.Visuals.BulletMod.Size = originalBulletProps.Size
        Settings.Visuals.BulletMod.Color = originalBulletProps.Color
        Settings.Visuals.BulletMod.Duration = originalBulletProps.Duration
        Settings.Visuals.BulletMod.Type = "2D"
        Settings.Visuals.BulletMod.Shape = "Cylinder"
        Settings.Visuals.BulletMod.Material = "Neon"
        Settings.Visuals.BulletMod.ApplyTo = "Self"

        Library.Options.BulletTransparency:SetValue(originalBulletProps.Transparency)
        Library.Options.BulletSize:SetValue(originalBulletProps.Size)
        Library.Options.BulletColor:SetValueRGB(originalBulletProps.Color)
        Library.Options.BulletDuration:SetValue(originalBulletProps.Duration)
        Library.Options.BulletType:SetValue("2D")
        Library.Options.BulletShape:SetValue("Cylinder")
        Library.Options.BulletMaterial:SetValue("Neon")
        Library.Options.BulletApplyTo:SetValue("Self")
    end
})
end)()

;(function()
if not WorldTab then return end
local LightingBox = WorldTab:AddLeftGroupbox('Lighting')

local WD = Settings.Visuals.World

local TimeTG = LightingBox:AddToggle('WORLD_TIME_TG', {
    Text = 'Clock Time',
    Default = WD.TimeEnabled,
    Callback = function(v)
        WD.TimeEnabled = v
        if v then
            Lighting.TimeOfDay = WD.TimeOfDay
        else
            Lighting.TimeOfDay = originalLightingProps.TimeOfDay
        end
    end
})

local TimeInput = LightingBox:AddSlider('WORLD_TIME_SLIDER', {
    Text = 'Hour',
    Min = 0,
    Max = 23,
    Default = tonumber(WD.TimeOfDay:sub(1,2)) or 14,
    Rounding = 0,
    Callback = function(v)
        local h = string.format("%02d", v)
        WD.TimeOfDay = h .. ":00:00"
        if WD.TimeEnabled then
            Lighting.TimeOfDay = WD.TimeOfDay
        end
    end
})

local BrightnessTG = LightingBox:AddToggle('WORLD_BRIGHT_TG', {
    Text = 'Brightness',
    Default = WD.BrightnessEnabled,
    Callback = function(v)
        WD.BrightnessEnabled = v
        if v then Lighting.Brightness = WD.Brightness else Lighting.Brightness = originalLightingProps.Brightness end
    end
})

local BrightnessSlider = LightingBox:AddSlider('WORLD_BRIGHT_SLIDER', {
    Text = 'Brightness',
    Min = 0,
    Max = 10,
    Default = WD.Brightness,
    Rounding = 1,
    Callback = function(v)
        WD.Brightness = v
        if WD.BrightnessEnabled then Lighting.Brightness = v end
    end
})

local AmbientTG = LightingBox:AddToggle('WORLD_AMBIENT_TG', {
    Text = 'Ambient',
    Default = WD.AmbientEnabled,
    Callback = function(v)
        WD.AmbientEnabled = v
        if v then
            Lighting.Ambient = WD.Ambient
            Lighting.OutdoorAmbient = WD.OutdoorAmbient
        else
            Lighting.Ambient = originalLightingProps.Ambient
            Lighting.OutdoorAmbient = originalLightingProps.OutdoorAmbient
        end
    end
})

local AmbientColor = AmbientTG:AddColorPicker('WORLD_AMBIENT_CP', {
    Default = WD.Ambient,
    Title = 'Ambient',
    Callback = function(v)
        WD.Ambient = v
        if WD.AmbientEnabled then Lighting.Ambient = v end
    end
})

local OutdoorAmbientColor = AmbientTG:AddColorPicker('WORLD_OUTDOOR_CP', {
    Default = WD.OutdoorAmbient,
    Title = 'Outdoor Ambient',
    Callback = function(v)
        WD.OutdoorAmbient = v
        if WD.AmbientEnabled then Lighting.OutdoorAmbient = v end
    end
})

local ShadowsTG = LightingBox:AddToggle('WORLD_SHADOWS_TG', {
    Text = 'Global Shadows',
    Default = WD.GlobalShadows,
    Callback = function(v)
        WD.GlobalShadows = v
        Lighting.GlobalShadows = v
    end
})

local GeoLatSlider = LightingBox:AddSlider('WORLD_GEOLAT_SLIDER', {
    Text = 'Geographic Latitude',
    Min = -90,
    Max = 90,
    Default = WD.GeographicLatitude,
    Rounding = 1,
    Callback = function(v)
        WD.GeographicLatitude = v
        Lighting.GeographicLatitude = v
    end
})
end)()

-- Fog section removed

;(function()
if not WorldTab then return end
local ResolutionBox = WorldTab:AddRightGroupbox('Aspect Ratio')

local WD = Settings.Visuals.World

local ResolutionTG = ResolutionBox:AddToggle('WORLD_RES_TG', {
    Text = 'Enabled',
    Default = WD.ResolutionEnabled,
    Callback = function(v)
        WD.ResolutionEnabled = v
        if not v then
            pcall(function() RunService:UnbindFromRenderStep("ResolutionOverride") end)
        else
            local cam = workspace.CurrentCamera
            pcall(function() RunService:UnbindFromRenderStep("ResolutionOverride") end)
            RunService:BindToRenderStep("ResolutionOverride", Enum.RenderPriority.Camera.Value + 1, function()
                if not WD.ResolutionEnabled then
                    RunService:UnbindFromRenderStep("ResolutionOverride")
                    return
                end
                local res = math.min(WD.Resolution or 1.0, 1.25)
                cam.CFrame = cam.CFrame * CFrame.new(0,0,0, 1, 0, 0, 0, res, 0, 0, 0, 1)
            end)
        end
    end
})

local ResolutionSlider = ResolutionBox:AddSlider('WORLD_RES_SLIDER', {
    Text = 'Resolution Scale',
    Min = 0.1,
    Max = 1.25,
    Default = math.min(WD.Resolution or 1.0, 1.25),
    Rounding = 2,
    Callback = function(v)
        WD.Resolution = v
    end
})
end)()








Library:OnUnload(function()
    Library.Unloaded = true
    getgenv().loaded = false
    revertActiveBullets()
    restoreOriginalSky()
    restoreOriginalLighting()
    Settings.Visuals.ShootSound.Enabled = false
    Settings.Visuals.ShootSound.Muted = false
    applyAllShootSounds()
    Settings.Visuals.World.ResolutionEnabled = false
    pcall(function() RunService:UnbindFromRenderStep("ResolutionOverride") end)
    Settings.VelocitySpoofer.Enabled = false
    Settings.VelocitySpoofer.MasterSwitch = false
    Settings.VelocitySpoofer.Status = false
    
    local conns = {
        getgenv().MainLoopConnection,
        getgenv().ESPConnection,
        getgenv().BulletModConnection
    }
    for _, conn in ipairs(conns) do
        if conn then
            conn:Disconnect()
        end
    end
    getgenv().MainLoopConnection = nil
    getgenv().ESPConnection = nil
    getgenv().BulletModConnection = nil
    
    local to_destroy = {HighlightTarget, screenGui, indicatorGui, notificationGUI}
    for _, v in pairs(to_destroy) do
        if v and typeof(v) == "Instance" then v:Destroy() end
    end
    
    local to_remove = {Circle, triangle, outline, arrow}
    for _, v in pairs(to_remove) do
        if v and type(v) == "table" and v.Remove then v:Remove() end
    end
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)

local MenuKeybind = MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Menu keybind'
})

Library.ToggleKeybind = MenuKeybind



ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind', 'ManualTarget' })
ThemeManager:SetFolder('Skibidinos')
SaveManager:SetFolder('Skibidinos/configs')

MenuGroup:AddInput('TargetStatsPos', { Text = 'Target Stats Pos', Default = "0.5,0,1,-120", Visible = false })
MenuGroup:AddInput('FeatureIndPos', { Text = 'Feature Ind Pos', Default = "0,8,0.5,-100", Visible = false })
MenuGroup:AddInput('KeybindsPos', { Text = 'Keybinds Pos', Default = "0,10,0.5,0", Visible = false })

Library.Options.TargetStatsPos:OnChanged(function()
    if frame then
        local p = string.split(Library.Options.TargetStatsPos.Value, ",")
        if #p == 4 then
            frame.Position = UDim2.new(tonumber(p[1]), tonumber(p[2]), tonumber(p[3]), tonumber(p[4]))
        end
    end
end)

Library.Options.FeatureIndPos:OnChanged(function()
    if container then
        local p = string.split(Library.Options.FeatureIndPos.Value, ",")
        if #p == 4 then
            container.Position = UDim2.new(tonumber(p[1]), tonumber(p[2]), tonumber(p[3]), tonumber(p[4]))
        end
    end
end)

Library.Options.KeybindsPos:OnChanged(function()
    if Library.KeybindFrame then
        local p = string.split(Library.Options.KeybindsPos.Value, ",")
        if #p == 4 then
            local newPos = UDim2.new(tonumber(p[1]), tonumber(p[2]), tonumber(p[3]), tonumber(p[4]))
            if Library.KeybindFrame.Position ~= newPos then
                Library.KeybindFrame.Position = newPos
            end
        end
    end
end)

if Library.KeybindFrame then
    Library.KeybindFrame:GetPropertyChangedSignal("Position"):Connect(function()
        if Library.Options.KeybindsPos then
            local pos = Library.KeybindFrame.Position
            local posStr = string.format("%f,%d,%f,%d", pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset)
            if Library.Options.KeybindsPos.Value ~= posStr then
                Library.Options.KeybindsPos:SetValue(posStr)
            end
        end
    end)
end

MenuGroup:AddToggle('KeybindMenuOpen', { 
    Default = Library.KeybindFrame.Visible, 
    Text = 'Keybind Menu', 
    Callback = function(v) Library.KeybindFrame.Visible = v end 
})

ThemeManager:ApplyToTab(Tabs['UI Settings'])

local lastStates = {}
local lastKeybindsUpdate = 0
function updateKeybinds()
    local now = tick()
    if now - lastKeybindsUpdate < 0.05 then return end
    lastKeybindsUpdate = now

    local opts = Library.Options
    if opts.FlyBind then
        local c = opts.FlyBind:GetState()
        if c ~= lastStates.Fly then Settings.Movement.Fly.Enabled = c; lastStates.Fly = c end
    end
    if opts.SpeedBind then
        local c = opts.SpeedBind:GetState()
        if c ~= lastStates.Speed then Settings.Movement.Speed.Enabled = c; lastStates.Speed = c end
    end
    if opts.NoclipBind then
        local c = opts.NoclipBind:GetState()
        if c ~= lastStates.Noclip then Settings.Movement.Noclip.Enabled = c; lastStates.Noclip = c end
    end
    if opts.CSYNCBIND then
        local c = opts.CSYNCBIND:GetState()
        if c ~= lastStates.CSYNC then Settings.CSYNC.Enabled = c; lastStates.CSYNC = c end
    end
    if opts.VelocitySpooferBind then
        local c = opts.VelocitySpooferBind:GetState()
        if c ~= lastStates.VelocitySpoofer then Settings.VelocitySpoofer.Enabled = c; lastStates.VelocitySpoofer = c end
    end
    if opts.DESYNCBIND then
        local c = opts.DESYNCBIND:GetState()
        if c ~= lastStates.Desync then Settings.Desync.Enabled = c; lastStates.Desync = c end
    end
    if opts.FreecamBind then
        local c = opts.FreecamBind:GetState()
        if c ~= lastStates.Freecam then 
            Settings.Extra.ExtrasFeatures.Freecam.Enabled = c; lastStates.Freecam = c 
            if Library.Toggles.FreecamToggle then Library.Toggles.FreecamToggle:SetValue(c) end
        end
    end
    if opts.AntiAllBind then
        local c = opts.AntiAllBind:GetState()
        if c ~= lastStates.AntiAll then 
            Settings.Extra.ExtrasFeatures.AntiAll.Enabled = c; lastStates.AntiAll = c 
            if Library.Toggles.AntiAllToggle then Library.Toggles.AntiAllToggle:SetValue(c) end
        end
    end
    if opts.EmotesBind then
        local c = opts.EmotesBind:GetState()
        if c ~= lastStates.Emotes then 
            Settings.Extra.ExtrasFeatures.Emotes.Enabled = c; lastStates.Emotes = c 
            if Library.Toggles.EmotesToggle then Library.Toggles.EmotesToggle:SetValue(c) end
        end
    end
    if opts.ChatUnlockBind then
        local c = opts.ChatUnlockBind:GetState()
        if c ~= lastStates.ChatUnlock then 
            Settings.Extra.ExtrasFeatures.ChatUnlock.Enabled = c; lastStates.ChatUnlock = c 
            if Library.Toggles.ChatUnlockToggle then Library.Toggles.ChatUnlockToggle:SetValue(c) end
        end
    end
    if opts.VCBypassBind then
        local c = opts.VCBypassBind:GetState()
        if c ~= lastStates.VCBypass then 
            Settings.Extra.ExtrasFeatures.VCBypass.Enabled = c; lastStates.VCBypass = c 
            if Library.Toggles.VCBypassToggle then Library.Toggles.VCBypassToggle:SetValue(c) end
        end
    end
    if opts.WalkSpeedBind then
        local c = opts.WalkSpeedBind:GetState()
        if c ~= lastStates.WalkSpeed then
            Settings.Movement.WalkSpeed.Enabled = c
            lastStates.WalkSpeed = c
            if Library.Toggles.WalkSpeedToggle then
                Library.Toggles.WalkSpeedToggle:SetValue(c)
            end
        end
    end
    if opts.JumpPowerBind then
        local c = opts.JumpPowerBind:GetState()
        if c ~= lastStates.JumpPower then
            Settings.Movement.JumpPower.Enabled = c
            lastStates.JumpPower = c
            if Library.Toggles.JumpPowerToggle then
                Library.Toggles.JumpPowerToggle:SetValue(c)
            end
        end
    end
    if opts.NoJumpCooldownBind then
        local c = opts.NoJumpCooldownBind:GetState()
        if c ~= lastStates.NoJumpCooldown then
            Settings.Movement.NoJumpCooldown = c
            lastStates.NoJumpCooldown = c
            if Library.Toggles.NoJumpCooldownToggle then
                Library.Toggles.NoJumpCooldownToggle:SetValue(c)
            end
        end
    end
    if opts.SpectateBind then
        local c = opts.SpectateBind:GetState()
        if c ~= lastStates.Spectate then
            Settings.SilentAim.Spectate = c
            lastStates.Spectate = c
            if Library.Toggles.SpectateTGEnabled then
                Library.Toggles.SpectateTGEnabled:SetValue(c)
            end
        end
    end
end

pcall(function()
    local loaderOpts = Library.Options.LOADER_VISUALS_OPTIONS and type(Library.Options.LOADER_VISUALS_OPTIONS.Value) == "table" and table.clone(Library.Options.LOADER_VISUALS_OPTIONS.Value) or nil
    local loaderTg = Library.Toggles.LOADER_VISUALS_TG and Library.Toggles.LOADER_VISUALS_TG.Value

    SaveManager:Load("autosave")

    if loaderOpts and Library.Options.LOADER_VISUALS_OPTIONS then Library.Options.LOADER_VISUALS_OPTIONS:SetValue(loaderOpts) end
    if loaderTg ~= nil and Library.Toggles.LOADER_VISUALS_TG then Library.Toggles.LOADER_VISUALS_TG:SetValue(loaderTg) end
    if not GameAdapter.Capabilities.HasGunHandler then
        if Library.Toggles.RANGE_OVERRIDE_TG then
            Library.Toggles.RANGE_OVERRIDE_TG:SetValue(false)
        end
        Settings.Extra.GunMod.RangeEnabled = false
        pcall(function() SaveManager:Save("autosave") end)
    end
    for _, bindName in ipairs({"FlyBind", "SpeedBind", "NoclipBind", "CSYNCBIND", "SilentBind", "VelocitySpooferBind", "WalkSpeedBind", "JumpPowerBind", "NoJumpCooldownBind", "SpectateBind"}) do
        if Library.Options[bindName] and Library.Options[bindName].Mode == "Hold" then
            Library.Options[bindName]:SetValue({Library.Options[bindName].Value, "Toggle"})
        end
    end
    updateSky()
    if Settings.Visuals.SkyChanger.Enabled then
        applySkyColor(Settings.Visuals.SkyChanger.Color)
    end
    applyAllShootSounds()
end)

local function stripToggleText(label)
    if label:IsA("TextLabel") then
        local function fixText()
            if label.Text:match(" %(Toggle%)") then
                local newText = label.Text:gsub(" %(Toggle%)", "")
                if label.Text ~= newText then
                    label.Text = newText
                end
            end
        end
        label:GetPropertyChangedSignal("Text"):Connect(fixText)
        fixText()
    end
end

if Library.KeybindContainer then
    Library.KeybindContainer.DescendantAdded:Connect(stripToggleText)
    for _, desc in pairs(Library.KeybindContainer:GetDescendants()) do
        stripToggleText(desc)
    end
end

local saveDebounce = false
local function queueAutoSave()
    if saveDebounce then return end
    saveDebounce = true
    task.delay(0.5, function()
        pcall(function()
            SaveManager:Save("autosave")
        end)
        saveDebounce = false
    end)
end

for _, toggle in pairs(Library.Toggles) do
    local oldSetValue = toggle.SetValue
    if oldSetValue then
        toggle.SetValue = function(self, val)
            local oldVal = self.Value
            oldSetValue(self, val)
            if self.Value ~= oldVal then
                queueAutoSave()
            end
        end
    end
end

for _, option in pairs(Library.Options) do
    local oldCallback = option.Callback
    if oldCallback then
        option.Callback = function(...)
            local res = {oldCallback(...)}
            queueAutoSave()
            return unpack(res)
        end
    else
        option.Callback = function() queueAutoSave() end
    end

    local oldOnChanged = option.OnChanged
    if oldOnChanged then
        option.OnChanged = function(self, func)
            local wrappedFunc = function(...)
                func(...)
                queueAutoSave()
            end
            oldOnChanged(self, wrappedFunc)
        end
    end

    if option.SetValueRGB then
        local oldSetValueRGB = option.SetValueRGB
        option.SetValueRGB = function(self, color, transp)
            local oldColor = self.Value
            local oldTransp = self.Transparency
            oldSetValueRGB(self, color, transp)
            if self.Value ~= oldColor or self.Transparency ~= oldTransp then
                queueAutoSave()
            end
        end
    else
        local oldSetValue = option.SetValue
        if oldSetValue then
            option.SetValue = function(self, val)
                local oldVal = self.Value
                local wasTable = type(oldVal) == "table"
                oldSetValue(self, val)
                if wasTable or self.Value ~= oldVal then
                    queueAutoSave()
                end
            end
        end
    end
end


Target = nil
TargetPlayer = nil


if getgenv().BulletModConnection then getgenv().BulletModConnection:Disconnect() end
if getgenv().LoadVisuals then
getgenv().BulletModConnection = workspace.DescendantAdded:Connect(function(desc)
    if desc.Name ~= "BULLET_RAYS" then return end
    task.spawn(function()
        if not pcall(function()
            local owner = desc:GetAttribute("OwnerCharacter")
            if not owner then
                local t0 = os.clock()
                repeat task.wait() owner = desc:GetAttribute("OwnerCharacter")
                until owner or os.clock() - t0 > 0.3
            end
            local applyTo = Settings.Visuals.BulletMod.ApplyTo or "Self"
            local isSelf = (owner == LocalPlayer.Name or (LocalPlayer.Character and owner == LocalPlayer.Character.Name))
            if applyTo == "Self" and not isSelf then
                return
            end

            local beam = desc:FindFirstChildWhichIsA("Beam")
            if not beam then
                local t0 = os.clock()
                repeat task.wait() beam = desc:FindFirstChildWhichIsA("Beam")
                until beam or os.clock() - t0 > 0.3
            end

            if beam and not originalBulletProps.Captured then
                task.wait(0.05)
                if beam and beam.Parent and not originalBulletProps.Captured then
                    originalBulletProps.Transparency = beam.Transparency.Keypoints[1].Value
                    originalBulletProps.Size = beam.Width0
                    originalBulletProps.Color = beam.Color.Keypoints[1].Value
                    originalBulletProps.Captured = true
                end
            end

            if not Settings.Visuals.BulletMod.Enabled then return end

            for i = #activeBullets, 1, -1 do
                if not activeBullets[i].Parent then
                    table.remove(activeBullets, i)
                end
            end

            local col   = Settings.Visuals.BulletMod.Color
            local trans = Settings.Visuals.BulletMod.Transparency
            local size  = Settings.Visuals.BulletMod.Size
            local dur   = Settings.Visuals.BulletMod.Duration or 1

            if Settings.Visuals.BulletMod.Type == "3D" then
                local a0 = beam and beam.Attachment0
                local a1 = beam and beam.Attachment1
                if beam and not (a0 and a1) then
                    local t0 = os.clock()
                    repeat task.wait()
                        a0 = beam.Attachment0
                        a1 = beam.Attachment1
                    until (a0 and a1) or os.clock() - t0 > 0.3
                end
                local startPos = a0 and a0.WorldPosition
                local endPos = a1 and a1.WorldPosition

                if beam then
                    beam.Enabled = false
                end
                for _, child in ipairs(desc:GetDescendants()) do
                    if child:IsA("BasePart") then
                        pcall(function() child.Transparency = 1 end)
                    elseif child:IsA("SpecialMesh") or child:IsA("BlockMesh") then
                        pcall(function() child:Destroy() end)
                    end
                end

                if startPos and endPos then
                    local shape = Enum.PartType[Settings.Visuals.BulletMod.Shape or "Cylinder"]
                    local mat = Enum.Material[Settings.Visuals.BulletMod.Material or "Neon"]
                    local distance = (endPos - startPos).Magnitude
                    local p = Instance.new("Part")
                    p.Shape = shape
                    p.Name = "BULLET_RAYS_CUSTOM"
                    p.Anchored = true
                    p.CanCollide = false
                    p.CanQuery = false
                    p.CastShadow = false
                    p.Color = col
                    p.Transparency = trans

                    if shape == Enum.PartType.Cylinder then
                        p.Size = Vector3.new(distance, size, size)
                        p.CFrame = CFrame.new(startPos:Lerp(endPos, 0.5), endPos) * CFrame.Angles(0, math.rad(90), 0)
                    else
                        p.Size = Vector3.new(size, size, distance)
                        p.CFrame = CFrame.new(startPos:Lerp(endPos, 0.5), endPos)
                    end

                    p.Parent = workspace
                    p.Material = mat
                    game:GetService("Debris"):AddItem(p, dur)
                    table.insert(activeBullets, p)
                end
                return
            end

            if not desc.Parent then return end

            if dur < 1 then
                table.insert(activeBullets, desc)
                if beam then
                    beam.Width0 = size
                    beam.Width1 = size
                    beam.Color = ColorSequence.new(col)
                    beam.Transparency = NumberSequence.new(trans)
                    beam.Enabled = true
                end
                for _, child in ipairs(desc:GetDescendants()) do
                    if child:IsA("BasePart") then
                        pcall(function() child.Transparency = 1 end)
                    elseif child:IsA("SpecialMesh") or child:IsA("BlockMesh") then
                        pcall(function() child:Destroy() end)
                    end
                end
                task.delay(dur, function()
                    pcall(function() desc:Destroy() end)
                end)
            else
                local clone = desc:Clone()
                clone.Name = "BULLET_RAYS_CUSTOM"
                clone.Parent = desc.Parent
                table.insert(activeBullets, clone)

                local cloneBeam = clone:FindFirstChildWhichIsA("Beam")
                if cloneBeam then
                    cloneBeam.Width0 = size
                    cloneBeam.Width1 = size
                    cloneBeam.Color = ColorSequence.new(col)
                    cloneBeam.Transparency = NumberSequence.new(trans)
                    cloneBeam.Enabled = true
                end
                for _, child in ipairs(clone:GetDescendants()) do
                    if child:IsA("BasePart") then
                        pcall(function() child.Transparency = 1 end)
                    elseif child:IsA("SpecialMesh") or child:IsA("BlockMesh") then
                        pcall(function() child:Destroy() end)
                    end
                end
                game:GetService("Debris"):AddItem(clone, dur)

                pcall(function()
                    desc.Transparency = 1
                    if beam then beam:Destroy() end
                end)
            end
        end) then end
    end)
end)
end

local allowedBodyParts = {
    Head = true, LeftFoot = true, LeftHand = true, LeftLowerArm = true, LeftLowerLeg = true,
    LeftUpperArm = true, LeftUpperLeg = true, LowerTorso = true, RightFoot = true, RightHand = true,
    RightLowerArm = true, RightLowerLeg = true, RightUpperArm = true, RightUpperLeg = true, UpperTorso = true
}

local lastVisualsUpdate = 0
local function updateLocalPlayerVisuals()
    if not getgenv().LoadVisuals then return end
    local now = tick()
    if now - lastVisualsUpdate < 0.1 then return end
    lastVisualsUpdate = now
    local char = LocalPlayer.Character
    if not char then return end
    local LPSet = Settings.Visuals.LocalPlayer

    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
            local toolAncestor = obj:FindFirstAncestorOfClass("Tool")
            local isWeapon = toolAncestor ~= nil
            -- Skip weapon parts entirely (weapon modification removed)
            if isWeapon then continue end

            if not obj:GetAttribute("OrigMaterial") then
                obj:SetAttribute("OrigMaterial", obj.Material.Name)
                obj:SetAttribute("OrigColor", obj.Color)
                obj:SetAttribute("OrigTrans", obj.Transparency)
            end

            local shouldApply = false
            local modConfig = nil

            if allowedBodyParts[obj.Name] or obj:FindFirstAncestorOfClass("Accessory") then
                shouldApply = true
                modConfig = LPSet.Body
            end

            local targetMatName = obj:GetAttribute("OrigMaterial")
            local targetColor = obj:GetAttribute("OrigColor")
            local targetTrans = obj:GetAttribute("OrigTrans")

            if shouldApply and modConfig and modConfig.Enabled then
                if modConfig.Material ~= "Default" then
                    targetMatName = modConfig.Material
                end
                targetColor = modConfig.Color
                targetTrans = modConfig.Transparency
            end

            if obj.Material.Name ~= targetMatName then
                local s, mat = pcall(function() return Enum.Material[targetMatName] end)
                if s and mat then obj.Material = mat end
            end
            if obj.Color ~= targetColor then
                obj.Color = targetColor
            end
            if obj.Transparency ~= targetTrans then
                obj.Transparency = targetTrans
            end
        end
    end
end
if getgenv().MainLoopConnection then getgenv().MainLoopConnection:Disconnect() end
getgenv().MainLoopConnection = RunService.Heartbeat:Connect(function(dt)
    if not getgenv().loaded then return end
    pcall(updateLocalPlayerVisuals)
    pcall(updateDesync)
    pcall(updateSilentAim, dt)
    pcall(updateGrip, dt)
    pcall(updateKeybinds)
    pcall(updateDuck)
    pcall(updateAutoKill)
end)

task.spawn(function()
    while getgenv().loaded and task.wait() do
        pcall(function()
            local pFolder = workspace:FindFirstChild("Players")
            local lChar = pFolder and pFolder:FindFirstChild(LocalPlayer.Name)
            if lChar then
                local ragdoll = lChar:FindFirstChild("RagdollConstraints")
                if ragdoll then
                    ragdoll:Destroy()
                end
            end
        end)
    end
end)

local TalkingBox = Tabs.Talking:AddLeftGroupbox('Information')
TalkingBox:AddLabel('Credits: ')
TalkingBox:AddLabel('-gorilanalog')
TalkingBox:AddLabel('--v1sion')

Tabs.Main:Show()
notify(string.format("Loaded in: %.3f seconds", tick() - initTick), 2)
end)
