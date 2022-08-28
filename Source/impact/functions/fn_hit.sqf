(_this # 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
_abort_evals = [
	{!alive _target},
	{vehicle _target isNotEqualTo _target},
	//{isPlayer _target && {!(missionNamespace getVariable ["impactForcedOn_player", false])}},		now disabled on player
	//{_target isKindOf "zombie" && {!(missionNamespace getVariable [("impactForcedOn_" + typeOf _target), false])}},//impactForcedOn_zombie_walker = true;
	//{_target isKindOf "UAV_AI_base_F" && {!(missionNamespace getVariable [("impactForcedOn_" + typeOf _target), false])}},
	{(missionNamespace getVariable ["impactDisabledOn_" + typeOf _target, false])},
	{(missionNamespace getVariable ["impactDisabledOn_" + str _target, false])}
];
if (_abort_evals findIf {call _x} isNotEqualTo -1) exitWith {};


_radius_threshold = [0.1, 0.15] select _isDirect;
_impact = (_ammo # 0) > 1 && _radius > _radius_threshold && {vectorMagnitude _velocity > 100 || (_ammo # 1) > 0};
if (_impact) then {
	_hitvalue = (_ammo select !_isDirect) min 12.5;
	_hitveloratio = _hitvalue/([100,vectorMagnitude _velocity] select _isDirect);
	_mass = _hitveloratio * _hitvalue * _radius*10 * (count _selection);

	_coef = missionNamespace getVariable ["impactCoef", 1];
	if (random 1 > _mass*_coef) exitWith {};

	_hitpos = _target selectionPosition (_selection # 0);
	_impact_vector = _velocity;
	if (!_isDirect) then {
		_origin = [getPosASL _projectile, eyePos _shooter] select _isDirect;
		_vector_offset = _position vectorFromTo _origin;
		_hitpos_world = _target modelToWorldWorld _hitpos;
		_posASL = _hitpos_world vectorAdd _vector_offset;
		_impact_vector = _posASL vectorFromTo _hitpos_world;
	};

	/*i_debug = "Sign_Sphere25cm_F" createVehicleLocal [0,0,0];
	i_debug setPosASL _posASL;
	i_debug spawn {sleep 5; deleteVehicle _this};*/

	_force = _impact_vector vectorMultiply _mass;
	_target addForce [_force, _hitpos];
	_target spawn {
		sleep 5;
		if (alive _this) then {
			_this setUnconscious false
		}
	};
};