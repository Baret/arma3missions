private _convoyDelay = paramsArray select 0;
trigger_start_delay setTriggerTimeout [_convoyDelay, _convoyDelay, _convoyDelay, false];
