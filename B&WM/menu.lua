local composer = require( "composer" )
 
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0,0)


math.randomseed(os.time())
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local backGroup 
local mainGroup 
local uiGroup 
 
local background_white
local background_black
 
local titleText
local menuButtonText

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
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
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

    titleText = display.newText( uiGroup, "2 WORLDS!", 200, display.contentCenterY,"neuropolitical_rg.tff",30)
    titleText:setFillColor(0,0,0)
    menuButtonText = display.newText( uiGroup, "START", display.contentCenterX + 200,display.contentCenterY,"neuropolitical_rg.tff",30)
    menuButtonText:setFillColor(1,1,1)
    local function playAgain()
        composer.gotoScene( "game_second",{time = 800, effect = "crossFade"})

    end 
    menuButtonText:addEventListener("tap",playAgain)

 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
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