@echo off

@REM FITm Starter
@REM version:   0.0.1
@REM date:      2022-04-07
@REM author:    johnny-appleseed
@REM email:     liuzhaohui@inspur.com

setlocal enableExtensions disableDelayedExpansion

set "batchname=%~nx0"
set "batchfolder=%~dp0"
if "%batchfolder:~-1%" == "\" set "batchfolder=%batchfolder:~0,-1%"
net session 1>nul 2>&1 || goto UacPrompt
set "fitm=%*"
if not defined fitm set "fitm=P:\eaglestream\Intel\EagleStreamRpPkg\Tool\FTool\SPS\Tools\Flash_Image_Tool\FITm_GUI_and_CLI_Version\Fitm.exe"
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
