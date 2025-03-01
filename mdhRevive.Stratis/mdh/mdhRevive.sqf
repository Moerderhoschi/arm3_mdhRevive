/////////////////////////////////////////////////////////////////////////////////////
// mdhRevive, made by moerderhoschi
// github: https://github.com/Moerderhoschi/arm3_mdhRevive
// steam:  https://steamcommunity.com/sharedfiles/filedetails/?id=3435005893
/////////////////////////////////////////////////////////////////////////////////////
pMdhRevive                   = ["pMdhRevive",                   1] call BIS_fnc_getParamValue; // MDH REVIVE FOR ALL PLAYERS (LOOP)
pMdhReviveBleedoutTime       = ["pMdhReviveBleedoutTime",     4^9] call BIS_fnc_getParamValue; // MDH REVIVE BLEEDOUT TIME FOR ALL PLAYERS (LOOP)
pMdhReviveAutoReviveTime     = ["pMdhReviveAutoReviveTime",   240] call BIS_fnc_getParamValue; // MDH AUTO REVIVE TIME FOR ALL PLAYERS (LOOP)
pMdhReviveSpectator          = ["pMdhReviveSpectator",          1] call BIS_fnc_getParamValue; // MDH REVIVE SPECTATOR FOR INCAPACITATED PLAYERS (LOOP)

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH REVIVE FOR ALL PLAYERS(by Moerderhoschi) - v2025-02-09
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhRevive",0] > 0 && {isMultiplayer}) then
{
	0 spawn
	{
		sleep (1 + random 1);
		bis_reviveParam_mode = 1;
		bis_revive_unconsciousStateMode = 0;
		_p = missionNameSpace getVariable ["pMdhRevive",0];
		mdhReviveAutoReviveTime = missionNameSpace getVariable["pMdhReviveAutoReviveTime", 240];
		sleep 0.5;
		if (!isDedicated) then {call BIS_fnc_reviveInit};
		sleep 1;
		bis_revive_duration = 5;
		bis_revive_durationmedic = 2;
		bis_revive_medicspeedmultiplier = 3;
		bis_revive_bleedoutduration = missionNameSpace getVariable["pMdhReviveBleedoutTime", 4^9];
		if (_p == 2) exitWith {bis_revive_bleedoutduration = 300};
		if (!isDedicated) then 
		{
			player setVariable ["mdhRevivePlayerSide",(side group player)];
			player setVariable ["mdhRevived",false,true];
			sleep 0.5;
			if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
			_mdhDragging = 
			{
				if (player getVariable ["mdhReviveDraged",false]) then
				{
					_dragger = player getVariable ["mdhReviveDragedBy",objNull];
					if (player getVariable ["mdhReviveDragInit",false] && {_dragger getVariable ["mdhReviveDragging",false]}) then
					{
						player setVariable ["mdhReviveDragInit",false,true];
						player attachTo [_dragger,[0,1.5,0]];
						player setDir 180;
					};
					if
					(
						!(player getVariable ["mdhReviveDraged",false])
						OR {!(lifeState _dragger in ["HEALTHY","INJURED"])}
						OR {!(_dragger in allPlayers)}
						OR {lifeState player != "INCAPACITATED"}
						OR {player getVariable ["mdhRevived",false]}
					)
					then
					{
						player setVariable ["mdhReviveDraged",false,true];
						detach player;
					};
				};
			};
			while{sleep 0.3; true}do
			{
				waitUntil
				{
					sleep 0.01;
					{
						if (_x != player) then
						{
							_player = _x;
							{
								if (count(_player actionParams _x) > 2) then
								{
									if (typeName(_player actionParams _x select 2) == "ARRAY") then
									{
										if (count(_player actionParams _x select 2) > 12 ) then
										{
											if ("bis_reviveTextures2d_unconscious" in str(_player actionParams _x select 2 select 12)) then
											{
												_player removeAction _x;
											};
										};
									};
								}
							} forEach (actionIDs _player);
						};
					} forEach allPlayers;
	
					{
						if (_x != player) then
						{
							_player = _x;
							_f = (actionIDs _player findIf { ">Revive " in (_player actionParams _x select 0) }) != -1;
	
							if (!_f && {_x getVariable ["mdhRevivePlayerName",""] != ""}) then
							{
								[
									_x,
									("Revive " + name _x),
									//("<t color=""#FF0000"">Revive "+(name _x)+"</t>"),
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"lifeState _target == ""INCAPACITATED"" 
									&& {player distance _target < 3}
									&& {!(_target getVariable [""mdhReviveDraged"",false])}
									",
									"true",
									{},
									{},
									{_target setVariable ["mdhRevivedBy",player,true];_target setVariable ["mdhRevived",true,true]}
									,{}
									,[]
									,3
									,99
									,false
									,false
								] call BIS_fnc_holdActionAdd;
							};
						};
					} forEach allPlayers;
	
					{
						if (_x != player) then
						{
							_player = _x;
							_f = (actionIDs _player findIf { "Drag " in (_player actionParams _x select 0) }) != -1;
	
							if (!_f && {_x getVariable ["mdhRevivePlayerName",""] != ""}) then
							{
								_x addAction
								[
									("<t color=""#FF0000"">Drag "+(name _x)+"</t>"),
									{
										params ["_target"];
										if (currentWeapon player == handgunWeapon player) then
										{
											player playMoveNow "acinpknlmstpsnonwpstdnon"; // pistol
										}
										else
										{
											player playMoveNow "acinpknlmstpsraswrfldnon"; // rifle
										};
										player setVariable ["mdhReviveDragging",true,true];
										_target setVariable ["mdhReviveDragInit",true,true];
										_target setVariable ["mdhReviveDraged",true,true];
										_target setVariable ["mdhReviveDragedBy",player,true];
										_target spawn
										{
											sleep 2;
											waitUntil
											{
												sleep 0.2;
												!(_this getVariable ["mdhReviveDraged",false])
												OR !(lifeState player in ["HEALTHY","INJURED"])
												OR lifeState _this != "INCAPACITATED"
												OR {_x isKindOf "man"} count attachedObjects player < 1
											};
											player setVariable ["mdhReviveDragging",false,true];
											for "_i" from 1 to 9 do
											{
												if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
												sleep 0.3;
											};
										};
									},0,98,true,false,""
									,"lifeState _target == ""INCAPACITATED""
									&& {vehicle player == player}
									&& {!(_target getVariable [""mdhReviveDraged"",false])}
									&& {time > _target getVariable [""mdhReviveDragEnableTime"",time + 5]}
									&& {_target in allPlayers}
									"
									,3,false
								];
							};
						};
					} forEach allPlayers;
					
					_f = (actionIDs player findIf { "Stop Drag" in (player actionParams _x select 0) }) != -1;
					if (!_f) then
					{
						player addAction
						[
							("<t color=""#FF0000"">Stop Drag</t>"),
							{
								{if(_x isKindOf "man")then{detach _x;_x setVariable ["mdhReviveDraged",false,true]}}forEach attachedObjects player;
								player setVariable ["mdhReviveDragging",false,true];
								for "_i" from 1 to 4 do
								{
									if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
									sleep 0.5;
								};
							},0,98,true,false,""
							,"vehicle player == player && {player getVariable [""mdhReviveDragging"",false]} && {{_x isKindOf ""man""} count attachedObjects player > 0}"
							,3,false
						];
					};
	
					if (player getVariable ["mdhRevivePlayerName",""] == "") then {player setVariable ["mdhRevivePlayerName",name player,true]};
					call _mdhDragging;
	
					lifeState player == "INCAPACITATED"
				};
				player allowDamage false;
				player setVariable["mdhReviveDragEnableTime",time + 5,true];
				_endTime = time + 3 + mdhReviveAutoReviveTime;
				_side = player getVariable ["mdhRevivePlayerSide",west];
				if (missionNameSpace getVariable["pMdhReviveSpectator", 1] == 1) then
				{
					if (name player == "Moerderhoschi") then
					{
						["Initialize",[player,[]             ,true   ,true           ,true          ,false        ,true             ,false             ,true      ,true]]call BIS_fnc_EGSpectator;
					}
					else
					{
						["Initialize",[player,[_side]        ,false  ,true           ,true          ,false        ,true             ,false             ,true      ,true]]call BIS_fnc_EGSpectator;
					};
				};
				sleep 0.1;
				_cam = nearestObject [player, "CamCurator"];
				_cam setPos (_cam modelToWorld [0,-5,0]);
				if (!isNil"bis_revive_ppColor") then {bis_revive_ppColor ppEffectEnable false};
				if (!isNil"bis_revive_ppVig") then {bis_revive_ppVig ppEffectEnable false};
				if (!isNil"bis_revive_ppBlur") then {bis_revive_ppBlur ppEffectEnable false};

				sleep 1;
				waitUntil
				{
					if (!isNil"bis_revive_ppColor") then {bis_revive_ppColor ppEffectEnable false};
					if (!isNil"bis_revive_ppVig") then {bis_revive_ppVig ppEffectEnable false};
					if (!isNil"bis_revive_ppBlur") then {bis_revive_ppBlur ppEffectEnable false};
	
					if (_endTime - time < 601 && {round(_endTime - time) mod 20 == 0}) then
					{
						systemChat("Automatic Revive in "+str(round(_endTime - time))+" seconds")
					};
	
					sleep 0.1;
					{
						if (count (player actionParams _x) > 2) then
						{
							if (typeName(player actionParams _x select 2) == "ARRAY" ) then
							{
								if (count(player actionParams _x select 2) > 12 ) then
								{
									if ("bis_reviveTextures2d_unconscious" in str(player actionParams _x select 2 select 12)) then
									{
										player removeAction _x;
									};
								};
							};
						};
					} forEach actionIDs player;
					
					sleep 0.3;
					call _mdhDragging;
					sleep 0.3;
					call _mdhDragging;
					sleep 0.3;
	
					lifeState player != "INCAPACITATED" OR time > _endTime OR player getVariable ["mdhRevived",false]
				};
				player setVariable ["mdhRevived",false,true];
				if (lifeState player == "INCAPACITATED") then
				{
					if (time > _endTime) then
					{
						[objNull,[1,player], player] remoteExec ["bis_fnc_reviveOnState"];
					}
					else
					{
						[objNull,[1,player getVariable["mdhRevivedBy",player]], player] remoteExec ["bis_fnc_reviveOnState"];
					};
				};
				["Terminate"] call BIS_fnc_EGSpectator;
				player allowDamage true;
				sleep 0.2;
				player setUnconscious false;
			};
		};
	};
};
