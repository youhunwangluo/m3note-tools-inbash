@echo off
mode con cols=80 lines=45&color 0a
title TWRP TOOL


:initial_content
set next_step=0
set exist_original_file=0
set current_path=%~dp0
set keyfiles_path=%current_path%key_files\android 5.1
set main_update=update
if not exist "%current_path%flyme" ( mkdir "%current_path%flyme" ) 


:intro
cls
echo --------------------------------------------------------------------------------
echo                           Flyme Firmware Customization
echo:
echo                    本工具用来修改官方固件，使其能通过TWRP刷入
echo:
echo                          魅蓝note3线刷交流群：652374279
echo:
echo                          魅蓝note3玩机交流群：548918085
echo:
echo                                    2017.11.20
echo --------------------------------------------------------------------------------
echo                                        注意
echo 1、仅适用于魅蓝note3
echo:
echo 2、可修改国际版固件
echo:
echo 3、打包时可能有轻微卡顿，勿进行其他操作
if %next_step%==0 goto current_version_choices
if %next_step%==1 goto next_version_choices
if %next_step%==2 goto info_confirm
if %next_step%==3 goto file_exacting
if %next_step%==4 goto file_replacing
if %next_step%==5 goto file_compressing
if %next_step%==6 goto exit


:current_version_choices
echo --------------------------------------------------------------------------------
echo                                  选择当前固件版本
echo 1、Android 7.0
echo 2、Android 5.1
set /p current_version=
if "%current_version%"=="1" set next_step=1
if "%current_version%"=="2" set next_step=1
goto intro


:next_version_choices
echo --------------------------------------------------------------------------------
echo                      当前固件版本已选择，选择要刷入的固件版本
echo 1、Android 7.0
echo 2、Android 5.1
set /p next_version=
if "%next_version%"=="1" set next_step=2
if "%next_version%"=="2" set next_step=2
goto intro


:info_confirm
echo --------------------------------------------------------------------------------
echo                                   当前固件版本为
if %current_version%==1 ( echo                                    Android 7.0 )
if %current_version%==2 ( echo                                    Android 5.1 )
echo                                 要修改的固件版本为
if %next_version%==1 ( echo                                    Android 7.0 )
if %next_version%==2 ( echo                                    Android 5.1 )
echo --------------------------------------------------------------------------------
echo                                  确认按1,否则重输
set /p version_confirm=
if "%version_confirm%"=="1" ( set next_step=3 ) else ( set next_step=0 )
goto intro


:file_exacting
echo --------------------------------------------------------------------------------
echo                                      文件解压
if %exist_original_file%==0 ( 
	echo                      请将官方固件改名update.zip放入flyme文件夹
	explorer "%current_path%flyme"
	pause
    if exist "%current_path%flyme\update.zip" ( set exist_original_file=1 ) 
	goto intro )
if exist "%current_path%extracted" ( rd /s /q "%current_path%extracted")
mkdir "%current_path%extracted"
"%current_path%add\7z" x "%current_path%flyme\update.zip" -o"%current_path%extracted"
set next_step=4
goto intro


:file_replacing
echo --------------------------------------------------------------------------------
echo                                      文件修改
if %next_version%==1 set keyfiles_path=%current_path%key_files\android 7.0
if exist "%current_path%extracted\META-INF\com\google\android\updater-script" ( 
del /q "%current_path%extracted\META-INF\com\google\android\updater-script" )
copy "%keyfiles_path%\updater-script" "%current_path%extracted\META-INF\com\google\android" >nul
copy "%keyfiles_path%\recovery.img" "%current_path%extracted" >nul
if exist "%current_path%twrp" ( rd /s /q "%current_path%twrp")
mkdir "%current_path%twrp"
if %current_version%==1 if %next_version%==2 ( 
	copy "%current_path%key_files\switches\switch to android_5.1.zip" "%current_path%twrp" >nul
	ren "%current_path%twrp\switch to android_5.1.zip" update1.zip
	set main_update=update2)
if exist "%current_path%extracted\custom" ( rd /s /q "%current_path%extracted\custom" )
if exist "%current_path%extracted\sig" ( rd /s /q "%current_path%extracted\sig" )
if exist "%current_path%extracted\file_contexts" ( del /q "%current_path%extracted\file_contexts" )
if exist "%current_path%extracted\file_contexts.bin" ( del /q "%current_path%extracted\file_contexts.bin" )
if exist "%current_path%extracted\logo.img" ( del /q "%current_path%extracted\logo.img" )
if exist "%current_path%extracted\scatter.txt" ( del /q "%current_path%extracted\scatter.txt" )
if exist "%current_path%extracted\SEC_VER.txt" ( del /q "%current_path%extracted\SEC_VER.txt" )
if exist "%current_path%extracted\type.txt" ( del /q "%current_path%extracted\type.txt" )
if exist "%current_path%extracted\META-INF\build.prop" ( del /q "%current_path%extracted\META-INF\build.prop" )
if exist "%current_path%extracted\META-INF\CERT.RSA" ( del /q "%current_path%extracted\META-INF\CERT.RSA" )
if exist "%current_path%extracted\META-INF\CERT.SF" ( del /q "%current_path%extracted\META-INF\CERT.SF" )
if exist "%current_path%extracted\META-INF\imei.dat" ( del /q "%current_path%extracted\META-INF\imei.dat" )
if exist "%current_path%extracted\META-INF\machine_match" ( del /q "%current_path%extracted\META-INF\machine_match" )
if exist "%current_path%extracted\META-INF\MANIFEST.MF" ( del /q "%current_path%extracted\META-INF\MANIFEST.MF" )
if exist "%current_path%extracted\META-INF\sw_version" ( del /q "%current_path%extracted\META-INF\sw_version" )
if exist "%current_path%extracted\META-INF\com\android" ( rd /s /q "%current_path%extracted\META-INF\com\android" )
if exist "%current_path%extracted\data" ( rd /s /q "%current_path%extracted\data" )
if exist "%current_path%extracted\patch_l91" ( rd /s /q "%current_path%extracted\patch_l91" )
set next_step=5
ping 127.1 -n 5 >nul
goto intro


:file_compressing
echo --------------------------------------------------------------------------------
echo                                      文件打包
"%current_path%add\7z" a "%current_path%twrp\%main_update%.zip" "%current_path%extracted\*"
set next_step=6
goto intro


:exit
explorer "%current_path%twrp"
echo --------------------------------------------------------------------------------
echo                                      刷入说明
echo:
echo                   0、若降级，务必四清后重启recovery
echo:
echo                   1、打开此工具的twrp文件夹
echo:
echo                   2、复制所有压缩包到手机中
echo:
echo                   3、若只有update.zip直接刷入
echo:
echo                   4、若有update1.zip和update2.zip两个压缩包，
echo:
echo                   务必先刷update1.zip，此时手机将自动重启，之
echo:
echo                   后再刷入update2.zip
echo:
echo                   5、刷入Android 7.0固件可能会卡气球，等待10分
echo:
echo                   钟后强制重启即可
echo:
echo                   6、若被还原为官方rec，开启系统root，使
echo:
echo                   用flashify手动刷入twrp即可                                     
echo --------------------------------------------------------------------------------
pause
exit