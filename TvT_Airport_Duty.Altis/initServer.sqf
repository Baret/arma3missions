addMissionEventHandler ["EntityKilled",	{
	params ["_killed", "_killer","_instigator"];
	{
		private _side = _x;
		private _teamCount = {(side _x == _side) and (alive _x)} count allPlayers;
		if (_teamCount == 0) then {
			switch (_x) do {
				case west: { "NatoDown" call BIS_fnc_endMissionServer };
				case east: {
					["main_defend", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
					"CsatDown" call BIS_fnc_endMissionServer;
				};
			};
		};
	} foreach [east, west];
}];

TaskArray=["dutytask_helorepair.sqf","dutytask_findweapons.sqf","dutytask_meetinformant.sqf"];
null=[] execVM "executerandomtasks.sqf";