@echo off
setlocal enabledelayedexpansion

if not exist NMake.nmake (
    echo Error: NMake.nmake not found!
    exit /b 1
)

:: Read the file line by line and set variables
for /f "tokens=1,2 delims==" %%A in (NMake.nmake) do (
    set %%A=%%B
)

echo Building %OUTPUT% with %COMPILER%...
if not exist build mkdir build

%COMPILER% %STANDARD% %FILES% -o %OUTPUT%

if %errorlevel% equ 0 (
    echo Done!
) else (
    echo Build failed.
)
