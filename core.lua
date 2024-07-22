local frame = CreateFrame("FRAME")
frame:RegisterEvent("GROUP_ROSTER_UPDATE", "OnEvent")
frame:RegisterEvent("UNIT_CONNECTION", "OnEvent")
frame:RegisterEvent("UNIT_AREA_CHANGED", "OnEvent")
frame:RegisterEvent("UNIT_PHASE", "OnEvent")
frame:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
frame:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
frame:RegisterEvent("PLAYER_LOGIN", "OnEvent")

local function UpdateHealth(frame, unit)
    frame:SetValue(UnitHealth(unit))
end

frame:SetScript("OnEvent", function(self, event, ...) 
    if event == "PLAYER_LOGIN" then 
        print(string.format("|cFF20ff20%s loaded|r", "PetHealthbarBackground"))
            local frames = { CompactPartyFrame:GetChildren() } 
            local anchor = nil

            for i, frame in ipairs(frames) do
                if frame.unit and frame:IsVisible() and (not anchor or frame:GetBottom() < anchor:GetBottom()) then
                    anchor = frame
                end
            end

            if UnitExists('pet') then

            local f = CreateFrame("Frame", "PetHealthbar", UIParent, "BackdropTemplate")
            f:SetPoint("TOP", anchor, "BOTTOM", 0, -5)
            f:SetSize(anchor:GetWidth()+6, 20)
            f:SetBackdrop({
                bgFile = "Interface\\TargetingFrame\\UI-StatusBar",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 4, right = 4, top = 4, bottom = 4 },
            })
            f:SetBackdropColor(0,0,0,0.5)

            local s = CreateFrame("StatusBar", "PetHealthbarStatusBar", PetHealthbar)
            s:SetAllPoints(f)
            s:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
            s:SetStatusBarColor(0.780, 0.612, 0.431)
            s:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)  
            s:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
            

            f:SetFrameLevel(2) 
            s:SetFrameLevel(1)  
            f:SetFrameStrata("HIGH")  
            s:SetFrameStrata("LOW")

            s:SetMinMaxValues(0, UnitHealthMax("pet"))
            s:RegisterEvent("UNIT_HEALTH")
            s:RegisterEvent("UNIT_MAXHEALTH")
            s:RegisterEvent("PLAYER_TARGET_CHANGED")
            
            s:HookScript("OnEvent", function(self, event)        
                s:SetMinMaxValues(0, UnitHealthMax("pet"))
                UpdateHealth(s, "pet")
            end)
            
            elseif not UnitExists('pet') then
                print('not pet')
            end
        end 
    end
)


