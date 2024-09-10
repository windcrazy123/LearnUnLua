--[[
    说明：
    
    使用 {函数名}_RPC 可以覆盖蓝图中RPC函数的实现
    使用 OnRep_{变量名} 可以覆盖蓝图中变量同步消息的处理

    蓝图示例：
    Content/Tutorials/10_Replications/ChatCharacter.uasset

    脚本示例：
    Content/Script/Tutorials/ChatCharacter.lua
]] --

---@type ChatCharacter_C
local M = UnLua.Class()

local Screen = require "Tutorials.Screen"

function M:UserConstructionScript()
    self.Name = ""
    if self.NameTextRender then
        self.NameTextRender:SetText("")
    end
end

function M:ReceivePossessed()
    self.Name = string.format("PLAYER_%d", self:GetController().PlayerState.PlayerId)
    if self.NameTextRender then
        self.NameTextRender:SetText(self.Name)
    end
    self:Say_Multicast("我来了")
end

function M:Say_Server_RPC(text)
    self:Say_Multicast(text)
end

function M:Say_Multicast_RPC(text)
    local msg = string.format("[%s]说：%s", self.Name, text)
    Screen.Print(msg)
end

function M:OnRep_Name()
    self.NameTextRender:SetText(self.Name)
end

function M:SpaceBar_Pressed()
    self:Jump()
    self:Say_Server("我跳~")
end

function M:MoveForward(AxisValue)
	self:AddMovementInput(UE.FVector(AxisValue, 0, 0), 100, false)
end

function M:MoveRight(AxisValue)
    self:AddMovementInput(UE.FVector(0, AxisValue, 0), 100, false)
end

return M
