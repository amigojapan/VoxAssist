#my favorite number is two hundred and fifty three point two how about yours?
#my favorite number is 253.2 how about yours?
#todo move or get rid of simbols after the last number word
#(done)handle numbers like "one two three" (still problems when I so even something like seven , three"
#(done)handle multiple numbers in the same sentence
import words2num as w2n
#import pdb

stringPhrase="my favorite number is two hundred and fifty three point two , my favorite single numbers are single numbers start one two three end single numbers how about yours?"
def delete_keyword(text, keyword):
    return text.replace(keyword, '')

def replace_words_with_numbers(text):
    word_to_number = {
        "zero": "0",
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    }
    
    # Split the text into words
    words = text.split()
    
    # Replace words with numbers if they are in the dictionary
    for i in range(len(words)):
        word = words[i].lower()  # Convert to lowercase to handle case sensitivity
        if word in word_to_number:
            words[i] = word_to_number[word]
    
    # Join the words back into a string
    return ' '.join(words)

def extract_between_keywords(text, start_keyword, end_keyword):
    try:
        start_index = text.index(start_keyword) + len(start_keyword)
        end_index = text.index(end_keyword, start_index)
        return text[start_index:end_index].strip()
    except ValueError as e:
        return str(e)

start_keyword = "single numbers start"
end_keyword = "end single numbers"

singleNumbersText=extract_between_keywords(stringPhrase, start_keyword, end_keyword)
numbers=replace_words_with_numbers(singleNumbersText)

def replace_between_keywords(text, start_keyword, end_keyword, replacement):
    try:
        start_index = text.index(start_keyword) + len(start_keyword)
        end_index = text.index(end_keyword, start_index)
        new_text = text[:start_index] + replacement + text[end_index:]
        return new_text
    except ValueError as e:
        return str(e)

stringPhrase = replace_between_keywords(stringPhrase, start_keyword, end_keyword, numbers)

def extract_string_between_indices(input_string, start_index, end_index):
    # Split the input string into words
    words = input_string.split()

    # Convert numerical indices to character indices
    start_char_index = sum(len(word) + 1 for word in words[:start_index])
    end_char_index = sum(len(word) + 1 for word in words[:end_index])

    # Extract the substring between the character indices
    result = input_string[start_char_index:end_char_index].strip()
    return result

def conv(stringPhrase):
	word_to_num = {
		"zero": 0, "one": 1, "two": 2, "three": 3, "four": 4,
		"five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
		"ten": 10, "eleven": 11, "twelve": 12, "thirteen": 13,
		"fourteen": 14, "fifteen": 15, "sixteen": 16, "seventeen": 17,
		"eighteen": 18, "nineteen": 19, "twenty": 20, "thirty": 30,
		"forty": 40, "fifty": 50, "sixty": 60, "seventy": 70,
		"eighty": 80, "ninety": 9, "hundred":100, "thousand":1000,
		"million": 1000000,
		"and": None, "point": None
	}


	words = stringPhrase.split()
	numberDetected=False
	wordIndex=0
	startIndex=None
	endIndex=None
	# Loop through each word
	#pdb.set_trace()  # Set a breakpoint here
	for word in words:
		wordIndex=wordIndex+1
		if word in word_to_num:
			if(numberDetected and not startIndex):
				startIndex=wordIndex
			else:
				numberDetected=True
			#print(f"{word} is in the dictionary.")
		else:
			if(numberDetected and not endIndex):
				endIndex=wordIndex
			#print(f"{word} is not in the dictionary.")

	if startIndex==None:
			return None,None, None, False, stringPhrase
	startIndex=startIndex-2
	endIndex=endIndex-1
	print(f"stringPhrase:{stringPhrase} startIndex:{startIndex} endIndex={endIndex}")
	numberString=extract_string_between_indices(stringPhrase,startIndex, endIndex)
	print(f"numberString:{numberString}")

	stringStart=extract_string_between_indices(stringPhrase,0,startIndex)
	stringEnd=extract_string_between_indices(stringPhrase,endIndex,wordIndex)

	res = stringStart + " " + str(w2n.w2n(numberString)) + " " + stringEnd

	return wordIndex,startIndex, endIndex, numberDetected, res

numberDetected=True
#stringPhrase="my favorite single number is two how about yours?"
originalPhrase=stringPhrase
while numberDetected:
	wordIndex, startIndex, endIndex, numberDetected,res=conv(stringPhrase)
	stringPhrase=res

stringPhrase=delete_keyword(stringPhrase, start_keyword)
stringPhrase=delete_keyword(stringPhrase, end_keyword)
res=stringPhrase

print(originalPhrase)
print("converted to:")
print(res)

