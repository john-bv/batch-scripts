:: Cache Clearer
:: Author @Olybear9
:: Repository: https://github.com/Olybear9/batch-scripts


:: This program is to not be used standardly. 
p="del %0${NEWLINE}if %errorlevel% == 1 ( ${NEWLINE}cls && color c && echo File failed to remove. ${NEWLINE}) else ( ${NEWLINE} cls && color a && echo Deleted %~n0 from your pc because you declined our service.${NEWLINE})"
set sftdir="%windir%\SoftwareDistribution\Download"
set tmpdir="%temp%"
set winold="%windir%../Windows.old"
set wintmp="%windir%\Temp"
set /a amount=0
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
echo If you need to create an issue, type git instead of y or n
set /p validate=Please input [y/n] to continue: 
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
echo (Prompt will appear in 5 seconds)
timeout /t 5
exit 0

:validated
cls
color f
echo Testing...
echo Performing system ADMINISTRATOR test.
net.exe session 1>NUL 2>NUL || (
    echo Test failed.
    cls
    echo This script requires elevated rights. 
    timeout /t 5
    exit
)
echo Performing system compatibility test.
setlocal
::for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i
::if "%version%" == "10.0" (
::     echo Windows 10
::     echo Test Passed.
::if "%version%" == "6.3" (
::     echo Windows 8.1
::     echo Test Passed.
::) 
::if "%version%" == "6.2" (
::     echo Windows 8.
::     echo Test Passed.
::)
::if "%version%" == "6.1" (
::     echo Windows 7.
::     echo Test Failed.
::     timeout /t 3
::     goto err
::)
::if "%version%" == "6.0" (
::     echo Windows Vista.
::     echo Test Failed.
::     timeout /t 3
::     goto err
::) else (
::    echo Error: Unknown version
::    echo Ignoring error..
::)
echo Compatibility disabled due to errors
rem etc etc
endlocal
echo.
echo Tests completed sucessfully.
timeout /t 2 /nobreak > nul
cls
title Configuring Cache Clear
set /p rmwin=Would you like to remove old windows? [y/n] 
set /p rmsftdir=Would you like to remove windows update cache? [y/n] 
set /p rmauto=Would you like to remove program history? (OWNER OF CDRIVE IS REQUIRED) [y/n] 
echo Press any key to continue.
pause > nul
cls
echo Attempting to clear Windows Update cache.
if "%rmsftdir%" == "y" (
    del /q %sftdir%\*
    for /d %%x in (%sftdir%\*) do @rd /s /q ^"%%x^"
    if %errorlevel% == 1 (
        echo Windows Update cache failed to delete.
    ) else (
        set /A amount=amount+1
        echo Windows Update cache cleared sucessfully.
    )
) else if "%rmsftdir%" == "yes" (
    del /q %sftdir%\*
    for /d %%x in (%sftdir%\*) do @rd /s /q ^"%%x^"
    if %errorlevel% == 1 (
        echo Windows Update cache failed to delete.
    ) else (
        set /A amount=amount+1
        echo Windows Update cache cleared sucessfully.
    )
) else (
    echo User chose to decline removal of windows update cache.
)
timeout /t 3 > nul
echo.
echo Attempting to delete old windows [if any]
if "%rmwin%" == "y" (
    if exist %winold% (
        rmdir /s /q %winold%
        if %errorlevel% == 1 (
            echo Windows old cache failed to delete.
        ) else (
            set /A amount=amount+1
            echo Windows old cache cleared sucessfully.
        )
    ) else (
        echo Old Windows could not be deleted because it doesn't exist
    )
) else if "%rmwin%" == "yes" (
    if exist %winold% (
        rmdir /s /q %winold%
        if %errorlevel% == 1 (
            echo Windows old cache failed to delete.
        ) else (
            set /A amount=amount+1
            echo Windows old cache cleared sucessfully.
        )
    ) else (
        echo Old Windows could not be deleted because it doesn't exist
    )
) else (
    echo User chose to decline removal of windows old.
)
timeout /t 3 > nul
echo.
echo Attempting to clear Temporary Storage.
del /q %tmpdir%\*
for /d %%x in (%tmpdir%\*) do @rd /s /q ^"%%x^"
if %errorlevel% == 1 (
    echo Temporary storage failed to delete.
) else (
    set /A amount=amount+1
    echo Temporary storage deleted sucessfully.
)
timeout /t 3 > nul
echo.
echo Attempting to clear Windows Temporary Storage.
del /q %wintmp%\*
for /d %%x in (%wintmp%\*) do @rd /s /q ^"%%x^"
if %errorlevel% == 1 (
    echo Temporary storage failed to delete.
    
) else (
    set /A amount=amount+1
    echo Temporary storage deleted sucessfully.
)

if "%rmauto%" == "y" (
    del /q %windir%\Prefetch\*
    if %errorlevel% == 1 (
        echo Program history removal failed.
    ) else (
        set /A amount=amount+1
        echo Program history removed successfully.
    )
) else if "%rmsftdir%" == "yes" (
    del /q %windir%\Prefetch\*
    if %errorlevel% == 1 (
        echo Program history removal failed.
    ) else (
        set /A amount=amount+1
        echo Program history removed successfully.
    )
) else (
    echo User chose to decline removal of program history cache.
)
timeout /t 3 > nul
echo.
echo Flushing DNS...
ipconfig/flushDNS > nul
echo.
echo Cleared %amount% of 5 cache areas!
echo Proceeding in 3 seconds.
timeout /t 3 > nul
cls
color a 
echo Want more? There's a bunch more of these programs on our github!
echo Repository: https://github.com/Olybear9/batch-scripts
echo Created By: Olybear9
echo.
echo Press any key to exit.
pause > nul
exit

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
