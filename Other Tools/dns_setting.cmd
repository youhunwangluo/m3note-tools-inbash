@echo off
mode con cols=40 lines=20&color 0a
title DNS SETTING
echo ��ѡ��
echo 1.PURE
echo 2.DHCP

:operation
set /p action=
if /i "%action%"=="1" goto pure
goto dhcp

:pure
netsh interface ip set dns name="��̫��" source=static addr=123.207.137.88 register=PRIMARY
netsh interface ip add dns name="��̫��" addr=115.159.220.214 index=2
goto exit

:dhcp
netsh interface ip set dns "��̫��" dhcp

:exit
ipconfig/flushdns
echo �����˳�...
ping -n 10 127.0>nul

