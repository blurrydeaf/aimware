local Walkbot = {
    is_running = false,
    move_left = true,
    speed = 250,
    last_velocity = 0,
    switch_delay = 0.1,
    last_switch_time = 0,
    stuck_timer = 0,
    stuck_threshold = 0.5,
    unstick_duration = 0.5,
    is_unsticking = false,
    unstick_attempts = 0,      -- Track attempts to alternate direction
    max_unstick_attempts = 2,  -- Try backward then forward, up to 2 cycles
    enemy_stop_range = 500,
    enemy_detected = false,
    status_message = ""
}

local gui_window = gui.Window("v_walkbot", "V-Pattern Walkbot", 200, 200, 400, 200)
gui_window:SetActive(1)
local gui_group = gui.Groupbox(gui_window, "Controls", 15, 15, 370, 0)
local toggle_button = gui.Button(gui_group, "Start/Stop Walkbot", function()
    Walkbot.is_running = not Walkbot.is_running
    Walkbot.status_message = Walkbot.is_running and "Walkbot started" or "Walkbot stopped"
end)

function Walkbot:check_for_enemies()
    local local_player = entities.GetLocalPlayer()
    if not local_player or not local_player:IsAlive() then return false end

    local my_team = local_player:GetTeamNumber()
    local my_pos = local_player:GetAbsOrigin()
    local players = entities.FindByClass("CCSPlayer")

    for i, player in pairs(players) do
        if player:IsAlive() and player:GetTeamNumber() ~= my_team then
            local enemy_pos = player:GetAbsOrigin()
            local distance = (my_pos - enemy_pos):Length()
            if distance <= self.enemy_stop_range then
                return true
            end
        end
    end
    return false
end

function Walkbot:check_wall_collision()
    local local_player = entities.GetLocalPlayer()
    if not local_player or not local_player:IsAlive() then return false end

    local velocity = local_player:GetPropVector("m_vecVelocity"):Length2D()
    local current_time = globals.CurTime()

    if velocity < 50 and self.last_velocity > 100 and (current_time - self.last_switch_time) > self.switch_delay then
        self.last_switch_time = current_time
        self.stuck_timer = 0
        self.is_unsticking = false
        self.unstick_attempts = 0
        return true
    end

    if velocity < 10 then
        self.stuck_timer = self.stuck_timer + globals.FrameTime()
        if self.stuck_timer > self.stuck_threshold then
            self.is_unsticking = true
            if self.unstick_attempts == 0 then
                self.last_switch_time = current_time  -- Reset timer for new unsticking attempt
            end
            return false
        end
    else
        self.stuck_timer = 0
        self.is_unsticking = false
        self.unstick_attempts = 0
    end

    self.last_velocity = velocity
    return false
end

function Walkbot:move(cmd)
    if not self.is_running then 
        self.status_message = "Walkbot not running"
        return 
    end

    local local_player = entities.GetLocalPlayer()
    if not local_player then
        self.status_message = "Local player not found!"
        return
    end
    if not local_player:IsAlive() then
        self.status_message = "Local player is dead!"
        return
    end

    self.enemy_detected = self:check_for_enemies()
    if self.enemy_detected then
        cmd:SetForwardMove(0)
        cmd:SetSideMove(0)
        self.status_message = "Enemy detected - stopping"
        return
    end

    if self.is_unsticking then
        local direction = (self.unstick_attempts % 2 == 0) and -self.speed or self.speed  -- Alternate backward/forward
        cmd:SetForwardMove(direction)
        cmd:SetSideMove(0)
        self.status_message = "Unsticking - moving " .. (direction < 0 and "backward" or "forward") .. " (Attempt " .. (self.unstick_attempts + 1) .. ")"

        if globals.CurTime() - self.last_switch_time > self.unstick_duration then
            local velocity = local_player:GetPropVector("m_vecVelocity"):Length2D()
            if velocity < 10 and self.unstick_attempts < self.max_unstick_attempts then
                self.unstick_attempts = self.unstick_attempts + 1  -- Try next direction
                self.last_switch_time = globals.CurTime()
            else
                self.is_unsticking = false
                self.unstick_attempts = 0
                self.last_switch_time = globals.CurTime()
            end
        end
    else
        cmd:SetForwardMove(self.speed * 0.5)
        cmd:SetSideMove(self.move_left and -self.speed or self.speed)
        local direction = self.move_left and "left" or "right"
        self.status_message = "Moving " .. direction

        if self:check_wall_collision() then
            self.move_left = not self.move_left
            self.status_message = "Hit a wall, switching to " .. (self.move_left and "left" or "right")
        end
    end
end

callbacks.Register("Draw", function()
    local local_player = entities.GetLocalPlayer()
    local velocity = 0
    if local_player and local_player:IsAlive() then
        velocity = math.floor(local_player:GetPropVector("m_vecVelocity"):Length2D())
    end

    if not Walkbot.status_message or Walkbot.status_message == "" then return end

    local screen_width, screen_height = draw.GetScreenSize()
    local x = screen_width / 2
    local y = screen_height / 2 + 20

    draw.Color(255, 255, 255, 255)
    local full_message = Walkbot.status_message .. " | Velocity: " .. velocity
    draw.TextShadow(math.floor(x), math.floor(y), full_message)
end)

callbacks.Register("CreateMove", function(cmd)
    if not cmd then
        Walkbot.status_message = "cmd is nil!"
        return
    end
    Walkbot:move(cmd)
end)

Walkbot.status_message = "V-Pattern Walkbot loaded!"