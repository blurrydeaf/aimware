--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]



	--##### AUTO UPDATER ##### credit: m0nsterJ
local local_version = "1.0"
local name_script = "CustomJitter.lua"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/version_customjitter.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/refs/heads/main/scripts/customjitter.lua"
local devmode = false
if "nil" == tostring(github_version) then 
	print("Enable LUA permission 'Allow internet connections...'")
elseif local_version > tostring(github_version) then --dev mode
	gui.Command("clear")
	print("*** ENABLE  DEVMODE ***")
	print(""..name_script.." local v" ..local_version.. "; cloud v" .. tostring(github_version) .. "")
	devmode = true
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


		--##### REFERENCE #####
local reference 	= gui.Reference("Ragebot");
	local tab 			= gui.Tab(reference, "customjitter", "CustomJitter.lua");
		local tab_base		= gui.Groupbox(tab, "Anti-aim Base", 10, 10, 200, 1);
			local base_yaw			= gui.Combobox(tab_base, "base_yaw", "Yaw", "Viewangles", "At target");
			local base_present		= gui.Combobox(tab_base, "base_present", "Present", "Disable", "Backjitter", "Sidejitter", "Random", "Custom");
			local base_jitter		= gui.Combobox(tab_base, "base_jitter", "Jitter", "Center");
			local base_range		= gui.Slider(tab_base, "base_range", "Range", 50, 0, 180, 1);
			local base_angle		= gui.Slider(tab_base, "base_angle", "Angle", 180, -180, 180, 1);
			local base_3way			= gui.Checkbox(tab_base, "base_3way", "3-way", false); 
			if devmode == true then
				debugmode = gui.Checkbox(tab_base, "debugmode", "Debug mode", true); 
			end
		
		local tab_pitch			= gui.Groupbox(tab, "Anti-aim Pitch", 220, 10, 200, 1);
			local pitch_present		= gui.Combobox(tab_pitch, "pitch_present", "Present", "Disable", "UpDown", "FlickUp", "Random", "Custom");
			local pitch_jitter		= gui.Combobox(tab_pitch, "pitch_jitter", "Jitter", "Center");
			local pitch_range		= gui.Slider(tab_pitch, "pitch_range", "Range", 30, 0, 89, 1);
			local pitch_angle		= gui.Slider(tab_pitch, "pitch_angle", "Angle", 10, -89, 89, 1);
		
		local tab_override		= gui.Groupbox(tab, "Anti-aim Override", 430, 10, 200, 1);
			local override_right	= gui.Keybox(tab_override, "override_right", "Right", 0);
			local override_left		= gui.Keybox(tab_override, "override_left", "Left", 0);
			local override_forward	= gui.Keybox(tab_override, "override_forward", "Forward", 0);
			local override_back		= gui.Keybox(tab_override, "override_back", "Back", 0);
			
			
		--##### VARIABLE #####
local font = draw.CreateFont("Verdana", 24, 100); 
local preva = EulerAngles(); 
local set_yaw = 180; 
local override = 0;


		--##### DRAW FUNC #####
local function checker_func()

	if base_yaw:GetValue() == 0 then -- Viewangles
		gui.SetValue("rbot.antiaim.condition.autodir.targets", false);
	elseif base_yaw:GetValue() == 1 then -- At target
		gui.SetValue("rbot.antiaim.condition.autodir.targets", true);
	end

 	if override_right:GetValue() ~= 0 and input.IsButtonPressed(override_right:GetValue()) then -- override right
		if override == 1 then
			override = 0; 
		else
			override = 1;
		end
	end
	if override_left:GetValue() ~= 0 and input.IsButtonPressed(override_left:GetValue()) then -- override left
		if override == 2 then
			override = 0; 
		else
			override = 2;
		end
	end
	if override_forward:GetValue() ~= 0 and input.IsButtonPressed(override_forward:GetValue()) then -- override forward
		if override == 3 then
			override = 0; 
		else
			override = 3;
		end
	end
	if override_back:GetValue() ~= 0 and input.IsButtonPressed(override_back:GetValue()) then -- override back
		if override == 4 then
			override = 0; 
		else
			override = 4;
		end
	end

end


		--##### PRE CREATEMOVE #####
local function preva_func(cmd)
	preva = cmd:GetViewAngles();
end


		--##### ANTIAIM BASE #####
local function antiaim_base()

	if override == 0 then
	
		if base_present:GetValue() == 1 then -- Backjitter
			
			if base_3way:GetValue() then
				if globals.TickCount()%4 == 0 then
					set_yaw = -140; 
				elseif globals.TickCount()%4 == 2 then
					set_yaw = 140; 
				else
					set_yaw = -180; 
				end
			else
				if globals.TickCount()%2 == 0 then
					set_yaw = -140; 
				else 
					set_yaw = 140;
				end
			end
			
		elseif base_present:GetValue() == 2 then -- Sidejitter
		
			if base_3way:GetValue() then
				if globals.TickCount()%4 == 0 then
					set_yaw = -100; 
				elseif globals.TickCount()%4 == 2 then
					set_yaw = 100; 
				else
					set_yaw = -180; 
				end
			else
				if globals.TickCount()%2 == 0 then
					set_yaw = -110; 
				else 
					set_yaw = 110;
				end
			end
			
		elseif base_present:GetValue() == 3 then -- Random
		
			if globals.TickCount()%2 == 0 then
				set_yaw = math.random(-180,0); 
			else 
				set_yaw = math.random(0,180);
			end
			
		elseif base_present:GetValue() == 4 then -- Custom
		
			if base_jitter:GetValue() == 0 then -- Center
			
				if base_3way:GetValue() then
				
					if globals.TickCount()%4 == 0 then
						set_yaw = base_angle:GetValue() - base_range:GetValue();  
					elseif globals.TickCount()%4 == 2 then
						set_yaw = base_angle:GetValue() + base_range:GetValue();
					else
						set_yaw = base_angle:GetValue(); 
					end
					
				else
				
					if globals.TickCount()%2 == 0 then
						set_yaw = base_angle:GetValue() - base_range:GetValue(); 
					else 
						set_yaw = base_angle:GetValue() + base_range:GetValue();
					end
					
				end
			end
		end
		
	elseif override == 1 then
		set_yaw = -90;
	elseif override == 2 then
		set_yaw = 90;
	elseif override == 3 then
		set_yaw = 0;
	elseif override == 4 then
		set_yaw = -180;
	end

	if set_yaw > 180 then
		set_yaw = set_yaw - 360;
	elseif set_yaw < -180 then
		set_yaw = set_yaw + 360;
	elseif set_yaw == 0 then -- Fix bug antiaim pitch
		set_yaw = set_yaw + 1
	end
	
	gui.SetValue("rbot.antiaim.base", set_yaw.." Backward");
	--print("set_yaw: " ..tostring(set_yaw)); --Debug
	
end


		--##### ANTIAIM PITCH #####
local function antiaim_pitch(cmd)

	local va = cmd:GetViewAngles();
	
	if va.x == preva.x and va.y == preva.y then return end
	
	if pitch_present:GetValue() == 0 then return -- Disable
	
	elseif pitch_present:GetValue() == 1 then -- UpDown
	
		if globals.TickCount()%2 == 0 then
			va.x = -89; 
		else 
			va.x = 89; 
		end
		
	elseif pitch_present:GetValue() == 2 then -- FlickUp
		
		if globals.TickCount()%64 == 0 then
			va.x = -89; 
		else 
			va.x = 89; 
		end
		
	elseif pitch_present:GetValue() == 3 then -- Random
	
		if globals.TickCount()%2 == 0 then
			va.x = math.random(-89,0); 
		else
			va.x = math.random(0,89);
		end
		
	elseif pitch_present:GetValue() == 4 then -- Custom
	
		if globals.TickCount()%2 == 0 then
			va.x = pitch_angle:GetValue() - pitch_range:GetValue(); 
		else 
			va.x = pitch_angle:GetValue() + pitch_range:GetValue();
		end
		
	end
	
	if va.x > 89 then
		va.x = va.x - 45;
	elseif va.x < -89 then
		va.x = va.x + 45;
	end
	
	cmd:SetViewAngles(va)
	--print("pitch: " ..tostring(va.x)) --Debug
	
end


		--##### DEV MODE #####
local function devmode_func()
	
	if devmode == true and debugmode:GetValue() then 
		
		draw.SetFont(font); draw.Color(70, 250, 20, 255); local screen_x, screen_y = 25, 450;
		draw.TextShadow(screen_x, screen_y, "globalsTickCount: " ..tostring(globals.TickCount()).. ""); screen_y = screen_y + 25;
		draw.TextShadow(screen_x, screen_y, "globalsFrameCount: " ..tostring(globals.FrameCount()).. ""); screen_y = screen_y + 25;
		--print("TickCount: "..tostring(globals.TickCount()%64).. " | FrameCount: " ..tostring(globals.FrameCount()%1000).. " "); --Debug
		
		screen_y = screen_y + 25;
		draw.TextShadow(screen_x, screen_y, "globalsRealTime: " ..tostring(math.floor(globals.RealTime())).. ""); screen_y = screen_y + 25;
		draw.TextShadow(screen_x, screen_y, "globalsCurTime: " ..tostring(math.floor(globals.CurTime())).. "");screen_y = screen_y + 25;
		
		--screen_y = screen_y + 25;
		--draw.TextShadow(screen_x, screen_y, "globalsFrameTime: " ..tostring(globals.FrameTime()).. ""); screen_y = screen_y + 25;
		--draw.TextShadow(screen_x, screen_y, "globalsAbsoluteFrameTime: " ..tostring(globals.AbsoluteFrameTime()).. "");screen_y = screen_y + 25;
		
		screen_y = screen_y + 25;
		draw.TextShadow(screen_x, screen_y, "millisecond: " ..tostring(math.floor(common.Time()*1000)).. " ");screen_y = screen_y + 25
		draw.TextShadow(screen_x, screen_y, "second: " ..tostring(math.floor(common.Time())).. " ");screen_y = screen_y + 25
		
		screen_y = screen_y + 25;
		draw.TextShadow(screen_x, screen_y, "Frametime: " ..tostring(math.floor((globals.FrameTime()*10000/10)+0.5)).. " ms");screen_y = screen_y + 25;
		draw.TextShadow(screen_x, screen_y, "FPS: " ..tostring(math.floor(1/globals.AbsoluteFrameTime())));screen_y = screen_y + 25;
		
	end
end


--##### CALL BACKS #####
callbacks.Register("Draw", function()
	checker_func()
	devmode_func()
end)

callbacks.Register("CreateMove", function(cmd)
	antiaim_base()
	antiaim_pitch(cmd)
end)

callbacks.Register("PreMove", function(cmd)
	preva_func(cmd)
end)

callbacks.Register("Unload", function()
    gui.SetValue("rbot.antiaim.base", "0 Off");
	gui.SetValue("rbot.antiaim.left", "0 Off");
	gui.SetValue("rbot.antiaim.right", "0 Off");
	gui.SetValue("rbot.antiaim.condition.autodir.edges", false);
	gui.SetValue("rbot.antiaim.advanced.pitch", 0);
	gui.Command("clear");
end)



--[[
CHANGELOG
v0.1 +added jitter yaw; 
	 +added jitter pitch;
	 +added auto-updater; 
	 +fixed bug minor antiaim
v0.2 +added aa edges and right;
	 +added jitter random and custom 
	 +Improved menu gui
v0.3 +added GUI esay settings for new players, 
	 +added new AA builders(Forjitter, backjitter, sidejitter, edegesjitter and flick), 
	 +added new selection speed box fastest to slowest
	 -removed sliders speed aa base, edges and pitch
	 +Improve AA edges(left and right).
v1.0
	+Added override antiaim
	+Added jitter 3-WAY
	+Remake code jitter, custom, pitch, etc
	+Remake menu GUI
	+Removed AA edges
	+Removed presents forjitter, edgejitters and flicks
	+Removed custom tickbase
	+Removed selections fastest to slowest
	+Fixed bug yaw 0ºdegree
	+Optimized code
	
---SOON
cache backup config.+ unload back to cache orignal
 new aa build pitch ~45
cs2 limit angle move 102º per 4 tick ?
jtter offet
pitch 3way

--]]
