--[[
#########################################################
	Aimware Lua Script v6.x for Counter-Strike 2  
💖 Enjoying this script? Leave a +rep on my profile! 💖  
	Profile: https://aimware.net/forum/user/61632  
	Discord: blurry33 (for feedback/suggestions)
#########################################################
--]]

		--##### REFERENCE #####
local tab_antiaim		= gui.Reference("Ragebot", "Anti-Aim");
	local yaw_preset		= gui.Combobox(tab_antiaim, "yaw_preset", "Yaw Presets", "Disabled ", "Custom Yaw", "Spinbot ", "Jitter ", "Random ");
	local yaw_spin_speed 	= gui.Slider(tab_antiaim, "yaw_spin_speed", "Spin Speed", 600, 1, 1440, 1);
	local yaw_jitter_mode	= gui.Combobox(tab_antiaim, "yaw_jitter_mode", "Jitter Mode", "Center", "3-Way", "Random");
	local yaw_jitter_range	= gui.Slider(tab_antiaim, "yaw_jitter_range", "Jitter Range", 30, 1, 180);
	local yaw_jitter_tick	= gui.Slider(tab_antiaim, "yaw_jitter_tick", "Jitter Speed", 4, 2, 32, 2);

	--local pitch_preset		= gui.Combobox(tab_pitch, "pitch_preset", "preset", "Disable", "UpDown", "FlickUp", "Random", "Custom");
	local pitch_preset		= gui.Combobox(tab_antiaim, "pitch_preset", "Pitch Presets", "Disabled", "Jitter Pitch", "Fake Pitch", "Fake Jitter", "Nod", "Custom Pitch");
	local pitch_slider 		= gui.Slider(tab_antiaim, "pitch_slider", "Pitch Offset", -50, -89, 89, 0.01);
	
	--local roll_enable 		= gui.Checkbox(tab_antiaim, "roll_enable", "Enable Roll Angle", false);
	local roll_preset		= gui.Combobox(tab_antiaim, "roll_preset", "Roll Presets", "Disabled", "Wave Camera", "Spin Camera", "Upside-Down Camera", "Custom Roll");
	local roll_slider		= gui.Slider(tab_antiaim, "roll_slider", "Roll Offset", 0, -45, 45, 0.1);
	--local roll_speed 		= gui.Slider(tab_antiaim, "roll_speed", "Roll Speed", 0, 0, 15, 1);
	--local roll_range 		= gui.Slider(tab_antiaim, "roll_range", "Roll Range", 0, 0, 360, 1);
	
	local override_right	= gui.Keybox(tab_antiaim, "override_right", "Manual Right", 0);
	local override_left		= gui.Keybox(tab_antiaim, "override_left", "Manual Left", 0);
	local override_forward	= gui.Keybox(tab_antiaim, "override_forward", "Manual Forward", 0);
	
	local anti_invalid		= gui.Checkbox(tab_antiaim, "anti_invalid", "Anti-Invalid Angle", true);
	--local angle_debug		= gui.Checkbox(tab_antiaim, "angle_debug", "Mode Debug", false);
	local fix_shot			= gui.Checkbox(tab_antiaim, "fix_shot", "Disable AA on Shot", true);
	--local max_degrees		= gui.Slider(tab_antiaim, "max_degrees", "Limit per tick", 45, 0, 90);


local angle_debug = false --only dev mode. no need public.
--local angle_debug = angle_debug:GetValue()
--local yaw_offset = gui.GetValue("rbot.antiaim.yawoffset");



-- ###################
-- ##### ANTIAIM #####
-- ###################
local fake_pitch = -3402823346297399750336966557696;
local in_attack = bit.lshift(1, 0);
local on_use = bit.lshift(1, 5);
local pre_va = EulerAngles(0, 0, 0);
local va = EulerAngles(0, 0, 0);
local override = 0;

-- get pre view angles
local function pre_aa(cmd)
	pre_va = cmd:GetViewAngles();
end

-- check anti aim logic
local function aa_base(cmd)

	local antiaim = gui.GetValue("rbot.antiaim.enabled"); 
	local aa_yaw_base = gui.GetValue("rbot.antiaim.yaw"); -- rbot.antiaim.yaw "Target Based" (1 select)
	local tick = globals.TickCount();
	local jitter_tick = yaw_jitter_tick:GetValue()
	local va = cmd:GetViewAngles();
	--local yaw_base = pre_va.y; --base viewangle crosshair
	local sp_speed = yaw_spin_speed:GetValue();
	local mode_yaw = yaw_preset:GetValue()

	-- check direction
	if aa_yaw_base == 1 then
		yaw_base = va.y; --at target + flip backward?
		--print("yaw_base: ".. yaw_base)
	elseif aa_yaw_base == 2 then --base viewangle crosshair
		yaw_base = pre_va.y; 
	end
	
	-- check yaw preset
	--  "Disable ", "Custom Yaw ", "Spinbot ", "Jitter ", "Random ", "Moonwalk ");
	if yaw_preset:GetValue() == 1 then   -- Custom

		va.y = yaw_base;

	elseif yaw_preset:GetValue() == 2 then -- Spinbot 

		--va.y = yaw_base + (tick * sp_speed) % 360 ;

		-- 1st test 
		--yaw_base = yaw_base + (tick % 360);
		--va.y = yaw_base + sp_speed;-- infinite ?

		--2nd test
		--va.y = yaw_base + (tick * sp_speed)
		--va.y = va.y % 360

		local rpm = sp_speed;
		local step = (rpm * 360) / (60 * 64); -- RPM
		
		if spin_angle == nil then spin_angle = 0 end
		spin_angle = (spin_angle + step) % 360;
		
		va.y = spin_angle;

	elseif yaw_preset:GetValue() == 3 then   -- Jitter

		local speed = yaw_jitter_tick:GetValue()
		local range = yaw_jitter_range:GetValue() / 2
		
		if yaw_jitter_mode:GetValue() == 0 then -- jitter Center
			if tick % speed >= speed / 2 then
				va.y = yaw_base - range
			else
				va.y = yaw_base + range
			end 
		elseif yaw_jitter_mode:GetValue() == 1 then -- jitter 3-Way
			local phase = math.floor((tick % speed) / (speed / 4))
			if phase == 0 then
				va.y = yaw_base - range
			elseif phase == 2 then
				va.y = yaw_base + range
			else
				va.y = yaw_base
			end
		elseif yaw_jitter_mode:GetValue() == 2 then -- jitter Random
			if tick % math.max(1, math.floor(speed / 2)) == 0 then
				random_jitter = (math.random() * (range * 2)) - range
			end
			va.y = yaw_base + random_jitter
		end
	
	elseif yaw_preset:GetValue() == 4 then -- random

		va.y = yaw_base + math.random(-180,180); 

	elseif yaw_preset:GetValue() == 5 then -- moonwalk

		va.y = yaw_base * 0;

	end

	-- preset pitch
	if pitch_preset:GetValue() == 1 then -- Jitter Pitch
		if tick % 2 == 0 then
			va.x = 89;
		else 
			va.x = -89;
		end
	elseif pitch_preset:GetValue() == 2 then -- Fake Pitch
		va.x = fake_pitch; --exploit fake pitch 
	elseif pitch_preset:GetValue() == 3 then -- Fake Jitter
		if tick % 2 == 0 then 
			va.x = 179;
		else 
			va.x = -179;
		end
	elseif pitch_preset:GetValue() == 4 then -- sine pitch
		va.x = math.sin(tick * (1 / 4)) * 89;
	elseif pitch_preset:GetValue() == 5 then -- Custom
		va.x = pitch_slider:GetValue();
	end

	-- check roll angle + preset
	if roll_preset:GetValue() == 1 then -- Wave camera
		va.z = math.sin(tick * (1 / 100)) * 45;
	elseif roll_preset:GetValue() == 2 then -- Spinning camera
		va.z = (tick * 1) % 360;
	elseif roll_preset:GetValue() == 3 then -- Camera Upside
		va.z = -180;
	elseif roll_preset:GetValue() == 4 then -- Custom roll
		va.z = roll_slider:GetValue();
	end

	-- check override
	if override == 1 then -- right
		va.y = va.y - 90;
	elseif override == 2 then -- left
		va.y = va.y + 90;
	elseif override == 3 then -- forward
		va.y = va.y + 180; 
	end

	--check conditions
	local buttons = cmd:GetButtons()
	local localPlayer = entities.GetLocalPlayer()
	local movetype = localPlayer:GetFieldInt("m_nActualMoveType")
	local weaponType = localPlayer:GetWeaponType()

	if movetype == 9 then
		--print("on ladder ")
		return -- on ladder
	elseif bit.band(buttons, on_use) ~= 0  then
		--print("on use ")
		return -- on use
	elseif weaponType == 0 then 
		--print("use knife")
		return -- on knife
	elseif weaponType == 9 then 
		--print("on grenade")
		return -- on grenade
	end
		--Disable AA on Shot. better shot when fire?? 
	if fix_shot:GetValue() and bit.band(buttons, in_attack) ~= 0 then
		--print("in attack")
		--va_cm.y = yaw_base_cm; 
		return
	end

	-- limit angle per tick
	--[[
	local limit_yaw = max_degrees:GetValue()
	if limit_yaw ~= 0 then
		-- future add limit degree per tickbase
	end
	]]

	-- anti invalid angle
	if anti_invalid:GetValue() then
		-- yaw angle
		if va.y > 180 then
			va.y = va.y - 360;
		elseif va.y < -180 then
			va.y = va.y + 360;
		end
		-- pitch
		if va.x > 89 then
			va.x = 89;
		elseif va.x < -89 then
			va.x = -89;
		end
		-- roll
		if va.z ~= 0 then
			va.z = 0;
		end
	end
	
	if antiaim then
		cmd:SetViewAngles(va);
		--print("yaw: ".. va.y);
	end
end


-- ################
-- ##### DRAW #####
-- ################
local function aa_debug(cmd)
	local va_debug = cmd:GetViewAngles();

	current_yaw = string.format("%.2f", va_debug.y)
	current_pitch = string.format("%.2f", va_debug.x)
	current_roll = string.format("%.2f", va_debug.z)
	current_fwd = math.floor(cmd:GetForwardMove())
	current_side = math.floor(cmd:GetSideMove())

	local me = entities.GetLocalPlayer()
	if me then
		current_movetype = me:GetFieldInt("m_MoveType") or 0
		current_actual = me:GetFieldInt("m_nActualMoveType") or 0
	end
	--print("yaw: " .. va_debug.y .. " pitch: " .. va_debug.x .. " roll: " .. va_debug.z);
end

	-- keys toggles override direction
local function handle_toggle(keybox, state_id)

	local key = keybox:GetValue();
	if key ~= 0 and input.IsButtonPressed(key) then
		override = (override == state_id) and 0 or state_id;
	end;
	
end

-- vars draw text
local offset_text = 50;
local white = 250, 255, 255, 255
local custom_color = 250, 50, 150, 255
local screen_x, screen_y = draw.GetScreenSize()

-- check frame
local function checker_func()
	local offset_text_y = 15; -- reset positon Y

	-- visibility toggles based on preset
	yaw_spin_speed:SetInvisible(yaw_preset:GetValue() ~= 2)
	
	local is_jitter = yaw_preset:GetValue() == 3
	yaw_jitter_mode:SetInvisible(not is_jitter)
	yaw_jitter_range:SetInvisible(not is_jitter)
	yaw_jitter_tick:SetInvisible(not is_jitter)
	
	-- snap jitter speed to multiples of 4 if in 3-way mode
	if is_jitter and yaw_jitter_mode:GetValue() == 1 then
		local speed = yaw_jitter_tick:GetValue()
		if speed % 4 ~= 0 then
			local new_speed = math.floor(speed / 4 + 0.5) * 4
			if new_speed < 4 then new_speed = 4 end
			yaw_jitter_tick:SetValue(new_speed)
		end
	end
	
	pitch_slider:SetInvisible(pitch_preset:GetValue() ~= 5)
	roll_slider:SetInvisible(roll_preset:GetValue() ~= 4)

	-- toggle keys
	handle_toggle(override_right, 1);
	handle_toggle(override_left, 2);
	handle_toggle(override_forward, 3);

	-- crosshair
	local center_x = screen_x / 2
	local center_y = screen_y / 2
	
	-- debug indicator
	if angle_debug then
		local offset_y = 15;
		
		draw.Color(custom_color) -- color
		
		-- text
		draw.TextShadow(center_x - offset_text,  center_y + offset_text_y, "YAW: " .. (current_yaw or "0.00"))
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "PITCH: " .. (current_pitch or "0.00"))
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "ROLL: " .. (current_roll or "0.00"))	
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "FWD: " .. (current_fwd or 0) .. " | SIDE: " .. (current_side or 0))	
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "MOVE: " .. (current_movetype or 0) .. " | ACTUAL: " .. (current_actual or 0))	
		offset_text_y = offset_text_y + offset_y

		--  override
		if override == 1 then 
			draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "DIR: RIGHT ") 
		end
		if override == 2 then 
			draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "DIR:  LEFT") 
		end
		if override == 3 then 
			draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "DIR:  FORWARD") 
		end
	end

end

--##### REGISTER CALLBACKS #####
callbacks.Register("Draw", function()
	checker_func();
end)
callbacks.Register("PreMove", function(cmd)	
	pre_aa(cmd);
	aa_base(cmd); --createmove no support Auto-stafer / premove no support at Target
end)
callbacks.Register("CreateMove", function(cmd)

	aa_debug(cmd);
end)
callbacks.Register("Unload", function()
	gui.Command("clear");
end)