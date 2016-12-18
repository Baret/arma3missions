private _taskID = "task_weaponcache";
private _meetTask = [west,_taskID,["A supply plane dropped some weapons at Aristi. We had no opportunity to collect them, yet. Find the weapons and do what ever you want with them. They dropped three weapon crates and two ammo boxes. ATTENTION: Some locals may also try to retrieve the weapons. Proceed with caution.","Find Weapons",""],[7942.364,21320.22],"CREATED",3,true,"rifle"] call BIS_fnc_taskCreate;

private _requiredWeaponCaches=[weaponcache_supplybox, weaponcache_basicweapons, weaponcache_specialweapons];
private _optionalWeaponCaches=[weaponcache_ammo1, weaponcache_ammo2];
remainingRequiredWeaponCacheTriggers=[];

checkWeaponsCacheFinished = {
	if (count remainingRequiredWeaponCacheTriggers == 0) then {
		["task_weaponcache", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
	};
};

private _createWeaponCacheTrigger = {
	params ["_object", "_activationCode"];
	private _trigger = createTrigger ["EmptyDetector", getPos _object, true];
	_trigger setTriggerArea [5, 5, 0, false];
	_trigger setTriggerActivation ["west", "present", false];
	_trigger setTriggerStatements ["this", _activationCode, ""];
	_trigger;
};

// required weapons
foundRequiredWeaponCache = {
	params ["_finders", "_trigger"];
	[_finders select 0, "Found a weapons box."] remoteExec ["sideChat", west];
	remainingRequiredWeaponCacheTriggers deleteAt (remainingRequiredWeaponCacheTriggers find _trigger);
	call checkWeaponsCacheFinished;
};

private _createRequiredTrigger = {
	params ["_object"];
	private _code = "[thisList, thisTrigger] call foundRequiredWeaponCache";
	private _trigger = [_object, _code] call _createWeaponCacheTrigger;
	remainingRequiredWeaponCacheTriggers pushBackUnique _trigger;
};

{
	_x call _createRequiredTrigger;
} forEach _requiredWeaponCaches;

// optional ammo
foundOptionalWeaponCache = {
	params ["_finders"];
	[_finders select 0, "Found some ammunition."] remoteExec ["sideChat", west];
};

private _createOptionalTrigger = {
	params ["_object"];
	private _code = "[thisList] call foundOptionalWeaponCache";
	private _trigger = [_object, _code] call _createWeaponCacheTrigger;
};

{
	_x call _createOptionalTrigger;
} forEach _optionalWeaponCaches;
