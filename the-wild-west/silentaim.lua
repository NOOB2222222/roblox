local config = shared.config or {
    silentaim = true,
    fov = false,
    fov_range = 360
}

local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()

local camera = workspace.CurrentCamera

local function closesttomouse()
    local target
    local distance
    for p, player in pairs(players:GetPlayers()) do
        if not player.Character or not player.Character:FindFirstChild("Head") or player.Character.Humanoid.Health < 0 or player == localplayer then
            continue
        end
        local spoint, onscreen = camera:WorldToScreenPoint(player.Character.Head.Position)
        local dist = (Vector2.new(spoint.X,spoint.Y) - Vector2.new(mouse.X,mouse.Y)).Magnitude
        if onscreen and dist <= ( distance or math.huge ) and (config.fov and dist <= config.fov_range or true) then
            target = player.Character.Head.Position
            distance = dist
        end
    end
    return target
end

local oldindex oldindex = hookmetamethod(game, "__index", newcclosure(function(...)
    local t,k = ...
    if k == "UnitRay" and config.silentaim then
        local old = oldindex(...)
        local target = closesttomouse();
        if target then
            local org = old.Origin
            return {
                Origin = org,
                Direction = (target-org).Unit*(target-org).Magnitude
            }
        end
    end
    return oldindex(...)
end))
