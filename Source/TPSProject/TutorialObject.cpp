#include "TutorialObject.h"

#include "LuaCore.h"
#include "UnLua.h"
#include "UnLuaEx.h"

FTutorialObject::FTutorialObject()
{
}

static int32 FTutorialObject_New(lua_State* L)
{
	const auto NumParams = lua_gettop(L);
    //self，FString，int
    if (NumParams != 3)
    {
        UNLUA_LOGERROR(L, LogUnLua, Log, TEXT("%s: Invalid parameters!"), ANSI_TO_TCHAR(__FUNCTION__));
        return 0;
    }

    const char* NameChars = lua_tostring(L, 2);
    if (!NameChars)
    {
        UE_LOG(LogUnLua, Log, TEXT("%s: Invalid tutorial name!"), ANSI_TO_TCHAR(__FUNCTION__));
        return 0;
    }

    const int AgeFromLua = lua_tointeger(L, 3);
    if (!AgeFromLua)
    {
        UE_LOG(LogUnLua, Log, TEXT("%s: Invalid tutorial age!"), ANSI_TO_TCHAR(__FUNCTION__));
        return 0;
    }

    const auto UserData = NewUserdataWithPadding(L, sizeof(FTutorialObject), "FTutorialObject");
	new(UserData) FTutorialObject(UTF8_TO_TCHAR(NameChars),AgeFromLua);
    return 1;
}

//D:\UEProjects\LearnUnLua\Plugins\UnLua\Source\UnLua\Private\ReflectionUtils\FunctionDesc.cpp
//459 line:  if (lua_pcall(L, NumParams, LUA_MULTRET, -(NumParams + 2)) != LUA_OK)
//lua_pcall在某次调用中会调用到此函数，因此只能返回0或1
//获取L后将所需要的元素取出(从TValue转到FString)然后再将想要输出的值push到栈中，我们在lua文件中获取的值是我们放入的值
//lua 堆栈介绍: https://blog.csdn.net/lishenglong666/article/details/109991788
static int32 MyFunction(lua_State* L)
{
    const auto ParamNum = lua_gettop(L);
    if (ParamNum != 2)
    {
        return 0;
    }
    const char* String = lua_tostring(L,2);
    FString str = String;
    str.Append("hhhhh");
    /*char s[1024]= "hhh";
    strcat_s(s,String);*/
    lua_pushfstring(L,TCHAR_TO_ANSI(*str));
    return true;
}

//__call 元方法
//__call 元方法在 Lua 调用一个值时调用。即：当table名字做为函数名字的形式被调用的时候，会调用__call函数。参数第一位为self剩下的按顺序排列
static const luaL_Reg FTutorialObjectLib[] =
{
    { "__call", FTutorialObject_New },
    {"MyFunctionName",MyFunction},
    { nullptr, nullptr }
};

BEGIN_EXPORT_CLASS(FTutorialObject)
ADD_FUNCTION(GetTitle)
//
ADD_LIB(FTutorialObjectLib)
END_EXPORT_CLASS()
IMPLEMENT_EXPORTED_CLASS(FTutorialObject)

/*或者这样
 *BEGIN_EXPORT_CLASS(FTutorialObject,FString,int)
    ADD_FUNCTION(GetTitle)
    //
    //ADD_LIB(FTutorialObjectLib)
END_EXPORT_CLASS()
IMPLEMENT_EXPORTED_CLASS(FTutorialObject)
*/