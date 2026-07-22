--[[
#########################################################
	Aimware Lua Script v6.x for Counter-Strike 2  
💖 Enjoying this script? Leave a +rep on my profile! 💖  
	Profile: https://aimware.net/forum/user/61632  
#########################################################
--]]

-- ref main
local tab_features = gui.Reference("Miscellaneous", "Features");
local window_enable = gui.Checkbox(tab_features, "window_enable", "Window NovaGuard", true);
	window_enable:SetDescription("Pick features, limits and restrictions to stay safe.");

-- vars
local width, height = draw.GetScreenSize();
local offset_window_width = -15
local window_width_pos2, window_height_pos2 = 610, 680;
local win_margem_w, win_margem_h = 15, 5;
local group_width_pos1, group_height_pos1 = 15, 15
local group_width_pos2, group_height_pos2 = 270, 0
local group2_width_pos1 = 285
local offset_x, offset_y = 15, 115;
local dpi = (gui.GetValue("adv.dpi") + 3) * 0.25
local menu_ref = gui.Reference("Menu");
local menu_w_offset,menu_h_offset = 800*dpi, 600*dpi
local menu_x, menu_y = menu_ref:GetValue()
local group_weapons = {"shared","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"};
local time_delay = 0
local menu = gui.Reference("MENU")

-- Cache initial
local original_rbot_fov = gui.GetValue("rbot.fov")
if original_rbot_fov == nil or type(original_rbot_fov) ~= "number" or original_rbot_fov <= 1 then
    original_rbot_fov = 180 -- max 180 fov
end

-- Bitwise flags
local on_use = bit.lshift(1, 5)
local in_attack = bit.lshift(1, 0)
local in_attack2 = bit.lshift(1, 11)  -- IN_ATTACK2
local on_using = 0
local is_attacking = 0
local is_attacking2 = 0
local has_forced_console = false

-- Alert drawing vars global
local alert_font = draw.CreateFont("Verdana", 24, 800) -- bold font
local alert_memory_msg = ""
local alert_expire_time = 0

-- window ref
local sm_window = gui.Window("sm_window", "Anti VacLive - Advanced Guard", menu_x-offset_x-(window_width_pos2*dpi), menu_y, window_width_pos2, window_height_pos2);

-- Advanced Groupbox 
local sm_advanced =     gui.Groupbox(sm_window, "Main", group_width_pos1, group_height_pos1, group_width_pos2, group_height_pos2);
	local sm_enable =       gui.Checkbox(sm_advanced, "sm_enable",          "Enable Master", false);
	local sm_automenu =     gui.Checkbox(sm_advanced, "sm_automenu",        "Auto window position", false);
	local sm_force_unshot	= gui.Checkbox(sm_advanced, "sm_force_unshot",  "Force unshot", false)
	local sm_cooldownkill = gui.Slider(sm_advanced, "sm_cooldownkill",      "Cooldown kill", 2.6, 0, 20, 0.1);
	local sm_headshot =     gui.Slider(sm_advanced, "sm_headshot",          "Headshot Rate", 60, 0, 100, 5);
	local sm_color_picker = gui.ColorPicker(sm_advanced, "sm_color_picker", "Indicator Color", 255, 50, 50, 255)

-- Legitbot Limiter 
local sm_limits = gui.Groupbox(sm_window, "Legitbot Limiters", group_width_pos1+group2_width_pos1, group_height_pos1, group_width_pos2, group_height_pos2);
  local sm_legit_enable = gui.Checkbox(sm_limits, "sm_legit_enable", "Enable Legitbot Limiter", false);
  local sm_minfov = gui.Slider(sm_limits, "sm_minfov", "Min. FOV", 0.3, 0, 5, 0.1)
  local sm_maxfov = gui.Slider(sm_limits, "sm_maxfov", "Max. FOV", 3.0, 0, 30.0, 0.1);
  local sm_minsmooth = gui.Slider(sm_limits, "sm_minsmooth", "Min. smooth", 10.0, 0, 20.0, 0.25);
  local sm_randomize = gui.Slider(sm_limits, "sm_randomize", "Min. randomize", 1.5, 0, 10.0, 0.1);
  local sm_curve = gui.Slider(sm_limits, "sm_curve", "Min. curve", 0.3, 0, 2.0, 0.05);
  local sm_method	= gui.Combobox(sm_limits, "sm_method", "Smooth method", "Disable", "Dynamic", "Static");
  local sm_autowall = gui.Checkbox(sm_limits, "sm_autowall", "Disable Penetrable wall", true);
  local sm_antistricky = gui.Checkbox(sm_limits, "sm_nonsticky", "Enable Anti-Stricky", true);
  local sm_targetswitch = gui.Slider(sm_limits, "sm_targetswitch", "Min. Target Switch", 300, 0, 1000, 10);
  local sm_firstshot = gui.Slider(sm_limits, "sm_firstshot", "Min. First Shot", 60, 0, 500, 10);
  local sm_h_recoil = gui.Slider(sm_limits, "sm_h_recoil", "Max. Yaw Recoil", 80, 0, 100);
  local sm_v_recoil = gui.Slider(sm_limits, "sm_v_recoil", "Max. Pitch Recoil", 40, 0, 100);
  local sm_trigger_min = gui.Slider(sm_limits, "sm_trigger_min", "Min. delay", 30, 0, 100, 5);
  local sm_autofire = gui.Checkbox(sm_limits, "sm_autofire", "Disable Auto Fire", true);
  local sm_antispread = gui.Checkbox(sm_limits, "sm_antispread", "Disable No Spread", true);

-- Ragebot Protection
local sm_rage_protection = gui.Groupbox(sm_window, "Rage Guard", group_width_pos1+group2_width_pos1*2, group_height_pos1, group_width_pos2, group_height_pos2);
  local sm_unstable_enable = gui.Checkbox(sm_rage_protection, "sm_unstable_enable", "Enable Guard", true);
  local sm_ragebot = gui.Checkbox(sm_rage_protection, "sm_ragebot", "Disable Ragebot", false);
  local sm_antiaim = gui.Checkbox(sm_rage_protection, "sm_antiaim", "Disable Anti-Aim", false);
  local sm_max_rage_fov = gui.Slider(sm_rage_protection, "sm_max_rage_fov", "Max Rage FOV", 40, 1, 180, 1);
  local sm_min_fps = gui.Slider(sm_rage_protection, "sm_min_fps", "Min FPS Limit", 65, 30, 145, 1);
  local sm_check_ladder = gui.Checkbox(sm_rage_protection, "sm_check_ladder", "Disable on Ladder", true);
  local sm_check_use = gui.Checkbox(sm_rage_protection, "sm_check_use", "Disable on +USE Key", true);
  local sm_check_aa = gui.Checkbox(sm_rage_protection, "sm_check_aa", "Strict Anti-Aim", false);
  local sm_check_dt = gui.Checkbox(sm_rage_protection, "sm_check_dt", "Disable on Doubletap", true);
  local sm_draw_alert_ui = gui.Checkbox(sm_rage_protection, "sm_draw_alert_ui", "Show Warning Alert UI", true);
  local sm_alert_text_color = gui.ColorPicker(sm_rage_protection, "sm_alert_text_color", "Alert Text Color", 255, 255, 255, 255);
  local sm_alert_bg_color = gui.ColorPicker(sm_rage_protection, "sm_alert_bg_color", "Alert Banner BG Color", 20, 20, 20, 200);

-- Misc Limiters Groupbox
local sm_misc_limits = gui.Groupbox(sm_window, "Misc Limiters", group_width_pos1, group_height_pos1 + 215, group_width_pos2, group_height_pos2);
  local sm_misc_enable = gui.Checkbox(sm_misc_limits, "sm_misc_enable", "Enable Misc Limiters", false);
  local sm_trig_random =  gui.Checkbox(sm_misc_limits, "sm_trig_random",      "Random delay trigger", false);
  local sm_trigger_range = gui.Slider(sm_misc_limits, "sm_trigger_max",   "Range Trigger ms", 20, 0, 100, 5);
  local sm_autostrafe = gui.Checkbox(sm_misc_limits, "sm_autostrafe", "Disable Strafe Bhop", false);
  local sm_speedboost = gui.Slider(sm_misc_limits, "sm_speedboost", "Max Speed Boost", 15, 0, 100);
  local sm_airspeed = gui.Slider(sm_misc_limits, "sm_airspeed", "Max Air Speed", 0, 0, 100);
  local sm_jumpbug = gui.Checkbox(sm_misc_limits, "sm_jumpbug", "Disable Jump Bug", false);

-- Helper functions
local function is_lbot_on()
    local val = gui.GetValue("lbot.master")
    return val == true or val == 1 or val == "On" or val == "true"
end

local function is_rbot_on()
    local val = gui.GetValue("rbot.master")
    if val == nil then
        val = gui.GetValue("rbot.enable")
    end
    return val == true or val == 1 or val == "On" or val == "true"
end

-- Dynamic window
local function window_func()
    if menu_ref:IsActive() and window_enable:GetValue() then
        sm_window:SetActive(true)
        
        local lbot_active = is_lbot_on()
        local rbot_active = is_rbot_on()
        
        -- groupbox visibility
        sm_limits:SetInvisible(not lbot_active)
        sm_rage_protection:SetInvisible(not rbot_active)

        -- Position active
        local col_index = 1
        
        if lbot_active then
            sm_limits:SetPosX(15 + group2_width_pos1 * col_index)
            col_index = col_index + 1
        end

        if rbot_active then
            sm_rage_protection:SetPosX(15 + group2_width_pos1 * col_index)
            col_index = col_index + 1
        end

        -- Dynamic height - custom custom core
        local current_height = 500
        if lbot_active then
            current_height = 550
        end
        sm_window:SetHeight(current_height)

        local current_width = 300 + (col_index - 1) * 285
        sm_window:SetWidth(current_width)

        if sm_automenu:GetValue() then
            local dpi_val = (gui.GetValue("adv.dpi") + 3) * 0.25
            local menu_width = 800 * dpi_val
            local menu_x, menu_y = menu_ref:GetValue()
            sm_window:SetPosX(menu_x + menu_width + 15)
            sm_window:SetPosY(menu_y + 10)
        end
    else
        sm_window:SetActive(false)
    end
end
callbacks.Register("Draw", window_func)

-- CreateMove handler
callbacks.Register("CreateMove", function(cmd)
    if not sm_enable:GetValue() then return end
    local buttons = cmd:GetButtons()
    on_using = bit.band(buttons, on_use)
    is_attacking = bit.band(buttons, in_attack)
    is_attacking2 = bit.band(buttons, in_attack2)
end)

-- Entity converter
local function userid_to_entindex(userid)
    local playercontroller = entities.GetByIndex(userid + 1)
    if not playercontroller then return nil end
    local playerpawn = playercontroller:GetFieldEntity("m_hPlayerPawn")
    if not playerpawn then return nil end
    return playerpawn
end

-- Event Listeners
client.AllowListener("player_hurt")
client.AllowListener("player_death")
client.AllowListener("round_start")
client.AllowListener("game_newmap")
client.AllowListener("cs_game_disconnected")

local total_hits = 0
local headshot_hits = 0
local aimbot_cooldown_end = 0
local was_cooldown = false
local was_lbot_enabled = false
local was_rbot_enabled = false

callbacks.Register("FireGameEvent", function(event)
    local event_name = event:GetName()
    
    if event_name == "game_newmap" then
        total_hits = 0
        headshot_hits = 0
        aimbot_cooldown_end = 0
        was_cooldown = false
    end

    if event_name == "player_hurt" then
        local attacker_id = event:GetInt("attacker")
        local is_me = false
        
        if client.GetLocalPlayerIndex and attacker_id == client.GetLocalPlayerIndex() then
            is_me = true
        else
            local attacker = userid_to_entindex(attacker_id)
            local me = entities.GetLocalPlayer()
            if attacker and me and attacker:GetIndex() == me:GetIndex() then
                is_me = true
            end
        end

        if is_me then
            total_hits = total_hits + 1
            if event:GetInt("hitgroup") == 1 then
                headshot_hits = headshot_hits + 1
            end
        end
    end

    if event_name == "player_death" then
        local attacker_id = event:GetInt("attacker")
        local is_me = false
        
        if client.GetLocalPlayerIndex and attacker_id == client.GetLocalPlayerIndex() then
            is_me = true
        else
            local attacker = userid_to_entindex(attacker_id)
            local me = entities.GetLocalPlayer()
            if attacker and me and attacker:GetIndex() == me:GetIndex() then
                is_me = true
            end
        end
        
        if is_me then
            total_hits = total_hits + 1
            if event:GetInt("headshot") == 1 then
                headshot_hits = headshot_hits + 1
            end
            
            local cooldown_sec = sm_cooldownkill:GetValue()
            if cooldown_sec > 0 then
                aimbot_cooldown_end = globals.RealTime() + cooldown_sec
            end
        end
    end
end)

-- Safe Mode function
local function safemode_func()
	if sm_enable:GetValue() and sm_legit_enable:GetValue() and is_lbot_on() then
		for i, v in next, group_weapons do
			-- FOV
			local current_maxfov = gui.GetValue("lbot.weapon.target." .. v .. ".maxfov");
			local current_minfov = gui.GetValue("lbot.weapon.target." .. v .. ".minfov");
			if current_maxfov and current_maxfov > sm_maxfov:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".maxfov", sm_maxfov:GetValue());
			end
			if current_minfov and current_minfov < sm_minfov:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".minfov", sm_minfov:GetValue());
			end

			-- MIN SMOOTH
			local current_smooth = gui.GetValue("lbot.weapon.aim." .. v .. ".smooth");
			if current_smooth and current_smooth < sm_minsmooth:GetValue() then
				gui.SetValue("lbot.weapon.aim.".. v ..".smooth", sm_minsmooth:GetValue());
			end
			if sm_method:GetValue() == 1 then
				gui.SetValue("lbot.weapon.aim.".. v ..".smoothtype", 0);
			elseif sm_method:GetValue() == 2 then
				gui.SetValue("lbot.weapon.aim.".. v ..".smoothtype", 1);
			end

			-- HUMAN AIMING
			local current_randomize = gui.GetValue("lbot.weapon.aim." .. v .. ".randomize");
			local current_curve = gui.GetValue("lbot.weapon.aim." .. v .. ".curve");
			if current_randomize and current_randomize < sm_randomize:GetValue() then
				gui.SetValue("lbot.weapon.aim.".. v ..".randomize", sm_randomize:GetValue());
			elseif current_curve and current_curve < sm_curve:GetValue() then
				gui.SetValue("lbot.weapon.aim.".. v ..".curve", sm_curve:GetValue());
			end

			-- AUTO WALL
			if sm_autowall:GetValue() then
				gui.SetValue("lbot.weapon.vis.".. v ..".autowall", 0);
			end

			-- RECOIL
			local current_hrecoil = gui.GetValue("lbot.weapon.accuracy." .. v .. ".hrecoil");
			local current_vrecoil = gui.GetValue("lbot.weapon.accuracy." .. v .. ".vrecoil");
			if current_hrecoil and current_hrecoil > sm_h_recoil:GetValue() then
				gui.SetValue("lbot.weapon.accuracy.".. v ..".hrecoil", sm_h_recoil:GetValue());
			end
			if current_vrecoil and current_vrecoil > sm_v_recoil:GetValue() then
				gui.SetValue("lbot.weapon.accuracy.".. v ..".vrecoil", sm_v_recoil:GetValue());
			end

			-- ANTI STICKY
			if sm_antistricky:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".nst", 1);
			end

			-- TARGET SWITCH
			local current_tsd = gui.GetValue("lbot.weapon.target.".. v ..".tsd");
			if current_tsd and current_tsd < sm_targetswitch:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".tsd", sm_targetswitch:GetValue());
			end
			-- First Shot
			local current_fsd = gui.GetValue("lbot.weapon.target.".. v ..".fsd");
			if current_fsd and current_fsd < sm_firstshot:GetValue() then
				gui.SetValue("lbot.weapon.target.".. v ..".fsd", sm_firstshot:GetValue());
			end
			
			-- TRIGGER DELAY
			local current_triggerdelay = gui.GetValue("lbot.trg.weapon." .. v .. ".delay");
			if current_triggerdelay and current_triggerdelay < sm_trigger_min:GetValue() then
				gui.SetValue("lbot.trg.weapon.".. v ..".delay", sm_trigger_min:GetValue());
			end
			-- AUTO FIRE
			if sm_autofire:GetValue() then
				gui.SetValue("lbot.trg.autofire", 0);
			end

			-- ANTI SPREAD
			if sm_antispread:GetValue() then
				gui.SetValue("lbot.trg.weapon.".. v ..".accuracy.antispread", 0);
			end
		end
	end
end
callbacks.Register("Draw", safemode_func)

-- Misc Limiters function
local function misc_limiters_func()
    if sm_enable:GetValue() and sm_misc_enable:GetValue() then
        if sm_jumpbug:GetValue() then
            gui.SetValue("misc.jumpbug", "OFF")
        end

        if sm_autostrafe:GetValue() then
            gui.SetValue("misc.autostrafe", 0)
        end

        local current_strafeboost = gui.GetValue("misc.autostrafe.strafeboost")
        if current_strafeboost and current_strafeboost > sm_speedboost:GetValue() then
            gui.SetValue("misc.autostrafe.strafeboost", sm_speedboost:GetValue())
        end

        local current_airstrafespeed = gui.GetValue("misc.autostrafe.airstrafespeed")
        if current_airstrafespeed and current_airstrafespeed > sm_airspeed:GetValue() then
            gui.SetValue("misc.autostrafe.airstrafespeed", sm_airspeed:GetValue())
        end
    end
end
callbacks.Register("Draw", misc_limiters_func)

--Rage Guard Function 
local function unstable_aa_func()
    if not sm_enable:GetValue() or not sm_unstable_enable:GetValue() or not is_rbot_on() then
        return
    end

    -- Force Disable Ragebot
    if sm_ragebot:GetValue() then
        gui.SetValue("rbot.enable", 0)
    end
    if sm_antiaim:GetValue() then 
        gui.SetValue("rbot.antiaim.enabled", 0)
    end

    local fps = 1.0 / globals.FrameTime()
    local tick = globals.TickCount()
    local localPlayer = entities.GetLocalPlayer()
    local in_game = (localPlayer ~= nil and localPlayer:IsAlive())
    local current_alert = ""

    if not in_game and not has_forced_console then
        client.Command("engine_no_focus_sleep 0", true)
        client.Command("fps_max 0", true)
        has_forced_console = true
    end

    if not localPlayer or not localPlayer:IsAlive() then 
        return
    end

    local moveType = localPlayer:GetFieldInt("m_nActualMoveType")
    local weaponType = localPlayer:GetWeaponType()

    local is_safe = true
    local antiaim = gui.GetValue("rbot.antiaim.enabled")
    local aa_yaw = gui.GetValue("rbot.antiaim.yaw")
    local aa_pitch = gui.GetValue("rbot.antiaim.pitch")
    local aa_override = gui.GetValue("rbot.antiaim.mouseaa")
    local doubletap = gui.GetValue("rbot.doubletap")

    -- Condition Checks
    if sm_min_fps:GetValue() > 0 and fps < sm_min_fps:GetValue() then
        is_safe = false
        current_alert = "⚠ FPS DROPPED TO " .. math.floor(fps) .. "! RAGEBOT STOPPED."
    elseif sm_check_ladder:GetValue() and moveType == 9 then
        is_safe = false
        current_alert = "⚠ ON LADDER! RAGEBOT STOPPED."
    elseif sm_check_use:GetValue() and on_using ~= 0 then
        is_safe = false
        current_alert = "⚠ HOLDING USE KEY! RAGEBOT STOPPED."
    elseif sm_check_aa:GetValue() and (not antiaim or aa_pitch ~= 2 or aa_yaw ~= 3 or aa_override ~= 0) then
        is_safe = false
        current_alert = "⚠ ANTI-AIM IS UNSAFE! RAGEBOT STOPPED."
    elseif sm_check_dt:GetValue() and doubletap and weaponType ~= 0 then
        is_safe = false
        current_alert = "⚠ EXPLOIT ENABLED! RAGEBOT STOPPED."
    end

    if current_alert ~= "" then
        alert_memory_msg = current_alert
        alert_expire_time = globals.RealTime() + 1.0
    end

    local current_fov = gui.GetValue("rbot.fov")
    if current_fov == nil or type(current_fov) ~= "number" then
        current_fov = 0
    end

    local max_allowed_fov = sm_max_rage_fov:GetValue()

    if is_safe then
        if current_fov <= 1 then
            local restore_fov = math.min(original_rbot_fov, max_allowed_fov)
            gui.SetValue("rbot.fov", restore_fov)
        else
            if current_fov > max_allowed_fov then
                gui.SetValue("rbot.fov", max_allowed_fov)
            else
                original_rbot_fov = current_fov
            end
        end
    else
        if current_fov > 1 then
            original_rbot_fov = current_fov
            gui.SetValue("rbot.fov", 0)
        end
    end
end
callbacks.Register("Draw", unstable_aa_func)

-- Indicators + Warning UI 
local font_indicator = draw.CreateFont("Verdana", 24, 800)

local function draw_shadow(x, y, text, r, g, b, a)
    draw.Color(0, 0, 0, a)
    draw.Text(x + 1, y + 1, text)
    draw.Text(x + 2, y + 2, text)
    draw.Color(r, g, b, a)
    draw.Text(x, y, text)
end

callbacks.Register("Draw", function()
    if not sm_enable:GetValue() then
        if was_cooldown then
            if was_lbot_enabled then gui.SetValue("lbot.master", 1) end
            if was_rbot_enabled then gui.SetValue("rbot.enable", 1) end
            was_cooldown = false
        end
        return
    end

    draw.SetFont(font_indicator)
    local ScrW, ScrH = draw.GetScreenSize()
    local y_offset = ScrH / 2

    -- 1. Cooldown logic & indicator
    if aimbot_cooldown_end > 0 then
        local remaining = aimbot_cooldown_end - globals.RealTime()
        if remaining > 0 then
            local cd_text = string.format("CD: %.1fs", remaining)
            local tw, _ = draw.GetTextSize(cd_text)
            local cr, cg, cb, ca = sm_color_picker:GetValue()
            draw_shadow(ScrW - tw - 20, y_offset, cd_text, cr, cg, cb, ca)
            y_offset = y_offset + 30
            
            if sm_force_unshot:GetValue() and not was_cooldown then
                was_cooldown = true
                was_lbot_enabled = gui.GetValue("lbot.master") == 1 or gui.GetValue("lbot.master") == true
                was_rbot_enabled = gui.GetValue("rbot.enable") == 1 or gui.GetValue("rbot.enable") == true
                gui.SetValue("lbot.master", 0)
                gui.SetValue("rbot.enable", 0)
            end
        else
            if was_cooldown then
                if was_lbot_enabled then gui.SetValue("lbot.master", 1) end
                if was_rbot_enabled then gui.SetValue("rbot.enable", 1) end
                was_cooldown = false
            end
            aimbot_cooldown_end = 0
        end
    end
    
    -- 2. Headshot Rate Indicator
    if total_hits > 0 then
        local hs_rate = (headshot_hits / total_hits) * 100
        local hs_text = string.format("HS: %d%%", hs_rate)
        local tw, _ = draw.GetTextSize(hs_text)
        local safe_limit = sm_headshot:GetValue()
        local r, g, b, a = 50, 255, 50, 255
        
        if hs_rate > safe_limit then
            r, g, b, a = sm_color_picker:GetValue()
        end
        
        draw_shadow(ScrW - tw - 20, y_offset, hs_text, r, g, b, a)
    end

    -- 3. Warning Alert
    if sm_unstable_enable:GetValue() and sm_draw_alert_ui:GetValue() and globals.RealTime() < alert_expire_time and alert_memory_msg ~= "" then
        local ScrW, ScrH = draw.GetScreenSize()
        draw.SetFont(alert_font)
        
        local text_w, text_h = draw.GetTextSize(alert_memory_msg)
        local text_x = math.floor((ScrW / 2) - (text_w / 2))
        local text_y = ScrH / 4

        local bgr, bgg, bgb, bga = sm_alert_bg_color:GetValue()
        draw.Color(bgr, bgg, bgb, bga)
        draw.FilledRect(text_x - 15, text_y - 8, text_x + text_w + 15, text_y + text_h + 8)
        
        local ar, ag, ab, aa = sm_alert_text_color:GetValue()
        draw.Color(ar, ag, ab, aa)
        draw.TextShadow(text_x, text_y, alert_memory_msg)
    end
end)

--[[ Last Updated: 07/22/2026

CHANGELOG - Anti VacLive Cooldown

v1.3
	* Merged vacguard.lua into antivaclive.lua
	* Added dynamic column window layout based on masters
	* Added Enable Legitbot Limiter checkbox
	* Added Rage Guard groupbox 
	* Added Max Rage FOV slider with original FOV caching & restoration
	* Switched Rage safety toggle logic 
	* Created Misc Limiters groupbox 
	* Added customizable Alert Text Color & Alert Banner BG Color pickers
	* Repositioned CD / HS indicators to screen middle-right
	* Optimized UI padding and dynamic height sizing 

v1.2
	* Added Min. FOV limitation
	* Added Disable Jump Bug option
	* Added Disable Anti-Aim option
	* Added Limiter Autostrafe Speed Boost and Air Turn Speed
	* Added Limiter recoil yaw and pitch
	* Added Cooldown per kill monitoring
	* Added Headshot Rate % tracker & indicator
	* Added indicator HS rate & cooldown per kill
	* Added new group Advanced / Main
	* Changed window enabled default setting
	* Fixed position window bugs & incorrect width X calculation
	* Improved window features, texts, and size

v1.1
	* Added target switch delay configuration
	* Added first shot delay limitation
	* Fixed smooth method functionality bug
	* Added triggerbot random delay activation when hitting enemies
	* Improved window positioning logic
	* Added window movement synchronization with menu
	* Added support DPI scale

Planned for v1.x
	* Kill counter implementation (fixing crash issues)
	* Cooldown per kill monitoring
	* Limit kills per round feature
	* Wallhack risk alert indicator
]]


