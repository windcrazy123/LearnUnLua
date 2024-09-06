--[[
    说明：在蓝图中实现UnLuaInterface接口，并通过 GetModuleName 指定脚本路径，即可绑定到Lua

    例如：
    本脚本由 "Content/Tutorials/01_HelloWorld/HelloWorld.map" 的关卡蓝图绑定
]]
--package.cpath = package.cpath .. ';C:/Users/Wemake/AppData/Roaming/JetBrains/Rider2024.1/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
--local dbg = require('emmy_core')
--dbg.tcpConnect('localhost', 9966)
--dbg.breakHere()--一旦连接就在此处进行断点调试


local Screen = require "Tutorials.Screen"

local M = UnLua.Class()

-- 所有绑定到Lua的对象初始化时都会调用Initialize的实例方法
function M:Initialize()
    print("unlua version ===> ".._VERSION)
    local msg = [[
    Hello World!

    —— 本示例来自 "Content/Script/Tutorials/01_HelloWorld.lua"
    ]]
    local msg2 = "hhhh\n"
    local totalMsg = {msg, msg2}
    --print(table.concat(totalMsg))
    --print(msg..msg2)
    
    Screen.Print(msg)

    tbl = {[1] = 2, [2] = 6, [3] = 34, [26] =5, [25]=36, [4]=3}
    print("tbl 最大值：", table_maxn(tbl,23))
    print("tbl 长度 ", #tbl)
--===================================
    -- 创建协同程序
    local co = coroutine.create(foo)

    -- 启动协同程序
    local status, result = coroutine.resume(co)
    print(status,result) -- 输出: 暂停 foo 的执行
    print(coroutine.running())
    -- 恢复协同程序的执行，并传入一个值
    status, result = coroutine.resume(co, 42,2)
    print(result) -- 输出: 协同程序 foo 恢复执行，传入的值为: 42
--===================================
    -- 创建对象
    myshape = Shape:new(nil,10)
    --myshape:printArea()
    -- 创建对象
    mysquare = Square:new(nil,10)
    --mysquare:printArea()
    -- 创建对象
    myrectangle = Rectangle:new(nil,10,20)
    
    myshape:printArea()
    mysquare:printArea()
    myrectangle:printArea()
end

function table_maxn(t)
    local mn=nil;
    for k, v in pairs(t) do
        if(mn==nil) then
            mn=v
        end
        if mn < v then
            mn = v
        end
    end
    return mn
end

function foo()
    print("协同程序 foo 开始执行")
    print(coroutine.running())
    local value = 8
    local anotherValue = 0;
    value, anotherValue= coroutine.yield("暂停 foo 的执行")
    print("协同程序 foo 恢复执行，传入的值为: " .. tostring(value))
    print(coroutine.running())
    print("协同程序 foo 结束执行")
end

-- Meta class
Shape = {area = 0}
-- 基础类方法 new
function Shape:new (o,side)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    side = side or 0
    self.area = side*side;
    return o
end
-- 基础类方法 printArea
function Shape:printArea ()
    print("面积为 ",self.area)
end

Square = Shape:new()
-- 派生类方法 new
function Square:new (o,side)
    o = o or Shape:new(o,side)
    setmetatable(o, self)
    self.__index = self
    return o
end

-- 派生类方法 printArea
function Square:printArea ()
    print("正方形面积为 ",self.area)
end

Rectangle = Shape:new()
-- 派生类方法 new
function Rectangle:new (o,length,breadth)
    o = o or Shape:new(o)
    setmetatable(o, self)
    self.__index = self
    self.area = length * breadth
    return o
end

-- 派生类方法 printArea
function Rectangle:printArea ()
    print("矩形面积为 ",self.area)
end


return M
