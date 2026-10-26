-- Settings.lua
-- Окно интерфейса
local Settings = {
    WindowWidth = 750,
    WindowHeight = 580,
    WindowX = 0,
    WindowY = 0,

    -- Визуал
    EnableESP = false,
    Skeleton = false,
    Chams = true,
    Tracers = false,
    ShowName = false,
    ShowDistance = false,
    EnableGeneratorsESP = true,
    EnablePalletsESP = true,
    RoleLogic = "All",
    KillerColor = Color3.fromRGB(255, 60, 60),
    SurvivorColor = Color3.fromRGB(60, 160, 255),
    GeneratorColor = Color3.fromRGB(150, 0, 200),
    PalletColor = Color3.fromRGB(74, 255, 181),

    -- Aim Assist
    EnableAim = false,
    AimKey = Enum.UserInputType.MouseButton2,
    IsBindingAimKey = false,
    Smoothness = 0.25,
    TargetPart = "Head",
    EnableFOV = true,
    FOVRadius = 120,
    TeamCheck = false,
    WallCheck = false,

    -- Камера и мир
    EnableCameraFOV = false,
    CameraFOVValue = 70,
    EnableFullBright = false,
    FPSBoostApplied = false,
    RemoveFog = false,

    -- Авто-инструменты
    MoonwalkEnabled = false,
    AutoSkillCheck = false,
    AutoDagger = false,
    ShowNextKiller = true,

    -- Настройки
    IsBindingMenuKey = false,
    EnableNickChanger = false,
    CustomNicks = {},
}
return Settings