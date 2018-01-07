@echo off
mode con cols=80 lines=45&color 0a
title fastboot tool


:initial_content
set next_step=0
set current_path=%~dp0
set connected=0


:intro
cls
echo --------------------------------------------------------------------------------
echo                              Universal Fastboot Tool 
echo:
echo                          ����note3��ˢ����Ⱥ��652374279
echo:
echo                          ����note3�������Ⱥ��548918085
echo:
echo                                    2017.11.27
echo --------------------------------------------------------------------------------
echo                                       ע��
echo:
echo 1���˹���ֻ����7.0����ϵͳʹ��
echo:
echo 2������BL�󣬼�����7.0��ʧREC��Ҳ��ʹ�ô˹��߽���REC��ש��������ˢ
echo:
echo 3������TWRP�ͽ���ٷ�REC����ˢ��REC����Ҫ����ˢ�룬����TWRP���ֶ�����
echo:
if %next_step%==0 goto 2choose
if %next_step%==1 goto unlockbl
if %next_step%==2 goto boottwrp
if %next_step%==3 goto bootofficialrec
if %next_step%==4 goto exit


:2choose
echo --------------------------------------------------------------------------------
echo                                      ��ѡ��
echo:
echo 1 ����BL���˲���Ҫ�����APP���гɹ���
echo:
echo 2 ����TWRP���˲���Ҫ���Ѿ�����BL��
echo:
echo 3 ����ٷ�REC���˲���Ҫ���Ѿ�����BL��
echo:
echo 4 �˳���ֱ�ӹرմ��ڣ�adb�����ں�̨�������С�
echo:
echo --------------------------------------------------------------------------------
set /p id=
if "%id%"=="1" set next_step=1
if "%id%"=="2" set next_step=2
if "%id%"=="3" set next_step=3
if "%id%"=="4" set next_step=4
goto intro


:unlockbl
echo --------------------------------------------------------------------------------
echo                                      ����BL
echo:
echo ����״̬���...
if exist "%current_path%add\device" del /q "%current_path%add\device"
"%current_path%add\fastboot" devices >"%current_path%add\device"
findstr "fastboot" "%current_path%add\device">nul
if %errorlevel% equ 0 (
	set connected=1
    echo �豸����ȷ���ӣ��밴������+��ȷ��
  ) else (
	echo ����״̬������ȷ���ѽ���fastbootģʽ������ȷ��װ����
	pause
	set next_step=0
	goto intro
)
"%current_path%add\fastboot" oem unlock
echo --------------------------------------------------------------------------------
echo ������ϣ����ڽ���TWRP...
"%current_path%add\fastboot" boot "%current_path%rec\twrp.img"
pause
set next_step=0
goto intro


:boottwrp
echo --------------------------------------------------------------------------------
echo                                     ����TWRP
echo:
echo ����״̬���...
if exist "%current_path%add\device" del /q "%current_path%add\device"
"%current_path%add\fastboot" devices >"%current_path%add\device"
findstr "fastboot" "%current_path%add\device">nul
if %errorlevel% equ 0 (
	set connected=1
    echo �豸����ȷ����
  ) else (
	echo ����״̬������ȷ���ѽ���fastbootģʽ������ȷ��װ����
	pause
	set next_step=0
	goto intro
)
"%current_path%add\fastboot" boot "%current_path%rec\twrp.img"
pause
set next_step=0
goto intro


:bootofficialrec
echo --------------------------------------------------------------------------------
echo                                    ����ٷ�REC
echo:
echo ����״̬���...
if exist "%current_path%add\device" del /q "%current_path%add\device"
"%current_path%add\fastboot" devices >"%current_path%add\device"
findstr "fastboot" "%current_path%add\device">nul
if %errorlevel% equ 0 (
	set connected=1
    echo �豸����ȷ����
  ) else (
	echo ����״̬������ȷ���ѽ���fastbootģʽ������ȷ��װ����
	pause
	set next_step=0
	goto intro
)
"%current_path%add\fastboot" boot "%current_path%rec\official.img"
pause
set next_step=0
goto intro


:exit
"%current_path%add\adb" kill-server
exit
