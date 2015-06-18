-----------------------------------------
-- 
-- file : home.lua
--
-- creater : Nobuyoshi Tanaka
--
-- comment : home画面作成
--
-----------------------------------------

-- Library
local storyboard = require("storyboard")
local widget = require("widget")

local scene = storyboard.newScene()

local group = display.newGroup()
local todoBtn

function scene:createScene( event )
	local background = display.newImage(group,"image/1.jpg",_RW/2,_RH/2,true)

	-- todoページへ移動
	todoBtn = widget.newButton
	{
	    width = 300,
	    height = 100,
	    defaultFile = "btn/todoBtn.png",
	    label = "Todo",
	    labelColor = { default={ 0.5, 0.3, 0.3 }, over={ 0, 0, 0, 0.5 } },
	    fontSize = 80,
	    isEnabled = false,
	    onEvent = function( event ) storyboard.gotoScene("todo",{ effect = "crossFade" , time = 2000 }) end

	}
	todoBtn.x , todoBtn.y = _RW/2 , _RH/3
	todoBtn.alpha = 0.7
	group:insert(todoBtn)
end

function scene:willEnterScene( event )

end


function scene:enterScene( event )
	todoBtn:setEnabled( true )
	self.view:insert(group)
end



scene:addEventListener("createScene")
scene:addEventListener("willEnterScene")
scene:addEventListener("enterScene")

return scene