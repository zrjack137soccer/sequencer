local function sleep(seconds)
  local start_time = os.clock()

  while os.clock() - start_time < seconds do
  end
end

return sleep
