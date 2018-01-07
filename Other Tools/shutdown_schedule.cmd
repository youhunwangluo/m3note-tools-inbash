@echo off
mode con cols=40 lines=10&color 0a
title SHUTDOWN

:time
if %time:~0,2% lss 22 (goto end)

date /t | find "一" && goto weekday
date /t | find "二" && goto weekday
date /t | find "三" && goto weekday
date /t | find "四" && goto weekday
date /t | find "日" && goto weekday
date /t | find "五" && goto weekday
date /t | find "六" && goto weekday

:weekday
echo [WEEKDAY] SHUTDOWN AT 11:00PM
shutdown -s -t 600
goto choice

:weekend
echo [WEEKEND] SHUTDOWN AT 00:00AM
shutdown -s -t 3600

:choice
set /p action=INPUT NUM 0 TO CANCEL:
if /i "%action%"=="0" goto cancel
goto end

:cancel
shutdown -a

:end
echo EXITING...
ping -n 10 127.0>nul
exit