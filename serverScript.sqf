vDownloadSpeed = (["DownloadSpeed",2] call BIS_fnc_getParamValue)/2;
vSynced = ["SyncedData", 0] call BIS_fnc_getParamValue;


[] spawn {
	if (vSynced == 0) then {
		while {(missionNameSpace getVariable "alphaUpload") < 100} do {
			vAlpha = missionNameSpace getVariable "alphaUpload";
			if ((missionNameSpace getVariable "alphaTriggered") == 1) then {
				missionNameSpace setVariable ["alphaUpload",(vAlpha + vDownloadSpeed),true];
			};
			sleep 0.5;
		};
	} else {
		while {(missionNameSpace getVariable "overallUpload") < 100} do {
			vOverall = missionNameSpace getVariable "overallUpload";
			if ((missionNameSpace getVariable "alphaTriggered") == 1) then {
				missionNameSpace setVariable ["overallUpload",(vOverall + vDownloadSpeed),true];
			};
			sleep 0.5;

		};
	};
};

[] spawn {
	if (vSynced == 0) then {
		while {(missionNameSpace getVariable "bravoUpload") < 100} do {
			vBravo = missionNameSpace getVariable "bravoUpload";
			if ((missionNameSpace getVariable "bravoTriggerd") == 1) then {
				missionNameSpace setVariable ["bravoUpload",(vbravo + vDownloadSpeed),true];
			};
			sleep 0.5;
		};
	} else {
		while {(missionNameSpace getVariable "overallUpload") < 100} do {
			vOverall = missionNameSpace getVariable "overallUpload";
			if ((missionNameSpace getVariable "bravoTriggered") == 1) then {
				missionNameSpace setVariable ["overallUpload",(vOverall + vDownloadSpeed),true];
			};
			sleep 0.5;
		};
	};
};

[] spawn {
	if (vSynced == 0) then {
		while {vSynced == 0} do {
			if ((missionNameSpace getVariable "alphaUpload") > 100) then {
				missionNameSpace setVariable ["alphaUpload",100,true];
			};
			
			if ((missionNameSpace getVariable "bravoUpload") > 100) then {
				missionNameSpace setVariable ["bravoUpload",100,true];
			};
			sleep 0.5;
		};
	} else {
		while {vSynced == 1} do {
			if ((missionNameSpace getVariable "overallUpload") > 100) then {
				missionNameSpace setVariable ["overallUpload",100,true];
			};
			sleep 0.5;
		};
	};
};