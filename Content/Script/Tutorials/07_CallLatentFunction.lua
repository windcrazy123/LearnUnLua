--[[
    说明：在Lua协程中可以方便的使用UE4的Latent函数实现延迟执行的效果
]] --

package.cpath = package.cpath .. ';C:/Users/Wemake/AppData/Roaming/JetBrains/Rider2024.1/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
local dbg = require('emmy_core')
dbg.tcpConnect('localhost', 9966)

local Screen = require "Tutorials.Screen"

local M = UnLua.Class()

local function run(self, name)
    Screen.Print(string.format("协程%s：启动", name))
    for i = 1, 5 do
        UE.UKismetSystemLibrary.Delay(self, 1)
        Screen.Print(string.format("协程%s：%d", name, i))
    end
    Screen.Print(string.format("协程%s：结束", name))
end

local function runYield(self, name)
    print(string.format("协程%s：启动", name))
    for i = 1, 5 do
        coroutine.yield()
        UE.UKismetSystemLibrary.Delay(self,3)
        print(string.format("协程%s：%d", name, i))
    end
    print(string.format("协程%s：结束", name))
end

function M:ReceiveBeginPlay()
    local msg = [[
    —— 本示例来自 "Content/Script/Tutorials.07_CallLatentFunction.lua"
    ]]
    Screen.Print(msg)

    --=====================
    
    coroutine.resume(coroutine.create(run), self, "A")
    Screen.Print("==============")
    coroutine.resume(coroutine.create(run), self, "B")
    
    --=====================
    
    --[[--???这个和蓝图for加delay还不一样
    coA = coroutine.create(runYield)
    coB = coroutine.create(runYield)
    coroutine.resume(coA, self, "A")
    coroutine.resume(coB, self, "B")
    for i = 1, 5 do
        coroutine.resume(coA, self, "A")
        Screen.Print("\n")
        coroutine.resume(coB, self, "B")
        --UE.UKismetSystemLibrary.Delay(self,1)--Can't call latent action in main lua thread!
        Screen.Print("==============")
    end]]
    
    --=====================
end

return M
