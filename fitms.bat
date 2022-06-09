@echo off

@REM FITm Starter
@REM version:   0.0.2
@REM date:      2022-04-13
@REM author:    johnny-appleseed
@REM email:     liuzhaohui@inspur.com

setlocal enableExtensions disableDelayedExpansion

@REM Set below variable to the path to your FITm
if not defined defaultFitmPath set "defaultFitmPath=P:\eaglestream\Intel\EagleStreamRpPkg\Tool\FTool\SPS\Tools\Flash_Image_Tool\FITm_GUI_and_CLI_Version\Fitm.exe"

set "batchname=%~nx0"
set "batchfolder=%~dp0"
if "%batchfolder:~-1%" == "\" (
    set "batchfolder=%batchfolder:~0,-1%"
)
set "fitm=%*"
if defined fitm (
    set "fitm=%fitm:"=%"
) else (
    set "fitm=%defaultFitmPath%"
)
if not exist "%fitm%" (
    >&2 echo error: could not find "%fitm%"
    pause
    exit /b
)
net session 1>nul 2>&1 || goto UacPrompt
netsh interface set interface Ethernet disabled
explorer "%fitm%"
ping localhost -n 5 >nul
netsh interface set interface Ethernet enabled
exit /b

:UacPrompt
@echo;
@echo     Requesting Administrative Privileges...
@echo     Press YES in UAC Prompt to Continue
@echo;
>"%TEMP%\UacPrompt.vbs" (
echo Set UAC = CreateObject^("Shell.Application"^)
echo arg = "%~1"
echo UAC.ShellExecute "%batchname%", arg, "%batchfolder%", "runas", 1
)
cscript //nologo "%TEMP%\UacPrompt.vbs"
del /f "%TEMP%\UacPrompt.vbs"
exit /b
