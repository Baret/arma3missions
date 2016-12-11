private _taskID = "task_informant";
private _meetTask = [west,_taskID,["A guy says he has valuable information about the enemy. Send some men there to check what he has to say, we can use every advantage we can get. The informant is somewhere in Abdera.","Meet an Informant",""],[9423.1865,20249.619],"CREATED",3,true,"meet"] call BIS_fnc_taskCreate;
if (alive informant) then {
	informantKilledEventIndex = informant addEventHandler ["killed", {["task_informant", "FAILED", true] spawn BIS_fnc_taskSetState}];
	talkedWithInformant = false;
	
	// find position of closest attacker
	_nearestunits = nearestObjects [getMarkerPos "mkr_hq_west",["Man","Car","Tank","Helicopter"],7000];
	closestEnemyPosition = nil;
	if(east countSide _nearestunits > 0) then {
	   closestEnemyPosition = {
		      _unit = _x;
		      if(side _unit == east) exitWith {position _unit}
		   } foreach _nearestunits;
	};
	
	private _talk = {
		private _talker = (_this select 1);

		playSound "faction_independent_x05_i_nonsense_EXI_1";
		// wait until sound is finished
		private _sound = ASLToAGL [0,0,0] nearestObject "#soundonvehicle";
		waitUntil {isNull _sound};

		informant removeEventHandler ["killed", informantKilledEventIndex];
		["task_informant", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
		if (!talkedWithInformant) then {
			if(isNil "closestEnemyPosition") then {
				[_talker, "The 'informant' is just a reporter that wanted to lure us. I told him nothing about our mission and that he should never do this shit again."] remoteExec ["sideChat", west];
			} else {
				{createMarkerLocal ["mkr_closest_enemy", closestEnemyPosition]} remoteExecCall ["bis_fnc_call", west];
				["mkr_closest_enemy", "ColorEAST"] remoteExecCall ["setMarkerColorLocal", west];
				["mkr_closest_enemy", "ELLIPSE"] remoteExecCall ["setMarkerShapeLocal", west];
				["mkr_closest_enemy", "DiagGrid"] remoteExecCall ["setMarkerBrushLocal", west];
				["mkr_closest_enemy", [250, 250]] remoteExecCall ["setMarkerSizeLocal", west];
				[_talker, "The informat says he has seen enemy forces around the marked position some time ago."] remoteExec ["sideChat", west];
			};
			talkedWithInformant = true;
		};
	};
	[informant, ["Talk", _talk]] remoteExec ["addAction", west, informant];
} else {
	// TODO somebody must find the corpse
	[_taskID, "FAILED", true] spawn BIS_fnc_taskSetState;
	[[west, "Base"], "Informant was killed."] remoteExec ["sideChat", west];
};