-----------------------------------------
-- 
-- file : menu.lua
--
-- creater : Nobuyoshi Tanaka
--
-- comment : menuボタンの作成
--
-----------------------------------------

-- menuの中身
-- createTask : Taskを作成

module(...,package.seeall)

-- Library
local widget = require("widget")

local function listener()

	local self = {}
	self.menuContentsGroup = nil

	function self.createMenuBtn()
		
		local topGroup = display.newGroup()
		local menuBtnGroup = display.newGroup()
		self.menuContentsGroup = display.newGroup()

		local menuBtn = nil

		-- メニューの内容を作成
		local blackFilter = display.newRect( self.menuContentsGroup , _RW/2 , _RH*(6/7) , _RW , _RH*(2/7) )
		blackFilter:setFillColor(0)
		blackFilter.alpha = 0.7
		blackFilter:addEventListener("tap",returnTrue)
		blackFilter:addEventListener("touch",returnTrue)
		self.menuContentsGroup.isVisible = false

		-- touch後メニューを表示する
		local function menuHandler( event )
			
			if event.phase == "ended" then
				topGroup:insert(self.menuContentsGroup)
				topGroup:insert(menuBtnGroup)
				if self.menuContentsGroup.isVisible == true then
					self.menuContentsGroup.isVisible = false
				elseif self.menuContentsGroup.isVisible == false then
					self.menuContentsGroup.isVisible = true
				end
			end
		end

		-- メニューボタン作成
		menuBtn = widget.newButton
            {
            	x = _W - 80 , 
            	y = _H - 80 , 
                radius = 60 , 
                shape = "circle" ,
                label = "menu" ,
                fontSize = 45,
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0.5, 0.3, 0.2 } } , 
                fillColor = { default={ 1, 0.2, 0.4, 0.5 }, over={ 1, 0.4, 0.5, 0.5 } } ,
                strokeColor = { default={ 0.3 , 0.4 , 0.5 }, over={ 0.3 , 0.4 , 0.5 } } ,
                strokeWidth = 8 ,
                onEvent = menuHandler ,
            }

        menuBtnGroup:insert(menuBtn)
        topGroup:insert(menuBtnGroup)



        return topGroup
    end

    function self.addMenuOption()

    end

	return self

end

function new()
	return listener()
end