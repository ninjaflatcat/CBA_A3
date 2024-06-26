#include "script_component.hpp"
SCRIPT(test_inventory);

// execVM "\x\cba\addons\common\test_inventory.sqf";

// Note: test requires a player with space in inventory

private ["_funcName", "_result"];

_funcName = "CBA_fnc_addWeapon";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_addWeapon","");

_result = [objNull, "Binocular"] call CBA_fnc_addWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_addWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, "Binocular"] call CBA_fnc_addWeapon;
TEST_TRUE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_removeWeapon";
LOG("Testing " + _funcName);

_result = [objNull, "Binocular"] call CBA_fnc_removeWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_removeWeapon;
TEST_FALSE(_result,_funcName);

_result = [player, "Binocular"] call CBA_fnc_removeWeapon;
TEST_TRUE(_result,_funcName);

_result = [player, "Binocular"] call CBA_fnc_removeWeapon;
TEST_FALSE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_addMagazine";
LOG("Testing " + _funcName);

TEST_DEFINED("CBA_fnc_addMagazine","");

_result = [objNull, "30Rnd_556x45_Stanag"] call CBA_fnc_addMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_addMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, "30Rnd_556x45_Stanag"] call CBA_fnc_addMagazine;
TEST_TRUE(_result,_funcName);

_result = [player, "30Rnd_556x45_Stanag", 1, true] call CBA_fnc_addMagazine;
TEST_TRUE(_result,_funcName);

_result = [player, "30Rnd_556x45_Stanag", 1, true] call CBA_fnc_addMagazine;
TEST_TRUE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

_funcName = "CBA_fnc_removeMagazine";
LOG("Testing " + _funcName);

_result = [objNull, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, ""] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [player, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_TRUE(_result,_funcName);

_result = [player, "30Rnd_556x45_Stanag", 1] call CBA_fnc_removeMagazine;
TEST_TRUE(_result,_funcName);

player removeMagazines "30Rnd_556x45_Stanag";

_result = [player, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

////////////////////////////////////////////////////////////////////////////////////////////////////

private _container = createVehicle ["B_supplyCrate_F", player, [], 10, "NONE"];
clearBackpackCargoGlobal _container;
clearItemCargoGlobal _container;
clearMagazineCargoGlobal _container;
clearWeaponCargoGlobal _container;


_funcName = "CBA_fnc_removeBackpackCargo";
LOG("Testing " + _funcName);

_result = [objNull, "SmokeShell"] call CBA_fnc_removeBackpackCargo;
TEST_FALSE(_result,_funcName);

_container addBackpackCargoGlobal ["B_AssaultPack_mcamo", 5];
_result = [_container, "B_AssaultPack_mcamo", 3] call CBA_fnc_removeBackpackCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (backpackCargo _container) == 2,_funcName);
clearBackpackCargoGlobal _container;

_container addBackpackCargoGlobal ["B_AssaultPack_mcamo_Ammo", 1];
_result = [_container, "B_AssaultPack_mcamo_Ammo", 1, true] call CBA_fnc_removeBackpackCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (backpackCargo _container) == 0 && count (itemCargo _container) == 4 && count (magazineCargo _container) == 20,_funcName);
clearBackpackCargoGlobal _container;
clearItemCargoGlobal _container;
clearMagazineCargoGlobal _container;

_container addBackpackCargoGlobal ["B_AssaultPack_mcamo", 1];
((everyBackpack _container) select 0) addWeaponCargoGlobal ["arifle_MX_ACO_pointer_F", 1];
_result = [_container, "B_AssaultPack_mcamo", 1] call CBA_fnc_removeBackpackCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (backpackCargo _container) == 0 && count (weaponCargo _container) == 0 && count (itemCargo _container) == 0,_funcName);
clearBackpackCargoGlobal _container;
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;

_container addBackpackCargoGlobal ["B_AssaultPack_mcamo", 1];
((everyBackpack _container) select 0) addWeaponCargoGlobal ["arifle_MX_ACO_pointer_F", 1];
_result = [_container, "B_AssaultPack_mcamo", 1, true] call CBA_fnc_removeBackpackCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (backpackCargo _container) == 0 && count (weaponCargo _container) == 1 && count (itemCargo _container) == 0,_funcName);
clearBackpackCargoGlobal _container;
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;

_container addBackpackCargoGlobal ["B_AssaultPack_mcamo", 1];
((everyBackpack _container) select 0) addWeaponCargoGlobal ["arifle_MX_SW_F", 1]; // arifle_MX_SW_F has no non-preset parent class
_result = [_container, "B_AssaultPack_mcamo", 1, true] call CBA_fnc_removeBackpackCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (backpackCargo _container) == 0 && count (weaponCargo _container) == 1,_funcName);
clearBackpackCargoGlobal _container;
clearWeaponCargoGlobal _container;


_funcName = "CBA_fnc_removeItemCargo";
LOG("Testing " + _funcName);

_result = [objNull, "SmokeShell"] call CBA_fnc_removeItemCargo;
TEST_FALSE(_result,_funcName);

_container addItemCargoGlobal ["FirstAidKit", 5];
_result = [_container, "FirstAidKit", 3] call CBA_fnc_removeItemCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (itemCargo _container) == 2,_funcName);
clearItemCargoGlobal _container;

_container addItemCargoGlobal ["V_PlateCarrier1_rgr", 5];
_result = [_container, "V_PlateCarrier1_rgr", 1] call CBA_fnc_removeItemCargo;
TEST_TRUE(count (itemCargo _container) == 4,_funcName);
clearItemCargoGlobal _container;

_container addItemCargoGlobal ["V_PlateCarrier1_rgr", 1];
(((everyContainer _container) select 0) select 1) addItemCargoGlobal ["FirstAidKit", 5];
_container addItemCargoGlobal ["FirstAidKit", 5];
_result = [_container, "FirstAidKit", 5] call CBA_fnc_removeItemCargo;
TEST_TRUE(count (itemCargo _container) == 1 && count (itemCargo (((everyContainer _container) select 0) select 1)) == 5,_funcName);
clearItemCargoGlobal _container;

_container addItemCargoGlobal ["V_PlateCarrier1_rgr", 1];
(((everyContainer _container) select 0) select 1) addItemCargoGlobal ["FirstAidKit", 5];
_result = [_container, "V_PlateCarrier1_rgr", 1, true] call CBA_fnc_removeItemCargo;
TEST_TRUE(count (itemCargo _container) == 5,_funcName);
clearItemCargoGlobal _container;


_funcName = "CBA_fnc_removeMagazine";
LOG("Testing " + _funcName);

_result = [objNull, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [_container, ""] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_container addMagazineAmmoCargo ["30Rnd_556x45_Stanag", 2, 1];

_result = [_container, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_TRUE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 2] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 1] call CBA_fnc_removeMagazine;
TEST_TRUE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazine;
TEST_FALSE(_result,_funcName);


_funcName = "CBA_fnc_addMagazineCargo";
LOG("Testing " + _funcName);

_result = [objNull, "30Rnd_556x45_Stanag"] call CBA_fnc_addMagazineCargo;
TEST_FALSE(_result,_funcName);

_result = [_container, ""] call CBA_fnc_addMagazineCargo;
TEST_FALSE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 5] call CBA_fnc_addMagazineCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (magazineCargo _container) == 5,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 10, false, 1] call CBA_fnc_addMagazineCargo;
TEST_TRUE(_result,_funcName);


_funcName = "CBA_fnc_removeMagazineCargo";
LOG("Testing " + _funcName);

_result = [objNull, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazineCargo;
TEST_FALSE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazineCargo;
TEST_TRUE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 2] call CBA_fnc_removeMagazineCargo;
TEST_TRUE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 1, 2] call CBA_fnc_removeMagazineCargo;
TEST_FALSE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 2, 1] call CBA_fnc_removeMagazineCargo;
TEST_TRUE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag", 10] call CBA_fnc_removeMagazineCargo;
TEST_TRUE(_result,_funcName);

_result = [_container, "30Rnd_556x45_Stanag"] call CBA_fnc_removeMagazineCargo;
TEST_FALSE(_result,_funcName);

// No mags of "30Rnd_556x45_Stanag" left at this point
_container addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 5];
_result = [_container, "30Rnd_556x45_Stanag", 3] call CBA_fnc_removeMagazineCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (magazineCargo _container) == 2,_funcName);
clearMagazineCargoGlobal _container;


_funcName = "CBA_fnc_removeWeaponCargo";
LOG("Testing " + _funcName);

_result = [objNull, "SmokeShell"] call CBA_fnc_removeWeaponCargo;
TEST_FALSE(_result,_funcName);

_container addWeaponCargoGlobal ["srifle_EBR_F", 5];
_result = [_container, "srifle_EBR_F", 3] call CBA_fnc_removeWeaponCargo;
TEST_TRUE(_result,_funcName);
TEST_TRUE(count (weaponCargo _container) == 2 && count (itemCargo _container) == 0,_funcName);
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;

_container addWeaponCargoGlobal ["arifle_MX_ACO_pointer_F", 1];
_result = [_container, "arifle_MX_F"] call CBA_fnc_removeWeaponCargo;
TEST_TRUE(count (weaponCargo _container) == 0 && count (itemCargo _container) == 0,_funcName);
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;

_container addWeaponCargoGlobal ["arifle_MX_ACO_pointer_F", 1];
_result = [_container, "arifle_MX_F", 1, true] call CBA_fnc_removeWeaponCargo;
TEST_TRUE(count (weaponCargo _container) == 0 && count (itemCargo _container) == 2,_funcName);
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;

_container addWeaponCargoGlobal ["arifle_MX_SW_F", 1]; // arifle_MX_SW_F has no non-preset parent class
_result = [_container, "arifle_MX_SW_F", 1, true] call CBA_fnc_removeWeaponCargo;
TEST_TRUE(count (weaponCargo _container) == 0 && count (itemCargo _container) == 1,_funcName);
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;

_container addWeaponCargoGlobal ["arifle_MX_ACO_pointer_F", 1];
_container addWeaponCargoGlobal ["arifle_MX_SW_F", 1]; // arifle_MX_SW_F has no non-preset parent class
_result = [_container, "arifle_MX_ACO_pointer_F", 1] call CBA_fnc_removeWeaponCargo;
TEST_TRUE(count (weaponCargo _container) == 1 && count (itemCargo _container) == 0,_funcName);
clearWeaponCargoGlobal _container;
clearItemCargoGlobal _container;


deleteVehicle _container;
