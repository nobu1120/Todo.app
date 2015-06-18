-----------------------------------------
-- 
-- file : lib.lua
--
-- creater : Nobuyoshi Tanaka
--
-- comment : library
--
-----------------------------------------

_W = display.contentWidth
_H = display.contentHeight

_RW = display.actualContentWidth
_RH = display.actualContentHeight

function returnTrue()
	return true
end

function loading( x , y , width , height , image )

	local loadingGroup = display.newGroup()
	local loadImage = display.newImage(loadingGroup,image,x,y,width,height)
	loadImage.anchorX , loadImage.anchorY = 0 , 0

	local transition = transition.to(loadImage,{time = 1000*100 , rotation = 180*100})


	return loadingGroup
end
