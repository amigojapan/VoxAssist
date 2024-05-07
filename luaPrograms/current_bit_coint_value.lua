#!/usr/bin/lua
require "settings"
require "BlindOSlib"

local http = require("socket.http")

function getBitcoinValue()
    local url = "https://api.coindesk.com/v1/bpi/currentprice/BTC.json"
    local response, errorMessage = http.request(url)

    if not response then
        speakAndPrint("Error fetching Bitcoin value:", errorMessage)
        return nil
    end

    -- Check if JSON data is found in the response
    local jsonStart = response:match('"rate_float":(.-)%}')
    if not jsonStart then
        speakAndPrint("Error: JSON data not found in the response")
        return nil
    end

    -- Parse JSON response
    --local jsonData = response:sub(jsonStart, jsonEnd)
    return jsonStart
end

-- Example usage
local bitcoinValue = getBitcoinValue()
if bitcoinValue then
    speakAndPrint("Current Bitcoin value:" .. bitcoinValue .. " united states dollars")
end
