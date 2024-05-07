--internationalization and localization implementation by amigojapan
--dictionary for english, kept in seperate file you can include it by require("localizations.lua")
i18n={}
--i18n["key"]={
--	["hw"]="",
--	["gw"]=""
--	}
i18n["English"]={
	["hw"]="Hello World",
	["gw"]="Goodbye World"
	}
i18n["Spanish"]={
	["hw"]="Saludos Mundo",
	["gw"]="Adios Mundo"
	}
i18n["Japanese"]={
	["hw"]="世界よこんにちは",
	["gw"]="世界よさよなら"
	}
function i18n_setlang(lang)
	return i18n[lang]
end

translate=i18n_setlang("English")
print(translate["hw"])
print(translate["gw"])
translate=i18n_setlang("Spanish")
print(translate["hw"])
print(translate["gw"])
translate=i18n_setlang("Japanese")
print(translate["hw"])
print(translate["gw"])
