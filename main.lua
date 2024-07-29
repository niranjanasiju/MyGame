function love.load()
    loadModule("home/main.lua")
end

function loadModule(module)
    if love.unload then 
        love.unload() 
    end
    love.filesystem.load(module)()
    if love.load then 
        love.load() 
    end
end

function goToHomePage()
    loadModule("home/main.lua")
end

function goToScoreboard()
    loadModule("score_board/main.lua")
end

function goToGamePage()
    loadModule("Game/main.lua")
end
