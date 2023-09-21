--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2 Beta
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]

local bgmenu = draw.CreateTexture(common.DecodePNG(http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/menu.png")))
local sideright = draw.CreateTexture(common.DecodePNG(http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/sideright.png?raw=true")))
local sideright1 = draw.CreateTexture(common.DecodePNG(http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/sideright1.png?raw=true")))
local sideleft = draw.CreateTexture(common.DecodePNG(http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/sideleft.png")))
local top = draw.CreateTexture(common.DecodePNG(http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/top.png?raw=true")))
local center = draw.CreateTexture(common.DecodePNG(http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/center.png?raw=true")))
local center1 = draw.CreateTexture(common.DecodePNG(http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/center1.png?raw=true")))
local bottom = draw.CreateTexture(common.DecodePNG(http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/bottom.png")))

--[[
local bgmenu = draw.CreateTexture(common.DecodePNG(file.Read("catware/bgmenu.png")))
local sideright = draw.CreateTexture(common.DecodePNG(file.Read("catware/sideright.png")))
local sideright1 = draw.CreateTexture(common.DecodePNG(file.Read("catware/sideright1.png")))
local sideleft = draw.CreateTexture(common.DecodePNG(file.Read("catware/sideleft.png")))
local top = draw.CreateTexture(common.DecodePNG(file.Read("catware/top.png")))
local center = draw.CreateTexture(common.DecodePNG(file.Read("catware/center.png")))
local center1 = draw.CreateTexture(common.DecodePNG(file.Read("catware/center1.png")))
local bottom = draw.CreateTexture(common.DecodePNG(file.Read("catware/bottom.png")))
--]]

local screenX, screenY = draw.GetScreenSize();
local menu = gui.Reference("MENU")
local abgmenu = 255
local acenter = 255
local acenter1 = 255
local atheme = 0
local r,g,b = 20, 20, 20

--##### TOP #####
callbacks.Register("Draw", function()

	if menu:IsActive() then
		local menuX, menuY = menu:GetValue()
		draw.SetTexture(top);
		draw.FilledRect(menuX+250, menuY-200, menuX+800, menuY+100);
	end
	
end)
--#########################

--##### BOTTOM #####
callbacks.Register("Draw", function()

	if menu:IsActive()  then
		randombottom = math.random (1,10)
	elseif randombottom == 1 then
		draw.SetTexture(bottom);
		draw.FilledRect(screenX-(screenX*0.18)-200, screenY-(screenX*0.17), screenX-200, screenY);
	end
	
end)
--#########################

--##### SIDE RIGHT #####
callbacks.Register("Draw", function()

	if menu:IsActive() then
	
		if randomright == 1 then
			local menuX, menuY = menu:GetValue()
			draw.SetTexture(sideright);
			draw.FilledRect(menuX+710, menuY+100, menuX+990 , menuY+600 );
		elseif randomright == 2 then
		 	local menuX, menuY = menu:GetValue()
			draw.SetTexture(sideright1);
			draw.FilledRect(menuX+760, menuY+400, menuX+1040 , menuY+900 );
		else 
			local menuX, menuY = menu:GetValue()
			draw.SetTexture(sideleft);
			draw.FilledRect(menuX, menuY-100, menuX+200, menuY+50 );
		end
		
	else
		randomright = math.random (1,3)
	end

end)
--#########################

--########## CENTER ##########
callbacks.Register("Draw", function()

	if menu:IsActive() then
	
		if acenter == 255 then
			acy = 0
		elseif acenter == 0 then
			acy = 255
		end
		
		if acy ~= acenter then
		
			if acy > acenter then
				acenter = acenter + 0.5
			else
				acenter = acenter - 0.5
			end
			
		end
		
		local menuX, menuY = menu:GetValue()
		draw.Color(255, 255, 255, acenter);
		draw.SetTexture(center);
		draw.FilledRect(menuX-600, menuY-300, menuX+1300 , menuY+790);
	end
	
	
	if menu:IsActive() then
	
		if acy == 0 then
			acy1 = 255
		elseif acy == 255 then
			acy1 = 0
		end
		
		if acy1 ~= acenter1 then
		
			if acy1 > acenter1 then
				acenter1 = acenter1 + 1
			else
				acenter1 = acenter1 - 1
			end
		end
		
		local menuX, menuY = menu:GetValue()
		draw.Color(255, 255, 255, acenter1);
		draw.SetTexture(center1);
		draw.FilledRect(menuX-600, menuY-300, menuX+1300 , menuY+790);
		
	end
	
end)
--#########################

--##### MENU ##### coded by LooseGod thank you 
callbacks.Register("Draw", function()

    if menu:IsActive() then
        local menux,menuy = menu:GetValue()
        draw.Color(255, 255, 255, abgmenu);
		gui.SetValue("theme.ui2.lowpoly1", r,g,b, atheme)
		gui.SetValue("theme.ui2.lowpoly2", r,g,b, atheme)
		gui.SetValue("theme.tablist.tabactivebg", r,g,b, atheme)
		gui.SetValue("theme.footer.bg", r,g,b, atheme)
		gui.SetValue("theme.nav.bg", r,g,b, atheme)
		gui.SetValue("theme.nav.active", r,g,b, atheme)
		gui.SetValue("theme.header.bg", r,g,b, atheme)
		gui.SetValue("theme.header.line", r,g,b, atheme)
        draw.SetTexture(bgmenu)
        draw.FilledRect(menux,menuy,menux+800,menuy+600);
    end
	
	if menu:IsActive() then
		aty = 0
	else 
		aty = 255
	end
	
	if aty ~= atheme then
	
		if aty > atheme then 
			atheme = atheme + 255
		else
			atheme = atheme - 1
		end
	end
	
	if menu:IsActive() then
		ay = 255
	else 
		ay = 0
	end
	
	if ay ~= abgmenu then
	
		if ay < abgmenu then 
			abgmenu = abgmenu - 255
		else
			abgmenu = abgmenu + 3
		end
		
	end
	
end)
--#########################
