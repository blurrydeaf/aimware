local tab_antiaim		= gui.Reference("Ragebot", "Anti-Aim");
	local override_right	= gui.Keybox(tab_antiaim, "override_right", "Manual Right", 0);
	local override_left		= gui.Keybox(tab_antiaim, "override_left", "Manual Left", 0);
	local override_forward	= gui.Keybox(tab_antiaim, "override_forward", "Manual Forward", 0);
local override = 0;
		--##### DRAW FUNC #####
local function checker_func()
 	if override_right:GetValue() ~= 0 and input.IsButtonPressed(override_right:GetValue()) then
		if override == 1 then  -- override right
			override = 0; 
		else
			override = 1;
		end
	end
	if override_left:GetValue() ~= 0 and input.IsButtonPressed(override_left:GetValue()) then
		if override == 2 then  -- override left
			override = 0; 
		else
			override = 2;
		end
	end
	if override_forward:GetValue() ~= 0 and input.IsButtonPressed(override_forward:GetValue()) then
		if override == 3 then  -- override forward
			override = 0; 
		else
			override = 3;
		end
	end
end
		--##### ANTIAIM #####
local function antiaim_base(cmd)
	local va = cmd:GetViewAngles();
	local antiaim = gui.GetValue("rbot.antiaim.enabled");
	if override == 0 then
		return
	elseif override == 1 then -- right
		va.y = -89;
	elseif override == 2 then -- left
		va.y = 89;
	elseif override == 3 then -- forward
		va.y = 179;
	end
	if antiaim then
		cmd:SetViewAngles(va);
	end
end
callbacks.Register("Draw", function()
	checker_func();
end)
callbacks.Register("CreateMove", function(cmd)
	antiaim_base(cmd);
end)
callbacks.Register("Unload", function()
	gui.Command("clear");
end)
--[[
	##### CHANGELOG #####
v0.1 (Initial Release)
	+ Added manual override system
	+ Right (-89), Left (+89), Forward (179)
	+ Toggle-on/toggle-off keybinds
	+ Auto-cleanup on unload
--]]