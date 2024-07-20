#!/usr/bin/lua
require "settings"
require "BlindOSlib"

math.randomseed(os.time())
-- Generate a random number between 1 and 99
local randomNumber = math.random(1, 99)

--[[
numbers_table={
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
	"ten",
	"eleven",
	"twelve",
	"thirteen",
	"fourteen",
	"fifteen",
	"sixteen",
	"seventeen",
	"eighteen",
	"nineteen",
	"twenty",
	"twenty one",
	"twenty two",
	"twenty three",
	"twenty four",
	"twenty five",
	"twenty six",
	"twenty seven",
	"twenty eight",
	"twenty nine",
	"thirty",
	"thirty one",
	"thirty two",
	"thirty three",
	"thirty four",
	"thirty five",
	"thirty six",
	"thirty seven",
	"thirty eight",
	"thirty nine",
	"fourty",
	"fourty one",
	"fourty two",
	"fourty three",
	"fourty four",
	"fourty five",
	"fourty six",
	"fourty seven",
	"fourty eight",
	"fourty nine",
	"fifty",
	"fifty one",
	"fifty two",
	"fifty three",
	"fifty four",
	"fifty five",
	"fifty six",
	"fifty seven",
	"fifty eight",
	"fifty nine",
	"sixty",
	"sixty one",
	"sixty two",
	"sixty three",
	"sixty four",
	"sixty five",
	"sixty six",
	"sixty seven",
	"sixty eight",
	"sixty nine",
	"seventy",
	"seventy one",
	"seventy two",
	"seventy three",
	"seventy four",
	"seventy five",
	"seventy six",
	"seventy seven",
	"seventy eight",
	"seventy nine",
	"eighty",
	"eighty one",
	"eighty two",
	"eighty three",
	"eighty four",
	"eighty five",
	"eighty six",
	"eighty seven",
	"eighty eight",
	"eighty nine",
	"ninety",
	"ninety one",
	"ninety two",
	"ninety three",
	"ninety four",
	"ninety five",
	"ninety six",
	"ninety seven",
	"ninety eight",
	"ninety nine"
}
]]
speakAndPrint("welcome to the guess my number game")
speakAndPrint("The computer has chosen a number from 1 to 99, please guess the number.")
::start::
	speakAndPrint("input your guess:")
	local input = io.voiceInput()
	if input == nil or input == "" then
		speakAndPrint("input error listening to value")
		goto start
	end
	if input == "keyboard input" or input == "voice input" then
		speakAndPrint("Switching input method")
		goto start
	end
	--key, maxval=which_menu_item_is_most_simillar(input,numbers_table)
	--maxval=getMaxValue(b)
	--key=findValueInTable(b,maxval)
	--input=numbers_table[key]
	print("recognized as:"..input)
	input=convertWords2Numbers(input)
	local number=tonumber(input)
	print("number:"..tostring(number))
	if number == nil then
		speakAndPrint("input error must be number")
		goto start
	end
	speakAndPrint("you guessed:" .. input)
	if number==randomNumber then    
		speakAndPrint("you win! quitting program")
		os.exit()
	end
	if number>randomNumber then
		speakAndPrint("too hight!")
	end    
	if number<randomNumber then
		speakAndPrint("too low!")
	end
	goto start
