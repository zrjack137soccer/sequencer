-- File: rooms.lua

local nodes = {}

nodes.start = function(state)
  print("\n--- STARTING ROOMS ---")
  return "center_room", true
end

nodes.center_room = function(state)
  print("\n--- CENTER ROOM ---")
  print("You are in a well-lit hall. There are doors to the North (Up) and South (Down).")
  
  -- io.write prints without adding a new line, so the cursor stays next to the text
  io.write("Which way? (up/down/left/right/quit): ")
  
  -- Read the player's input and convert it to lowercase so "UP" and "up" both work
  local input = string.lower(io.read())
  
  if input == "up" then
    return "north_room", true
  elseif input == "down" then
    return "south_room", true
  elseif input == "left" then
    return "east_room", true
  elseif input == "right" then
    return "west_room", true
  elseif input == "quit" then
    print("Thanks for playing!")
    return nil, true -- Returning nil stops the state machine
  else
    print("There is a solid wall there. You can't go that way.")
    return "center_room", false -- Loop back to the same room!
  end
end

nodes.north_room = function(state)
  print("\n--- NORTH ROOM ---")
  print("It's freezing in here. The only exit is back South (Down).")
  io.write("Which way? ")
  local input = string.lower(io.read())
  
  if input == "down" then
    return "center_room", true
  elseif input == "quit" then
    return nil, true
  else
    print("You bump into a wall.")
    return "north_room", false
  end
end

nodes.south_room = function(state)
  print("\n--- SOUTH ROOM ---")
  print("A warm fireplace crackles here. The exit is North (Up).")
  io.write("Which way? ")
  local input = string.lower(io.read())
  
  if input == "up" then
    return "center_room", true
  elseif input == "quit" then
    return nil, true
  else
    print("You bump into a wall.")
    return "south_room", false
  end
end

nodes.east_room = function(state)
  print("\n--- EAST ROOM ---")
  print("A candle lights the room full of books and maps. The exit is West (Right).")
  io.write("Which way? ")
  local input = string.lower(io.read())
  
  if input == "right" then
    return "center_room", true
  elseif input == "quit" then
    return nil, true
  else
    print("You bump into a wall.")
    return "east_room", false
  end
end

nodes.west_room = function(state)
  print("\n--- WEST ROOM ---")
  print("A bed sits in the middle of the room. Looks cozy. The exit is East (Left).")
  io.write("Which way? ")
  local input = string.lower(io.read())

  if input == "left" then
    return "center_room", true
  elseif input == "quit" then
    return nil, true
  elseif input == "right" then
    print("You find a secret passage")
    return "secret_room", true
  else
    print("You bump into a wall.")
    return "west_room", false
  end
end

nodes.secret_room = function(state)
  print("\n--- SECRET ROOM ---")
  print("A vial sits in the middle of a room full or lab equipment. The exit is East (Left).")
  io.write("Which way? OR Do you take the vial (Yes) ")
  local input = string.lower(io.read())

  if input == "yes" then
    error("You found a virus")
  elseif input == "quit" then
    return nil, true
  elseif input == "left" then
    return "west_room", true
  else
    print("You bump into a wall.")
    return "secret_room", false
  end
end


return nodes
