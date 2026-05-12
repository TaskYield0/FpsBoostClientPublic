-- 1. Double check this URL (Note: your screenshot said "avatrar" with an extra 'r', make sure it matches!)
local proxyUrl = "https://fpsboostclient.taskyield0.workers.dev" 

-- 2. Put the actual ACCESS_KEY password you set in Cloudflare here
local secretKey = "TaskYield0SecretKey" 

print("Attempting to connect to proxy...")

local response
local success, err = pcall(function()
    response = request({
        Url = proxyUrl,
        Method = "GET",
        Headers = {
            ["Authorization"] = "Bearer " .. secretKey
        }
    })
end)

-- Check if Xeno's request function failed
if not success then
    warn("Xeno failed to send the request: " .. tostring(err))
    return
end

-- Check if Cloudflare accepted our password
if response.StatusCode == 200 then
    print("Proxy hit successfully! Executing code...")
    
    local func, compileErr = loadstring(response.Body)
    if func then
        func() -- Run the code
    else
        warn("Xeno fetched the code, but failed to compile it. Check your raw GitHub link. Error: " .. tostring(compileErr))
    end
else
    -- If you see a 403, your secretKey is wrong. If you see a 404, your GitHub token or raw link is wrong.
    warn("Proxy Blocked or Failed! Status Code: " .. tostring(response.StatusCode))
    warn("Cloudflare Message: " .. tostring(response.Body))
end
