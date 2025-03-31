--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]
--##### AUTO UPDATER ##### credit: m0nsterJ
local local_version = "0.3"
local name_script = "CustomJitter.lua"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/version_customjitter.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/CustomJitter.lua"
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
--##### VARIABLE #####
--local player_name = cheat.GetUserName();
local font = draw.CreateFont("Bahnschrift", 35, 100);
local preva, x,y = EulerAngles(), 25,450;
--##### REFERENCE #####
local reference 	= gui.Reference("Ragebot");
	local tab 			= gui.Tab(reference, "customjitter", "CustomJitter.lua");
		local aa_base		= gui.Groupbox(tab, "Anti-aim Base", 10, 10, 200, 1);
			local box_base			= gui.Combobox(aa_base, "box_base", "Type base", "Disable", "Frontjitter", "Backjitter","Sidejitter" ,"Random", "Custom");
			local speed_box_base	= gui.Combobox(aa_base, "speed_box_base", "Type Speed","Fastest", "Faster", "More fast", "Fast", "Slow" ,"More slow", "Slower","Slowest");
			--local speed_slider_base		= gui.Slider(aa_base, "speed_slider_base", "Speed", 2, 2, 16, 2);
			local jitter1_base		= gui.Slider(aa_base, "jitter1_base", "Offset base 1", 1, -180, 180, 1);
			local jitter2_base		= gui.Slider(aa_base, "jitter2_base", "Offset base 2", 1, -180, 180, 1);
		local aa_edges				= gui.Groupbox(tab, "Anti-aim Edges ", 220, 10, 200, 1);
			local box_edges			= gui.Combobox(aa_edges, "box_edges", "Type edges", "Disable", "Edgejitter", "Flick", "Random", "Custom");
			local speed_box_edges	= gui.Combobox(aa_edges, "speed_box_edges", "Type Speed","Fastest", "Faster", "More fast", "Fast", "Slow" ,"More slow", "Slower","Slowest");
			--local speed_edges		= gui.Slider(aa_edges, "speed_edges", "Speed", 2, 2, 16, 2);
			local jitter1_left		= gui.Slider(aa_edges, "jitter1_edges", "Offset left 1", 1, -180, 180, 1);
			local jitter2_left		= gui.Slider(aa_edges, "jitter2_edges", "Offset left 2", 1, -180, 180, 1);
			local jitter1_right		= gui.Slider(aa_edges, "jitter1_right", "Offset right 1", 1, -180, 180, 1);
			local jitter2_right		= gui.Slider(aa_edges, "jitter2_right", "Offset right 2", 1, -180, 180, 1);
		local aa_pitch				= gui.Groupbox(tab, "Anti-aim Pitch", 430, 10, 200, 1);
			local box_pitch			= gui.Combobox(aa_pitch, "box_pitch", "Type pitch", "Disable", "Flickup", "Random", "Custom");
			local speed_box_pitch	= gui.Combobox(aa_pitch, "speed_box_pitch", "Type Speed","Fastest", "Faster", "More fast", "Fast", "Slow" ,"More slow", "Slower","Slowest");
			--local speed_pitch		= gui.Slider(aa_pitch, "speed_pitch", "Speed", 2, 2, 16, 2);
			local jitter1_pitch		= gui.Slider(aa_pitch, "jitter1_pitch", "Offset pitch 1", 1, -89, 89, 1);
			local jitter2_pitch		= gui.Slider(aa_pitch, "jitter2_pitch", "Offset pitch 2", 1, -89, 89, 1);
--##### DRAW FUNC #####
local function checker_func()
--[[
	local box_select = speed_box_base:GetValue()
	local box_check = (box_select+1)*2
	local slider_select = speed_slider_base:GetValue()
	local slider_check = math.floor((slider_select-1)/2)
	--print("box_select: "..box_select..", slider_select: "..slider_select..", box_check: "..box_check..", slider_check: "..slider_check.."")
	if slider_select ~= box_check and box_base:GetValue() ~= 5 then
		--print("not equal")
		gui.SetValue("rbot.customjitter.speed_slider_base", box_check) --rbot.customjitter.speed_slider_base
	elseif box_select ~= slider_check then
		--print("not equal")
		gui.SetValue("rbot.customjitter.speed_box_base", slider_check) -- rbot.customjitter.speed_box_base
	end
]]--
	if box_base:GetValue() ~= 5 then
		jitter1_base:SetDisabled(true);
		jitter2_base:SetDisabled(true);
	else
		jitter1_base:SetDisabled(false);
		jitter2_base:SetDisabled(false);
	end
	if box_edges:GetValue() ~= 4 then
		jitter1_left:SetDisabled(true);
		jitter2_left:SetDisabled(true);
		jitter1_right:SetDisabled(true);
		jitter2_right:SetDisabled(true);
	else
		jitter1_left:SetDisabled(false);
		jitter2_left:SetDisabled(false);
		jitter1_right:SetDisabled(false);
		jitter2_right:SetDisabled(false);
	end
	if box_pitch:GetValue() ~= 3 then
		jitter1_pitch:SetDisabled(true);
		jitter2_pitch:SetDisabled(true);
	else
		jitter1_pitch:SetDisabled(false);
		jitter2_pitch:SetDisabled(false);
	end
end
--##### PRE CREATEMOVE #####
local function preva_func(cmd)
	preva = cmd:GetViewAngles();
end
--##### ANTIAIM BASE #####
local function antiaim_base()
	local box_select = (speed_box_base:GetValue()+1)*2;
	local box_check = box_select/2;
	local tickcount_base = globals.TickCount() %box_select;
	--print("box_select: "..box_select.. " box_check: "..box_check.." tickcount_base: "..tickcount_base.."")
	if box_base:GetValue() == 0 then return -- Disable
	elseif box_base:GetValue() == 1 then -- Frontjitter
		if box_check <= tickcount_base then
			base = 60; else base = -60;
		end
	elseif box_base:GetValue() == 2 then -- Backjitter
		if box_check <= tickcount_base then
			base = 140 else base = -140;
		end
	elseif box_base:GetValue() == 3 then -- Sidejitter
		if box_check <= tickcount_base then
			base = 100; else base = -100;
		end
	elseif box_base:GetValue() == 4 then -- Random
		base = math.random(-180,180);
	elseif box_base:GetValue() == 5 then -- Custom
		if box_check <= tickcount_base then
			base = jitter1_base:GetValue(); else base = jitter2_base:GetValue();
		end
	end
	gui.SetValue("rbot.antiaim.base",""..base.." Backward"); -- rbot.antiaim.base
	--print("base: " ..tostring(base).. ""); --debug
end
--##### ANTIAIM EDGES #####
local function antiaim_edges()
	local box_select = (speed_box_edges:GetValue()+1)*2;
	local box_check = box_select/2;
	local tickcount_edges = globals.TickCount() %box_select;
	if box_edges:GetValue() >= 1 then
		gui.SetValue("rbot.antiaim.condition.autodir.edges", true)
	end
	if box_edges:GetValue() == 0 then return  -- Disable
	elseif box_edges:GetValue() == 1 then -- Edgesjitter
		if box_check <= tickcount_edges then
			left = 15; 
			right = -15; 
		else
			left = 165; 
			right = -165; 
		end
	elseif box_edges:GetValue() == 2 then -- Flick
		local flick = globals.TickCount()%16
		if flick >= 14 then
			left = -90; 
			right = 90;
		else
			left = 90; 
			right = -90;
		end
	elseif box_edges:GetValue() == 3 then -- Random
		left = math.random(-180,180);
		right = math.random(-180,180);
	elseif box_edges:GetValue() == 4 then -- Custom
		if box_check <= tickcount_edges then
			left = jitter1_left:GetValue(); 
			right = jitter1_right:GetValue(); 
		else 
			left = jitter2_left:GetValue();
			right = jitter2_right:GetValue(); 
		end
	end
	gui.SetValue("rbot.antiaim.left", ""..left.." Backward")
	gui.SetValue("rbot.antiaim.right",""..right.." Backward")
	--print("edges: " ..tostring(edges).. "") --debug
end
--##### ANTIAIM PITCH #####
local function antiaim_pitch(cmd)
	local box_select = (speed_box_edges:GetValue()+1)*2;
	local box_check = box_select/2;
	local tickcount_pitch = globals.TickCount() %box_select;
	
	local va = cmd:GetViewAngles();
	if va.x == preva.x and va.y == preva.y then return end
	if box_pitch:GetValue() == 0 then return -- Disable
	elseif box_pitch:GetValue() == 1 then -- Flick
		local flick = globals.TickCount()%16
		if flick >= 14 then
			va.x = -89; else va.x = 89; 
		end
	elseif box_pitch:GetValue() == 2 then -- Random
		va.x = math.random(-89,89);
	elseif box_pitch:GetValue() == 3 then -- Custom
		if box_check <= tickcount_pitch then
			va.x = jitter1_pitch:GetValue(); else va.x = jitter2_pitch:GetValue();
		end
	end
	cmd:SetViewAngles(va)
	--print("pitch: " ..tostring(va.x).. "") --debug
end
--##### DEV MODE #####
local function devmode_func()
	if devmode == true then
	local box_select = (speed_box_base:GetValue()+1)*2;
	local box_check = box_select/2;
	local tickcount = globals.TickCount();
	local tickcount_select = globals.TickCount() %box_select;
		local time = math.floor(common.Time());
		local curtime = math.floor(globals.CurTime());
		local absoluteframetime = math.floor(globals.AbsoluteFrameTime()*10000)/10;
		local framerate = math.floor(1/globals.AbsoluteFrameTime());
	draw.SetFont(font);
	draw.Color(255, 50, 50, 255);
	draw.TextShadow(x, y+25, "box_select: " ..tostring(box_select).. "");
	draw.TextShadow(x, y+50, "box_check: " ..tostring(box_check).. "");
	draw.TextShadow(x, y+75, "tickcount: " ..tostring(tickcount).. "");
	draw.TextShadow(x, y+100, "tickcount_select: " ..tostring(tickcount_select).. "");
	draw.TextShadow(x, y+125, "time: " ..tostring(time).. "");
	draw.TextShadow(x, y+150, "curtime: " ..tostring(curtime).. "");
	draw.TextShadow(x, y+175, "absoluteframetime: " ..tostring(absoluteframetime).. " ms");
	draw.TextShadow(x, y+200, "framerate: " ..tostring(framerate).. " FPS");
	end
end
--##### CALL BACKS #####
callbacks.Register("Draw", function()
	checker_func()
	devmode_func()
end)
callbacks.Register("CreateMove", function(cmd)
	antiaim_base()
	antiaim_edges()
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
	 +fixed antiaim suck
v0.2 +added aa edges and right;
	 +added jitter random and custom 
	 +Improved menu gui
v0.3 +added GUI esay settings for new players, 
	 +added new AA builders(Forjitter, backjitter, sidejitter, edegesjitter and flick), 
	 +added new selection box fastest to slowest
	 -removed sliders speed aa base, edges and pitch
	 +Improve AA edges(left and right).

---SOON
 3 angles loop example -90 > 180(back) or 0(front) > 90
 better code optimized and short code
 new aa build pitch ~45
--]]
