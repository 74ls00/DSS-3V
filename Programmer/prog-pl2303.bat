@echo off
chcp 1251
rem в свойствах консоли изменить шрифт
title -= avrdude PL2303 AVR =-
set port=com3
rem set mk=m168p
set mk=8535
set prog=pl2303
rem set fwn=Digital_Solder_Staton.hex
rem set fwn=DSS31.hex
set fwn=STK500.hex
set tdir=%~d0%~p0bin\
set fw=%tdir%..\..\Firmware\%fwn%
set lfuse=E2
set hfuse=D4
:menu
cls
echo port=%port% mk=%mk% programmer=%prog%
echo tdir=%tdir%
echo fw=%fw%
echo fuses %lfuse% %hfuse%
echo.
echo [I] read id
echo [W] write flash [R] read flash [V] verify flash
echo [G] write fuses [F] read fuses
echo.
echo [Q] Exit [C] Eease chip
echo _______________________
rem I read id
rem W write flash
rem G wtite fuse
rem O write rom
rem F read fuses
rem R read flash
rem E read rom
rem V verify flash
rem B veryfy rom
rem C erase chip
rem Q exit
choice /C IWGOFREVBCQ
if %ERRORLEVEL% == 1 goto id
if %ERRORLEVEL% == 2 goto wflash
if %ERRORLEVEL% == 3 goto wfuses
if %ERRORLEVEL% == 4 goto wrom
if %ERRORLEVEL% == 5 goto rfuses
if %ERRORLEVEL% == 6 goto rflash
if %ERRORLEVEL% == 7 goto rrom
if %ERRORLEVEL% == 8 goto vflash
if %ERRORLEVEL% == 9 goto vrom
if %ERRORLEVEL% == 10 goto cerase
if %ERRORLEVEL% == 11 exit
goto menu
:id
%tdir%\avrdude.exe -c %prog% -p %mk% -P %port% -i 400 -v
pause
cls
goto menu
:wflash
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 400 -U flash:w:%fw%:a
pause
cls
goto menu
:wfuses
echo Write fuses ?
pause
pause
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -B 4800 -i 500 -U lfuse:w:0x%lfuse%:m
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -B 4800 -i 500 -U hfuse:w:0x%hfuse%:m
pause
cls
goto menu
:rfuses
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -B 4800 -i 500 -U hfuse:r:"hfuse.hex":h -U lfuse:r:"lfuse.hex":h -U efuse:r:"efuse.hex":h
pause
cls
goto menu
:rflash
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -B 4800 -i 400 -U flash:r:"read.hex":r
pause
cls
goto menu
:vflash
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -B 4800 -i 400 -U flash:v:"%fw%":a
pause
cls
goto menu
:cerase
echo Erase chip ?
pause
pause
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -B 4800 -i 500 -e
pause
cls
goto menu
:wrom
:rrom
:vrom
goto menu
pause