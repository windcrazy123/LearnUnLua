---@type AN_FootStep_C : UAnimNotify
local M = UnLua.Class()

function M:Received_Notify(MeshComp, Animation)
    print("foot step")
    return false
end

return M