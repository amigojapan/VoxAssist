#!/usr/bin/lua
-- Copyright 2014 Usmar A. Padow (amigojapan) usmpadow@gmail.com
--Line editor is a text editor for blind people
--Load settings
require "settings"
--helper functions
require "BlindOSlib"
--punctuation lib
require "punctuation"

function removeRows(array, startRow, endRow)
    -- Validate input indices
    if startRow < 1 or startRow > #array or endRow < 1 or endRow > #array or startRow > endRow then
        print("Invalid indices")
        return
    end

    -- Remove the specified range of rows
    for _ = 1, endRow - startRow + 1 do
        table.remove(array, startRow)
    end

    -- Print the modified array for demonstration
    print("Modified Array:")
    for i, row in ipairs(array) do
        print(i, row)
    end

end

function moveAndInsertRows(array, startRow, endRow, insertRow)
    -- Validate input indices
    if startRow < 1 or startRow > #array or endRow < 1 or endRow > #array or insertRow < 1 or insertRow > #array + 1 then
        print("Invalid indices")
        return
    end

    -- Extract the range of rows to be moved
    local rowsToMove = {}
	local rowsMoved = 0
    for i = startRow, endRow do
        table.insert(rowsToMove, array[i])
		rowsMoved = rowsMoved + 1
	end

	-- Insert the removed rows at the specified position
    for i, row in ipairs(rowsToMove) do
        table.insert(array, insertRow + i - 1, row)
    end

    -- Print the modified array for demonstration
    print("Modified Array:")
    for i, row in ipairs(array) do
        print(i, row)
    end
	return rowsMoved
end

-- Example usage
--local myArray = {"a", "b", "c", "d", "e"}
--moveAndInsertRows(myArray, 2, 3, 5)

function ennumerate_lines(from,to)
	local output=""
	--print("from:"..from)
	--print("to:"..to)
	for counter, line in ipairs(buffer) do
		--print("counter:"..counter)
		--print("line:"..line)
		if(tonumber(counter)>=tonumber(from) and tonumber(counter)<=tonumber(to)) then
			output = output  .. "Line " .. counter .. " " .. line .. ".\n"
		end
	end
	return output
end
buffer={}
if(not file_exists(arg[1])) then
	speakAndPrint("File does not exist " .. arg[1].. " creating it as new file.")
else
	for line in io.lines(arg[1]) do
		--table.insert(buffer,table.getn(buffer)+1)
		table.insert(buffer,#buffer+1)
		--buffer[table.getn(buffer)]=line--fills the last element with the line from the file
		buffer[#buffer]=line--fills the last element with the line from the file
	end
	speakAndPrint("File " .. arg[1] .. " contains " .. #buffer .. " lines.")
end

--external call
if arg[2]=="list" then
	local listing=ennumerate_lines(1,#buffer)
	speakAndPrint(listing)
	os.exit()
end

if(not advacedMode) then
	speakAndPrint("Welcome to line editor")
	speakAndPrint("Type help and press enter for help on how to use the commands")
end
--loop
quit=false
while quit==false do
	speakAndPrint("Enter edit command:")
	local command_input = io.read()
--	if(not advacedMode) then
--		speakAndPrint("Command entered: " .. command_input .."")
--		speakAndPrint("Execute? Y for Yes N for No:")
--	else
		command_line_arr = split_by_space(command_input)
		if(command_line_arr[1]=="list") then --lines is not really nessesary to type
			local listing=""
			if(command_line_arr[3]=="from") then
				listing=ennumerate_lines(command_line_arr[4],command_line_arr[6])
			else
				listing=ennumerate_lines(1,#buffer)
			end
			speakAndPrint(listing)
		elseif(command_line_arr[1]=="line" and command_line_arr[2]=="count") then
			speakAndPrint("File contains " .. #buffer .. " lines.")
		elseif(command_line_arr[1]=="delete" and command_line_arr[2]=="line") then
			local index = tonumber(command_line_arr[3])
			if(index>#buffer) then
				speakAndPrint("The file has only" .. #buffer .. " lines " .. " you cannot insert at index " .. index)
			else
				table.remove(buffer, index)
			end
		--make a simillar command to move lines, but just copy lines number to number to index	
		elseif(command_line_arr[1]=="move" and command_line_arr[2]=="lines") then
			local from = tonumber(command_line_arr[3])
			local to = tonumber(command_line_arr[5])
			local index = tonumber(command_line_arr[7])
			--add checks to see if the line you are moving to is more or less than the range prescrived
			if(index>#buffer or from>#buffer or to>#buffer) then
				speakAndPrint("The file has only" .. #buffer .. " lines " .. " check parameters")
				speakAndPrint("syntax, move lines number to number to index")
			else
				
				if(index<from) then
					rowsMoved=moveAndInsertRows(buffer, from, to, index)
					removeRows(buffer, rowsMoved+from, rowsMoved+to)
				else
					rowsMoved=moveAndInsertRows(buffer, from, to, index+1)
					removeRows(buffer, from, to)
				end
			end
		elseif(command_line_arr[1]=="append" and command_line_arr[2]=="line") then
			table.insert(buffer,#buffer+1)
			speakAndPrint("Type contents: ")			
			local new_line = io.read()
			speakAndPrint(new_line)	
			buffer[#buffer]=new_line
		elseif(command_line_arr[1]=="insert" and command_line_arr[2]=="line") then
			--(fixed)this is buggy, it seems to modify the following line after the insert to a number?
			local index = tonumber(command_line_arr[3])
			if(index>#buffer) then
				speakAndPrint("The file has only" .. #buffer .. " lines " .. " you cannot insert at index " .. index)
			else
				speakAndPrint("Type contents: ")			
				local new_line = io.read()
				new_line = new_line:gsub("\n", "")  -- Remove newline character
				table.insert(buffer, command_line_arr[3], new_line)
				speakAndPrint(new_line)	
				buffer[index] = new_line
			end 
		elseif(command_line_arr[1]=="edit" and command_line_arr[2]=="line") then
			local index = tonumber(command_line_arr[3])
			if(index>#buffer) then
				speakAndPrint("The file has only" .. #buffer .. " lines " .. " you cannot edit at index " .. index)
			else
				speakAndPrint("Line used to contain: " .. buffer[index])
				speakAndPrint("Type new contents: ")			
				local new_line = io.read()
				buffer[index] = new_line
			end
		elseif(command_line_arr[1]=="say" and command_line_arr[2]=="line") then
			--print(buffer[index])--this is nil eventhough index is 1, what is up?
			--bug solved , needed to ocnvert to a number print(buffer[1])--this prints, not nil
			local index = tonumber(command_line_arr[3])
			if(index>#buffer) then
				speakAndPrint("The file has only" .. #buffer .. " lines " .. " you asked for index " .. index)
			else
				tmp = buffer[index]
				if(command_line_arr[4]=="with" and command_line_arr[5]=="punctuation") then
					--print("here0")
					if(command_line_arr[6]=="and" and command_line_arr[7]=="spaces") then
						tmp = convert_punctuation_to_words(buffer[index],true,true)
						print("space")
						--print(tmp)
					else
						tmp = convert_punctuation_to_words(buffer[index],true)
						print("punct")
						--print(tmp)
					end
				end
				--print(tmp)
				speakAndPrint(tmp)				
			end
		elseif(command_line_arr[1]=="save") then
			if(not advacedMode) then
				speakAndPrint("Save File? Y for yes N for no")
			else
				speakAndPrint("Save File?")
				print("Y/N")
			end
			local answer = string.lower(io.read())
			if(answer=="y") then
				file = io.open(arg[1],"w+")
				local data=""
				for counter, line in ipairs(buffer) do
					data = data  .. line .. "\n"
				end
				--print(data)
				file:write(data)
				file:close()
				speakAndPrint("File " ..arg[1].." saved.")		
			end													
		elseif(command_line_arr[1]=="help") then
			speakAndPrint("line count")
			speakAndPrint("list lines")
			speakAndPrint("list lines from X to Y")
			speakAndPrint("delete line X")
			speakAndPrint("append line, appends a new line at the end of the file")
			speakAndPrint("insert line X")
			speakAndPrint("edit line X")
			speakAndPrint("move lines number to number to index")
			speakAndPrint("say line X")--get rid of this,   why not alway ssay punctuatin?
			speakAndPrint("say line X with punctuation")
			speakAndPrint("say line X with punctuation and spaces")
			speakAndPrint("save")			
			speakAndPrint("quit")
		elseif(command_input=="quit") then
			if(not advacedMode) then
				speakAndPrint("Quit editor? Y for yes N for no")
			else
				speakAndPrint("Quit editor?")
				print("Y/N")
			end
			local answer = string.lower(io.read())
			if(answer=="y") then
				speakAndPrint("Leaving editor")
				break
--			end
		end
	end
end
--add an option to list a range of lines