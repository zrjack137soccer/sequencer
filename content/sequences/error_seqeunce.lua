local sequence_c = {
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

return sequence_c
