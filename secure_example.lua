-- File: security_example.lua temp file to demonstrate using a generic security proxy

local proxy = require("engine/proxy")

-- ==========================================
-- Room 1: The Server Room (Requires a keycard)
-- ==========================================
local ServerRoomCore = {
    reboot_server = function() print("Server rebooting...") end
}

local has_keycard = false -- External state

local server_room = proxy.new(
    ServerRoomCore,
    { 
        look = function() print("A locked server rack.") end,
        swipe_card = function() 
            has_keycard = true 
            print("Card accepted.")
        end 
    },
    function() return has_keycard end -- The unlock rule
)

-- ==========================================
-- Room 2: The Command Bridge (Requires a password)
-- ==========================================
local BridgeCore = {
    fire_lasers = function() print("Pew! Pew!") end
}

local bridge_password_entered = false -- External state

local bridge = proxy.new(
    BridgeCore,
    {
        look = function() print("A dusty control console.") end,
        enter_code = function(code) 
            if code == "hunter2" then 
                bridge_password_entered = true 
                print("Console unlocked.")
            end
        end
    },
    function() return bridge_password_entered end -- The unlock rule
)

-- === Execution ===
server_room.look()
server_room.reboot_server() -- Fails: System: Access Denied
server_room.swipe_card()
server_room.reboot_server() -- Succeeds: Server rebooting...
