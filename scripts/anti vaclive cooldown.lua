--[[
#########################################################
	Aimware Lua Script v6.x for Counter-Strike 2  
💖 Enjoying this script? Leave a +rep on my profile! 💖  
	Profile: https://aimware.net/forum/user/61632  
#########################################################
--]]

-- ref main
local tab_features = gui.Reference("Miscellaneous", "Features");
local window_enable = gui.Checkbox(tab_features, "window_enable", "Restrictions Mode", false);
	window_enable:SetDescription("Pick features, limits and restrictions to stay safe.");

-- vars
local win_width, win_height = draw.GetScreenSize();
local width_pos2, height_pos2 = 300, 600;
local win_margem_w, win_margem_h = 15, 5;
local offset_x, offset_y = 100, 10;
local menu_ref = gui.Reference("Menu");
local group_weapons = {"shared","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"};
local time_delay = 0

-- window ref
local sm_window = gui.Window("sm_window", "Restrictions Mode", win_width/7, win_height/3, width_pos2, height_pos2);
local sm_group = gui.Groupbox(sm_window, "Features", win_margem_w, win_margem_h);
  local sm_enable = gui.Checkbox(sm_group, "sm_enable", "Enable script", true);
  local sm_maxfov = gui.Slider(sm_group, "sm_maxfov", "Maximum FOV", 2.0, 0.1, 10.0, 0.1);
  local sm_minsmooth = gui.Slider(sm_group, "sm_minsmooth", "Minimum smooth", 15.0, 0.25, 20.0, 0.25);
  local sm_randomize = gui.Slider(sm_group, "sm_randomize", "Minimum randomize", 1.5, 0.1, 10.0, 0.1);
  local sm_curve = gui.Slider(sm_group, "sm_curve", "Minimum curve", 0.3, 0.05, 2.0, 0.05);
  local sm_method	= gui.Combobox(sm_group, "sm_method", "Smooth method", "Dynamic", "Static", "Disable");
  local sm_autowall = gui.Checkbox(sm_group, "sm_autowall", "Penetrable wall", false);
  local sm_antistricky = gui.Checkbox(sm_group, "sm_nonsticky", "Anti-Stricky", true);
  local sm_targetswitch = gui.Slider(sm_group, "sm_targetswitch", "Minimum Target Switch", 330, 10, 1000, 10);
  local sm_firstshot = gui.Slider(sm_group, "sm_firstshot", "Minimum First Shot", 60, 10, 1000, 10);
  local sm_recoil = gui.Slider(sm_group, "sm_recoil", "Limit recoil", 80, 1, 100, 1);
  local sm_trig_random = gui.Checkbox(sm_group, "sm_trig_random", "Random delay", true);
  local sm_trigger_min = gui.Slider(sm_group, "sm_maxfov", "Minimum delay", 30, 5, 500, 5);
  local sm_trigger_range = gui.Slider(sm_group, "sm_trigger_max", "Range delay", 70, 5, 500, 5);
  local sm_autofire = gui.Checkbox(sm_group, "sm_autofire", "Automatic fire", false);
  local sm_antispread = gui.Checkbox(sm_group, "sm_antispread", "Remove spread", false);
  local sm_autostrafe = gui.Checkbox(sm_group, "sm_autostrafe", "Strafe Bhop", false);
  local sm_ragebot = gui.Checkbox(sm_group, "sm_ragebot", "Ragebot", false);

--window position with menu
local function window_func()
	if menu_ref:IsActive() and window_enable:GetValue() then
		local menu_x, menu_y = menu_ref:GetValue(); --returns X,Y position
		local menu_width, menu_height = 800, 600; --default menu size
		--DPI scale
		local dpi_scale = (gui.GetValue("adv.dpi") + 3) * 0.25;
		menu_width = menu_width * dpi_scale;
		menu_height = menu_height * dpi_scale;
		--position window
		local window_x = menu_x + offset_x - (menu_width/2);
		local window_y = menu_y + offset_y;
		sm_window:SetActive(true);
		sm_window:SetPosX(window_x);
		sm_window:SetPosY(window_y);
	else
		sm_window:SetActive(false);
	end
end
callbacks.Register("Draw", window_func);

--##### FUNCTION #####

 -- Convert userid to entity index by random user
local function userid_to_entindex(userid)
    local playercontroller = entities.GetByIndex(userid + 1)
    if not playercontroller then
        print("No player controller for userid: " .. userid)
        return nil
    end
    local playerpawn = playercontroller:GetFieldEntity("m_hPlayerPawn")
    if not playerpawn then
        print("No player pawn for userid: " .. userid)
        return nil
    end
    return playerpawn
end

-- funcion random time delay when hit enemy
callbacks.Register("FireGameEvent", function(event)
	local event_name = event:GetName()
	if event_name == "player_hurt" then
		local me = client.GetLocalPlayerIndex()
		local attacker_id = event:GetInt("attacker")
		local attacker = userid_to_entindex(attacker_id)
		if not attacker then
            print("Attacker entity not found for userid: " .. attacker_id)
            return
        end
		local attacker_index = attacker:GetIndex()
		local range_delay = sm_trigger_range:GetValue() + sm_trigger_min:GetValue()
        if me == attacker_index and sm_trig_random:GetValue() then
            time_delay = math.random(sm_trigger_min:GetValue(), range_delay)
			for i, v in next, group_weapons do
				gui.SetValue("lbot.trg.weapon.".. v ..".delay", time_delay);
			end
			print("time delay: "..time_delay )
        end
    end
end)

--##### SAFE MODE FUNCTION #####
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
			if sm_method:GetValue() == 0 then --"Dynamic"
				gui.SetValue("lbot.weapon.aim.".. v ..".smoothtype", 0);
			elseif sm_method:GetValue() == 1 then -- "Static"
				gui.SetValue("lbot.weapon.aim.".. v ..".smoothtype", 1);
			
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
			-- TARGET SWITCH
			local current_tsd = gui.GetValue("lbot.weapon.target.".. v ..".tsd");
			if current_tsd < sm_targetswitch:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".tsd", sm_targetswitch:GetValue());
			end
			-- First Shot
			local current_fsd = gui.GetValue("lbot.weapon.target.".. v ..".fsd");
			if current_fsd < sm_firstshot:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".fsd", sm_firstshot:GetValue());
			end
			
			-- TRIGGER DELAY
			local current_triggerdelay = gui.GetValue("lbot.trg.weapon." .. v .. ".delay");
			if current_triggerdelay < sm_trigger_min:GetValue() then
				gui.SetValue("lbot.trg.weapon.".. v ..".delay", sm_trigger_min:GetValue());
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

--[[ Last Updated: 07/02/2026

CHANGELOG - anti cooldown vaclive
v1.1 
	*Added target switch + first shot delay
	*Fixed smooth method
	*Triggerbot random delay
	Improved postion window
	
v1.2 - future
	*Count kills soon issue bug crash
	*Cooldown per kill
	*Limit kills per round
	*indicador alert wallhack risk 
	**more idea? add discord id: blurry33
]]