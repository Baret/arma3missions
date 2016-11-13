// *******************************************************************
// Author: -[EUTW]- void
// *******************************************************************

#define GetIcon(Grp) Grp getVariable ["GroupIcon", ""]
private _sideGroups = [];

// delay between refreshes in seconds
private _delay = 2;

// Sort Groups to correct Factions
{
    if (side (leader _x) == playerSide) then
    {
        _sideGroups pushBack _x;
    };
} forEach allGroups;

// Create markers for all groups
{
    _markerName = groupID _x;
    _icon = GetIcon(_x);
    _marker = createMarkerLocal [_markerName, [0,0,0]];
    _marker setMarkerTextLocal _markerName;
    _marker setMarkerColorLocal "ColorBlack";
    _marker setMarkerTypeLocal _icon;
} forEach _sideGroups;

// Script will run each _delay seconds and corrects marker positions on group leader
while {true} do
{
    waitUntil {uisleep 0.1 ; visibleGPS || visibleMap || shownArtilleryComputer};
    {
        //Check if group is still alive, if not marker is removed from array and marker is set to red
        if (group (leader _x) == grpNull) then
        {
            _sideGroups = _sideGroups - _x;
            deleteMarkerLocal (groupID _x);
        }
        else
        {
            _position = getPos (leader _x);
            (groupID _x) setMarkerPosLocal _position;
        };
    } forEach _sideGroups;

    uisleep _delay;
};