if (side player == west && leader player == player) then {
	_actStop = [player,"convoyStop"] call BIS_fnc_addCommMenuItem;
	_actGo = [player,"convoyGo"] call BIS_fnc_addCommMenuItem;
};

if (side player == west) then {
	player createDiaryRecord ["Diary", ["Commanding the Convoy", "You can order the driver by radio, to stop and continue moving. Use Reply (<font color='#ffffff'>0</font>), Supports (<font color='#ffffff'>8</font>), Convoy Stop! (<font color='#ffffff'>1</font>) or Convoy Move! (<font color='#ffffff'>2</font>). So pressing <font color='#ffffff'>0 8 1</font> will stop the convoy."]];
	player createDiaryRecord ["Diary", ["Mission", "Protect the VIP (Colonel Patterson). His driver will bring him back to <marker name='marker_destination'>Kavala</marker>. Make sure he arrives there alive."]];
} else {
	if (side player == east) then {
		player createDiaryRecord ["Diary", ["Mission", "Prepare an ambush, neutralize the escort and kill Colonel Patterson."]];
	};
};
player createDiaryRecord ["Diary", ["Situation", "The highly decorated Colonel Patterson is currently in the <marker name='marker_start'>church of Agios Dionysios</marker>. Soon he will drive back to <marker name='marker_destination'>Kavala</marker>. He is escorted by a platoon, because there were rumors, that enemies will use his weekly church visit to kill him."]];

GroupMarkerFnc = call compileFinal preprocessfilelinenumbers "groupmarkers.sqf";
[] spawn GroupMarkerFnc;
