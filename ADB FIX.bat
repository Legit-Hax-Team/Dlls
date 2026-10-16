@echo off
title 
echo ==============================================
echo 
echo ==============================================
echo 1. Terminating Emulator Background Tasks
echo ==============================================

:: Force kill BlueStacks and MSI background processes so they don't overwrite the config
taskkill /F /IM HD-Player.exe /T >nul 2>&1
taskkill /F /IM HD-Agent.exe /T >nul 2>&1
taskkill /F /IM HD-MultiInstanceManager.exe /T >nul 2>&1
taskkill /F /IM BstkSVC.exe /T >nul 2>&1
echo Background tasks terminated.

echo.
echo ==============================================
echo 2. Forcing Port 5555 in Config
echo ==============================================

set "CONF_PATH=C:\ProgramData\BlueStacks_nxt\bluestacks.conf"

if not exist "%CONF_PATH%" (
    set "CONF_PATH=C:\ProgramData\MSI App Player\bluestacks.conf"
)

if exist "%CONF_PATH%" (
    echo Editing config at: %CONF_PATH%
    
    :: Overwrite any existing port number with 5555
    powershell -Command "(Get-Content '%CONF_PATH%') -replace 'adb_port=`"[0-9]+`"', 'adb_port=`"5555`"' | Set-Content '%CONF_PATH%'"
    
    echo.
    echo Port successfully locked to 5555! You can now start the emulator.
) else (
    echo ERROR: Config file not found.
)

echo.
pause