local run_sequence = function (sequence)
  local state = {}
  for index, f in ipairs(sequence) do
    local success, result = pcall(f, state)
    
    if not success then
      print("Sequence stopped at step " .. index .. " due to error: " .. tostring(result))
      break -- stop gracefully
    end
    if result == false then
      break
    end
  end
end

return run_sequence

