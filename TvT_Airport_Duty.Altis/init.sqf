// Init markers
if (side player == east) then {

	_mkr_opf_boats = createMarkerLocal ["mkr_opf_boats", getMarkerPos "marker_opfor_boats"];
	_mkr_opf_boats setMarkerColorLocal "ColorEAST";
	_mkr_opf_boats setMarkerShapeLocal "ICON";
	_mkr_opf_boats setMarkerTypeLocal "mil_marker";
	_mkr_opf_boats setMarkerTextLocal "Boats";

	_mkr_opf_helos = createMarkerLocal ["mkr_opf_helos", getMarkerPos "marker_opfor_helicopters"];
	_mkr_opf_helos setMarkerColorLocal "ColorEAST";
	_mkr_opf_helos setMarkerShapeLocal "ICON";
	_mkr_opf_helos setMarkerTypeLocal "mil_marker";
	_mkr_opf_helos setMarkerTextLocal "Helicopters & SDVs";

} else {

	// BLUFOR markers (not yet existing)
};

// Playertracking
GroupMarkerFnc = call compileFinal preprocessfilelinenumbers "groupmarkers.sqf";
[] spawn GroupMarkerFnc;