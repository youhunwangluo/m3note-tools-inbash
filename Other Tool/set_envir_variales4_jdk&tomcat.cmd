@echo off
mode con cols=100 lines=40&color 0a
title 设置环境变量
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo 请求管理员权限...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
echo BACKUP REG TO D:\backup.reg...
reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" D:\backup.reg
rem SET JAVA_HOME_
echo Example：JAVA_HOME=C:\Program Files\Java\jdk1.8.0_144
@set/p JAVA_HOME_=复制JAVA_HOME目录右键：
rem SET TOMCAT_HOME_
echo Example：TOMCAT_HOME=C:\Program Files\apache-tomcat-9.0.0.M22
@set/p TOMCAT_HOME_=复制TOMCAT_HOME目录右键：
echo 结果如下(忽略引号)：
echo "%JAVA_HOME_%"
echo "%TOMCAT_HOME_%"
@set/p correct=正确输入1,否则重新设置：
if not "%correct%"=="1" goto gotAdmin
rem SET THE OTHER THIRR VAR
@set CLASSPATH_=.;%%JAVA_HOME_%%\lib;%%JAVA_HOME%%\lib\tools.jar;%%CATALINA_HOME%%\lib\servlet-api.jar
@set Path_=%%JAVA_HOME%%\bin;%%JAVA_HOME%%\jre\bin;%%CATALINA_HOME%%\bin
@set Reg_=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
reg add "%Reg_%" /v JAVA_HOME /t REG_SZ /d "%JAVA_HOME_%" /f
reg add "%Reg_%" /v TOMCAT_HOME /t REG_SZ /d "%TOMCAT_HOME_%" /f
reg add "%Reg_%" /v CATALINA_HOME /t REG_SZ /d "%TOMCAT_HOME_%" /f
reg add "%Reg_%" /v CLASSPATH /t REG_EXPAND_SZ /d "%CLASSPATH_%" /f
rem %%i为第1字段，%%j为第2字段，%%k为第3字段
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" ^| find /i "Path"') do set "regvalue=%%k"
reg add "%Reg_%" /v Path /t REG_EXPAND_SZ /d "%regvalue%;%Path_%" /f
pause

