@ECHO OFF
@title WorldServer
CLS
ECHO Initializing WorldServer (Core-Server)...
:1
start "WorldServer" /B /MIN /WAIT worldserver.exe -c ../etc/worldserver.conf
if %errorlevel% == 0 goto end
goto 1
:end
pause