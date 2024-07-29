-- main.lua
local Player = require("Game.player")
local Coin= require ("Game/coin")
local Enemy_1= require ("Game/enemy/enemy_1")
local enemy_2= require ("Game/enemy/enemy_2")
local Enemy_3= require ("Game/enemy/enemy_3")
local Enemy_4= require ("Game/enemy/enemy_4")

function love.load()
    background = love.graphics.newImage("assets/background.jpg")
    font = love.graphics.newFont(44)
    boardBackground = love.graphics.newImage("assets/brick_wall.jpg")

    boardColor = {1, 0.84, 0}
    Mapwidth = 4800
    yourScore = 0
    
    playAgainButton = {
        x = love.graphics.getWidth() / 2 - 175,
        y = love.graphics.getHeight()/ 1.33 - 150,
        width = 150,
        height = 50
    }

    homeButton = {
        x = love.graphics.getWidth() / 2 + 20,
        y = love.graphics.getHeight() / 1.33 - 150,
        width = 150,
        height = 50
    }
end

function love.update(dt)
    yourScore = calculateScore()
end

function love.draw()
    local scaleX = love.graphics.getWidth() / background:getWidth()
    local scaleY = love.graphics.getHeight() / background:getHeight()
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)

    local boardX = love.graphics.getWidth() / 4
    local boardY = love.graphics.getHeight() / 4
    local boardWidth = love.graphics.getWidth() / 2
    local boardHeight = love.graphics.getHeight() / 2
    love.graphics.draw(boardBackground, boardX, boardY, 0, boardWidth / boardBackground:getWidth(), boardHeight / boardBackground:getHeight())
    

    love.graphics.setColor(0, 0, 0) 
    love.graphics.setFont(font)
    love.graphics.printf("Your Score: " ..  yourScore, 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")


    love.graphics.setColor(0.4, 0.4, 1)  
    love.graphics.rectangle("fill", playAgainButton.x, playAgainButton.y, playAgainButton.width, playAgainButton.height)
    love.graphics.setColor(1, 1, 1) 
    font2 = love.graphics.newFont(24)
    love.graphics.setFont(font2)
    love.graphics.printf("PLAY AGAIN", playAgainButton.x, playAgainButton.y + 15, playAgainButton.width, "center")

    love.graphics.setColor(0.4, 0.4, 1)
    love.graphics.rectangle("fill", homeButton.x, homeButton.y, homeButton.width, homeButton.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("HOME", homeButton.x, homeButton.y + 15, homeButton.width, "center")
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and x >= playAgainButton.x and x <= playAgainButton.x + playAgainButton.width and
       y >= playAgainButton.y and y <= playAgainButton.y + playAgainButton.height then
        Coin.removeAll()
        Enemy_1.removeAll()
        Enemy_2.removeAll()
        Enemy_3.removeAll()
        Enemy_4.removeAll()
        goToGamePage()
        
    elseif x >= homeButton.x and x <= homeButton.x + homeButton.width and y >= homeButton.y and y <= homeButton.y + homeButton.height then
        Coin.removeAll()
        Enemy_1.removeAll()
        Enemy_2.removeAll()
        Enemy_3.removeAll()
        Enemy_4.removeAll()
        backgroundMusic:stop()
        goToHomePage()
    end
end

function calculateScore()
    yourScore = (Player.coins * 100)
   
    return yourScore
end