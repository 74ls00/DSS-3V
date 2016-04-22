@echo off
rem Проверка разрядности системы
if "%PROCESSOR_ARCHITEW6432%"=="AMD64" goto launch64
if "%PROCESSOR_ARCHITECTURE%"==""      set PROCESSOR_ARCHITECTURE=x86
if "%PROCESSOR_ARCHITECTURE%"=="x86"   goto launch32
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto launch64
goto endorunknwn
	  
:launch32
set sysd=%windir%\system32
goto fcopys
	  
:launch64
set sysd=%windir%\SysWOW64

rem Копирование файлов
:fcopys
echo PROCESSOR ARCHITECTURE=%PROCESSOR_ARCHITECTURE%
echo ____________________________
echo copy MgButton.ocx to %sysd%\MgButton.ocx
copy %~d0%~p0\MgButton.ocx %sysd%\MgButton.ocx
echo copy mscomm32.ocx to %sysd%\mscomm32.ocx
copy %~d0%~p0\mscomm32.ocx %sysd%\mscomm32.ocx
echo copy tabctl32.ocx to %sysd%\tabctl32.ocx
copy %~d0%~p0\tabctl32.ocx %sysd%\tabctl32.ocx

:endorunknwn
rem Регистрация файлов
echo regsvr32 MgButton.ocx
regsvr32 %sysd%\MgButton.ocx
echo regsvr32 mscomm32.ocx
regsvr32 %sysd%\mscomm32.ocx
echo regsvr32 tabctl32.ocx
regsvr32 %sysd%\tabctl32.ocx

