local function error_handler(err_message)
  return debug.traceback("Error: " .. tostring(err_message), 2)
end

return error_handler
