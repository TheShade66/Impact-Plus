////////////////////////////////////////////////////////////////////
//DeRap: impact\config.bin
//Produced from mikero's Dos Tools Dll version 8.35
//https://mikero.bytex.digital/Downloads
//'now' is Sun Aug 28 12:29:13 2022 : 'file' last modified on Thu Jan 01 01:00:01 1970
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class impact
	{
		units[] = {};
		weapons[] = {};
		magazines[] = {};
		ammo[] = {};
		requiredVersion = 2;
		requiredAddons[] = {"A3_Characters_F"};
		author = "Haleks";
		versionDesc = "impact";
		versionAct = "";
		version = "0.10.1";
		versionStr = "0.10.1";
		versionAr[] = {0,10,1};
	};
};
class CfgMods
{
	class Mod_Base;
	class impact: Mod_Base{};
	author = "Haleks";
	timepacked = "1642863673";
};
class cfgFunctions
{
	version = 3;
	createShortcuts = 1;
	class impact
	{
		tag = "imp";
		class impact_functions
		{
			file = "\impact\functions";
			class init{};
			class hit{};
		};
	};
};
class CfgVehicles
{
	class Land;
	class Man: Land
	{
		class EventHandlers;
	};
	class CAManBase: Man
	{
		class EventHandlers: EventHandlers
		{
			class impact
			{
				init = "(_this # 0) call imp_fnc_init";
			};
		};
	};
};
