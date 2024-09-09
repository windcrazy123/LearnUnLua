--[[
    说明：如果需要从C++侧调用Lua，需要将UnLua模块添加到 {工程名}.Build.cs 的依赖配置里

    如果需要访问Lua原生API，则还需要添加Lua模块

    例如：
    PrivateDependencyModuleNames.AddRange(new string[]
    {
        "UnLua",
        "Lua",
    });

    本示例C++源码：
    Source\TPSProject\TutorialBlueprintFunctionLibrary.cpp
]]--

local Screen = require "Tutorials.Screen"

local M = UnLua.Class()

function M:ReceiveBeginPlay()
    local msg =
        [[

    —— 本示例来自 "Content/Script/Tutorials.08_CppCallLua.lua"
    ]]
    Screen.Print(msg)
    UE.UTutorialBlueprintFunctionLibrary.CallLuaByGlobalTable()
    Screen.Print("=================")
    UE.UTutorialBlueprintFunctionLibrary.CallLuaByFLuaTable()
end

function M.CallMe(a, b)
    local ret = a + b
    local msg = string.format("[Lua]收到来自C++的调用，a=%f b=%f，返回%f", a, b, ret)
    Screen.Print(msg)
    return ret
end

--[[
从本质上来看，其实说是不存在所谓的C++与lua的相互调用。lua是运行在C上的，简单来说lua的代码会被编译成字节码在被C语言的语法运行。
在C++调用lua时，其实是解释运行lua文件编译出来的字节码。lua调用C++其实还是解释运行lua文件编译出来的字节码的语义是调用lua栈上的C++函数。
lua调用C++，是上述C++调用lua时即c的语法解释运行lua代码生成的字节码的一种情况，即取出lua状态机全局表中的CClosure中的函数指针运行。
https://www.cnblogs.com/hggzhang/p/17079700.html

在C++调用lua传的FuncName被解析后，一般会将lua文件最后一个匹配的字节码放入buffer中
]]
function M.CallMe(a,b)
    local ret = a
    local msg = string.format("[Lua]收到来自C++的调%fb", a, ret)
    Screen.Print(msg)
    return ret
end

return M
