-- Function to convert words to an integer
function words_to_int(words)
    -- Define a dictionary to map words to numerical values
    local word_to_num = {
        zero = 0, one = 1, two = 2, three = 3, four = 4,
        five = 5, six = 6, seven = 7, eight = 8, nine = 9,
        ten = 10, eleven = 11, twelve = 12, thirteen = 13,
        fourteen = 14, fifteen = 15, sixteen = 16, seventeen = 17,
        eighteen = 18, nineteen = 19, twenty = 20, thirty = 30,
        forty = 40, fifty = 50, sixty = 60, seventy = 70,
        eighty = 80, ninety = 90
    }

    -- Split the input string into words
    words_split = {}
    for word in words:gmatch("%S+") do
        table.insert(words_split, word)
    end

    local result = 0
    local current_num = 0
    local is_compound = false
    local counter=0
    for i, word in ipairs(words_split) do
	counter=counter+1
	if word == "hundred" then
		goto continue2
	end
        if words_split[counter+1] == "hundred" then
        	current_num = word_to_num[word] * 100
		print("here0;" .. current_num)
		goto continue1
        elseif word == "thousand" then
            current_num = current_num * 1000
        elseif word == "million" then
            current_num = current_num * 1000000
        elseif word == "and" then
            -- Skip the word "and"
            goto continue2
        elseif word_to_num[word] then
            if is_compound then
                -- Add the compound number to the current result
                current_num = current_num + word_to_num[word]
                is_compound = false
            else
                current_num = word_to_num[word]
            end
        elseif word == "point" then
            -- Ignore any words after "point" as it's for floating point numbers
            break
        else
            -- Check for compound numbers (e.g., twenty-five)
            local compound_parts = {}
            for part in word:gmatch("%a+") do
                table.insert(compound_parts, part)
            end
            current_num = word_to_num[compound_parts[1]]
            for j = 2, #compound_parts do
                current_num = current_num + word_to_num[compound_parts[j]]
            end
            is_compound = true
        end
	::continue1::
	print("counter;"..counter)
        result = result + current_num
        ::continue2::
    end

    return result
end

-- Test the function
print(words_to_int("one hundred and two"))  -- Output: 250

--print(words_to_int("twenty three"))  -- Output: 250
-- take the string "two hundred and fifty point twenty three" and seperate it into "two hundred and fifty" and "twenty three"
--local input_string = "two hundred and fifty point one"

-- Split the input string at the "point" keyword
function words_to_float(words)
--[[
	local has_point = input_string:find("point")

	if has_point then
    		local integer_part, fractional_part = input_string:match("(.+) point (.+)")
    		if not integer_part or not fractional_part then
        		print("Invalid input format")
    		else
        		print("Integer part:", integer_part)
        		print("Fractional part:", fractional_part)
    		end
   		print(words_to_int(integer_part) .. "." .. words_to_int(fractional_part))
		else
    			print(words_to_int(input_string))
		end
	end
]]--
end
