private _deviceRelativeTo = selectRandom [shed1, shed2, shed3, shed4, shed5];
device setPos (_deviceRelativeTo buildingPos 2);
device setDir (getDir _deviceRelativeTo);

comment "cache objects for task informant";
nearestObjects [getMarkerPos "mkr_hq_west",["Man","Car","Tank","Helicopter"],7000];
comment "Building markers";
{
	private _markerForMapMarks = _x;
	{
		private _objectsToMarkOnMap = (getMarkerPos _markerForMapMarks) nearObjects [_x, 320];
		{
			_aMarkerName = [_x] call BIS_fnc_boundingBoxMarker;
			_aMarkerName setMarkerColor "ColorGrey";
			_aMarkerName setMarkerBrush "SolidFull";
		} foreach _objectsToMarkOnMap;
	} foreach ["House", "Wall", "HBarrier_base_F"];
} foreach ["mkr_hq_west", "mkr_hq_east"];

addMissionEventHandler ["EntityKilled",	{
	params ["_killed", "_killer","_instigator"];
	{
		private _side = _x;
		private _teamCount = {(side _x == _side) and (alive _x)} count playableUnits;
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

TaskArray=["dutytask_helorepair.sqf","dutytask_findweapons.sqf","dutytask_meetinformant.sqf","dutytask_vipextraction.sqf"];
null=[] execVM "executerandomtasks.sqf";