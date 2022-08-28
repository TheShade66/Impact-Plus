if (!local _this || !isNil {_this getVariable "impactHandler"}) exitWith {};
_this setVariable ["impactHandler", _this addEventHandler ["HitPart", {_this call imp_fnc_hit}]];