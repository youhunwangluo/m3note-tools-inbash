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
echo                          魅蓝note3线刷交流群：652374279
echo:
echo                          魅蓝note3玩机交流群：548918085
echo:
echo                                    2017.11.27
echo --------------------------------------------------------------------------------
echo                                       注意
echo:
echo 1、此工具只能在7.0以上系统使用
echo:
echo 2、解锁BL后，即便在7.0丢失REC，也可使用此工具进入REC救砖，无需线刷
echo:
echo 3、进入TWRP和进入官方REC不会刷入REC，若要永久刷入，须在TWRP中手动进行
echo:
if %next_step%==0 goto 2choose
if %next_step%==1 goto unlockbl
if %next_step%==2 goto boottwrp
if %next_step%==3 goto bootofficialrec
if %next_step%==4 goto exit


:2choose
echo --------------------------------------------------------------------------------
echo                                      请选择
echo:
echo 1 解锁BL【此操作要求解锁APP运行成功】
echo:
echo 2 进入TWRP【此操作要求已经解锁BL】
echo:
echo 3 进入官方REC【此操作要求已经解锁BL】
echo:
echo 4 退出【直接关闭窗口，adb程序将在后台继续运行】
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
echo                                      解锁BL
echo:
echo 连接状态检测...
if exist "%current_path%add\device" del /q "%current_path%add\device"
"%current_path%add\fastboot" devices >"%current_path%add\device"
findstr "fastboot" "%current_path%add\device">nul
if %errorlevel% equ 0 (
	set connected=1
    echo 设备已正确连接，请按【音量+】确认
  ) else (
	echo 连接状态错误，请确认已进入fastboot模式，并正确安装驱动
	pause
	set next_step=0
	goto intro
)
"%current_path%add\fastboot" oem unlock
echo --------------------------------------------------------------------------------
echo 解锁完毕，正在进入TWRP...
"%current_path%add\fastboot" boot "%current_path%rec\twrp.img"
pause
set next_step=0
goto intro


:boottwrp
echo --------------------------------------------------------------------------------
echo                                     进入TWRP
echo:
echo 连接状态检测...
if exist "%current_path%add\device" del /q "%current_path%add\device"
"%current_path%add\fastboot" devices >"%current_path%add\device"
findstr "fastboot" "%current_path%add\device">nul
if %errorlevel% equ 0 (
	set connected=1
    echo 设备已正确连接
  ) else (
	echo 连接状态错误，请确认已进入fastboot模式，并正确安装驱动
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
echo                                    进入官方REC
echo:
echo 连接状态检测...
if exist "%current_path%add\device" del /q "%current_path%add\device"
"%current_path%add\fastboot" devices >"%current_path%add\device"
findstr "fastboot" "%current_path%add\device">nul
if %errorlevel% equ 0 (
	set connected=1
    echo 设备已正确连接
  ) else (
	echo 连接状态错误，请确认已进入fastboot模式，并正确安装驱动
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
