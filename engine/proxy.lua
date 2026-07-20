local errors = require('engine/errors')

--[[
Proxy is a wrapper around core logic. It will intercept any requests to that logic
and validate that the request can be made. Can be used for authentication.
]]

local SecurityProxy = {}

function SecurityProxy.new(target_object, public_tools, handshake)
  local proxy = {}
  -- Bind public tools directly to the proxy
  for tool_name, tool_func in pairs(public_tools) do
    proxy[tool_name] = tool_func
  end

  setmetatable(proxy, {
    __index = function(_, key)
      -- If the tool exists in the target object...
      if target_object[key] then
        return function(...)
          if not handshake() then
            -- Potentially look at sending error, but not sure about shutting down whole system
            print("System: Access Denied to '" .. key .. "'.")
            return false
          end

          -- Forward the call if authorized
          return target_object[key](...)
        end
      end
      return nil
    end
  })

  return proxy
end

return SecurityProxy

