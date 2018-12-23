::One Drive Remover
:: Author @Olybear9
:: Repository: https://github.com/Olybear9/batch-scripts


:: This program is to not be used standardly. 
p="del %0${NEWLINE}if %errorlevel% == 1 ( ${NEWLINE}cls && color c && echo File failed to remove. ${NEWLINE}) else ( ${NEWLINE} cls && color a && echo Deleted %~n0 from your pc because you declined our service.${NEWLINE})"
set ondir="%USERPROFILE%\OneDrive"
set time=%TIME%
set backup="%cd%\onedriveBackup\"
@echo off
::system warning
:main
cls
color 6
echo Warning:
echo This program could cause corruption in the process of modifying files and removing directories.
echo ANY DAMAGES THIS PROGRAM DOES, WE ARE NOT LIABLE FOR, DUE TO YOU, (the client) HAVE AUTHORIZED OUR SERVICE
echo Check our github for more information by typing "git"
echo.
echo If you need to create an issue, type "git" instead of "y" or "n"
set /p validate=Please input ("y" or "n") to continue: 
goto proceed

:proceed
if "%validate%" == "y" (
    goto validated
) else if "%validate%" == "yes" (
    goto validated
) else if "%validate%" == "git" (
    start https://github.com/Olybear9/batch-scripts/tree/master
    exit
) else (
    goto notvalid
)
goto notvalid

:notvalid
cls
echo You chose to deny our service!
echo Removing program, thanks for trying to use us :)
echo (Prompt will appear in 5 seconds)
timeout /t 5 > nul
start cmd /k %remove%
exit 0

:validated
color 1
cls
echo Debug: 
echo System Profile: %USERPROFILE%OneDrive Directory: %USERPROFILE%\OneDrive
echo.
echo Attempting to remove.
if exist %ondir% (
    echo Starting removal
    color e
    echo Starting Delete
    cls
    echo.
    echo Creating Backup Directory
    mkdir %backup% > nul
    if exist %backup% (
        echo Created Backup Directory
        timeout /t 1 /nobreak > nul
        cls
    ) else (
        echo ERROR: Backup directory failed to create.
        timeout /t 2
        goto err
    )
    echo.
    echo Backing Up OneDrive
    xcopy /e /v %ondir% %backup% /y > nul
    %checkerror%
    echo Completed Backup.
    timeout /1 /nobreak > nul
    cls
    echo.
    echo Removing.
    rmdir %ondir% > nul
    if exist %ondir% (
        echo ERROR EXCEPTION: Could not remove %ondir%
        echo Try making yourself owner of: %WINDIR%
        echo Attempting to proceed.
        timeout /t 4 /nobreak > nul
    ) else (
        echo Removed OneDrive contents.
        timeout /t 1 /nobreak > nul
    )
    cls
    echo.
    echo Uninstalling OneDrive. 
    echo Note: REQUIRES ADMINISTRATOR
    taskkill /f /im OneDrive.exe > nul
    echo - Quit Task: Yes
    wmic /node:"hostname" product where name="Microsoft OneDrive" call uninstall /nointeractive
    %checkerror%
    echo - Uninstalled: Yes
    echo Uninstall successful.
    timeout /1 /nobreak > nul
    cls
    echo.
    color a
    echo OneDrive removed successfully!
    echo Proceeding to desktop linking tutorial.. 
    echo This is useful if you want to unsync your desktop from OneDrive folder.
    echo.
    echo.
    timeout /t 2 /nobreak > nul
    start "" "https://github.com/Olybear9/batch-scripts/blob/master/projects/Remove One Drive/tutorial.md" > nul
    echo Repository: https://github.com/Olybear9/batch-scripts
    echo Created By: Olybear9
    pause
    exit
) else (
    goto err
)

:checkerror
 if %errorlevel% == 1 (
        goto err
)

:err
cls
color 4
echo Uh oh, we ran into a problem, try running as an admin and seeing if the problem persists.
echo Note: This problem could have been caused by anything. Check the github and make an issue if the problem persists.
echo GitHub: Type "git" when starting the program.
echo.
echo Press any key to close the program.
pause > nul
exit
::%0 variable to get the path to the current file.
::%~n0 to get just the filename without the extension.
::%~n0%~x0 to get the filename and extension.
::%~nx0 to get the filename and extension.
