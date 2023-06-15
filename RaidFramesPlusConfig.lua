local locales = select(2,...)
local handler = RaidFramePlusHandler
local frame1 = CreateFrame("Frame", "RaidFramesPlusConfig", handler, "SettingsFrameTemplate, SecureFrameTemplate") 
local GetProfile = handler.GetProfile 
local default_roles = handler.default_roles 
local default_class = handler.default_class 

frame1:SetPoint("TOPLEFT",CompactRaidFrameManager, "TOPRIGHT", 0, 0)
frame1:SetSize(440,270)
frame1:SetMovable(true)
frame1:SetScript("OnDragStart", function(self) self:StartMoving() end)
frame1:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
frame1:RegisterForDrag("LeftButton")
frame1:EnableMouse(true)
--frame1.Bg:SetFrameStrata("BACKGROUND")
frame1.NineSlice.Text:SetFontObject("Fancy12Font") 
frame1.NineSlice.Text:SetText(locales[1])


local fs = frame1:CreateFontString(nil, nil, "GameFontNormalLeft")
fs:SetPoint("TOPLEFT", frame1, 30, -30)
fs:SetText(locales[2])
local infoTip = CreateFrame("Button", nil, frame1)
infoTip:SetSize(16, 16)
infoTip:SetPoint("TOPLEFT", frame1, 10, -30)
infoTip.Icon = infoTip:CreateTexture(nil, "ARTWORK")
infoTip.Icon:SetAllPoints()
infoTip.Icon:SetTexture("Interface\\FriendsFrame\\InformationIcon")
infoTip:SetHighlightTexture("Interface\\FriendsFrame\\InformationIcon")
local infoTipText = locales[13]
infoTip:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(infoTip, "ANCHOR_TOPRIGHT", 0, 10)
	GameTooltip:AddLine(infoTipText, 1, 1, 1, true)
	GameTooltip:Show()
end)
infoTip:SetScript("OnLeave", function() GameTooltip:Hide() end)

local play
local function onclick1(self)
	PlaySound(799);
	local id = self:GetID()
	local pp = RaidFramesPlus.pp or 7
	play.checks:SetTexCoord(0.5,1,0.5,1)
	self.checks:SetTexCoord(0,0.5,0.5,1)
	RaidFramesPlus.pp = id
	play = self
end

local onclick2 = "player_position=self:GetID() owner:Run(update)"
local _, h = fs:GetFont()
for i =1, 7 do 
	local button = CreateFrame("Button", nil, frame1, "SecureFrameTemplate")
	button:SetSize(70,16)
	button:SetPoint("TOPLEFT", 15, -(i-1)*16 -35-h)
	button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	button:SetScript("OnClick", onclick1)
	handler:WrapScript(button, "OnClick", onclick2)
	button:SetID(i)
	local text
	if i == 7 then
		text = locales[11]
	else
		if i == 6 then
			text = locales[12]
		else
			text = i
		end
	end
	
	local tex = button:CreateTexture(nil, "ARTWORK")
	tex:SetTexture("Interface\\Common\\UI-DropDownRadioChecks")
	tex:SetSize(16,16)
	tex:SetPoint("LEFT")
	if i == RaidFramesPlus.pp or (not RaidFramesPlus.pp and i == 7) then
		play = button
		tex:SetTexCoord(0,0.5,0.5,1)
	else
		tex:SetTexCoord(0.5,1,0.5,1)
	end
	button.checks = tex
	button:SetNormalFontObject("GameFontHighlightSmallLeft")
	button:SetText(text)
	button:GetFontString():SetPoint("LEFT", 20,0)
end 

local cursor = CreateFrame("Frame", nil, frame1)
cursor:SetSize(32,32)
cursor:SetFrameStrata("HIGH")
local tex = cursor:CreateTexture(nil, "ARTWORK")
tex:SetPoint("CENTER")
tex:SetSize(32,32)
cursor.tex = tex
cursor:Hide()
cursor:SetScript("OnUpdate", function(self)
	local uiScale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition()
	self.tex:SetPoint("CENTER", nil, "BOTTOMLEFT", x/uiScale, y/uiScale)
end)


local function template(i)
	local button = CreateFrame("Button", nil, frame1, "SecureHandlerMouseUpDownTemplate")
	button:SetSize(45, 45)
	button:SetScale(32/45)
	button:SetID(i)
	local tex = button:CreateTexture(nil, "OVERLAY")
	tex:SetAtlas("UI-HUD-ActionBar-IconFrame")
	tex:SetSize(46,45)
	tex:SetPoint("TOPLEFT")
	local tex = button:CreateTexture(nil, "OVERLAY")
	tex:SetAtlas("UI-HUD-ActionBar-IconFrame-Mouseover")
	tex:SetSize(46,45)
	tex:SetPoint("TOPLEFT")
	button:SetHighlightTexture(tex)
	local tex = button:CreateTexture(nil, "BACKGROUND")
	tex:SetAtlas("ui-hud-actionbar-iconframe-slot") --UI-HUD-ActionBar-IconFrame-Background
	tex:SetSize(45,45)
	tex:SetPoint("TOPLEFT")
	local tex = button:CreateTexture(nil, "ARTWORK")
	tex:SetPoint("CENTER")
	tex:SetSize(45,45)
	button.tex = tex
	button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	return button
end

local fs = frame1:CreateFontString(nil, nil, "GameFontNormalLeft")
fs:SetPoint("BOTTOMLEFT", frame1, 10, 102*32/45+5)
fs:SetText(locales[3])
fs:SetWidth(frame1:GetWidth()-20)

local function start(self)
	PlaySound(799)
	local id = self:GetID()
	local t = RaidFramesPlus.relos or default_roles
	cursor.tex:SetTexCoord(GetTexCoordsForRole(t[id]))
	cursor.tex:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
	cursor.xet = self.tex
	cursor:Show()
	self.tex:Hide()
end

local function stop(self)
	local targ = GetManagedEnvironment(handler).mouse1
	targ = targ and GetFrameHandleFrame(targ)
	if targ then
		PlaySound(799)
		local di = self:GetID()
		local id = targ:GetID()
		local t = RaidFramesPlus.relos
		if not t then t = default_roles 
		RaidFramesPlus.relos = t end
		local a = t[id]
		local b = t[di]
		targ.tex:SetTexCoord(GetTexCoordsForRole(b))
		self.tex:SetTexCoord(GetTexCoordsForRole(a))
		t[di] = a
		t[id] = b
	end
	self.tex:Show()
	cursor:Hide()
end

local enter = 'mouse1=self'
local leave = 'mouse1=nil'

handler:SetAttribute("roles",[[
	if mouse1 then
		local di = ...
		local id = mouse1:GetID()
		local a = roles[id]
		local b = roles[di]
		roles[id] = b
		roles[di] = a
		self:Run(update)
	end
]])

local sotp = "self:GetParent():GetParent():RunAttribute('roles', self:GetID())"

for i=1,3 do
	local button = template(i)
	button:SetPoint("BOTTOMLEFT", (i-1)*46 + 15, 57)
	handler:WrapScript(button, "OnEnter", enter)
	handler:WrapScript(button, "OnLeave", leave)
	button:HookScript("OnMouseDown", start)
	button:HookScript("OnMouseUp", stop)
	button:SetAttribute("_onmouseup", sotp)
	local t = RaidFramesPlus.relos or default_roles
	button.tex:SetTexCoord(GetTexCoordsForRole(t[i]))
	button.tex:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
end


local function start(self)
	PlaySound(799)
	local id = self:GetID()
	local t = RaidFramesPlus.class or default_class
	cursor.tex:SetTexCoord(unpack(CLASS_ICON_TCOORDS[t[id]]))
	cursor.tex:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
	self.tex:Hide()
	cursor:Show()
	cursor.xet = self.tex
end

local function stop(self)
	local targ = GetManagedEnvironment(handler).mouse2 
	targ = targ and GetFrameHandleFrame(targ)
	if targ then
		PlaySound(799)
		local di = self:GetID()
		local id = targ:GetID()
		local t = RaidFramesPlus.class
		if not t then t = default_class 
		RaidFramesPlus.class = t end
		local a = t[id]
		local b = t[di]
		targ.tex:SetTexCoord(unpack(CLASS_ICON_TCOORDS[b]))
		self.tex:SetTexCoord(unpack(CLASS_ICON_TCOORDS[a]))
		t[di] = a
		t[id] = b
	end
	self.tex:Show()
	cursor:Hide()
end

local enter = 'mouse2=self'
local leave = 'mouse2=nil'

handler:SetAttribute("class",[[
	if mouse2 then
		local di = ...
		local id = mouse2:GetID()
		local a = class[id]
		local b = class[di]
		class[id] = b
		class[di] = a
		self:Run(update)
	end
]])

local sotp = "self:GetParent():GetParent():RunAttribute('class',self:GetID())"

for i=1,13 do
	local button = template(i)
	handler:WrapScript(button, "OnEnter", enter)
	handler:WrapScript(button, "OnLeave", leave)
	button:HookScript("OnMouseDown", start)
	button:HookScript("OnMouseUp", stop)
	button:SetAttribute("_onmouseup", sotp)
	button:SetPoint("BOTTOMLEFT", (i-1)*46 +15, 10)
	local t = RaidFramesPlus.class or default_class
	button.tex:SetTexCoord(unpack(CLASS_ICON_TCOORDS[t[i]]))
	button.tex:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
end
template = nil

frame1:SetScript("OnHide", function()
	if cursor:IsShown() then
		cursor.xet:Show()
		cursor:Hide() 
	end
end)

handler:WrapScript(frame1, "OnHide", "mouse1=nil mouse2=nil")
 
local button = CreateFrame("CheckButton", nil, frame1, "UICheckButtonTemplate, SecureFrameTemplate")
button:SetSize(24,24)
button.Text:SetText(locales[4])
 
button:SetScript("OnClick", function(self)
	PlaySound(799)
	RaidFramesPlus.pet_below = not RaidFramesPlus.pet_below
end)
handler:WrapScript(button, "OnClick", "pet_below=not(pet_below) owner:Run(update)")
button:SetPoint("LEFT", frame1, "BOTTOM",  0, (57+45/2)*32/45)
button:SetChecked(RaidFramesPlus.pet_below)


-- AURA SIZE SLIDER
local fs = frame1:CreateFontString(nil, nil, "GameFontHighLightSmall")
fs:SetText(locales[5])
fs:SetPoint("TOP", frame1:GetWidth()*1/4, -30)

local aura_size = CreateFrame("Slider", nil, frame1)-- "UISliderTemplate"
aura_size:SetMinMaxValues(0, 20)
aura_size:SetSize(144,19)
aura_size:SetPoint("TOP", fs, "BOTTOM", 0, -4)
--aura_size:EnableMouse(true) ??
aura_size:SetOrientation("HORIZONTAL")

	local texl = aura_size:CreateTexture(nil, "BACKGROUND")
	texl:SetAtlas("Minimal_SliderBar_Left", true)
	texl:SetPoint("LEFT")
	local texr = aura_size:CreateTexture(nil, "BACKGROUND")
	texr:SetAtlas("Minimal_SliderBar_Right", true)
	texr:SetPoint("RIGHT")
	local texm = aura_size:CreateTexture(nil, "BACKGROUND")
	texm:SetAtlas("_Minimal_SliderBar_Middle", true)
	texm:SetPoint("LEFT", texl, "RIGHT")
	texm:SetPoint("RIGHT", texr, "LEFT")
	local tex = aura_size:CreateTexture(nil, "OVERLAY")
	--tex:SetAtlas("Minimal_SliderBar_Button", true)
	tex:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	tex:SetSize(32,32)
	aura_size:SetThumbTexture(tex)
 
 
local fs = aura_size:CreateFontString(nil, nil, "NumberFontSmallWhiteLeft")
fs:SetPoint("LEFT", aura_size, "RIGHT",5,0)
aura_size.value = fs

local fs = aura_size:CreateFontString(nil, nil, "GameFontHighLightSmallRight")
fs:SetPoint("RIGHT", aura_size, "LEFT", -5, 0)
fs:SetText(IGNORE)

aura_size:SetValue(0)
aura_size:SetScript("OnValueChanged", function(self, value)
	local profile = GetProfile()
	if profile then
		value = floor(value)
		local t = RaidFramesPlus[profile]
		if not t then t = {} RaidFramesPlus[profile] = t end
		if value ~= t.aura_size then
			self.value:SetText(value == 0 and "" or value)
			t.aura_size = value
			handler.update_baseSize(nil, value)
		end
	end
end) 

local button_name =  CreateFrame("CheckButton", nil, frame1, "UICheckButtonTemplate")
local button_role =  CreateFrame("CheckButton", nil, frame1, "UICheckButtonTemplate")
button_role:SetSize(24,24)
button_role:SetPoint("TOPLEFT",frame1, "TOP", 0,-75)
button_role.text:SetText(locales[6])
button_name:SetSize(24,24)
button_name:SetPoint("TOPLEFT",frame1, "TOP", 0,-100)
button_name.text:SetText(locales[7])
 
button_role:SetScript("OnClick", function(self)
	PlaySound(799)
	local profile = GetProfile()
	if profile then
	local t = RaidFramesPlus[profile]
	if not t then t = {} RaidFramesPlus[profile] = t end
	t.hide_role = self:GetChecked()
	CompactRaidFrameContainer:ApplyToFrames("normal", handler.toggle_role)
	end
end)
 
button_name:SetScript("OnClick", function(self)
	PlaySound(799)
	local profile = GetProfile()
	if profile then
	local t = RaidFramesPlus[profile]
	if not t then t = {} RaidFramesPlus[profile] = t end
	t.hide_name = self:GetChecked()
	CompactRaidFrameContainer:ApplyToFrames("normal", handler.toggle_name)
	CompactRaidFrameContainer:ApplyToFrames("mini", handler.toggle_name)
	end
end)

local button = CreateFrame("Button", nil, frame1, "UIMenuButtonStretchTemplate") 
button:SetWidth(172)
button:SetPoint("TOPLEFT", frame1, "TOP", 0, -135)
button:SetText(locales[14])
button:SetScript("OnClick", function(self)
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	local index = GetMacroIndexByName("RaidFramesPlus")
	if index == 0 then 		
		index =  CreateMacro("RaidFramesPlus", "Inv_pet_egbert",
[[# Target
/click xtarget|cff00F0F01|r
# Focus
/click xtarget1 RightButton
# Assist
/click xtarget1 MiddleButton
# Spell
/click xcast1 spellid or a spellname without space
#
# Replace 1 by the desired position (max 5)
# For xtargetX you can use the bindings interface
]])
		print(self[1])
	else
		print(self[2])
	end
	if index then
		ShowMacroFrame() --refresh?
	else
		print(self[3])
	end
end)
button[1] = locales[8]
button[2] = locales[9]
button[3] = locales[10]

local _, h = button:GetFontString():GetFont()
button:SetHeight(20+(h-10))

local function updateprofile()
	if frame1:IsShown() then
		local profile = GetProfile()
		if profile then
			local t = RaidFramesPlus[profile]
			if t then
				button_name:SetChecked(t.hide_name)
				button_role:SetChecked(t.hide_role)
				aura_size:SetValue(t.aura_size or 0)
				aura_size.value:SetText(t.aura_size == 0 and "" or t.aura_size)
			end
		end
	end
end
updateprofile()

frame1:SetScript("OnShow", updateprofile)
EditModeManagerFrame.CloseButton:HookScript("OnHide", updateprofile)
CompactPartyFrame:HookScript("OnShow", updateprofile)
CompactRaidFrameContainer:HookScript("OnShow", updateprofile)
wipe(locales)
