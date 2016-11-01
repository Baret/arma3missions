/* This script will execute the scripts in the array in a random order with a random delay */
/* based on Random Tasks by h8ermaker https://youtu.be/UTsUo9NgCs8 */

private _minDelay = paramsArray select 0;
private _maxDelay = paramsArray select 1;

// create a copy of the array
private _opentasks = +TaskArray;
private _taskcount = count _opentasks;
for "_n" from 1 to _taskcount do {
	private _atask = selectRandom _opentasks;
	
	private _wait = _minDelay + random (_maxDelay - _minDelay);
	sleep _wait;
	
	private _script = [] execVM _atask;
	_opentasks = _opentasks - [_atask];
	waitUntil {sleep 1; scriptDone _script};
};