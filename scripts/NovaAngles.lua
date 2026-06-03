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
	local yaw_present		= gui.Combobox(tab_antiaim, "yaw_present", "Yaw Presets", "Disabled ", "Custom Yaw", "Spinbot ", "Jitter ", "Random ", "Moonwalk ");
	local yaw_offset 		= gui.Slider(tab_antiaim, "yaw_offset", "Yaw Offset", 180, -180, 180, 0.1);
	local yaw_spin_speed 	= gui.Slider(tab_antiaim, "yaw_spin_speed", "Spin Speed", -5, -45, 45, 0.1);
	local yaw_jitter_range	= gui.Slider(tab_antiaim, "yaw_jitter_range", "Jitter Range", 30, 0, 90);
	local yaw_jitter_tick	= gui.Slider(tab_antiaim, "yaw_jitter_tick", "Jitter Speed", 4, 2, 32, 2);

	--local pitch_present		= gui.Combobox(tab_pitch, "pitch_present", "Present", "Disable", "UpDown", "FlickUp", "Random", "Custom");
	local pitch_present		= gui.Combobox(tab_antiaim, "pitch_present", "Pitch Presets", "Disabled", "Jitter Pitch", "Fake Pitch", "Fake Jitter", "Nod", "Custom Pitch");
	local pitch_slider 		= gui.Slider(tab_antiaim, "pitch_slider", "Pitch Offset", -50, -89, 89, 0.1);
	
	--local roll_enable 		= gui.Checkbox(tab_antiaim, "roll_enable", "Enable Roll Angle", false);
	local roll_present		= gui.Combobox(tab_antiaim, "roll_present", "Roll Presets", "Disabled", "Wave Camera", "Spin Camera", "Upside-Down Camera", "Custom Roll");
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

-- ###################
-- ##### ANTIAIM #####
-- ###################
local fake_pitch = -3402823346297399750336966557696;
local in_attack = bit.lshift(1, 0)
local on_use = bit.lshift(1, 5)
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
	local ad_target = gui.GetValue("rbot.antiaim.yaw"); -- rbot.antiaim.yaw "Target Based" (1 select)
	local tick = globals.TickCount();
	local jitter_tick = yaw_jitter_tick:GetValue()
	local va = cmd:GetViewAngles();
	--local yaw_base = pre_va.y; --base viewangle crosshair
	local sp_speed = yaw_spin_speed:GetValue();
	local mode_yaw = yaw_present:GetValue()

	-- check direction
	if ad_target == 1 then
	print("target?")
		yaw_base = va.y + 180; --at target + flip backward?
		--print("yaw_base: ".. yaw_base)
	else
		yaw_base = pre_va.y; --base viewangle crosshair
	end
	
	-- check yaw present
	--  "Disable ", "Custom Yaw ", "Spinbot ", "Jitter ", "Random ", "Moonwalk ");
	if yaw_present:GetValue() == 1 then   -- Custom

		va.y = yaw_base + yaw_offset:GetValue();

	elseif yaw_present:GetValue() == 2 then -- Spinbot

		va.y = yaw_base + (tick * sp_speed) % 360 ;

		-- 1st test 
		--yaw_base = yaw_base + (tick % 360);
		--va.y = yaw_base + sp_speed;-- infinite ?

		--2nd test
		--va.y = yaw_base + (tick * sp_speed)
		--va.y = va.y % 360

	elseif yaw_present:GetValue() == 3 then   -- Jitter

		if tick % yaw_jitter_tick:GetValue() >= yaw_jitter_tick:GetValue()/2 then --tick 0 1
			va.y = yaw_base + (yaw_offset:GetValue() - yaw_jitter_range:GetValue())
		else --tick 3 4
			va.y = yaw_base + (yaw_offset:GetValue() + yaw_jitter_range:GetValue())
		end
	
	elseif yaw_present:GetValue() == 4 then -- random

		va.y = yaw_base + math.random(-180,180); 

	elseif yaw_present:GetValue() == 5 then -- moonwalk

		va.y = yaw_base * 0;

	end

	-- present pitch
	if pitch_present:GetValue() == 1 then -- Jitter Pitch
		if tick % 2 == 0 then
			va.x = 89;
		else 
			va.x = -89;
		end
	elseif pitch_present:GetValue() == 2 then -- Fake Pitch
		va.x = fake_pitch; --exploit fake pitch 
	elseif pitch_present:GetValue() == 3 then -- Fake Jitter
		if tick % 2 == 0 then 
			va.x = 179;
		else 
			va.x = -179;
		end
	elseif pitch_present:GetValue() == 4 then -- sine pitch
		va.x = math.sin(tick * (1 / 4)) * 89;
	elseif pitch_present:GetValue() == 5 then -- Custom
		va.x = pitch_slider:GetValue();
	end

	-- check roll angle + present
	if roll_present:GetValue() == 1 then -- Wave camera
		va.z = math.sin(tick * (1 / 100)) * 45;
	elseif roll_present:GetValue() == 2 then -- Spinning camera
		va.z = (tick * 1) % 360;
	elseif roll_present:GetValue() == 3 then -- Camera Upside
		va.z = -180;
	elseif roll_present:GetValue() == 4 then -- Custom roll
		va.z = roll_slider:GetValue();
	end

	-- check override
	if override == 1 then -- right
		va.y = yaw_base - 90;
	elseif override == 2 then -- left
		va.y = yaw_base + 90;
	elseif override == 3 then -- forward
		va.y = yaw_base; 
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
		draw.TextShadow(center_x - offset_text,  center_y + offset_text_y, "YAW: " .. current_yaw)
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "PITCH: " .. current_pitch)
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "ROLL: " .. current_roll)	
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "FWD: " .. current_fwd .. " | SIDE: " .. current_side)	
		offset_text_y = offset_text_y + offset_y
		draw.TextShadow(center_x - offset_text, center_y + offset_text_y, "MOVE: " .. current_movetype .. " | ACTUAL: " .. current_actual)	
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
	--gui.Command("clear");
end)
