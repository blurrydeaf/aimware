
--[[
#########################################################
               Aimware Lua Script v5.1.x for CS2  
💖 Enjoying this script? Leave a +rep on my profile! 💖  
           Profile: https://aimware.net/forum/user/61632  
#########################################################
--]]
-- Last Updated: 30/03/2025



--- AUTO UPDATE ---
--- AUTO UPDATE --- 
--- AUTO UPDATE ---
-- Version tracking 
local major,minor,patch = 3,14,8  -- script version
local local_version = string.format("%d.%d", major, minor)

local name_script = GetScriptName() -- name file
local name_tag = " [".. name_script .."] "

local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/refs/heads/main/scripts/version_catware.txt" -- version
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/refs/heads/main/scripts/catware.lua" -- script
local devmode = false -- set to false for public releases
local cloud_version = http.Get(github_version_url) -- Fetch info

-- Check connection
if not cloud_version or cloud_version == "" then
    print(name_tag.. "Update check failed (no connection)")
    return
elseif devmode then -- Dev mode active
	gui.Command("clear")
    print("\n===== DEV MODE =====")
    print(" Script: ".. name_script .."\n Local: ".. local_version .."\n Cloud: ".. cloud_version)
	print("===== DEV MODE =====\n")
elseif local_version ~= cloud_version then
    print(name_tag .."Updating to v"..cloud_version)
    
    local new_script = http.Get(github_source_url)
    if new_script then
        file.Write(name_script, new_script)
		print(name_tag .."Reloading updated "..name_script)
		print(name_tag .. name_script.." refreshed")
		print(name_tag .."Update applied")
        UnloadScript(name_script)
    else
        print(name_tag .."Update failed")
    end
end
print(name_tag .."Loaded script... ".. name_script)


--- REFERENCE --- 
--- REFERENCE --- 
--- REFERENCE --- 
local player_name = cheat.GetUserName(); 
local name_tab = "Catware"
local cw_reference = gui.Reference("LEGITBOT")
local cw_tab = gui.Tab(cw_reference, "cw_tab", name_tab)

local cw_group_master = gui.Groupbox(cw_tab, "🐱 Welcome to ".. name_tab ..", ".. player_name .."! 🐱", 10, 10, 300, 1)
local cw_group_messages = gui.Groupbox(cw_tab, "📚 Tips & Tricks 📚", 320, 10, 300, 1)
local cw_group_righ = gui.Groupbox(cw_tab, "Group weapons", 320, 140, 300, 1)
local cw_group_left = gui.Groupbox(cw_tab, "Keybinds", 10, 285, 300, 1)

local cw_check_safemode = gui.Checkbox(cw_group_master, "cw_check_safemode", "Safety Mode BETA", false); 
	cw_check_safemode:SetDescription("Avoids cooldown bans and VAC Live cancellations"); 
local cw_check_override = gui.Checkbox(cw_group_master, "cw_check_override", "Config Override", false); 
	cw_check_override:SetDescription("Force script settings over Aimware defaults"); 
local cw_check_oscillation  = gui.Checkbox(cw_group_master, "cw_check_oscillation", "Oscillation Smooth", false); 
	cw_check_oscillation:SetDescription("Ensures dynamic and adjustable aim smoothness"); 
local cw_check_prospread = gui.Checkbox(cw_group_master, "cw_check_prospread", "Pro Spread", false); 
	cw_check_prospread:SetDescription("Maximizes accuracy with dynamic spread control"); 

local cw_check_trigger = gui.Checkbox(cw_group_left, "cw_check_trigger", "Magnet Trigger", false);
	cw_check_trigger:SetDescription("Pulls and locks your aim onto nearby enemies");
local cw_check_autowall = gui.Checkbox(cw_group_left, "cw_check_autowall", "Autowall", false);
	cw_check_autowall:SetDescription("Lets bullets hit enemies through walls"); 
local cw_check_antispread = gui.Checkbox(cw_group_left, "cw_check_antispread", "Force Anti-Spread", false);
	cw_check_antispread:SetDescription("A maximum of 10 bullets per match is allowed"); 

local cw_combo_weapons = gui.Combobox(cw_group_righ, "cw_combo_weapons", "Weapon", 
	"Pistol", "Heavy Pistol", "Submachine Gun", "Rifle", "Shotgun", "Scout", "Auto Sniper", "Sniper", "Light Machine Gun")
	cw_combo_weapons:SetDescription("Select weapon group to configure")




--- MESSAGES ---
--- MESSAGES ---
--- MESSAGES ---
local messages = {
    "🔧 Autowall requires visible checks!\n\n\nDisable safemode for better wall penetration.",
    "🎯 Pro Spread enhances accuracy!\n\n\nEnable it for precise aiming in all situations.",
    "🚫 Force Anti-Spread required!\n\n\nDisable Complete Anti-Untrusted for better spread control.",
    "⚠️ Disable Complete Anti-Untrusted!\n\n\nRequired for Force Anti-Spread to work properly.",
    "⚙️ Optimize your settings!\n\n\nAdjust smoothness and FOV for the best performance.",
    "🔥 Use dynamic spread control!\n\n\nIt adapts to your weapon for maximum accuracy.",
    "🎮 Join the Catware community!\n\n\nGet exclusive tips and tricks from top players.",
    "💡 Experiment with weapon settings!\n\n\nFind the perfect configuration for each gun.",
    "🌟 Catware is constantly updated!\n\n\nStay tuned for new features and improvements.",
    "🚀 Customize your experience!\n\n\nTailor Catware to fit your playstyle.",
    "🛡️ Safemode helps avoid VAC Live bans!\n\n\nIt reduces the risk of cooldowns and bans.",
    "🎯 Default hitbox means no enemy on crosshair!\n\n\nAdjust hitbox settings for better targeting.",
    "🌀 Oscillation aim reduces cooldown risk!\n\n\nIt’s less detectable and more natural.",
    "🔫 Customize weapon groups!\n\n\nSet hitbox and smooth aim for each weapon type.",
    "❤️ Enjoying script Catware.lua?\n\n\nDon’t forget to +rep my profile! 😊"
}

local function get_message()
    return messages[math.random(#messages)]
end

local tips_message = gui.Text(cw_group_messages, get_message())
local cw_version = gui.Text(cw_group_messages, "Script: "..name_script..", version: "..local_version)
local last_update = globals.RealTime()

callbacks.Register("Draw", function()
    if globals.RealTime() - last_update > 15 then
        tips_message:SetText(get_message())
        last_update = globals.RealTime()
    end
end)

local group_weapons = {
	"pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper", "lmg"
}

local configs_weapon = {
    {name = "Pistol: ", hitchance = 30, min_smooth = 5, max_smooth = 8, hitbox = 0, prefer = 1, health = 30 },
    {name = "Heavy Pistol: ", hitchance = 50, min_smooth = 5, max_smooth = 8, hitbox = 0, prefer = 1, health = 60 },
	{name = "Submachine Gun: ", hitchance = 10, min_smooth = 10, max_smooth = 15, hitbox = 2, prefer = 2, health = 10 },
	{name = "Rifle: ", hitchance = 30, min_smooth = 10, max_smooth = 15, hitbox = 2, prefer = 2, health = 30 },
	{name = "Shotgun: ", hitchance = 10, min_smooth = 7, max_smooth = 12, hitbox = 2, prefer = 2, health = 20 },
    {name = "Scout: ", hitchance = 70, min_smooth = 5, max_smooth = 8, hitbox = 1, prefer = 1, health = 70 },
    {name = "Auto Sniper: ", hitchance = 50, min_smooth = 7, max_smooth = 10, hitbox = 1, prefer = 2, health = 50 },
    {name = "Sniper: ", hitchance = 80, min_smooth = 5, max_smooth = 8, hitbox = 2, prefer = 2, health = 100 },
    {name = "Light Machine Gun: ", hitchance = 10, min_smooth = 10, max_smooth = 15, hitbox = 2, prefer = 2, health = 10 }
}


--- GUI --- 
--- GUI --- 
--- GUI --- 
local update_gui = {}
for i, cfg in ipairs(configs_weapon) do
    local prefix = cfg.name:lower():gsub(" ", "_")
    local default_min = cfg.min_smooth or math.max(cfg.min_smooth, smooth_safe)
    local default_max = cfg.max_smooth or math.max(cfg.max_smooth, smooth_safe)
	
    update_gui[i] = {
		hitchance = gui.Slider(cw_group_righ, prefix .."hitchance", cfg.name .." Hit Chance", cfg.hitchance, 1, 100, 1),
		min_smooth = gui.Slider(cw_group_righ, prefix .."min_smooth", cfg.name .." Minimum smooth", default_min, 1, 50, 0.1),
		max_smooth = gui.Slider(cw_group_righ, prefix .."max_smooth", cfg.name .." Maximum smooth", default_max, 1, 50, 0.1),
        hitbox = gui.Combobox(cw_group_righ, prefix .."hitbox", cfg.name .."Hitbox Options", "Only Head", "No Arms/Legs", "All"),	
		prefer = gui.Combobox(cw_group_righ, prefix .."prefer", cfg.name .."Prefer Target", "None", "Head aim", "Body aim")
    }
	
	update_gui[i].hitchance:SetDescription("Higher values more precise but slower response")
	update_gui[i].min_smooth:SetDescription("Lowest oscillation smoothness (fastest aim)")
	update_gui[i].max_smooth:SetDescription("Peak oscillation smoothness (slowest aim)")
	update_gui[i].hitbox:SetDescription("Aim uses hitbox areas")
	update_gui[i].prefer:SetDescription("Priority target selection")
	
	update_gui[i].hitchance:SetInvisible(i ~= 1)
    update_gui[i].min_smooth:SetInvisible(i ~= 1)
	update_gui[i].max_smooth:SetInvisible(i ~= 1)
    update_gui[i].hitbox:SetInvisible(i ~= 1)
	update_gui[i].prefer:SetInvisible(i ~= 1) 
end

--Import Aimware's default
local extra = 7
local function initialize_hitchance()
    local selected_idx = cw_combo_weapons:GetValue() + 1
    local weapon_group = group_weapons[selected_idx]
	
	for i, weapon_group in ipairs(group_weapons) do
        local default_hitchance = gui.GetValue("lbot.trg.weapon."..weapon_group..".hitchance")
        local default_smooth = gui.GetValue("lbot.weapon.aim."..weapon_group..".smooth")
        local extra_smooth = default_smooth + extra
		
        -- only update if valid values
        if default_hitchance and default_smooth then
            update_gui[i].hitchance:SetValue(default_hitchance)
            update_gui[i].min_smooth:SetValue(default_smooth)
            update_gui[i].max_smooth:SetValue(extra_smooth)
        end
	end
end
initialize_hitchance() -- Call when script loads

local function update_update_gui()
	local selected_idx = cw_combo_weapons:GetValue() + 1
	
	-- update the visible controls for the selected weapon
    for i = 1, #configs_weapon do
        local is_selected = (i == selected_idx)
		update_gui[i].hitchance:SetInvisible(not is_selected)
        update_gui[i].min_smooth:SetInvisible(not is_selected)
		update_gui[i].max_smooth:SetInvisible(not is_selected)
        update_gui[i].hitbox:SetInvisible(not is_selected)
		update_gui[i].prefer:SetInvisible(not is_selected)
    end
	
	--[[
	local hitchance = update_gui[selected_idx].hitchance:GetValue()
	local hitbox = update_gui[selected_idx].hitbox:GetValue()
	local prefer = update_gui[selected_idx].prefer:GetValue()
	]]
	-- enforce max > min smooth
	local min_smooth = update_gui[selected_idx].min_smooth:GetValue()
	local max_smooth = update_gui[selected_idx].max_smooth:GetValue()
    if min_smooth > max_smooth then
        update_gui[selected_idx].max_smooth:SetValue(min_smooth)
    end

	-- Safemode restrictions
	local safemode = cw_check_safemode:GetValue()
	local antiuntrusted = gui.GetValue("misc.antiuntrusted")

	-- Disable features based on conditions
	cw_check_trigger:SetDisabled(safemode)
	cw_check_autowall:SetDisabled(safemode)

	local spread_checks_disabled = safemode or antiuntrusted
	cw_check_antispread:SetDisabled(spread_checks_disabled)
	cw_check_prospread:SetDisabled(spread_checks_disabled)

end
callbacks.Register("Draw", update_update_gui)



--- TRIGGER --- 
--- TRIGGER ---
--- TRIGGER ---
local function func_trigger()
	local LocalPawn = entities.GetLocalPawn(); -- Using GetLocalPlayer for consistency
	if not LocalPawn or not LocalPawn:IsAlive() then 
		--print("You are not alive or not detected")
		return
	end
	local EntIndex = LocalPawn:GetPropInt("m_iIDEntIndex");
    if EntIndex == -1 or EntIndex == 0 then 
		--print("No entity under crosshair")
		return
	end
	local Crosshair = entities.GetByIndex(EntIndex)
	if not Crosshair or not Crosshair:IsPlayer() or Crosshair:GetTeamNumber() == LocalPawn:GetTeamNumber() then 
		--print("Invalid entity under crosshair")
		return
	end
	local EnemyHealth = Crosshair:GetPropInt("m_iHealth") -- Using GetHealth for simplicity  
	--print("Enemy Health: " .. string.format("%.0f", EnemyHealth))
	if Crosshair:IsPlayer() and Crosshair:IsAlive() then
        --print("Enemy detected under crosshair! Health: " .. EnemyHealth)
		return
	end
end
callbacks.Register("Draw", function()
	func_trigger()
end)



--- BIND KEY ---
--- BIND KEY ---
--- BIND KEY ---
callbacks.Register("Draw", function()
    local active = cw_check_trigger:GetValue()
    gui.SetValue("lbot.aim.autofire", active)
    gui.SetValue("lbot.trg.autofire", active)
    if active then
        gui.SetValue("lbot.aim.enable", true)
        gui.SetValue("lbot.trg.enable", true)
        gui.SetValue("lbot.aim.fireonpress", false)
    end
end)

local function autowall_func() 
	for i, v in next, group_weapons do
		gui.SetValue("lbot.weapon.vis." .. v .. ".autowall", cw_check_autowall:GetValue()) -- lbot.weapon.vis.pistol.autowall
	end
end
callbacks.Register("Draw", autowall_func)


--- OVERRIDE ---
--- OVERRIDE ---
--- OVERRIDE ---
local function update_hitboxes_and_preference()
   
    
	--[[
	 if not cw_check_override:GetValue() then return end
    local selected_idx = cw_combo_weapons:GetValue() + 1
    local weapon_group = group_weapons[selected_idx]
	]]
	
	for selected_idx, weapon_group in ipairs(group_weapons) do
		local hitbox_setting = update_gui[selected_idx].hitbox:GetValue()  -- 0=Head Only, 1=No Arms/Legs, 2=All
		local prefer_setting = update_gui[selected_idx].prefer:GetValue()   -- 0=None, 1=Head aim, 2=Body aim
    
		-- Default: all off (0 0 0 0 0 0 0 0)
		local hitbox_flags = "0 0 0 0 0 0 0 0"
    

		-- Configure hitbox flags based on selection
		if hitbox_setting == 0 then -- "Head Only" hitboxes	
	
			hitbox_flags = "4 0 0 0 0 0 0 0" 

		elseif hitbox_setting == 1 then -- "No Arms/Legs"
	
			if prefer_setting == 1 then -- "Head aim" priority
				hitbox_flags = "4 1 0 1 1 0 0 0 " 
			elseif prefer_setting == 2 then -- "Body aim" priority
				hitbox_flags = "1 4 0 4 4 0 0 0 "  
			else -- No preference
				hitbox_flags = "1 1 0 1 1 0 0 0 "
			end  
		
		elseif hitbox_setting == 2 then -- "All"
	
			if prefer_setting == 1 then
				hitbox_flags = "4 1 1 1 1 1 1 1"
			elseif prefer_setting == 2 then
				hitbox_flags = "1 4 1 4 4 1 1 1" 
			else
				hitbox_flags = "1 1 1 1 1 1 1 1" 
			end
		end
    
		gui.SetValue("lbot.aim.hitbox."..weapon_group..".hitbox", hitbox_flags)
		gui.SetValue("lbot.trg.hitbox."..weapon_group..".hitbox", hitbox_flags)
		
		local hitchance = update_gui[selected_idx].hitchance:GetValue()
		gui.SetValue("lbot.trg.weapon."..weapon_group..".hitchance", hitchance)
	end
end

-- Main override callback
callbacks.Register("Draw", function()
    if cw_check_override:GetValue() then
        update_hitboxes_and_preference()
    end
end)



--- NO SPREAD ---
--- NO SPREAD ---
--- NO SPREAD ---
local prospread = 10
local function nospread_func()
    if cw_check_prospread:GetValue() then
        for i, v in next, group_weapons do
            gui.SetValue("lbot.trg.weapon." .. v .. ".antispread", true)
			gui.SetValue("lbot.trg.weapon." .. v .. ".hitchance", prospread)
        end
	else
        for i, v in next, group_weapons do
            gui.SetValue("lbot.trg.weapon." .. v .. ".antispread", false)
        end
    end
	-- force anti spread
	if cw_check_antispread:GetValue() then 
		for i, v in next, group_weapons do
            gui.SetValue("lbot.trg.weapon." .. v .. ".antispread", true)
			gui.SetValue("lbot.trg.weapon." .. v .. ".hitchance", 0)
		end
	end
end
callbacks.Register("Draw", nospread_func)

 -- Convert userid to entity index
local function userid_to_entindex(userid)
    local playercontroller = entities.GetByIndex(userid + 1)
    if not playercontroller then
        print("No player controller for userid: " .. userid)
        return nil
    end
    local playerpawn = playercontroller:GetPropEntity("m_hPlayerPawn")
    if not playerpawn then
        print("No player pawn for userid: " .. userid)
        return nil
    end
    return playerpawn
end

-- Callback for game events
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
        if me == attacker_index then
            prospread = math.random(5, 15)

        end
    end
end)


--- SMOOTH ---
--- SMOOTH ---
--- SMOOTH ---
local weapon_oscillation = {}
for _, group in ipairs(group_weapons) do
    weapon_oscillation[group] = {
        current = 1,
        direction = 1,
        step = 0.1
    }
end
callbacks.Register("CreateMove", function(cmd)
    if not cw_check_oscillation:GetValue() then return end
    
    -- Update all weapon groups independently
    for i, group in ipairs(group_weapons) do
        local osc = weapon_oscillation[group]
        
        -- Get this weapon's specific min/max smooth values
        local min_smooth = update_gui[i].min_smooth:GetValue()
        local max_smooth = update_gui[i].max_smooth:GetValue()
        
        -- Update oscillation value
        osc.current = osc.current + (osc.step * osc.direction)
        
        -- Reverse direction at boundaries
        if osc.current >= max_smooth then
            osc.current = max_smooth
            osc.direction = -1
        elseif osc.current <= min_smooth then
            osc.current = min_smooth
            osc.direction = 1
        end
        
        -- Apply to this weapon group
        local smooth_path = "lbot.weapon.aim."..group..".smooth"
        if gui.GetValue(smooth_path) ~= nil then
            gui.SetValue(smooth_path, osc.current)
        end
        
    end
end)



--- SAFE MODE --- 
--- SAFE MODE --- 
--- SAFE MODE --- 
local smooth_safe = 3 -- minimum smooth 
local max_fov = 5 -- maximum FOV
local min_delay = 30 -- ms delay
local smoothtype = "Static" -- "Static" or "Dynamic"
local function safemode_func() 
	if cw_check_safemode:GetValue() then
	
		-- ragebot master 
		if gui.GetValue("rbot.master") then
			gui.SetValue("rbot.master", false)
		end
		
		-- smooth factor
		for i, v in next, group_weapons do
			local current_smooth = gui.GetValue("lbot.weapon.aim." .. v .. ".smooth") -- lbot.weapon.aim.pistol.smooth
			if current_smooth < smooth_safe then
				gui.SetValue("lbot.weapon.aim." .. v .. ".smooth", smooth_safe)
			end
            local current_min = update_gui[i].min_smooth:GetValue() -- Enforce min_smooth ≥ 3
            if current_min < smooth_safe then
                update_gui[i].min_smooth:SetValue(smooth_safe)
            end
            local current_max = update_gui[i].max_smooth:GetValue() -- Enforce max_smooth ≥ 3
            if current_max < smooth_safe then
                update_gui[i].max_smooth:SetValue(smooth_safe)
            end
        end
		
		-- field of view 
		for i, v in next, group_weapons do
			local current_fov = gui.GetValue("lbot.weapon.target." .. v .. ".maxfov") -- lbot.weapon.target.pistol.maxfov
			if current_fov > max_fov then
				gui.SetValue("lbot.weapon.target." .. v .. ".maxfov", max_fov)
			end
		end
		
		-- auto wallbang
		for i, v in next, group_weapons do
			local current_autowall = gui.GetValue("lbot.weapon.vis." .. v .. ".autowall") --lbot.weapon.vis.pistol.autowall
			if current_autowall then
				gui.SetValue("lbot.weapon.vis." .. v .. ".autowall", false)
			end
		end
		
		-- smooth type
		for i, v in next, group_weapons do
			local current_smoothtype = gui.GetValue("lbot.weapon.aim." .. v .. ".smoothtype") --lbot.weapon.aim.pistol.smoothtype
			if current_smoothtype ~= smoothtype then
				gui.SetValue("lbot.weapon.aim." .. v .. ".smoothtype", smoothtype)
			end
		end
		
		-- triggerbot delay
		for i, v in next, group_weapons do
			local current_delay = gui.GetValue("lbot.trg.weapon." .. v .. ".delay") -- lbot.trg.weapon.pistol.delay"
			if current_delay < min_delay then
				gui.SetValue("lbot.trg.weapon." .. v .. ".delay", min_delay)
			end
		end
		
		-- auto fire triggerbot
		if gui.GetValue("lbot.trg.autofire") then
			gui.SetValue("lbot.trg.autofire", false)
		end
		
		-- auto fire aimbot
		if gui.GetValue("lbot.aim.autofire") then
			gui.SetValue("lbot.aim.autofire", false)
		end
		
		-- anti spread
		for i, v in next, group_weapons do
			gui.SetValue("lbot.trg.weapon." .. v .. ".antispread", false)
		end
	end
end
callbacks.Register("Draw", safemode_func)



-- Enable event listeners
client.AllowListener("player_hurt")
client.AllowListener("round_start")
client.AllowListener("round_end")
client.AllowListener("game_newmap")
client.AllowListener("game_end")



-- Clean up on unload
callbacks.Register("Unload", function()
    print(name_tag.."Unloading script...".. name_script)
end)



--[[
CHANGELOG
3.x.x
	Remake full code
	Added SafeMode BETA
	Added AutoUpdater
	Added Config. override
	Added Oscillation smooth
	Added Pro Spread
	Added Magnet Trigger
	Added Autowall
	Added Force AntiSpread
	Added Group Weapons
	Added Presents Hitbox
	Added Presents Prefer target.
	Added Messages(Tips and ticks)
	Fixed bugs/brokens/invalids/
	Fixed Crashed and Error Loops
	Improved code optimization
FUTURE
	add count force anti spread
	add indicator
	add watermark
--]]


