--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]
--##### AUTO UPDATER ##### credit: m0nsterJ
local local_version = "0.2"
local name_script = "CustomJitter.lua"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/version_customjitter.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/CustomJitter.lua"
print("Script "..name_script.." version: local v" ..local_version.. "; lastest v" .. tostring(github_version) .. "")
if "nil" == tostring(github_version) then 
	print("Enable LUA permission 'Allow internet connections...'")
elseif local_version > tostring(github_version) then --dev mode
	print("**SCRIPT DEV MODE***")
	print("**SCRIPT DEV MODE***")
	print("**SCRIPT DEV MODE***")
elseif local_version < tostring(github_version) then
	print("your version outdated")
	print("Now updating " ..local_script_name)
    file.Delete(local_script_name)
    print("Successfully deleted old version of " ..local_script_name)
    file.Write(local_script_name, http.Get(github_source_url))
    local_version = github_version
    print("Successfully updated " ..local_script_name)
---@diagnostic disable-next-line: undefined-global
    UnloadScript(local_script_name)
end
--##### VARIABLE #####
local player_name = cheat.GetUserName(); 
local font = draw.CreateFont("Bahnschrift", 35, 100);
local yaw,pitch,roll, preva, x,y = 0,0,0, EulerAngles(nil,nil,nil), 25,450;
--##### REFERENCE #####
local reference 	= gui.Reference("Ragebot");
	local tab 			= gui.Tab(reference, "customjitter", "CustomJitter.lua");
		local aa_yaw		= gui.Groupbox(tab, "Anti-aim Base", 10, 10, 200, 1);
			--local enable_yaw		= gui.Checkbox(aa_yaw, "enable_yaw", "Enable Yaw", false);
			local box_yaw			= gui.Combobox(aa_yaw, "box_yaw", "Type Yaw", "Disable", "Jitter", "Random");
			local speed_yaw			= gui.Slider(aa_yaw, "speed_yaw", "Speed", 2, 2, 16, 2);
			local jitter1_yaw		= gui.Slider(aa_yaw, "jitter1_yaw", "Jitter yaw 1", 1, -180, 180, 1);
			local jitter2_yaw		= gui.Slider(aa_yaw, "jitter2_yaw", "Jitter yaw 2", 1, -180, 180, 1);
		local aa_left				= gui.Groupbox(tab, "Anti-aim Left ", 220, 10, 200, 1);
			local box_left			= gui.Combobox(aa_left, "box_left", "Type left", "Disable", "Jitter", "Random");
			local speed_left		= gui.Slider(aa_left, "speed_left", "Speed", 2, 2, 16, 2);
			local jitter1_left		= gui.Slider(aa_left, "jitter1_left", "Jitter left 1", 1, -180, 180, 1);
			local jitter2_left		= gui.Slider(aa_left, "jitter2_left", "Jitter left 2", 1, -180, 180, 1);
		local aa_right				= gui.Groupbox(tab, "Anti-aim Right", 430, 10, 200, 1);
			local box_right			= gui.Combobox(aa_right, "box_right", "Type right", "Disable", "Jitter", "Random");
			local speed_right		= gui.Slider(aa_right, "speed_right", "Speed", 2, 2, 16, 2);
			local jitter1_right		= gui.Slider(aa_right, "jitter1_right", "Jitter right 1", 1, -180, 180, 1);
			local jitter2_right		= gui.Slider(aa_right, "jitter2_right", "Jitter right 2", 1, -180, 180, 1);
		local aa_pitch				= gui.Groupbox(tab, "Anti-aim Pitch", 10, 270, 200, 1);
			local box_pitch			= gui.Combobox(aa_pitch, "box_pitch", "Type Pitch", "Disable", "Jitter", "Random");
			--local invalid_pitch		= gui.Checkbox(aa_pitch, "invalid_pitch", "Invalid Pitch ", false);
			local speed_pitch		= gui.Slider(aa_pitch, "speed_pitch", "Speed", 2, 2, 16, 2);
			local jitter1_pitch		= gui.Slider(aa_pitch, "jitter1_pitch", "Jitter pitch 1", 1, -89, 89, 1);
			local jitter2_pitch		= gui.Slider(aa_pitch, "jitter2_pitch", "Jitter pitch 2", 1, -89, 89, 1);
--##### DRAW FUNC #####
local function checker_func()
	if box_yaw:GetValue() == 0 then
		speed_yaw:SetInvisible(false)
		speed_yaw:SetDisabled(true)
		jitter1_yaw:SetDisabled(true)
		jitter2_yaw:SetDisabled(true)
	elseif box_yaw:GetValue() == 1 then
		speed_yaw:SetInvisible(false)
		speed_yaw:SetDisabled(false)
		jitter1_yaw:SetDisabled(false)
		jitter2_yaw:SetDisabled(false)
	elseif box_yaw:GetValue() == 2 then
		speed_yaw:SetInvisible(true)
		speed_yaw:SetDisabled(true)
		jitter1_yaw:SetDisabled(false)
		jitter2_yaw:SetDisabled(false)
	end
	if box_left:GetValue() == 0 then
		speed_left:SetDisabled(true)
		jitter1_left:SetDisabled(true)
		jitter2_left:SetDisabled(true)
	elseif box_left:GetValue() == 1 then
		speed_left:SetDisabled(false)
		jitter1_left:SetDisabled(false)
		jitter2_left:SetDisabled(false)
	elseif box_left:GetValue() == 2 then
		speed_left:SetDisabled(true)
		jitter1_left:SetDisabled(false)
		jitter2_left:SetDisabled(false)
	end
	if box_right:GetValue() == 0 then
		speed_right:SetDisabled(true)
		jitter1_right:SetDisabled(true)
		jitter2_right:SetDisabled(true)
	elseif box_right:GetValue() == 1 then
		speed_right:SetDisabled(false)
		jitter1_right:SetDisabled(false)
		jitter2_right:SetDisabled(false)
	elseif box_right:GetValue() == 2 then
		speed_right:SetDisabled(true)
		jitter1_right:SetDisabled(false)
		jitter2_right:SetDisabled(false)
	end
	if box_pitch:GetValue() == 0 then
		speed_pitch:SetInvisible(false)
		speed_pitch:SetDisabled(true)
		jitter1_pitch:SetDisabled(true)
		jitter2_pitch:SetDisabled(true)
	elseif box_pitch:GetValue() == 1 then
		speed_pitch:SetInvisible(false)
		speed_pitch:SetDisabled(false)
		jitter1_pitch:SetDisabled(false)
		jitter2_pitch:SetDisabled(false)
	elseif box_pitch:GetValue() == 2 then
		speed_pitch:SetInvisible(true)
		jitter1_pitch:SetDisabled(false)
		jitter2_pitch:SetDisabled(false)
	end
end
--##### PRE CREATEMOVE #####
local function preva_func(cmd)
	preva = cmd:GetViewAngles();
end
--##### ANTIAIM YAW #####
local function antiaim_yaw()
	local halftick_yaw = speed_yaw:GetValue()/2;
	local tickcount_yaw = globals.TickCount() %speed_yaw:GetValue();
	if box_yaw:GetValue() == 0 then return
	elseif box_yaw:GetValue() == 1 then
		if halftick_yaw <= tickcount_yaw then
			yaw = jitter1_yaw:GetValue()
		else
			yaw = jitter2_yaw:GetValue()
		end
	elseif box_yaw:GetValue() == 2 then
		yaw = math.random(jitter1_yaw:GetValue(),jitter2_yaw:GetValue())
	end
	gui.SetValue("rbot.antiaim.base",""..yaw.." Backward") -- rbot.antiaim.base
	--print("yaw: " ..tostring(yaw).. "") --debug
end
--##### ANTIAIM LEFT #####
local function antiaim_left()
	local halftick_left = speed_left:GetValue()/2;
	local tickcount_left = globals.TickCount() %speed_left:GetValue();
	if box_left:GetValue() == 0 then return
	elseif box_left:GetValue() == 1 then
		if halftick_left <= tickcount_left then
			left = jitter1_left:GetValue()
		else
			left = jitter2_left:GetValue()
		end
	elseif box_left:GetValue() == 2 then
		left = math.random(jitter1_left:GetValue(),jitter2_left:GetValue())
	end
	gui.SetValue("rbot.antiaim.left",""..left.." Backward") --rbot.antiaim.left
	--print("left: " ..tostring(left).. "") --debug
end
--##### ANTIAIM RIGHT #####
local function antiaim_right()
	local halftick_right = speed_right:GetValue()/2;
	local tickcount_right = globals.TickCount() %speed_right:GetValue();
	if box_right:GetValue() == 0 then return
	elseif box_right:GetValue() == 1 then
		if halftick_right <= tickcount_right then
			right = jitter1_right:GetValue()
		else
			right = jitter2_right:GetValue()
		end
	elseif box_right:GetValue() == 2 then
		right = math.random(jitter1_right:GetValue(),jitter2_right:GetValue())
	end
	gui.SetValue("rbot.antiaim.right",""..right.." Backward") --rbot.antiaim.right
	--print("right: " ..tostring(right).. "") --debug
end
--##### ANTIAIM PITCH #####
local function antiaim_pitch(cmd)
	local halftick_pitch = speed_pitch:GetValue()/2;
	local tickcount_pitch = globals.TickCount() %speed_pitch:GetValue();
	local va = cmd:GetViewAngles();
	if va.x == preva.x and va.y == preva.y then return end
	if box_pitch:GetValue() == 0 then return
	elseif box_pitch:GetValue() == 1 then
		if halftick_pitch <= tickcount_pitch then
			va.x = jitter1_pitch:GetValue()
		else
			va.x = jitter2_pitch:GetValue()
		end
	elseif box_pitch:GetValue() == 2 then
		va.x = math.random(jitter1_pitch:GetValue(),jitter2_pitch:GetValue())
	end
	cmd:SetViewAngles(va)
	--print("pitch: " ..tostring(va.x).. "") --debug
end
--[[
local function devmode_func()
	local speed_yaw = speed_yaw:GetValue();
	local halftick_yaw = speed_yaw/2;
	local tickcount_yaw = globals.TickCount() %speed_yaw;
	local time = math.floor(common.Time());
	local curtime = math.floor(globals.CurTime());
	local absoluteframetime = math.floor(globals.AbsoluteFrameTime()*100000)/100+0.05;
	local framerate = math.floor(1/globals.AbsoluteFrameTime());
	draw.SetFont(font);
	draw.Color(255, 50, 50, 255);
	draw.TextShadow(x, y+25, "speed_yaw: " ..tostring(speed_yaw).. "");
	draw.TextShadow(x, y+50, "halftick_yaw: " ..tostring(halftick_yaw).. "");
	draw.TextShadow(x, y+75, "tickcount_yaw: " ..tostring(tickcount_yaw).. "");
	draw.TextShadow(x, y+100, "time: " ..tostring(time).. "");
	draw.TextShadow(x, y+125, "curtime: " ..tostring(curtime).. "");
	draw.TextShadow(x, y+150, "absoluteframetime: " ..tostring(absoluteframetime).. " ms");
	draw.TextShadow(x, y+175, "framerate: " ..tostring(framerate).. " FPS");
end
--]]
--##### CALL BACKS #####
callbacks.Register("Draw", function()
	--devmode_func()
	checker_func()
end)
callbacks.Register("CreateMove", function(cmd)
	antiaim_yaw()
	antiaim_left()
	antiaim_right()
	antiaim_pitch(cmd)
end)
callbacks.Register("PreMove", function(cmd)
	preva_func(cmd)
end)
callbacks.Register("Unload", function()
    gui.SetValue("rbot.antiaim.base", "0 Off");
end)
--[[
CHANGELOG
v0.1 +added jitter yaw; +added jitter pitch;+added auto-updater; *fixed antiaim suck
v0.2 +added aa left and right;+added more type jitter, random, ;Improved menu gui
FLICK
hold per Tick
random jitter
tick / 3 example -90 > 180(back) or 0(front) > 90 > loop
Combobox edge: base, left and right
Combobox AA: jitter, flick and random
--]]
