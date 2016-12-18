if( alive vipTransportHelo ) then {
	vipTaskStarted = true;
	private _taskID = "task_vip_extraction";
	private _vipTask = [west,_taskID,["A colonel needs to move quickly away from the island. He comes to the airfield from the north. Protect him till a helo comes for extraction.","Protect the VIP",""],[9177.58,21643.4],"CREATED",3,true,"default"] call BIS_fnc_taskCreate;
};