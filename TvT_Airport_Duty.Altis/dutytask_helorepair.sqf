if( alive helo ) then {
	repairTaskStarted = true;
	private _taskID = "task_helo_repair";
	private _meetTask = [west,_taskID,["We have a damaged air vehicle that needs repairs. Wair for it to arrive at the airbase and repair it (get the repair truck close and wait).","Repair air vehicle",""],[9177.58,21643.4],"CREATED",3,true,"repair"] call BIS_fnc_taskCreate;
};