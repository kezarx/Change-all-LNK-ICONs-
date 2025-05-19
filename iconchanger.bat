@echo off
REM -- This changes all desktop shortcuts to use the Internet Explorer icon (for educational purposes only!)
set "IE_ICON=%%SystemRoot%%\System32\ieframe.dll,1"

REM -- Target both user and public desktops (if applicable)
for %%D in ("%USERPROFILE%\Desktop", "%PUBLIC%\Desktop") do (
    if exist "%%~D" (
        echo Targeting desktop: %%~D
        for %%F in ("%%~D\*.lnk") do (
            echo Modifying: %%~nxF
            call :ChangeIcon "%%~F"
        )
    )
)
echo Done! All shortcuts now use the IE icon.
pause
exit /b

:ChangeIcon
set "LNK_FILE=%~1"
REM -- Use PowerShell to force icon change
powershell -noprofile -command "$sh = New-Object -ComObject WScript.Shell; $lnk = $sh.CreateShortcut('%LNK_FILE%'); $lnk.IconLocation = '%IE_ICON%'; $lnk.Save();"
exit /b
