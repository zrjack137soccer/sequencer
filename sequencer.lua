local sequence_a = {
  function(state)
    print("Running Step 1...")
    state.playerName = "PlayerOne"
    state.score = 10
  end,
  
  function(state)
    print("Running Step 2...")
    print("Welcome, " .. state.playerName .. "!")
    state.score = state.score + 5
  end,
  
  function(state)
    print("Running Step 3...")
    print("Final score is: " .. state.score)
  end
}

sequence_b = {
function(state)
    state.health = 100
    print("Step 1: Health is 100. Continuing.")
    return true
  end,
  
  function(state)
    state.health = 0
    print("Step 2: Health reached 0!")
    
    if state.health <= 0 then
      print("-> Halting sequence.")
      return false -- This tells the sequencer to stop
    end
    
    return true
  end,
  
  function(state)
    -- This step is never reached
    print("Step 3: You survived!") 
  end
}

sequence_c = {
  function(state)
    print("Step 1: Running fine...")
  end,
  
  function(state)
    print("Step 2: About to cause a crash...")
    -- Trigger an intentional error
    error("Something went terribly wrong!") 
  end,
  
  function(state)
    print("Step 3: This won't run.")
  end
}

local sequencer = function (sequence)
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

print("Sequence A -- simple sequence\n")
sequencer(sequence_a)

print("\nSequence B -- sequence triggering early exit\n")
sequencer(sequence_b)

print("\nSequence C -- sequence triggering an error\n")
sequencer(sequence_c)
