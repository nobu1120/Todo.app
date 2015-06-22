-----------------------------------------
-- 
-- file : todo_view.lua
--
-- creater : Nobuyoshi Tanaka
--
-- comment : todo作成のview
--
-----------------------------------------

module(...,package.seeall)

-- Library
local widget = require("widget")

-- Model
local todo_model = require("todo_model")
local model = todo_model.new()

local function listener()

    local self = {}

    function self.createTask(image)

        assert(image,"image does not exist!")

        -- 全体セル
        local taskGroup = display.newGroup()
        local taskCell = display.newRect(taskGroup,_W/2 - 20,380,_W - 140,250)
        taskCell.isVisible = false

        -- 単体セル
        local cellGroup = display.newGroup()

        -- 入力された文字
        local getText = "todoを入力しよう"
        -- 入力された文字を移す
        local todoText = nil

        -- todoを入力するセル作成
        local todoCellGroup = display.newGroup()
        local todoCell = display.newImage(todoCellGroup,image,300,400,true)
        todoCell.width = 500 ; todoCell.height = 200
        todoCell.alpha = 1
        todoText = display.newText(todoCellGroup,getText,0,0,system.nativeFont,30)
        todoText:setFillColor(0)
        todoText.x , todoText.y = todoCell.x , todoCell.y

        -- -- 文字挿入
        -- local function inputListener( event )

        --     if event.phase == "began" then
        --         -- user begins editing textBox
        --         print( event.text )
        --         native.setKeyboardFocus( nil )

        --     elseif event.phase == "ended" then
        --         -- do something with textBox text
        --         print( event.target.text )
        --         getText = nil
        --         getText = event.target.text
        --         native.setKeyboardFocus( event.target )

        --     elseif event.phase == "editing" then
        --         print( event.newCharacters )
        --         print( event.oldText )
        --         print( event.startPosition )
        --         print( event.text )
        --         native.setKeyboardFocus( nil )
        --     end

        -- end

        -- -- 入力を可能にする
        -- local textBox = native.newTextField( _W/2, 0, _W, 200 )
        -- textBox.y = 700
        -- textBox.text = ""
        -- textBox.isVisible = false
        -- textBox.isEditable = false
        -- textBox:addEventListener( "userInput", inputListener )

        local function textListener( event )

            if ( event.phase == "began" ) then
                -- user begins editing defaultField
                print( event.text )

            elseif ( event.phase == "ended" or event.phase == "submitted" ) then
                -- do something with defaultField text
                print( event.target.text )
                getText = nil
                getText = event.target.text

            elseif ( event.phase == "editing" ) then
                print( event.newCharacters )
                print( event.oldText )
                print( event.startPosition )
                print( event.text )
            end
        end
        -- 入力を可能にする
        local textField = native.newTextField( _W/2, _H-300, _W, 100 )
        textField.y = 700
        textField.text = ""
        textField.isVisible = false
        textField.isEditable = false
        textField:addEventListener( "userInput", textListener )

        -- todo関連ボタン作成
        -- type : edit , save
        local function createBtn( image , Type , text )

            local function ediitListener( event )

                textField.isEditable = true
                textField.isVisible = true

                print("-------- To do edit -------------")
            end

            local function saveListener( event )

                if event.phase == "ended" then

                    -- テキストボックスを透明にする
                    textField.isEditable = false
                    textField.isVisible = false
                    textField.isHitTestable = false

                    -- 保存されたテキスト表示
                    display.remove(todoText)
                    todoText = nil
                    todoText = display.newText(cellGroup , getText , 0 , 0 , system.nativeFont , 30)
                    todoText.x , todoText.y = todoCell.x , todoCell.y
                    todoText:setFillColor(0)

                    -- todoをデータベースへ投稿
                    model.postTodo(getText)

                    print("-------- To do save --------------")

                end
            end
            

            -- -- 編集
            if Type == "edit" then
                -- btn:addEventListener("tap",ediitListener)
                handler = ediitListener
            -- 保存
            elseif Type == "save" then
                -- btn:addEventListener("tap",saveListener)
                handler = saveListener
            end

            local btn = widget.newButton
            {
                width = 130 , 
                height = 50 ,
                defaultFile = image ,
                label = text ,
                fontSize = 40,
                onEvent = handler
            }

            return btn
        end

        -- タスクをドラッグ可能にする
        function taskGroup:touch( event )
            if event.phase == "began" then
                
                -- 編集不可
                textField.isEditable = false

                self.markX = self.x    -- store x location of object
                self.markY = self.y    -- store y location of object
            
            elseif event.phase == "moved" then
            
                local x = (event.x - event.xStart) + self.markX
                local y = (event.y - event.yStart) + self.markY
                
                self.x, self.y = x, y    -- move object based on calculations above
            end
            
            return true
        end

        taskGroup:addEventListener("touch",taskGroup)

        -- 編集ボタン
        local editBtn = createBtn("btn/btn048_01.png" , "edit" , "編集" )
        editBtn.x , editBtn.y = taskCell.x-187 , taskCell.y-105

        -- 保存ボタン
        local saveBtn = createBtn("btn/btn048_02.png" , "save" , "保存" )
        saveBtn.x ,saveBtn.y = taskCell.x-60 , taskCell.y-105

        todoCellGroup:insert(textField)
        cellGroup:insert(editBtn)
        cellGroup:insert(saveBtn)
        cellGroup:insert(todoCellGroup)
        taskGroup:insert(cellGroup)

        return taskGroup
    end

    return self

end

function new()
    return listener()
end



