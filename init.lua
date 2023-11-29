--程序初始化
--移除文本内容
io.open("speedrunLog.txt","w"):close()
function OnPlayerSpawned( player_entity )--当玩家加载的时候
    local file = io.open("speedrunLog.txt", "a")
    io.output(file)
    io.write("SpawnPlayer\n")--打印生成玩家
    io.write("World seed:"..tostring(StatsGetValue("world_seed")).."\n")--打印世界种子
    io.close(file)
    WSComponent = EntityGetFirstComponent(GameGetWorldStateEntity(),"WorldStateComponent")
    HolyMountainValue = tonumber( GlobalsGetValue( "HOLY_MOUNTAIN_DEPTH", "0" ) )
end

function OnPlayerDied()--当玩家死亡的时候
    local file = io.open("speedrunLog.txt", "a")
    io.output(file)
    if IsSampoUse then
        io.write("LUA: Sampo:completed!\n")--打印玩家结束游戏
    end
    io.write("HandleEvent - Player Entity Destroyed\n")--打印死亡玩家
    io.close(file)
end

function OnWorldPreUpdate()--监听玩家是否完成了伟大之作
    local deepest_hm = tonumber( GlobalsGetValue( "HOLY_MOUNTAIN_DEPTH", "0" ) )
    if deepest_hm > HolyMountainValue then
        HolyMountainValue = deepest_hm
        local hm_visits = GlobalsGetValue( "HOLY_MOUNTAIN_VISITS", "0" )
        local file = io.open("speedrunLog.txt", "a")
        io.output(file)
        io.write("uusi HM " .. hm_visits .. "\n")
        io.close(file)
    end
    if WSComponent ~= nil then
        local down = ComponentGetValue2(WSComponent,"EVERYTHING_TO_GOLD")
        local up = ComponentGetValue2(WSComponent,"INFINITE_GOLD_HAPPENING")
        if tostring(down) == "false" and tostring(up) == "false" then
            return
        end
        IsSampoUse = true
        WSComponent = nil
    end
end