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

local sequencer = function (sequence)
  local state = {}
  for _, f in ipairs(sequence) do
   f(state)
  end
end

sequencer(sequence_a)
