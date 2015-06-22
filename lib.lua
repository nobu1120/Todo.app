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


-- library.lua

_W = display.contentWidth
_H = display.contentHeight

-- Btn.lua
function storyboardBtn(X,Y,word,file,option)

	local storyboard = require("storyboard")
	local group = display.newGroup()
	local btn = display.newRect(group,300,300,X,Y)
	btn:setFillColor(0.3,0.2,0.4)
	local text = display.newText(group,word,btn.x,btn.y,nil,40)
	text:setFillColor(0.3,0.5,0.9)

	local function storyboardListener(event)

		if event.phase == "began" then 

			btn:setFillColor(0.3,0.4,0.5)

		elseif event.phase == "ended" then

			btn:setFillColor(0.3,0.2,0.4)

			storyboard.gotoScene(file,option)

		end

		return true
	end

	btn:addEventListener("touch",storyboardListener)

	return group
end

function print_r ( t ) 
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end