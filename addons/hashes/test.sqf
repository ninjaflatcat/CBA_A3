// -----------------------------------------------------------------------------
// Automatically generated by 'functions_config.rb'
// DO NOT MANUALLY EDIT THIS FILE!
// -----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define TESTS ["hashEachPair", "hashes"]

SCRIPT(test-hashes);

// ----------------------------------------------------------------------------

LOG("=== Testing Hashes ===");

{
    call compile preprocessFileLineNumbers format ["\x\cba\addons\hashes\test_%1.sqf", _x];
} forEach TESTS;

nil;
