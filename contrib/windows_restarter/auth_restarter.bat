@ECHO OFF
@title AuthServer
CLS
ECHO Initializing AuthServer (Logon-Server)...
:1
start "AuthServer" /B /MIN /WAIT authserver.exe -c ../etc/authserver.conf
if %errorlevel% == 0 goto end
goto 1
:end
pause