local sequence_b = {
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

return sequence_b
