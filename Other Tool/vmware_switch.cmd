@echo off
mode con cols=50 lines=20&color 0a
title VMWARE
:begin
cls
Echo.PLS SELECT
Echo 1 START VM
Echo 2 STOP VM

set /p id=
if "%id%"=="1" goto start
if "%id%"=="2" goto stop
goto begin

:start
net start vds
net start VMAuthdService
net start VMnetDHCP
net start "VMware NAT Service"
net start VMUSBArbService
net start VMwareHostd
netsh interface set interface  "VMware Network Adapter VMnet1" enabled
netsh interface set interface  "VMware Network Adapter VMnet8" enabled
start C:\ToRun\DEV\VM\"VM.lnk"
goto end

:stop
net stop vds
net stop VMwareHostd
net stop VMAuthdService
net stop VMnetDHCP
net stop VMUSBArbService
net stop "VMware NAT Service"
netsh interface set interface  "VMware Network Adapter VMnet1" disabled
netsh interface set interface  "VMware Network Adapter VMnet8" disabled
taskkill /im vmware-tray.exe
goto end

:end
exit