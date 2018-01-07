@echo off
mode con cols=80 lines=30&color 0a
title 底层分区备份与恢复

:begin
cls
echo 底层分区备份与恢复工具
echo --------------------------
echo 请打开USB调试和SuperSU APP
echo --------------------------      
echo 请选择
echo 0 USB调试测试
echo 1 备份
echo 2 恢复
echo 3 结束

set /p id=
if "%id%"=="0" goto usbdebugtest
if "%id%"=="1" goto backup
if "%id%"=="2" goto recover
if "%id%"=="3" goto exit
goto begin

:usbdebugtest
adb devices
pause
goto begin

:backup
Echo 备份中...
adb shell "su -c 'cd sdcard;mkdir LowLevelPartitions'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p2 of=/sdcard/LowLevelPartitions/para.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p4 of=/sdcard/LowLevelPartitions/expdb.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p5 of=/sdcard/LowLevelPartitions/frp.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p6 of=/sdcard/LowLevelPartitions/ppl.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p7 of=/sdcard/LowLevelPartitions/nvdata.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p8 of=/sdcard/LowLevelPartitions/proinfo.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p9 of=/sdcard/LowLevelPartitions/metadata.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p10 of=/sdcard/LowLevelPartitions/rstinfo.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p11 of=/sdcard/LowLevelPartitions/protect1.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p12 of=/sdcard/LowLevelPartitions/protect2.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p13 of=/sdcard/LowLevelPartitions/seccfg.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p14 of=/sdcard/LowLevelPartitions/oemkeystore.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p19 of=/sdcard/LowLevelPartitions/nvram.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p27 of=/sdcard/LowLevelPartitions/keystore.img'"
adb shell "su -c 'dd if=/dev/block/mmcblk0p32 of=/sdcard/LowLevelPartitions/flashinfo.img'"
adb pull /sdcard/LowLevelPartitions ./
Echo 备份成功
pause
goto begin

:recover
Echo 恢复中...
adb shell "su -c 'cd sdcard;mkdir LowLevelPartitions'"
adb push ./LowLevelPartitions /sdcard/
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/para.img of=/dev/block/mmcblk0p2'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/expdb.img of=/dev/block/mmcblk0p4'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/frp.img of=/dev/block/mmcblk0p5'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/ppl.img of=/dev/block/mmcblk0p6'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/nvdata.img of=/dev/block/mmcblk0p7'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/proinfo.img of=/dev/block/mmcblk0p8'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/metadata.img of=/dev/block/mmcblk0p9'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/rstinfo.img of=/dev/block/mmcblk0p10'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/protect1.img of=/dev/block/mmcblk0p11'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/protect2.img of=/dev/block/mmcblk0p12'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/seccfg.img of=/dev/block/mmcblk0p13'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/oemkeystore.img of=/dev/block/mmcblk0p14'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/nvram.img of=/dev/block/mmcblk0p19'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/keystore.img of=/dev/block/mmcblk0p27'"
adb shell "su -c 'dd if=/sdcard/LowLevelPartitions/flashinfo.img of=/dev/block/mmcblk0p32'"
adb shell "su -c 'reboot'"
Echo 恢复成功，等待手机重启
pause
goto begin

:exit
exit