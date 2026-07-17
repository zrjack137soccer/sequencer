-- File: main.lua

local find_file = function (dir, filename)
  
  local path = dir .. filename
  local success, loaded_data = pcall(require, path)

  if not success then
    print("ERROR: Could not load file '" .. path .. ".lua'")
    print(loaded_data) -- Prints the exact error from Lua
    os.exit()
  end
  return loaded_data
end

math.randomseed(os.time())

-- 1. Capture the terminal arguments
-- arg[1] will be the mode (e.g., "linear" or "state")
-- arg[2] will be the file name (e.g., "simple_sequence" or "my_nodes")
local mode = arg[1]
local filename = arg[2]

-- 2. Validate that the user actually provided the arguments
if not mode or not filename then
  print("Usage: lua main.lua <mode> <filename>")
  print("Modes: 'linear' or 'state'")
  print("Example: lua main.lua state my_nodes")
  os.exit() -- Stop the script immediately
end

-- 3. Route to the correct sequencer
if mode == "linear" then
  
  -- 3.a Find and load sequence file
  local loaded_data = find_file("content/sequences", filename)
  
  local run_linear = require("engine/sequencer")
  
  print("--- Starting Linear Sequence: " .. filename .. " ---")
  run_linear(loaded_data)
  
elseif mode == "state" then
  
  -- 3.b Find and load machine
  local loaded_data = find_file("content/", filename)

  local run_state_machine = require("engine/state_machine")
  
  print("--- Starting State Machine: " .. filename .. " ---")
  -- The state machine requires a starting key (assuming "start" here) and an empty state
  run_state_machine(loaded_data, "start", {})
  
else
  -- The user typed something other than 'linear' or 'state'
  print("ERROR: Unknown mode '" .. mode .. "'. Please use 'linear' or 'state'.")
end

print("--- Program Finished ---")
