local info = {
    moduleName = "WeakAuras Options",
    moduleDesc = "This will only recolor the Options window and does not touch any of your Auras.",
    color1 = {
        name = "Frame",
    },
    color2 = {
        name = "Background",
    },
}
local module = FrameColor_CreateSkinModule(info)

local pairs = pairs
local SetDesaturation = SetDesaturation
local SetVertexColor = SetVertexColor

function module:OnEnable()
    local main_color = self:GetColor1()
    local bg_color = self:GetColor2()
    if IsAddOnLoaded("WeakAurasOptions") then
        self:Recolor(main_color, bg_color, 1)
    else
        self:RegisterEvent("ADDON_LOADED", function(_, event)
            if event == "WeakAurasOptions" then
                RunNextFrame(function()
                    self:Recolor(main_color, bg_color, 1)
                end)
                self:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end

function module:OnDisable()
    local color = {r=1,g=1,b=1,a=1}
    if IsAddOnLoaded("WeakAurasOptions") then
        self:Recolor(color, color, 0)
    end
end

function module:Recolor(main_color, bg_color, desaturation)
    --recolor frame
    local WeakAurasOptions = WeakAurasOptions
    if not WeakAurasOptions then 
        return
    end
    for _, texture in pairs({
        WeakAurasOptions.NineSlice.TopEdge,
        WeakAurasOptions.NineSlice.BottomEdge,
        WeakAurasOptions.NineSlice.TopRightCorner,
        WeakAurasOptions.NineSlice.TopLeftCorner,
        WeakAurasOptions.NineSlice.RightEdge,
        WeakAurasOptions.NineSlice.LeftEdge,
        WeakAurasOptions.NineSlice.BottomRightCorner,
        WeakAurasOptions.NineSlice.BottomLeftCorner,  
    }) do
        texture:SetDesaturation(desaturation)
        texture:SetVertexColor(main_color.r,main_color.g,main_color.b) 
    end
    local Bg = WeakAurasOptionsBg
    if Bg then
        Bg:SetDesaturation(desaturation)
        Bg:SetVertexColor(bg_color.r, bg_color.g, bg_color.b)
    end
end

