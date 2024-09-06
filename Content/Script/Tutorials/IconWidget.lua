local Screen = require "Tutorials.Screen"
local FVector2D = UE.FVector2D
local FLinearColor = UE.FLinearColor
local FVector = UE.FVector
local FWidgetTransform = UE.FWidgetTransform

---@type IconWidget_C
local M = UnLua.Class()

function M:RandomPosition()
    local x = math.random(0, 1920)
    local y = math.random(0, 960)
    --self:SetPositionInViewport(FVector2D(x, y))
    --Screen.Print(x..','..y)
    --self:SetAlignmentInViewPort(FVector2D(0.5,0.5))
print("rrrrrrrrrrttttttttttttttt")
    local widgetTransform = FWidgetTransform();
    widgetTransform.Translation = FVector2D(500,1)
    widgetTransform.Angle = 100
    
    self:SetRenderTransform(--[[FTransform(FVector(1,0,0),FVector(2,1,1),FVector(1,1,3))]]widgetTransform)
    
end

return M
