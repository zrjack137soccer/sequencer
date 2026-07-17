-- File: main.lua
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

-- 3. Dynamically load the requested file using pcall
local success, loaded_data = pcall(require, filename)

if not success then
  print("ERROR: Could not load file '" .. filename .. ".lua'")
  print(loaded_data) -- Prints the exact error from Lua
  os.exit()
end

-- 4. Route to the correct sequencer
if mode == "linear" and string.find(filename, "sequence", 1, true) then
  local run_linear = require("sequencer")
  
  print("--- Starting Linear Sequence: " .. filename .. " ---")
  run_linear(loaded_data)
  
elseif mode == "state" then
  local run_state_machine = require("state_machine")
  
  print("--- Starting State Machine: " .. filename .. " ---")
  -- The state machine requires a starting key (assuming "start" here) and an empty state
  run_state_machine(loaded_data, "start", {})
  
else
  -- The user typed something other than 'linear' or 'state'
  print("ERROR: Unknown mode '" .. mode .. "'. Please use 'linear' or 'state'.")
end

print("--- Program Finished ---")
