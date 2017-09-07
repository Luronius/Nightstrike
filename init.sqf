missionNameSpace setVariable ["alphaTriggered",0,true];
missionNameSpace setVariable ["bravoTriggered",0,true];
missionNameSpace setVariable ["emp1Charge",0,true];
missionNameSpace setVariable ["emp2Charge",0,true];
missionNameSpace setVariable ["alphaUpload",0,true];
missionNameSpace setVariable ["bravoUpload",0,true];
missionNameSpace setVariable ["overallUpload",0,true];
missionNameSpace setVariable ["vLightsOut",0,true];


if (isServer) then {
	execVM "ServerScript.sqf";
	vEMPDuration = ["EMPDuration", 20] call BIS_fnc_getParamValue;
	vEMPRecharge = ["RechargeTime", 50] call BIS_fnc_getParamValue;
	vFogVar = ["FogWeather", 1] call BIS_fnc_getParamValue;
	0 setfog [(vFogVar/10),0.015,220];
	vCloudVar = ["CloudWeather",10] call BIS_fnc_getParamValue;
	[(vCloudVar)/10] call BIS_fnc_setOvercast;
	vRainVar = ["RainWeather",25] call BIS_fnc_getParamValue;
	0 setRain (vRainVar / 100);
	forceWeatherChange;
};

if (side player == west) then {
	player execVM "hudScript.sqf";
};


if (!isNil "pOperator1" && {local pOperator1}) then {
	pOperator1 execVM "operator1Script.sqf";
};


if (!isNil "pOperator2" && {local pOperator2}) then {
	pOperator2 execVM "operator2Script.sqf";
};


PublicVariable "vEMPDuration";
PublicVariable "vEMPRecharge";
publicVariable "alphatriggered";
publicVariable "bravotriggered";