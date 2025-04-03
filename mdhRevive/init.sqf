/////////////////////////////////////////////////////////////////////////////////////
// MDH REVIVE FOR ALL PLAYERS(by Moerderhoschi) - v2025-04-03
// github: https://github.com/Moerderhoschi/arm3_mdhRevive
// steam:  https://steamcommunity.com/sharedfiles/filedetails/?id=3435005893
/////////////////////////////////////////////////////////////////////////////////////
if (missionNameSpace getVariable ["pMdhRevive",99] == 99 && {isMultiplayer}) then
{
	0 spawn
	{
		_diary  = 0;
		if (hasInterface) then
		{
			_diary =
			{
				waitUntil {!(isNull player)};
				_c = true;
				_t = "MDH Revive";
				if (player diarySubjectExists "MDH Mods") then
				{
					{
						if (_x#1 == _t) exitWith {_c = false}
					} forEach (player allDiaryRecords "MDH Mods");
				}
				else
				{
					player createDiarySubject ["MDH Mods","MDH Mods"];
				};
		
				if(_c) then
				{
					mdhReviveModBriefingFnc =
					{
						if (isServer OR serverCommandAvailable "#logout") then
						{
							missionNameSpace setVariable[_this#0,_this#1,true];
							systemChat (_this#2);
							if ((_this#0) == "bis_revive_Bleedoutduration") then
							{
								missionNameSpace setVariable["pMdhReviveBleedoutTime",_this#1,true];
							};
						}
						else
						{
							systemChat "ONLY ADMIN CAN CHANGE OPTION";
						};
					};

					player createDiaryRecord
					[
						"MDH Mods",
						[
							_t,
							(
							  '<br/>MDH Revive is a script, created by Moerderhoschi for Arma 3.<br/>'
							+ '<br/>'
							+ 'Features:<br/>'
							+ '- You can revive unconscious players while laying on the ground.<br/>'
							+ '- You can drag other players while they unconscious.<br/>'
							+ '- You have a Spectatorcamera while unconscious.<br/>'
							+ '- You are immortal while on the ground and unconscious.<br/>'
							+ '- Autorevive option is available (default 4 min).<br/>'
							+ '- Bleedout option is available (default deact).<br/>'
							+ '- Spectatorcamera option is available (default units side player).<br/>'
							+ '<br/>'
							+ 'set Autorevive: '
							+    '<font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',120,''MDH Revive Autorevive set 2 min''] call mdhReviveModBriefingFnc">2 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',180,''MDH Revive Autorevive set 3 min''] call mdhReviveModBriefingFnc">3 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',240,''MDH Revive Autorevive set 4 min''] call mdhReviveModBriefingFnc">4 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',300,''MDH Revive Autorevive set 5 min''] call mdhReviveModBriefingFnc">5 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',360,''MDH Revive Autorevive set 6 min''] call mdhReviveModBriefingFnc">6 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',600,''MDH Revive Autorevive set 10 min''] call mdhReviveModBriefingFnc">10 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''mdhReviveAutoReviveTime'',4^9,''MDH Revive Autorevive deactivated''] call mdhReviveModBriefingFnc">deact</execute></font color>'
							+ '<br/>'
							+ 'set BleedoutTime: '
							+    '<font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',120,''MDH Revive BleedoutTime set 2 min''] call mdhReviveModBriefingFnc">2 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',180,''MDH Revive BleedoutTime set 3 min''] call mdhReviveModBriefingFnc">3 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',240,''MDH Revive BleedoutTime set 4 min''] call mdhReviveModBriefingFnc">4 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',300,''MDH Revive BleedoutTime set 5 min''] call mdhReviveModBriefingFnc">5 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',360,''MDH Revive BleedoutTime set 6 min''] call mdhReviveModBriefingFnc">6 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',600,''MDH Revive BleedoutTime set 10 min''] call mdhReviveModBriefingFnc">10 min</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''bis_revive_Bleedoutduration'',4^9,''MDH Revive BleedoutTime deactivated''] call mdhReviveModBriefingFnc">deact</execute></font color>'
							+ '<br/>'
							+ 'set Spectator: '
							+    '<font color="#33CC33"><execute expression = "[''pMdhReviveSpectator'',1,''MDH Revive Spectatorcamera set units side player''] call mdhReviveModBriefingFnc">units side player</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''pMdhReviveSpectator'',2,''MDH Revive Spectatorcamera set all units''] call mdhReviveModBriefingFnc">all units</execute></font color>'
							+ ' / <font color="#33CC33"><execute expression = "[''pMdhReviveSpectator'',0,''MDH Revive Spectatorcamera deactivated''] call mdhReviveModBriefingFnc">deact</execute></font color>'
							+ '<br/>'
							+ '<br/>'
							+ 'If you have any question you can contact me at the steam workshop page.<br/>'
							+ '<br/>'
							+ 'Credits and Thanks:<br/>'
							+ 'Armed-Assault.de Crew - For many great ArmA moments in many years<br/>'
							+ 'BIS - For ArmA3<br/>'
							)
						]
					]
				};
				true
			};
		};

		if (hasInterface) then
		{
			uiSleep 0.3;
			call _diary;
		};

		mdhReviveAutoReviveTime = missionNameSpace getVariable["pMdhReviveAutoReviveTime", 240];
		sleep (1 + random 1);
		bis_reviveParam_mode = 1;
		bis_revive_unconsciousStateMode = 0;
		_p = missionNameSpace getVariable ["pMdhRevive",99];
		sleep 0.5;
		if (hasInterface) then {call BIS_fnc_reviveInit};
		sleep 1;
		bis_revive_duration = 5;
		bis_revive_durationmedic = 2;
		bis_revive_medicspeedmultiplier = 3;
		bis_revive_bleedoutduration = missionNameSpace getVariable["pMdhReviveBleedoutTime", 4^9];
		if (_p == 2) exitWith {bis_revive_bleedoutduration = 300};
		if (hasInterface) then 
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
			_diaryTimer = 10;
			while{sleep 0.01; missionNameSpace getVariable ["pMdhRevive",99] == 99}do
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
									("<t color='#00FF00'>Revive "+(name _x)+"</t>"),
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
									"lifeState _target == ""INCAPACITATED"" 
									&& {player distance _target < 3.2}
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
								] call mdhHoldActionAdd;
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
								[
									_x,
									("<t color='#FF8200'>Drag "+(name _x)+" </t>"),
									"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
									"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
									"lifeState _target == ""INCAPACITATED""
									&& {vehicle player == player}
									&& {player distance _target < 3}
									&& {!(_target getVariable [""mdhReviveDraged"",false])}
									&& {time > _target getVariable [""mdhReviveDragEnableTime"",time + 5]}
									&& {_target in allPlayers}
									",
									"true",
									{},
									{},
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
									}
									,{}
									,[]
									,1     // Action duration in seconds
									,98    // Priority
									,false // Remove on completion
									,false // Show in unconscious state
								] call mdhHoldActionAdd;
							};
						};
					} forEach allPlayers;

					_f = (actionIDs player findIf { "Stop Drag" in (player actionParams _x select 0) }) != -1;
					if (!_f) then
					{
						[
							player,
							("<t color='#FF8200'>Stop Drag</t>"),
							"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
							"a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_ca.paa",
							"vehicle player == player && {player getVariable [""mdhReviveDragging"",false]} && {{_x isKindOf ""man""} count attachedObjects player > 0}",
							"true",
							{},
							{},
							{
								{if(_x isKindOf "man")then{detach _x;_x setVariable ["mdhReviveDraged",false,true]}}forEach attachedObjects player;
								player setVariable ["mdhReviveDragging",false,true];
								for "_i" from 1 to 4 do
								{
									if (animationState player in["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb","acinpknlmstpsnonwpstdnon","acinpknlmwlksnonwpstdb"]) then {player switchMove ""};
									sleep 0.5;
								};
							}
							,{}
							,[]
							,1     // Action duration in seconds
							,97    // Priority
							,false // Remove on completion
							,false // Show in unconscious state
						] call mdhHoldActionAdd;														
					};
	
					if (player getVariable ["mdhRevivePlayerName",""] == "") then {player setVariable ["mdhRevivePlayerName",name player,true]};
					if (time > _diaryTimer) then {call _diary; _diaryTimer = time + 10};
					call _mdhDragging;
	
					lifeState player == "INCAPACITATED"
				};
				player allowDamage false;
				player setVariable["mdhReviveDragEnableTime",time + 5,true];
				_endTime = time + 3 + mdhReviveAutoReviveTime;
				_side = player getVariable ["mdhRevivePlayerSide",west];
				if (missionNameSpace getVariable["pMdhReviveSpectator", 1] > 0) then
				{
					if (missionNameSpace getVariable["pMdhReviveSpectator", 2] == 2 OR name player == "Moerderhoschi") then
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
					if (time > _diaryTimer) then {call _diary; _diaryTimer = time + 10};
	
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
				player setUnconscious false;
				sleep 0.2;
				player allowDamage true;
			};
		};
	};
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// MDH HOLD ACTION ADD FUNCTION(by Moerderhoschi with massive help of GenCoder8) - v2025-03-27
// fixed version of BIS_fnc_holdActionAdd
///////////////////////////////////////////////////////////////////////////////////////////////////////////
if (hasInterface) then
{
	GenCoder8_fixHoldActTimer =
	{
		params["_title","_iconIdle","_hint"];
		private _frameProgress = "frameprog";
		if(time > (missionNamespace getVariable [_frameProgress,-1])) then
		{
			missionNamespace setVariable [_frameProgress,time + 0.065];
			bis_fnc_holdAction_animationIdleFrame = (bis_fnc_holdAction_animationIdleFrame + 1) % 12;
		};
		private _var = "bis_fnc_holdAction_animationIdleTime_" + (str _target) + "_" + (str _actionID);
		if (time > (missionNamespace getVariable [_var,-1]) && {_eval}) then
		{
			missionNamespace setVariable [_var, time + 0.065];
			if (!bis_fnc_holdAction_running) then
			{
				[_originalTarget,_actionID,_title,_iconIdle,bis_fnc_holdAction_texturesIdle,bis_fnc_holdAction_animationIdleFrame,_hint] call bis_fnc_holdAction_showIcon;
			};
		};
	};

	_origFNC = preprocessFileLineNumbers "a3\functions_f\HoldActions\fn_holdActionAdd.sqf";
	_newFNC = ([_origFNC, "bis_fnc_holdAction_animationTimerCode", true] call BIS_fnc_splitString)#0;
	_newFNC = _newFNC + "GenCoder8_fixHoldActTimer";
	_newFNC = _newFNC + ([_origFNC, "bis_fnc_holdAction_animationTimerCode", true] call BIS_fnc_splitString)#1;
	_newFNC = _newFNC + "GenCoder8_fixHoldActTimer";
	_newFNC = _newFNC + ([_origFNC, "bis_fnc_holdAction_animationTimerCode", true] call BIS_fnc_splitString)#2;
	mdhHoldActionAdd = compile _newFNC;
};