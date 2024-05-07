#!/usr/bin/lua
-- Copyright 2014 Usmar A. Padow (amigojapan) usmpadow@gmail.com
-- BlindOE (the operation environment, should offer something like the bash shell for blind people)
--Load settings
require "settings"
--helper functions
require "BlindOSlib"
--internationalization dictionary
require "i18n_dict"
--lua file system libeary
lfs = require("lfs")

if defaultInputType=="voice" then
	translate=i18n_setlang("English_voice_input")
else
	translate=i18n_setlang("English_keyboard_input")
end

function help(menutable)
	speakAndPrint("say commands as follows:")
	for index, value in ipairs(menutable) do
		speakAndPrint(value)
	end
end
function sayDateAndTIme()
	speakAndPrint(os.date("Today is %B %A the %dth, the time is %I oclock with %M minutes %p"))
end

function run_program(parameters)
	--speakAndPrint("say program name:")
	--local voice_programName = InputVoiceOrKeyboard()
	if(parameters=="") then
		speakAndPrint("say my dear computer please run program and then mention the programname")
		return
	end
	print("parameters recieved:"..parameters)
	print("running closest match.")
	print("programs directory:" ..luaProgramsDirectory)
    local fileList = listFilesInDirectory(luaProgramsDirectory)
    programKey=which_menu_item_is_most_simillar(parameters,fileList)
    print("executing:"..luaProgramsDirectory .. "/" ..fileList[programKey])
	os.execute(luaProgramsDirectory .. "/" ..fileList[programKey])
end

local function dumpTable(table)
    for key, value in pairs(table) do
        print(key, value)
    end
end

local function joinTable(table, endIndex)
    local result = ""
    for i = 1, endIndex do
        result = result .. table[i]
        if i < endIndex then
            result = result .. " " -- Add a space between elements except for the last one
        end
    end
    return result
end

function findAfterIndex(str,index)
	-- Split the string into words
	local words = {}
	for word in str:gmatch("%S+") do
		table.insert(words, word)
	end

	result=""
	for i, word in ipairs(words) do
		if index < i then
			result=result..words[i].. " "
		end
	end
	return result
end

--commands
--so list programs, make folder, delete file, delete folder, list files, edit file, coommand help, quit to linux, I think those are all the menu options I need?
--5:35 PM <amigojapan> change directory
menutable={
	"my dear computer please tell me the system commands",
	"my dear computer please run program",
	"my dear computer please quit",
	"my dear computer please tell me the date and time"
}
if(not advacedMode) then
	speakAndPrint("Welcome to Vox Assist Operating Environment",false)
	speakAndPrint(translate["Type 'help for system commands' and press enter for help on how to use the commands"],false)
	--speakAndPrint("日本語モードに変えるには「日本語」ってにゆうりょくしてください。",false)
end

quit=false
while quit==false do
	::start::
	speakAndPrint(translate["Enter command:"],false)
	local command_input = InputVoiceOrKeyboard()
	if command_input==nil or command_input=="" then
		print("error command nil")
        goto start--used this cause there is not continue in lua
	end
	menu_items_split={} 
	for index, value in ipairs(menutable) do
		--print(index, value)
		local substrings_of_command = {}

		-- Iterate through the substrings_of_command using string.gmatch
		for value_inner in value:gmatch("%S+") do
			-- Add each substring to the table
			table.insert(substrings_of_command, value_inner)
		end
		table.insert(menu_items_split,substrings_of_command)
	end
	substrings_of_command = {}
	
	-- Iterate through the substrings_of_command using string.gmatch
	for value in command_input:gmatch("%S+") do
		-- Add each substring to the table
		table.insert(substrings_of_command, value)
	end
	--trimmed_command = joinTable(substrings_of_command, #substrings_of_command)
	--print(" trimmed_command:" .. trimmed_command)

	found=false
	possible_commands = {}
	parameters=""
	--get the same string form the substrings_of_command as from the menu items
	for index, menu_item_split in ipairs(menu_items_split) do
		--print("#substrings_of_command".. #substrings_of_command .. "#menu_item_split" .. #menu_item_split)
		if (#substrings_of_command >= #menu_item_split) then
			parameters =findAfterIndex(command_input,#menu_item_split)
			print("parameters"..parameters)
			joined_menu_item = joinTable(menu_item_split, #menu_item_split)
			trimmed_command = joinTable(substrings_of_command, #menu_item_split)
			found=true
			percentage=percentageEqual(trimmed_command,joined_menu_item)
			print("actually recognized text:" .. command_input)
			--print("trimmed_command:" .. trimmed_command .." joined_menu_items:" .. joined_menu_items)
			print("comparing "..joined_menu_item.." to " ..trimmed_command .. ", equality ".. math.floor(percentage).." percent equal...")
			table.insert(possible_commands, percentage)
		else
			table.insert(possible_commands, 0)
		end
	end
	if not found then
		speakAndPrint("command not found or too short.",false)
		goto start
	end
	maxval=getMaxValue(possible_commands)
	key=findValueInTable(possible_commands,maxval)
	dumpTable(menutable)
	dumpTable(possible_commands)
	print("key:" ..  key)
	if key == 1 then
		help(menutable)
	elseif key == 2 then
		run_program(parameters)
	elseif key == 3 then
		os.exit()
	elseif key == 4 then
		sayDateAndTIme()
	end
	--•amigojapan> yeah I think this needs ot be thought of more deeply
	--7:10 PM <•amigojapan> big-MAC: maybe run the diff first, on the menu items, and then on the list of programs in programs directory woudl be perfect
end
--fix problem with putting quotes inside llama or translate command, maybe need to escape quotes in some special way?