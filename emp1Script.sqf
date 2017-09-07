vEMPRange = ["EMPRange", 100] call BIS_fnc_getParamValue;
vEmp1Charge = missionNameSpace getVariable "Emp1Charge";

"emp1marker" setMarkerPos (getPos pOperator1);
aEMPObjects = nearestObjects[(getMarkerPos "emp1Marker"), ["Lamps_base_F","PowerLines_base_F","PowerLines_Small_base_F"],vEMPRange];


emp1Empty = {
	emp1Used = 1;
	missionNameSpace setVariable ["Emp1Charge",0];
};
call emp1Empty;

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
