
		--##### REFERENCE #####
local tab_antiaim		= gui.Reference("Ragebot", "Anti-Aim");
	local override_right	= gui.Keybox(tab_antiaim, "override_right", "Manual Right", 0);
	local override_left		= gui.Keybox(tab_antiaim, "override_left", "Manual Left", 0);
	local override_forward	= gui.Keybox(tab_antiaim, "override_forward", "Manual Forward", 0);
	
		--##### VARIABLE #####
local override = 0;
local pre_va = EulerAngles(); 

		--##### PRE CREATEMOVE #####
local function preva_func(cmd)
	pre_va = cmd:GetViewAngles();
end

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
	local ad_target = gui.GetValue("rbot.antiaim.autodir.targets");
	local va_base = pre_va.y; --base viewangle crosshair
	
	-- check direction target
	if ad_target == true then
		va_base = va.y - 180;
	end
	
	-- check antiaim override
	if override == 0 then
		return
	elseif override == 1 then -- right
		va.y = va_base - 90;
	elseif override == 2 then -- left
		va.y = va_base + 90;
	elseif override == 3 then -- forward
		va.y = va_base; 
	end

	-- anti angle invalid
	if va.y > 180 then
		va.y = va.y - 360;
	elseif va.y < -180 then
		va.y = va.y + 360;
	end
	
	if antiaim then
		cmd:SetViewAngles(va);
		--print("yaw: " ..tostring(va_yaw.y)) --Debug yaw
	end
end

callbacks.Register("Draw", function()
	checker_func();
end)
callbacks.Register("PreMove", function(cmd)
	preva_func(cmd)
end)
callbacks.Register("CreateMove", function(cmd)
	antiaim_base(cmd);
end)
