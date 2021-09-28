-- Compiled with roblox-ts v1.2.3
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = game.Workspace.CurrentCamera
local getClosestPlayer = function()
	local Target
	local Distance
	local _exp = Players:GetPlayers()
	local _arg0 = function(Player)
		if Player ~= LocalPlayer then
			local Character = Player.Character
			local _Humanoid = Character
			if _Humanoid ~= nil then
				_Humanoid = _Humanoid:FindFirstChildOfClass("Humanoid")
			end
			local Humanoid = _Humanoid
			if Character and Humanoid then
				local Root = Character:FindFirstChild("HumanoidRootPart")
				local _arg0_1 = Root:IsA("Part")
				assert(_arg0_1)
				local Vector, IsOnScreen = Camera:WorldToViewportPoint(Root.Position)
				if IsOnScreen then
					local MousePos = Vector2.new(Mouse.X, Mouse.Y)
					local ScreenPos = Vector2.new(Vector.X, Vector.Y)
					local _mousePos = MousePos
					local _screenPos = ScreenPos
					local Mag = (_mousePos - _screenPos).Magnitude
					local _exp_1 = Mag
					local _condition = Distance
					if not (_condition ~= 0 and _condition == _condition and _condition ~= "" and _condition) then
						_condition = math.huge
					end
					if _exp_1 <= _condition then
						Target = Root.Position
						Distance = Mag
					end
				end
			end
		end
	end
	-- ▼ ReadonlyArray.forEach ▼
	for _k, _v in ipairs(_exp) do
		_arg0(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	return {
		Target = Target,
		Distance = Distance,
	}
end
local oldindex
oldindex = hookmetamethod(game, "__index", function(A, B)
	local _oldindex = oldindex
	assert(_oldindex)
	if B == "UnitRay" then
		local old = oldindex(A, B)
		local data = getClosestPlayer()
		local Target = data.Target
		if Target then
			local org = old.Origin
			local _ptr = {
				Origin = org,
			}
			local _left = "Direction"
			local _target = Target
			local _org = org
			local _exp = ((_target - _org).Unit)
			local _target_1 = Target
			local _org_1 = org
			local _magnitude = (_target_1 - _org_1).Magnitude
			_ptr[_left] = _exp * _magnitude
			return _ptr
		end
	end
	return oldindex(A, B)
end)
return nil
