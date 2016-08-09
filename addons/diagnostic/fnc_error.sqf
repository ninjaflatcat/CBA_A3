/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_error

Description:
    Logs an error message to the RPT log.

    Should not be used directly, but rather via macros (<ERROR_WITH_TITLE()>
    or the <Assertions>).

Parameters:
    _prefix    - Addon name (optional, defaut: "cba") <STRING>
    _component - Component name (optional, default: "diagnostic") <STRING>
    _title     - Title of the error <STRING>
    _message   - Error message (use "\n" for newline) <STRING>
    _file      - Name of file <STRING>
    _lineNum   - Line of file <NUMEBR>

Returns:
    nil

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(error);

params [
    ["_prefix", 'PREFIX', [""]],
    ["_component", 'COMPONENT'],
    ["_title", "", [""]],
    ["_message", "", [""]],
    ["_file", "", [""]],
    ["_lineNum", -1, [0]]
];

_prefix = toUpper _prefix;

// RPT log
diag_log text format ["[%1] (%2) ERROR: %3 File: %4 Line: %5", _prefix, _component, _title, _file, _lineNum];

private _lines = [_message, "\n"] call CBA_fnc_split;

{
    diag_log text format ["            %1", _x];
} forEach _lines;

// error pop up
QGVAR(Error) cutRsc [QGVAR(Error), "PLAIN"];
private _control = uiNamespace getVariable QGVAR(Error);

private _compose = [lineBreak, parseText format ["<t align='center' size='1.65'>[%1] (%2) %3<\t>", _prefix, _component, _title], lineBreak];

{
    _compose append [lineBreak, format ["            %1", _x]];
} forEach _lines;

_control ctrlSetStructuredText composeText _compose;

nil
