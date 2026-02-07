--[[
#########################################################
	Aimware Lua Script v6.x for Counter-Strike 2  
💖 Enjoying this script? Leave a +rep on my profile! 💖  
	Profile: https://aimware.net/forum/user/61632  
#########################################################
--]]

local tab_features = gui.Reference("Miscellaneous", "Features");
local window_enable = gui.Checkbox(tab_features, "window_enable", "Custom safemode", false);
local win_width, win_height = draw.GetScreenSize();
local width_pos2, height_pos2,margem_pos1, margem_pos2 = 300, 500, 15, 25;
local menu_active = gui.Reference("Menu");

local sm_window = gui.Window("sm_window", "Settings", win_width/7, win_height/3, width_pos2, height_pos2);
local sm_group = gui.Groupbox(sm_window, "Features", margem_pos1, margem_pos1);
local sm_enable = gui.Checkbox(sm_group, "sm_enable", "Enable script", true);
--local sm_force = gui.Checkbox(sm_group, "sm_force", "Force config", true);
--local sm_indicator = gui.Checkbox(sm_group, "sm_indicator", "Indicator", true);
local sm_maxfov = gui.Slider(sm_group, "sm_maxfov", "Maximum FOV", 3.0, 0.1, 10.0, 0.1);
	sm_maxfov:SetDescription("description no work sadly");
local sm_minsmooth = gui.Slider(sm_group, "sm_minsmooth", "Minimum smooth", 15.0, 0.25, 20.0, 0.25);
local sm_randomize = gui.Slider(sm_group, "sm_randomize", "Minimum randomize", 1.5, 0.1, 10.0, 0.1);
local sm_curve = gui.Slider(sm_group, "sm_curve", "Minimum curve", 0.2, 0.05, 2.0, 0.05);
local sm_method	= gui.Combobox(sm_group, "sm_method", "Smooth method", "Dynamic", "Static", "Disable");
local sm_autowall = gui.Checkbox(sm_group, "sm_autowall", "Penetrable wall", false);
local sm_antistricky = gui.Checkbox(sm_group, "sm_nonsticky", "Anti-Stricky", true);
local sm_recoil = gui.Slider(sm_group, "sm_recoil", "Limit recoil", 80, 1, 100, 1);

local sm_triggerdelay = gui.Slider(sm_group, "sm_maxfov", "Minimum delay", 60, 0, 200, 5);
local sm_autofire = gui.Checkbox(sm_group, "sm_autofire", "Automatic fire", false);
local sm_antispread = gui.Checkbox(sm_group, "sm_antispread", "Remove spread", false);
local sm_autostrafe = gui.Checkbox(sm_group, "sm_autostrafe", "Strafe Bhop", false);
local sm_ragebot = gui.Checkbox(sm_group, "sm_ragebot", "Ragebot", false);

local function window_func()
	if menu_active:IsActive() and window_enable:GetValue() then
		sm_window:SetActive(true);
	else
		sm_window:SetActive(false);
	end
end
callbacks.Register("Draw", window_func);

--##### SAFE MODE FUNCTION #####
local group_weapons = {"shared","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"};
local smooth_dynamic, smooth_static = "Dynamic","Static"
local function safemode_func()
	if sm_enable:GetValue() then
		for i, v in next, group_weapons do
			-- MAX FOV
			local current_fov = gui.GetValue("lbot.weapon.target." .. v .. ".maxfov")
			if current_fov > sm_maxfov:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".maxfov", sm_maxfov:GetValue());
			end
			-- MIN SMOOTH
			local current_smooth = gui.GetValue("lbot.weapon.aim." .. v .. ".smooth")
			if current_smooth < sm_minsmooth:GetValue() then
				gui.SetValue("lbot.weapon.aim.".. v ..".smooth", sm_minsmooth:GetValue());
			end
			-- METHOD SMOOTH
			if sm_method:GetValue() == 0 then
				gui.SetValue("lbot.weapon.aim.".. v ..".smoothtype", smooth_dynamic);
				--print("smooth: ".. smooth_dynamic)
			elseif sm_method:GetValue() == 1 then
				gui.SetValue("lbot.weapon.aim.".. v ..".smoothtype", smooth_static);
				--print("smooth: ".. smooth_static)
			end
			-- HUMAN AIMING
			local current_randomize = gui.GetValue("lbot.weapon.aim." .. v .. ".randomize");
			local current_curve = gui.GetValue("lbot.weapon.aim." .. v .. ".curve");
			if current_randomize < sm_randomize:GetValue() then
				gui.SetValue("lbot.weapon.aim.".. v ..".randomize", sm_randomize:GetValue());
			elseif current_curve < sm_curve:GetValue() then
				gui.SetValue("lbot.weapon.aim.".. v ..".curve", sm_curve:GetValue());
			end
			-- AUTO WALL
			if sm_autowall:GetValue() == false then
				gui.SetValue("lbot.weapon.vis.".. v ..".autowall", 0);
			end
			-- RECOIL
			local current_hrecoil = gui.GetValue("lbot.weapon.accuracy." .. v .. ".hrecoil");
			local current_vrecoil = gui.GetValue("lbot.weapon.accuracy." .. v .. ".vrecoil");
			if current_hrecoil > sm_recoil:GetValue() then
				gui.SetValue("lbot.weapon.accuracy.".. v ..".hrecoil", sm_recoil:GetValue());
			elseif current_vrecoil > sm_recoil:GetValue() then
				gui.SetValue("lbot.weapon.accuracy.".. v ..".vrecoil", sm_recoil:GetValue());
			end
			-- ANTI STICKY
			if sm_antistricky:GetValue() == true then
				gui.SetValue("lbot.weapon.target.".. v ..".nst", 1);
			end
			-- TRIGGER DELAY
			local current_triggerdelay = gui.GetValue("lbot.trg.weapon." .. v .. ".delay");
			if current_triggerdelay < sm_triggerdelay:GetValue() then
				gui.SetValue("lbot.trg.weapon.".. v ..".delay", sm_triggerdelay:GetValue());
			end
			-- AUTO FIRE
			if sm_autofire:GetValue() == false then
				gui.SetValue("lbot.trg.autofire", 0);
			end
			-- ANTI SPREAD
			if sm_antispread:GetValue() == false then
				gui.SetValue("lbot.trg.weapon.".. v ..".accuracy.antispread", 0);
			end
			-- AUTOSTRAFE
			if sm_autostrafe:GetValue() == false then
				gui.SetValue("misc.autostrafe", 0);
			end
			-- RAGEBOT
			if sm_ragebot:GetValue() == false then
				gui.SetValue("rbot.enable", 0);
				gui.SetValue("rbot.antiaim.enabled", 0);
			end
		end
	end
end
callbacks.Register("Draw", safemode_func)

-- Last Updated: 23/11/2025

