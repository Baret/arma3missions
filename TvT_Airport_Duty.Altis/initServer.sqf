addMissionEventHandler ["EntityKilled",	{
	params ["_killed", "_killer","_instigator"];
	{
		if (playersNumber _x == 0) then {
			switch (_x) do {
				case west: { "NatoDown" call BIS_fnc_endMission };
				case east: {
					["main_defend", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
					"CsatDown" call BIS_fnc_endMission;
				};
			};
		};
	} foreach [east, west];
}];

TaskArray=["dutytask_helorepair.sqf","dutytask_findweapons.sqf","dutytask_meetinformant.sqf"];
null=[] execVM "executerandomtasks.sqf";