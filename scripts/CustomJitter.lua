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
print(""..name_script.." local current: v" ..local_version.. ", cloud lastest: v" .. tostring(github_version) .. "")
if "nil" == tostring(github_version) then 
	print("Enable lua permission 'Allow internet connections...'")
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
local edge  = "base"
--##### REFERENCE #####
local reference 	= gui.Reference("SETTINGS"); 
	local tab 			= gui.Tab(reference, "customjitter", "CustomJitter.lua"); 
		local antiaim		= gui.Groupbox(tab, "Anti-aim", 10, 10, 300, 1); 
			local enable_yaw		= gui.Checkbox(antiaim, "enable_yaw", "Enable Yaw", false);
			local speed_yaw			= gui.Slider(antiaim, "speed_yaw", "Speed", 2, 2, 64, 2); 
			local jitter1_yaw		= gui.Slider(antiaim, "jitter1_yaw", "Jitter yaw 1", 1, -180, 180, 1);
			local jitter2_yaw		= gui.Slider(antiaim, "jitter2_yaw", "Jitter yaw 2", 1, -180, 180, 1);		
			local enable_pitch		= gui.Checkbox(antiaim, "enable_pitch", "Enable Pitch ", false);
			local speed_pitch		= gui.Slider(antiaim, "speed_pitch", "Speed", 2, 2, 64, 2); 
			local jitter1_pitch		= gui.Slider(antiaim, "jitter1_pitch", "Jitter pitch 1", 1, -89, 89, 1);
			local jitter2_pitch		= gui.Slider(antiaim, "jitter2_pitch", "Jitter pitch 2", 1, -89, 89, 1);
--##### PRE CREATEMOVE #####
local function preva_func(cmd)
	preva = cmd:GetViewAngles();
end
--##### ANTIAIM RAGE #####
local function antiaim_func(cmd)
	local speed_yaw = speed_yaw:GetValue()
	local halftick_yaw = speed_yaw/2
	local tickcount_yaw = globals.TickCount() %speed_yaw
	if enable_yaw:GetValue() then
		if halftick_yaw <= tickcount_yaw then
			yaw = jitter1_yaw:GetValue()
		else
			yaw = jitter2_yaw:GetValue()
		end
		--print("yaw: " ..tostring(yaw).. "") --debug
		gui.SetValue("rbot.antiaim.".. edge, yaw .. " Backward")
	end
	local speed_pitch = speed_pitch:GetValue()
	local halftick_pitch = speed_pitch/2
	local tickcount_pitch = globals.TickCount() %speed_pitch
	if enable_pitch:GetValue() then
		local va = cmd:GetViewAngles()
		if va.x == preva.x and va.y == preva.y then return end
		
		if halftick_pitch <= tickcount_pitch then
			va.x = jitter1_pitch:GetValue()
		else
			va.x = jitter2_pitch:GetValue()
		end
		--print("pitch: " ..tostring(va.x).. "") --debug
		cmd:SetViewAngles(va)
	end
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
end)
callbacks.Register("CreateMove", function(cmd)
	antiaim_func(cmd)
end)
callbacks.Register("PreMove", function(cmd)
	preva_func(cmd)
end)
callbacks.Register("Unload", function()
    gui.SetValue("rbot.antiaim.base", "0 Off");
end)
--[[
CHANGELOG
v0.1 +added jitter yaw
v0.2 +added jitter pitch;+added auto-updater; *fixed antiaim suck
FLICK
hold per Tick
random jitter
tick / 3 example -90 > 180(back) or 0(front) > 90 > loop
Combobox edge: base, left and right
Combobox AA: jitter, flick and random
--]]
