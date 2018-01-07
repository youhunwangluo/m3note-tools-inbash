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
echo                    �����������޸Ĺٷ��̼���ʹ����ͨ��TWRPˢ��
echo:
echo                          ����note3��ˢ����Ⱥ��652374279
echo:
echo                          ����note3�������Ⱥ��548918085
echo:
echo                                    2017.11.20
echo --------------------------------------------------------------------------------
echo                                        ע��
echo 1��������������note3
echo:
echo 2�����޸Ĺ��ʰ�̼�
echo:
echo 3�����ʱ��������΢���٣��������������
if %next_step%==0 goto current_version_choices
if %next_step%==1 goto next_version_choices
if %next_step%==2 goto info_confirm
if %next_step%==3 goto file_exacting
if %next_step%==4 goto file_replacing
if %next_step%==5 goto file_compressing
if %next_step%==6 goto exit


:current_version_choices
echo --------------------------------------------------------------------------------
echo                                  ѡ��ǰ�̼��汾
echo 1��Android 7.0
echo 2��Android 5.1
set /p current_version=
if "%current_version%"=="1" set next_step=1
if "%current_version%"=="2" set next_step=1
goto intro


:next_version_choices
echo --------------------------------------------------------------------------------
echo                      ��ǰ�̼��汾��ѡ��ѡ��Ҫˢ��Ĺ̼��汾
echo 1��Android 7.0
echo 2��Android 5.1
set /p next_version=
if "%next_version%"=="1" set next_step=2
if "%next_version%"=="2" set next_step=2
goto intro


:info_confirm
echo --------------------------------------------------------------------------------
echo                                   ��ǰ�̼��汾Ϊ
if %current_version%==1 ( echo                                    Android 7.0 )
if %current_version%==2 ( echo                                    Android 5.1 )
echo                                 Ҫ�޸ĵĹ̼��汾Ϊ
if %next_version%==1 ( echo                                    Android 7.0 )
if %next_version%==2 ( echo                                    Android 5.1 )
echo --------------------------------------------------------------------------------
echo                                  ȷ�ϰ�1,��������
set /p version_confirm=
if "%version_confirm%"=="1" ( set next_step=3 ) else ( set next_step=0 )
goto intro


:file_exacting
echo --------------------------------------------------------------------------------
echo                                      �ļ���ѹ
if %exist_original_file%==0 ( 
	echo                      �뽫�ٷ��̼�����update.zip����flyme�ļ���
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
echo                                      �ļ��޸�
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
echo                                      �ļ����
"%current_path%add\7z" a "%current_path%twrp\%main_update%.zip" "%current_path%extracted\*"
set next_step=6
goto intro


:exit
explorer "%current_path%twrp"
echo --------------------------------------------------------------------------------
echo                                      ˢ��˵��
echo:
echo                   0����������������������recovery
echo:
echo                   1���򿪴˹��ߵ�twrp�ļ���
echo:
echo                   2����������ѹ�������ֻ���
echo:
echo                   3����ֻ��update.zipֱ��ˢ��
echo:
echo                   4������update1.zip��update2.zip����ѹ������
echo:
echo                   �����ˢupdate1.zip����ʱ�ֻ����Զ�������֮
echo:
echo                   ����ˢ��update2.zip
echo:
echo                   5��ˢ��Android 7.0�̼����ܻῨ���򣬵ȴ�10��
echo:
echo                   �Ӻ�ǿ����������
echo:
echo                   6��������ԭΪ�ٷ�rec������ϵͳroot��ʹ
echo:
echo                   ��flashify�ֶ�ˢ��twrp����                                     
echo --------------------------------------------------------------------------------
pause
exit