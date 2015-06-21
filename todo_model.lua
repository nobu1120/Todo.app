-----------------------------------------
-- 
-- file : todo_model.lua
--
-- creater : Nobuyoshi Tanaka
--
-- comment : todo作成のmodel(todo投稿と取得)
--
-----------------------------------------

module(...,package.seeall)


local function listener()

	local self = {}
	self.comment = nil

	-- todoを投稿する
	function self.postTodo(text)

		local function postTodoListener( event )

		if ( event.isError ) then
		    print( "Network error!" )
		else
		    print ( "RESPONSE: " .. event.response )
		end
		end

		local headers = {}

		headers["Content-Type"] = "application/x-www-form-urlencoded"
		headers["Accept-Language"] = "en-US"

		local body = "todoComment="..text

		local params = {}
		params.headers = headers
		params.body = body

		network.request("http://localhost:8888/app_php/postTodo.php","POST",postTodoListener,params)
	end

	function self.getTodo()

		local function getTodoListener( event )

		if ( event.isError ) then
		    print( "Network error!" )
		else
		    print ( "RESPONSE: " .. event.response )
		    self.comment = event.response
		end
		end

		network.request("http://localhost:8888/app_php/getTodo.php","GET",getTodoListener)

	end

	return self

end


function new()
	return listener()
end