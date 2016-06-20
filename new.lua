-- MA2 Drone Tracking System
-- Ian Mackenzie, E-GO CG

--[[
here we assign some of the MA2 Lua API (the commands which relate to MA stuff)
to local names which are not only easier to use, but actually more efficient
when the script is running. Assigning to locals means they can be found faster than
looking for them directly, and we are interested in good performance

    Note: locals are things that only have relevance to this script, not other plug-ins.
--]]
local sleep = gma.sleep;     -- used to yield spare time to GMA.
local dmx = gma.show.getdmx; -- get value of a dmx channel
local C = gma.cmd;           -- execute a command on the command line

function calcTilt(X, Y, Z)

	local a1 = Z;
	local b1 = (X^2);
	local c1 = (Y^2);
	local d1 = b1 + c1;
	local e1 = math.sqrt(d1);
	local f1 = e1/a1;
	local g1 = math.atan(f1);
	local tilt = math.deg(g1)*1.1;

	return tilt;
end

function calcPan(X, Y)

	local slope = (-Y)/(X);
	local panRad = math.atan(slope);
	local pan = math.deg(panRad);
	return (pan+270)*0.9916666-270;

end

function lightInit()
	numLights = 2;

	light1X = -1.221;
	light1Y = -1.221;
	light1Z = 0;

	light2X = 0;
	light2Y = 0;
	light2Z = 0;

	light3X = 0;
	light3Y = 0;
	light3Z = 0;

	light4X = 0;
	light4Y = 0;
	light4Z = 0;

	light5X = 0;
	light5Y = 0;
	light5Z = 0;

	light6X = 0;
	light6Y = 0;
	light6Z = 0;

	light7X = 0;
	light7Y = 0;
	light7Z = 0;

	light8X = 0;
	light8Y = 0;
	light8Z = 0;

	light8X = 0;
	light8Y = 0;
	light8Z = 0;

	light9X = 0;
	light9Y = 0;
	light9Z = 0;

	light10X = 0;
	light10Y = 0;
	light10Z = 0;

	light11X = 0;
	light11Y = 0;
	light11Z = 0;

	light12X = 0;
	light12Y = 0;
	light12Z = 0;

end

function droneInit()

	initDrone1X = -10;
	initDrone1Y = 10;
	initDrone1Z = 8;

	initDrone2X = 85;
	initDrone2Y = 7;
	initDrone2Z = 2.5;

	initDrone3X = 3.660;
	initDrone3Y = 0;
	initDrone3Z = 1.278;

	initDrone4X = 3.660;
	initDrone4Y = 0;
	initDrone4Z = 1.278;

	initDrone5X = 3.660;
	initDrone5Y = 0;
	initDrone5Z = 1.278;

	initDrone6X = 3.660;
	initDrone6Y = 0;
	initDrone6Z = 1.278;

	drone1X = initDrone1X - light1X;
	drone1Y = initDrone1Y - light1Y;
	drone1Z = initDrone1Z - light1Z;

	drone2X = initDrone2X - light2X;
	drone2Y = initDrone2Y - light2Y;
	drone2Z = initDrone2Z - light2Z;

	drone3X = initDrone3X - light3X;
	drone3Y = initDrone3Y - light3Y;
	drone3Z = initDrone3Z - light3Z;

	drone4X = initDrone4X - light4X;
	drone4Y = initDrone4Y - light4Y;
	drone4Z = initDrone4Z - light4Z;

	drone5X = initDrone5X - light5X;
	drone5Y = initDrone5Y - light5Y;
	drone5Z = initDrone5Z - light5Z;

	drone6X = initDrone6X - light6X;
	drone6Y = initDrone6Y - light6Y;
	drone6Z = initDrone6Z - light6Z;

end

-- called by gMA on "Go Plugin X"
function MainLoop()
--[[
   We are now ready to loop constantly while variable "plugin_loops_run" is not equal to 0
--]]

	lightInit();
	droneInit();

	pan1 = calcPan(drone1X, drone1Y);

	if drone1X < 0 then
		pan1 = pan1 + 180;

	end
	pan2 = calcPan(drone2X, drone2Y);

	if drone2X < 0 then
		pan2 = pan2 + 180;
	end

	tilt1 = calcTilt(drone1X, drone1Y, drone1Z);

	tilt2 = calcTilt(drone2X, drone2Y, drone2Z);

	C('Fixture 1 Attribute "tilt" at ' .. tilt1);
	C('Fixture 1 Attribute "pan" at ' .. pan1);

	C('Fixture 2 Attribute "tilt" at ' .. tilt2);
	C('Fixture 2 Attribute "pan" at ' .. pan2);

end
-- end of the function MainLoop()

--[[
    This function below is called by gMA when 'Off Plugin X' is executed.
It is not really necessary, but helpful in providing feedback to the user
    to let them know the plug-in has finished or been stopped.
--]]
function Cleanup()
     -- print a message in the command line feedback to advise we've stopped.
     gma.feedback('Finished');
end

--[[
   This next statement is _very important_, every plug-in should have it!
   It tells gMA how to run and stop/reset our plug-in.
   we tell gMA what our start and stop functions are by name with no brackets, and in order.
--]]
return MainLoop, Cleanup;
