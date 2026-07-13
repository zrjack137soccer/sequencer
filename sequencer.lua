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

local sequencer = function (sequence)
  local state = {}
  for _, f in ipairs(sequence) do
    local should_continue = f(state)
    
    if should_continue == false then
      break
    end
  end
end

print("Sequence A -- simple sequence\n")
sequencer(sequence_a)

print("\nSequence B -- sequence triggering early exit\n")
sequencer(sequence_b)
