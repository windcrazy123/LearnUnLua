--[[
    说明：覆盖蓝图事件时，只需要在返回的table中声明 Receive{EventName}

    例如：
    function M:ReceiveBeginPlay()
    end

    除了蓝图事件可以覆盖，也可以直接声明 {FunctionName} 来覆盖Function。
    如果需要调用被覆盖的蓝图Function，可以通过 self.Overridden.{FunctionName}(self, ...) 来访问

    例如：
    function M:SayHi(name)
        self.Overridden.SayHi(self, name)
    end

    注意：这里不可以写成 self.Overridden:SayHi(name)
]] --
--package.cpath = package.cpath .. ';C:/Users/Wemake/AppData/Roaming/JetBrains/Rider2024.1/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
--local dbg = require('emmy_core')
--dbg.tcpConnect('localhost', 9966)

local Screen = require "Tutorials.Screen"

local M = UnLua.Class()

print("aaaaaaaa")

function M:Initialize()
    Screen.Print("jjjjjjjjjjjj")
end

function M:ReceiveBeginPlay()
    local msg = self:SayHi("陌生人")
    Screen.Print(msg)
    self:Test()
end

function M:SayHi(name)
    local origin = self.Overridden.SayHi(self, name)
    myfunction ()
    print(debug.getinfo(1))
    return origin .. "\n\n" ..
        [[现在我们已经相互熟悉了，这是来自Lua的问候。

        —— 本示例来自 "Content/Script/Tutorials.02_OverrideBlueprintEvents.lua"
    ]]
end

function M:Test()
    Screen.Print("he")
end

function myfunction ()
    print(debug.traceback("Stack trace"))
    print(debug.getinfo(1))
    print("Stack trace end")
    return 10
end


return M
