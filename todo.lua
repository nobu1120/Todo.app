-----------------------------------------
-- 
-- file : todo.lua
--
-- creater : Nobuyoshi Tanaka
--
-- comment : todoを入力し、作成出来る
--
-----------------------------------------

-- Library
local storyboard = require("storyboard")
local menu = require("menu")

-- View
local todo_view = require("todo_view")
local view = todo_view.new()

-- インスタンス化
local menu = menu.new()


local scene = storyboard.newScene()

local group = display.newGroup()

function scene:createScene( event )
	local background = display.newImage(group,"image/todoView.jpeg",_RW/2,_RH/2,true)
	background:scale(1,2)
	local task = view.createTask("image/flame2.png")
	local menuBtn = menu.createMenuBtn()
	group:insert(task)
	group:insert(menuBtn)
	group.isVisible = false
end

function scene:willEnterScene( event )
	self.view:insert(group)
	-- local loadImage = loading( _RW/2 , _RH/2 , 100 , 100 , "image/load.png")
	-- self.view:insert(loadImage)
end

function scene:enterScene( event )
	group.isVisible = true
end



scene:addEventListener("createScene")
scene:addEventListener("willEnterScene")
scene:addEventListener("enterScene")

return scene

