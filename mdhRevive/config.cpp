class CfgPatches 
{
	class mdhRevive
	{
		author = "Moerderhoschi";
		name = "MDH Revive";
		url = "https://steamcommunity.com/sharedfiles/filedetails/?id=3455187736";
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {};
		version = "1.20160815";
		versionStr = "1.20160815";
		versionAr[] = {1,20160816};
		authors[] = {};
	};
};

class CfgFunctions
{
	class mdh
	{
		class mdhFunctions
		{
			class mdhRevive
			{
				file = "mdhRevive\init.sqf";
				postInit = 1;
			};
		};
	};
};

class CfgMods
{
	class mdhRevive
	{
		dir = "@mdhRevive";
		name = "MDH Revive";
		picture = "a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa";
		hidePicture = "true";
		hideName = "true";
		actionName = "Website";
		action = "https://steamcommunity.com/sharedfiles/filedetails/?id=3455187736";
	};
};