-- Trap door simulation used by state machine

local nodes = {}

nodes.start = function(state)
  print("[START] Waking up in a dark room.")
  state.health = 100
  
  -- Jump directly to the 'explore' step
  return "explore" 
end

nodes.explore = function(state)
  print("[EXPLORE] Searching the room...")
  local roll = math.random()
  
  if roll > 0.5 then
    return "trap"
  else
    return "exit"
  end
end

nodes.trap = function(state)
  print("[TRAP] You triggered a dart trap!")
  state.health = state.health - 50
  
  if state.health <= 0 then
    print("[DEATH] Game Over!")
    return nil 
  end
  
  -- Loop BACK to explore
  return "explore" 
end

nodes.exit = function(state)
  print("[EXIT] You found the door and escaped!")
  -- Returning nil stops the sequencer
  return nil 
end

return nodes
