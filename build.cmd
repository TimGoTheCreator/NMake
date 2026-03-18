@echo off
setlocal enabledelayedexpansion

if not exist NMake.nmake (
    echo Error: NMake.nmake not found!
    exit /b 1
)

:: Set Defaults
set "COMPILER=g++"
set "STANDARD=-std=c++20"
set "FILES="

for /f "usebackq tokens=1* delims==" %%A in ("NMake.nmake") do (
    set "key=%%A"
    set "val=%%B"
    
    :: Clean the key (remove spaces)
    set "key=!key: =!"

    if /i "!key!"=="COMPILER" (
        set "COMPILER=!val: =!"
    ) else if /i "!key!"=="STANDARD" (
        set "STANDARD=!val: =!"
    ) else if /i "!key!"=="FILES" (
        set "temp=!val!"
        set "temp=!temp:{=!"
        set "temp=!temp:}=!"
        set "FILES=!temp:,=!"
    ) else if /i "!key!"=="OUTPUT" (
        set "OUT=!val: =!"
        echo [BUILD] Generating !OUT!...
        for %%I in (!OUT!) do if not exist "%%~dpI" mkdir "%%~dpI"
        
        !COMPILER! !STANDARD! !FILES! -o !OUT!
        
        if !errorlevel! equ 0 (echo Success.) else (echo Build Failed.)
    ) else if /i "!key!"=="RUN" (
        :: Execute immediately
        echo [EXEC] !val!
        !val!
    )
)
