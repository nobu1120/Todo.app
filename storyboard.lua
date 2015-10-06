-- storyboard.lua

-- library読み込み
local composer   = require("composer")
-- composer.isDebug = true
--------------------------------------------------
-- composer 組み込み
--------------------------------------------------

local storyboard = {}

_composerGetScene             = composer.getScene
_composerGetSceneName         = composer.getSceneName
_composerGetVariable          = composer.getVariable
_composerGotoScene            = composer.gotoScene
_composerHideOverlay          = composer.hideOverlay
-- _composerIsDebug              = composer.isDebug
_composerLoadScene            = composer.loadScene
_composerNewScene             = composer.newScene
_composerRecycleAutomatically = composer.recycleAutomatically
_composerRecycleOnLowMemory   = composer.recycleOnLowMemory
-- _composerRecycleOnSceneChange = composer.recycleOnSceneChange
_composerRemoveHidden         = composer.removeHidden
_composerRemoveScene          = composer.removeScene
_composerSetVariable          = composer.setVariable
_composerShowOverlay          = composer.showOverlay
-- _composerStage                = composer.stage

composer.recycleOnSceneChange = storyboard.purgeOnSceneChange
composer.isDebug              = storyboard.isDebug
composer.stage                = storyboard.stage

--------------------------------------------------
-- 変更後composerを組み込んだ関数
--------------------------------------------------

local scene      = _composerNewScene()

function storyboard.newScene()

	scene:addEventListener("create", create )
	scene:addEventListener("show", show )
	scene:addEventListener("hide", hide )
	scene:addEventListener("destroy", destroy )

	return scene
end

function scene:create( event )

	local disEvent = {}
	disEvent.name = "createScene"
	scene:dispatchEvent(disEvent)

end

function scene:show( event )
	local phase = event.phase

	if ( phase == "will" ) then
		
		local disEvent = {}
		disEvent.name = "willEnterScene"
		scene:dispatchEvent(disEvent)

	elseif ( phase == "did" ) then

		local disEvent = {}
		disEvent.name = "enterScene"
		scene:dispatchEvent(disEvent)

	end
end

function scene:hide( event )
	local phase = event.phase

	if ( phase == "will" ) then

		local disEvent = {}
		disEvent.name = "exitScene"
		scene:dispatchEvent(disEvent)

	elseif ( phase == "did" ) then

		local disEvent = {}
		disEvent.name = "didExitScene"
		scene:dispatchEvent(disEvent)

	end
end

function scene:destroy( event )

		local disEvent = {}
		disEvent.name = "destroyScene"
		scene:dispatchEvent(disEvent)

end

function storyboard.getCurrentSceneName()
	local sceneName = _composerGetSceneName("current")

	if sceneName == nil then
		sceneName = _composerGetSceneName("overlay")
		if sceneName == nil then
			return false
		end
	else
		return sceneName
	end
end

function storyboard.getPrevious()
	return _composerGetSceneName("previous")
end

function storyboard.purgeScene()
	_composerRemoveScene( true )
end

function storyboard.purgeAll()
	_composerRemoveHidden( true )
end

function storyboard.removeAll()
	_composerRemoveHidden( false )
end

-- default true
-- change to false to disable auto-recycling
function storyboard.disableAutoPage()
	_composerRecycleOnLowMemory()
end

function storyboard.printMemUsage()
	collectgarbage("collect")
	local memUsage_str = string.format( "MEMORY= %.3f KB", collectgarbage( "count" ) )
	print( memUsage_str .. " | TEXTURE= "..(system.getInfo("textureMemoryUsed")/1048576) )
end

--------------------------------------------------
-- 新しく追加された関数
--------------------------------------------------
function storyboard.setVariable(...)
	_composerSetVariable(...)
end

function storyboard.getVariable(...)
	return _composerGetVariable(...)
end

--------------------------------------------------
-- 変更のないプロパティまたは関数
--------------------------------------------------

-- _composerRecycleOnSceneChange = storyboard.purgeOnSceneChange
-- _composerIsDebug              = storyboard.isDebug
-- _composerStage                = storyboard.stage

function storyboard.gotoScene(...)
	_composerGotoScene(...)
end

function storyboard.getScene(...)
	return _composerGetScene(...)
end

function storyboard.loadScene(...)
	return _composerLoadScene(...)
end

function storyboard.hideOverlay(...)
	return _composerHideOverlay(...)
end

function storyboard.showOverlay(...)
	return _composerShowOverlay(...)
end

function storyboard.removeScene(...)
	return _composerRemoveScene(...)
end

function storyboard.getScene(...)
	return _composerGetScene(...)
end


return storyboard