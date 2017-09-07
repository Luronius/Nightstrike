vEMPRange = ["EMPRange", 100] call BIS_fnc_getParamValue;
vEmp2Charge = missionNameSpace getVariable "Emp2Charge";

"emp2marker" setMarkerPos (getPos pOperator2);
aEMPObjects = nearestObjects[(getMarkerPos "emp2Marker"), ["Lamps_base_F","PowerLines_base_F","PowerLines_Small_base_F"],vEMPRange];

emp2Empty = {
	emp2Used = 1;
	missionNameSpace setVariable ["Emp2Charge",0];
};
call emp2Empty;

empON = {
	{
		for "_i" from 0 to count getAllHitPointsDamage _x do {
			if ((_x getHitIndex _i) < 1) then {
				_x setHitIndex [_i, 0.9766];
			};
		};
	} forEach aEMPObjects; 
};

empOFF = {
	{
		for "_i" from 0 to count getAllHitPointsDamage _x do {
			if ((_x getHitIndex _i) == 0.9766) then {
				_x setHitIndex [_i, 0];
			};
		};
	} forEach aEMPObjects;
};

call empON;
sleep 0.2;
call empOFF;
sleep 0.1;
call empON;
sleep 0.2;
call empOFF;
sleep 0.1;
call empOn;

missionNameSpace setVariable ["vLightsOut",1,true];
sleep 5;
missionNameSpace setVariable ["vLightsOut",0,true];
sleep (vEMPDuration - 5); //main EMP off time

call empOFF;
sleep 0.1;
call empON;
sleep 0.4;
call empOFF;
