-- Lua Socket for Passing in Drone Location
-- Ian Mackenzie @ E-go CG

function getInfo()


	-- name for the host and port
	local host, port = "localhost", 44332;


	local socket = require("socket");

	-- convert host name to ip address
	local ip = socket.try(socket.dns.toip(host));

	-- fullInfo contains the information gained from the socket call
	local fullInfo = socket.try(socket.udp());


	socket.try(fullInfo:sendto("anything", ip, port));
	socket.try(fullInfo:receive());

	-- splitInfo is the table that will contain all of the information,
	-- split by comma

	local splitInfo = {};


	-- split the initially called protocol, which includes more info than we want,
	-- into smaller usable pieces

	for word in string.gmatch(fullInfo, '([^,]+)') do
		table.insert(splitInfo, word);
	end

	local x = splitInfo[7];
	local y = splitInfo[8];
	local z = splitInfo[9];

	-- print(x .. "  " .. y .. "  " .. z);

	return x, y, z;

end

return getInfo();

