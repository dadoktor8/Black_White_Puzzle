local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 





math.randomseed(os.time()) -- Define random arg! 

--Define global game variables

local player_white
local player_black

local background_white
local background_black


local obj_white
local obj_black

local obj_black_done = false
local obj_white_done = false

local backGroup 
local mainGroup 
local uiGroup 

local level = 1
local levelText
local levelTemp
local timerCount = 10
local timerCountText
local timerCountTimer

local gameDoneText

local up
local down
local left 
local right

--Obj SpriteSheet
local Obj_White_SS_Opt = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 200,
            height = 200
        },
        {          
            x = 200,
            y = 0,
            width = 200,
            height = 200
        },
        {
            x = 400,
            y = 0,
            width = 200,
            height = 200
        },
        {
            x = 600,
            y = 0,
            width = 200,
            height = 200
        }
    }
}
local Obj_White_SS = graphics.newImageSheet( "White_Obj.png", Obj_White_SS_Opt )
local Obj_White_Idle_Seq = {
    {
        name = "idle",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local Obj_Black_SS_Opt = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 200,
            height = 200
        },
        {          
            x = 200,
            y = 0,
            width = 200,
            height = 200
        },
        {
            x = 400,
            y = 0,
            width = 200,
            height = 200
        },
        {
            x = 600,
            y = 0,
            width = 200,
            height = 200
        }
    }
}
local Obj_Black_SS = graphics.newImageSheet( "Black_Obj.png", Obj_Black_SS_Opt )
local Obj_Black_Idle_Seq = {
    {
        name = "idle",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}

--Background SpriteSheet
local BG_White_SS_Opt = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 1024,
            height = 768
        },
        {          
            x = 768,
            y = 0,
            width = 1024,
            height = 768
        },
        {
            x = 1536,
            y = 0,
            width = 1024,
            height = 768
        },
        {
            x = 2304,
            y = 0,
            width = 1024,
            height = 768
        }
    }
}
local BG_White_SS = graphics.newImageSheet( "White_BG.png", BG_White_SS_Opt )
local BG_White_Idle_Seq = {
    {
        name = "idle",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}
local BG_Black_SS_Opt = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 1024,
            height = 768
        },
        {          
            x = 768,
            y = 0,
            width = 1024,
            height = 768
        },
        {
            x = 1536,
            y = 0,
            width = 1024,
            height = 768
        },
        {
            x = 2304,
            y = 0,
            width = 1024,
            height = 768
        }
    }
}
local BG_Black_SS = graphics.newImageSheet( "Black_BG.png", BG_Black_SS_Opt )
local BG_Black_Idle_Seq = {
    {
        name = "idle",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}

--Player SpriteSheet

local Player_White_SS_Opt = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 270,
            height = 500
        },
        {          
            x = 270,
            y = 0,
            width = 270,
            height = 500
        },
        {
            x = 540,
            y = 0,
            width = 270,
            height = 500
        },
        {
            x = 810,
            y = 0,
            width = 270,
            height = 500
        }
    }
}
local Player_Black_SS_Opt = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 270,
            height = 500
        },
        {          
            x = 270,
            y = 0,
            width = 270,
            height = 500
        },
        {
            x = 540,
            y = 0,
            width = 270,
            height = 500
        },
        {
            x = 810,
            y = 0,
            width = 270,
            height = 500
        }
    }
}
local Player_White_SS = graphics.newImageSheet( "Player_White.png", Player_White_SS_Opt )
local Player_Black_SS = graphics.newImageSheet( "Player_Black.png", Player_Black_SS_Opt )
local Player_White_Idle_Seq = {
    {
        name = "idle",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}
local Player_Black_Idle_Seq = {
    {
        name = "idle",
        start = 1,
        count = 4,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}
-- Define Physics
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
--Players Movement Functions
local function playerMovement(event)

    if(event.keyName == "a" and event.phase == "up") then -- Means left
        player_black.x = player_black.x - player_black.speed    -- Goes left
        if player_black.x <= 0 then
            player_black.x = 50
        end
        player_white.x = player_white.x + player_white.speed  -- Goes Right
        if player_white.x >= display.contentWidth then
            player_white.x = display.contentWidth - 50
        end
    elseif(event.keyName == "d" and event.phase == "up") then -- Means right
        player_black.x = player_black.x + player_black.speed    -- Goes right
        if player_black.x >= display.contentWidth then
            player_black.x = display.contentWidth - 50
        end
        player_white.x = player_white.x - player_white.speed  -- Goes left
        if player_white.x <= 0 then
            player_white.x = 50
        end    
    elseif(event.keyName == "w" and event.phase == "up") then -- Means up
        player_black.y = player_black.y - player_black.speed -- Goes up
        if player_black.y <= 0 then
            player_black.y = 50
        end
        player_white.y = player_white.y + player_white.speed -- Goes down
        if player_white.y >= display.contentHeight then
            player_white.y = display.contentHeight - 50
        end
    elseif(event.keyName == "s" and event.phase == "up") then -- Means down
        player_black.y = player_black.y + player_black.speed -- Goes down
        if player_black.y >= display.contentCenterY - 50 then
            player_black.y = display.contentCenterY - 50
        end
        player_white.y = player_white.y - player_white.speed
        if player_white.y <= display.contentCenterY + 50  then
            player_white.y = display.contentCenterY + 50
        end

    end
end 

local function goUp()
    player_black.y = player_black.y - player_black.speed -- Goes up
    if player_black.y <= 0 then
        player_black.y = 50
    end
    player_white.y = player_white.y + player_white.speed -- Goes down
    if player_white.y >= display.contentHeight then
        player_white.y = display.contentHeight - 50
    end


end
local function goDown()
    player_black.y = player_black.y + player_black.speed -- Goes down
    if player_black.y >= display.contentHeight then
        player_black.y = display.contentHeight - 50
    end
    player_white.y = player_white.y - player_white.speed
    if player_white.y <= 0  then
        player_white.y = 50
    end

end
local function goLeft()

    player_black.x = player_black.x - player_black.speed    -- Goes left
    if player_black.x <= 0 then
        player_black.x = 50
    end
    player_white.x = player_white.x + player_white.speed  -- Goes Right
    if player_white.x >= display.contentWidth then
        player_white.x = display.contentWidth - 50
    end
end
local function goRight()
    player_black.x = player_black.x + player_black.speed    -- Goes right
    if player_black.x >= display.contentCenterX - 50 then
        player_black.x = display.contentCenterX - 50
    end
    player_white.x = player_white.x - player_white.speed  -- Goes left
    if player_white.x <= display.contentCenterX + 50  then
        player_white.x = display.contentCenterX + 50
    end 

end

local function TimerSec()

    timerCount = timerCount - 1
    timerCountText.text = "Time: " .. timerCount

end

local function onLocalCollision(self, event)

    if(event.phase == "began" and (self.isVisible == true and event.other.isVisible == true)) then
        self.isVisible = false
        event.other.isVisible = false
        print(self.myName .."Reached" .. event.other.myName)
        if(self.myName == "PlayerBlack" and event.other.myName == "ObjectiveBlack") then
            obj_black_done = true
        end
        if(self.myName == "PlayerWhite" and event.other.myName == "ObjectiveWhite") then
            obj_white_done = true
        end
    end

end
local function levelReset()
    timerCountTimer = timer.performWithDelay( 1000, TimerSec, -1 )
    gameDoneText.isVisible = false
    obj_black.isVisible = true
    obj_white.isVisible = true
    player_black.isVisible = true
    player_white.isVisible = true
    timerCount = 10
    level = level + 1
    levelText.text = "Level: " .. level
    player_black.x = 200
    player_black.y = display.contentCenterY
    player_white.x = display.contentCenterX + 200
    player_white.y = display.contentCenterY
    obj_black.x = math.random(100, display.contentCenterX - 20)
    obj_black.y = math.random(20,display.contentHeight - 100)
    obj_white.x = math.random(display.contentCenterX + 20, display.contentWidth - 100)
    obj_white.y = math.random(20,display.contentHeight - 100)

end
local function OnObjComplete()

    if(obj_black_done == true and obj_white_done == true) then
        obj_black_done = false
        obj_white_done = false
        gameDoneText.isVisible = true
        timer.cancel( timerCountTimer )
        gameDoneText.text = "Level completed in " .. (10 - timerCount) .. " seconds"
        timer.performWithDelay(1500, levelReset  ,1)
    end
end

local function gameOver()

    if(timerCount == 0) then
        composer.gotoScene( "gameover",{time = 800, effect = "crossFade"}) 
    end
end

local function onTouch(event)
    local target = event.target

    if event.phase == "ended" then
        -- Handle touch ended event
        if target == up then
            goUp()
        elseif target == down then

            goDown()
        elseif target == left then
  
            goLeft()
        elseif target == right then
           
            goRight()
        end
    end

    return true 
end







-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    physics.pause()

    backGroup = display.newGroup()
    sceneGroup:insert(backGroup)

    mainGroup = display.newGroup()
    sceneGroup:insert(mainGroup)

    uiGroup = display.newGroup()
    sceneGroup:insert(uiGroup)

    gameDoneText = display.newText( uiGroup, "Level completed in " .. timerCount .. " seconds", 200,100,"neuropolitical_rg.tff",20)
    gameDoneText.isVisible = false
    gameDoneText:setFillColor(0,0,0)
    levelText = display.newText( uiGroup, "Level: " .. level, display.contentCenterX - 100,50,"neuropolitical_rg.tff",30)
    levelText:setFillColor(0,0,0)
    timerCountText = display.newText( uiGroup, "Time: " .. timerCount, display.contentCenterX + 100,50,"neuropolitical_rg.tff",30)

    --background_white =display.newRect( backGroup, 0, 0, display.contentWidth,display.contentHeight )
    background_white =display.newSprite( backGroup, BG_White_SS, BG_White_Idle_Seq )
    background_white.x = 0
    background_white.y = 0
    background_white.xScale = 0
    background_white.anchorX = 0.5
    background_white.anchorY = 0
    background_white:play()
    --background_white:setFillColor(1,1,1,1)

    --background_black =display.newRect( backGroup, display.contentCenterX, 0,display.contentWidth / 2,display.contentHeight )
    background_black =display.newSprite( backGroup, BG_Black_SS, BG_Black_Idle_Seq )
    background_black.x = display.contentCenterX
    background_black.y = 0
    background_black.anchorX = 0
    background_black.anchorY = 0
    background_black:play()
    --background_black:setFillColor(0,0,0,1)

    --player_black =display.newRect( mainGroup,200,display.contentCenterY, 50, 50)
    player_black = display.newSprite( mainGroup, Player_Black_SS, Player_Black_Idle_Seq )
    player_black.x = 200
    player_black.y = display.contentCenterY
    player_black.speed = 50
    player_black.xScale = 0.1
    player_black.yScale = 0.1
    player_black.anchorX = 0.5
    player_black.anchorY = 0.5
    player_black.width = 50
    player_black.height = 50
    --player_black:setFillColor(0,0,0)
    player_black:play()
    physics.addBody( player_black, {density = 0, friction = 0, isSensor = true} )
    player_black.myName = "PlayerBlack"
    player_black.collision = onLocalCollision

    --player_white =display.newRect( mainGroup, display.contentCenterX + 200, display.contentCenterY, 50, 50 )
    player_white = display.newSprite( mainGroup, Player_White_SS, Player_White_Idle_Seq )
    player_white.x = display.contentCenterX + 200
    player_white.y = display.contentCenterY
    player_white.speed = 50
    player_white.xScale = 0.1
    player_white.yScale = 0.1
    player_white.anchorX = 0.5
    player_white.anchorY = 0.5
    player_white.width = 50
    player_white.height = 50
    --player_white:setFillColor(1,1,1)
    player_white:play()
    physics.addBody( player_white, {density = 0, friction = 0, isSensor = true} )
    player_white.myName = "PlayerWhite"
    player_white.collision = onLocalCollision



    --obj_black = display.newCircle( mainGroup, math.random(20,display.contentCenterX  - 20),math.random(20, display.contentHeight - 20), 20)
    --obj_black:setFillColor(0,0,0)
    obj_black =display.newSprite( mainGroup, Obj_Black_SS, Obj_Black_Idle_Seq)
    obj_black.x = math.random(100, display.contentCenterX - 20)
    obj_black.y = math.random(20,display.contentHeight - 100)
    obj_black.xScale = 0.2
    obj_black.yScale = 0.2
    obj_black.anchorX = 0.5
    obj_black.anchorY = 0.5
    obj_black.width= 20
    obj_black.height= 20
    obj_black:play()
    obj_black.myName = "ObjectiveBlack"
    physics.addBody( obj_black, "kinematic", {density = 0, friction = 0} )

   -- obj_white = display.newCircle( mainGroup, math.random(display.contentCenterX + 20,display.contentWidth - 20),math.random(20, display.contentHeight - 20), 20)
   -- obj_white:setFillColor(1,1,1)
    obj_white = display.newSprite( mainGroup, Obj_White_SS, Obj_White_Idle_Seq )
    obj_white.x = math.random(display.contentCenterX + 20, display.contentWidth - 100)
    obj_white.y = math.random(20,display.contentHeight - 100)
    obj_white.xScale = 0.2
    obj_white.yScale = 0.2
    obj_white.anchorX = 0.5
    obj_white.anchorY = 0.5
    obj_white.width= 20
    obj_white.height= 20
    obj_white:play()                    
    obj_white.myName = "ObjectiveWhite"
    physics.addBody( obj_white, "kinematic", {density = 0, friction = 0} )


    up = display.newImage( uiGroup,"UP_Black.png", 100,display.contentHeight - 100)
    up.xScale = 0.2
    up.yScale = 0.2
    --up:setFillColor(0,0,0)
    down = display.newImage( uiGroup,"UP_Black.png", 100,display.contentHeight - 50)
    down:rotate(180)
    down.xScale = 0.2
    down.yScale = 0.2
    --down:setFillColor(0,0,0)
    left = display.newImage( uiGroup,"UP_White.png", display.contentWidth - 100,display.contentHeight - 75)
    left:rotate(270)
    left.xScale = 0.2
    left.yScale = 0.2
    right = display.newImage( uiGroup,"UP_White.png", display.contentWidth - 50,display.contentHeight - 75)
    right:rotate(90)
    right.xScale = 0.2
    right.yScale = 0.2



  
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        timerCount = 10
        level = 1
        levelText.text ="Level: " .. level
        

 
    elseif ( phase == "did" ) then
        physics.start( )
        Runtime:addEventListener("key", playerMovement)
        Runtime:addEventListener("enterFrame", OnObjComplete)
        Runtime:addEventListener("enterFrame", gameOver)
        timerCountTimer = timer.performWithDelay( 1000, TimerSec, -1 )
        player_black:addEventListener("collision")
        player_white:addEventListener("collision")
        left:addEventListener("touch",onTouch)
        right:addEventListener("touch",onTouch)
        up:addEventListener("touch",onTouch)
        down:addEventListener("touch",onTouch)
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        levelTemp = level
        composer.setVariable( "level", levelTemp )
        timer.cancel( timerCountTimer )
 
    elseif ( phase == "did" ) then
        physics.pause()
        Runtime:removeEventListener("enterFrame", gameOver)
        Runtime:removeEventListener("key", playerMovement)
        Runtime:removeEventListener("enterFrame", OnObjComplete)
        player_black:removeEventListener("collision")
        player_white:removeEventListener("collision")
        left:removeEventListener("touch",onTouch)
        right:removeEventListener("touch",onTouch)
        up:removeEventListener("touch",onTouch)
        down:removeEventListener("touch",onTouch)

 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene