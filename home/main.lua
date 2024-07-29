-- main.lua

function love.load()
    background = love.graphics.newImage("assets/background.jpg")
    title = love.graphics.newImage("assets/title.png")
    soundOnIcon = love.graphics.newImage("assets/sound-on.png")
    soundOffIcon = love.graphics.newImage("assets/sound-off.png")
    backgroundMusic = love.audio.newSource("assets/music.mp3", "stream")
    backgroundMusic:setLooping(true)

    font = love.graphics.newFont(24)
    
    local titleY = title:getHeight() - 190

    playButton = {
        x = 300,
        y = titleY + 0, 
        width = 200,
        height = 50
    }

    soundButton = {
        x = love.graphics.getWidth() - soundOnIcon:getWidth() - 20,  
        y = 20,
        width = 24,  
        height = 24,  
        on = true,
        backgroundMusic:play()  
    }

  
    highScore = 0
end



function love.draw()
   
    local scaleX = love.graphics.getWidth() / background:getWidth()
    local scaleY = love.graphics.getHeight() / background:getHeight()

  
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)


    local titleX = love.graphics.getWidth() / 2 - title:getWidth() / 2
    love.graphics.draw(title, titleX, 20)  

    love.graphics.setFont(font)
    love.graphics.printf("High Score: " .. highScore, 20, 20, love.graphics.getWidth(), "left")


    local soundIconX = love.graphics.getWidth() - soundOnIcon:getWidth() - 20
    love.graphics.draw(soundButton.on and soundOnIcon or soundOffIcon, soundIconX, 20, 0, soundButton.width / soundOnIcon:getWidth(), soundButton.height / soundOnIcon:getHeight())


    love.graphics.setFont(font) 
    love.graphics.setColor(0.4, 0.4, 1)  
    love.graphics.rectangle("fill", playButton.x, playButton.y, playButton.width, playButton.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("PLAY NOW", playButton.x + 35, playButton.y + 8, playButton.width, "left")
end



function love.mousepressed(x, y, button, istouch, presses)

    if button == 1 and x >= playButton.x and x <= playButton.x + playButton.width and
    y >= playButton.y and y <= playButton.y + playButton.height then
        goToGamePage()
    end

    if button == 1 and x >= soundButton.x and x <= soundButton.x + soundButton.width and
       y >= soundButton.y and y <= soundButton.y + soundButton.height then
        toggleSound()
    end
end



function toggleSound()
    soundButton.on = not soundButton.on
    if soundButton.on then
        backgroundMusic:play() 
    else
        backgroundMusic:stop()  
    end
end


