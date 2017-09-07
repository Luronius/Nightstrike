vEmp1Charge = missionNameSpace getVariable "Emp1Charge";
actionAdded = 0;
emp1Used = 0;

publicVariable "emp1Used";	

[] spawn {
	while {alive pOperator1} do {
		vEMPRange = ["EMPRange", 100] call BIS_fnc_getParamValue;
		if (vEmp1Charge < 100) then {
			vEmp1Charge = vEmp1Charge + (100/vEMPRecharge);
		} else {
			vEmp1Charge = 100;
		};
		if ((vEmp1Charge == 100) && (actionAdded == 0)) then {
			actionAdded = 1;
			emp1Used = 0;
			pOperator1 addAction["EMP Charge", {{execVM "emp1Script.sqf";} remoteExec ["BIS_fnc_call", 0]; playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", pOperator1, false, getPosASL pOperator1, 5, 1, (vEMPRange * 2)];},nil,6,false,true,"","true",0];
		};
		if (emp1Used == 1) then {
			removeAllActions pOperator1;
			actionAdded = 0;
		};
		sleep 1;
	};
};

[] spawn {
	while {alive pOperator1} do {
		vSynced = ["SyncedData", 0] call BIS_fnc_getParamValue;
		_vAlpha = missionNameSpace getVariable "alphaUpload";
		_vBravo = missionNameSpace getVariable "bravoupload";
		_vOverall = missionNameSpace getVariable "overallUpload";
		if (vSynced == 0) then {
			hintSilent parsetext format["<t size='2.0' color='#00F700'>Download Status</t><br/>
			Alpha Site: <t color='#00F700'>%1%3</t><br/>
			Bravo Site: <t color='#00F700'>%2%3</t> <br/>
			EMP Charge: <t color='#00F700'>%4%3</t> <br/>",round(_vAlpha),round(_vBravo),"%",round(vEmp1Charge)];
		} else {
			hintSilent parsetext format["<t size='2.0' color='#00F700'>Download Status</t><br/>
			Overall Download: <t color='#00F700'>%1%3</t><br/>
			<br/>
			EMP Charge: <t color='#00F700'>%2%3</t> <br/>",round(_vOverall),round(vEmp1Charge),"%"];
		};
		sleep 0.2;
	};
};

[] spawn {

	pOperator1 addEventHandler["killed", {west addScoreSide 9;}];
	vThirdPerson = ["OperatorThirdPerson", 1] call BIS_fnc_getParamValue;

	_guardArray = [];
	cLootable = {
    _unit = param [0];
        createVehicle ["Item_FirstAidKit", getPos _unit,[],0,"CAN_COLLIDE"];
        removeAllWeapons _unit;
		removeVest _unit;
		_unit removeweapon "itemmap";
		_unit removeweapon "itemcompass";
		_unit removeweapon "itemradio";
		_unit removeweapon "ItemWatch";
        removeAllItems _unit;
		clearWeaponCargo _unit;
    };
	
	{
	if (side _x == west) then {
		_guardArray pushback _x;
	};
	} forEach allUnits;

	{
	if !(isNil {_x}) then {
		_x addEventHandler["killed", {call cLootable}];
	};
	} forEach _guardArray;
	
	if (vThirdPerson == 0) then {
		addMissionEventHandler ["EachFrame", {
			if (cameraView isEqualTo "EXTERNAL") then {
				cameraOn switchCamera "INTERNAL";
			};
		}];
	};
};

