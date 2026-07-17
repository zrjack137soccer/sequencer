local function error_handler(err_message)
  return debug.traceback("Error: " .. tostring(err_message), 2)
end

-- State machine means functions will instead give a go to and the sequence passed into the function is now a
-- table instead of a table dressed as an array
local run_machine = function (nodes, start_step, start_state)
  local state = start_state or {}
  local current_step = start_step

  while current_step do
    local step_function = nodes[current_step]

    if not step_function then
      print("-> Finished: No step found for '" .. tostring(current_step) .. "'")
      break
    end

    local success, next_step = xpcall(step_function, error_handler, state)

    if not success then
      print("FATAL CRASH at step '" .. tostring(current_step) .. "':\n" .. next_step)
      break
    end
    
    current_step = next_step
  end

  return state
end

return run_machine
