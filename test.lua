local function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        if not string.gmatch(inputstr, "([^"..sep.."]+)") then
            return inputstr
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end


print(split("tamere")[1])
