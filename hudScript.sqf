[]spawn {
	player setAnimSpeedCoef 0.75;
	gThirdPerson = ["GuardThirdPerson", 0] call BIS_fnc_getParamValue;	
	while {alive player} do {
		vSynced = ["SyncedData", 0] call BIS_fnc_getParamValue;
		vGuardSpeed = ["GuardSpeed", 75] call BIS_fnc_getParamValue;
		vGuardStamina = [false,true] select (["GuardStamina", 1] call BIS_fnc_getParamValue);
		player setAnimSpeedCoef (vGuardSpeed / 100);
		player enableStamina vGuardStamina;
		_vAlpha = missionNameSpace getVariable "alphaUpload";
		_vBravo = missionNameSpace getVariable "bravoupload";
		_vOverall = missionNameSpace getVariable "overallUpload";
		_vLightsOutvar = missionNameSpace getVariable "vLightsOut";
		_vEMPRange = ["EMPRange", 100] call BIS_fnc_getParamValue;
		
		if (vSynced == 0) then {
			hintSilent parsetext format["<t size='2.0' color='#ff970f'>Intel Status</t><br/>
				Alpha Site: <t color='#ff970f'>%1%3 Stolen</t><br/>
				Bravo Site: <t color='#ff970f'>%2%3 Stolen</t>",round(_vAlpha),round(_vBravo),"%"];
		} else {
			hintSilent parsetext format["<t size='2.0' color='#ff970f'>Intel Status</t><br/>
				Overall Status: <t color='#ff970f'>%1%2 Stolen</t>",round(_vOverall),"%"];
		};
		if (_vLightsOutVar == 1 && ((player distance (getMarkerPos "emp1Marker") < _vEMPRange) or (player distance (getMarkerPos "emp2Marker") < _vEMPRange))) then {
			player action ["GunLightOff", player];
		};
		sleep 0.5;
	};
	
	if (gThirdPerson == 0) then {
		addMissionEventHandler ["EachFrame", {
			if (cameraView isEqualTo "EXTERNAL") then {
				cameraOn switchCamera "INTERNAL";
			};
		}];
	};
};
