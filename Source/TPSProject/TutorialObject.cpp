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

//如何自定义？？？？？？？？？？？？？？？？？？LuaArray.h  LuaLib_FVector.cpp
static int32 MyFunction(lua_State* L)
{
    const auto ParamNum = lua_gettop(L);
    if (ParamNum == 9)
    {
        return ParamNum;
    }
    const char* String = lua_tostring(L,2);
    if (String)
    {
        return 8;
    }
    const int n = lua_tointeger(L,3);
    if (n)
    {
        return n;
    }
    return 0;
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