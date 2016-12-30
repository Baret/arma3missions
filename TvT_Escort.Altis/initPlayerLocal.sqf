if (side player == west && leader player == player) then {
	_actStop = [player,"convoyStop"] call BIS_fnc_addCommMenuItem;
	_actGo = [player,"convoyGo"] call BIS_fnc_addCommMenuItem;
};

GroupMarkerFnc = call compileFinal preprocessfilelinenumbers "groupmarkers.sqf";
[] spawn GroupMarkerFnc;
