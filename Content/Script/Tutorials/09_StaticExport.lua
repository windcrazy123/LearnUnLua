--[[
    说明：

    本示例C++源码：
    \Source\TPSProject\TutorialObject.cpp
]]--

local Screen = require "Tutorials.Screen"

local M = UnLua.Class()

function M:ReceiveBeginPlay()
    local msg =
        [[

    —— 本示例来自 "Content/Script/Tutorials.09_StaticExport.lua"
    ]]
    Screen.Print(msg)
    
    local tutorial = UE.FTutorialObject("MyName",1)
    msg = string.format("tutorial -> %s\n\n tutorial:GetTitle() -> %s", tostring(tutorial), tutorial:GetTitle())
    local ParamNum = UE.FTutorialObject.MyFunctionName("hh",3)
    print("ParamNum",ParamNum)
    Screen.Print(msg)
end

return M
