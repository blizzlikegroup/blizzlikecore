@echo off
color 0b
rem config.
set svr=localhost
set port=3306
set wdb=world
set cdb=characters
set rdb=auth
set sdb=scripts
set dbpath=development
set mysql=.
set mysqldump=.
cls
echo.
echo ================
echo * MySQL Config *
echo ================
echo.
set /p user=What is your MySQL user name?	[root]: 
if %user%. == . set user=root
set /p pass=What is your MySQL password?	[]: 
if %pass%. == . set pass=
rem config.(end)
:panel
cls
echo.
echo =================
echo * BlizzLikeCore *
echo =================
echo.
echo Create MySQL	[1]
echo World DB	[2]
echo Chars DB	[3]
echo Auth DB		[4]
echo Scripts DB	[5]
echo Realmlist	[6]
echo Drop MySQL	[7]
echo DB Backup	[8]
echo Exit		[0]
echo.
set /p opc=what is your option? 
echo.
if "%opc%" == "1" (
  echo Wait..
  echo.
  %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% < create_mysql.sql
  echo.
  pause
)
if "%opc%" == "2" (
  echo Wait..
  echo.
  for %%i in (%dbpath%\world\*.sql) do if %%i neq %dbpath%\world\characters*.sql if %%i neq %dbpath%\world\auth*.sql if %%i neq %dbpath%\world\scripts*.sql echo %%i & %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% < %%i
  echo.
  pause
)
if "%opc%" == "3" (
  echo Wait..
  echo.
  for %%i in (%dbpath%\characters\*.sql) do echo %%i & %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %cdb% < %%i
  echo.
  pause
)
if "%opc%" == "4" (
  echo Wait..
  echo.
  for %%i in (%dbpath%\auth\*.sql) do echo %%i & %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% < %%i
  echo.
  pause
)
if "%opc%" == "5" (
  echo Wait..
  echo.
  for %%i in (%dbpath%\scripts\*.sql) do echo %%i & %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% %sdb% < %%i
  echo.
  pause
)
if "%opc%" == "6" (
  set /p address=What is your Server IP?	[localhost]: 
  if %address%. == . set address=127.0.0.1
  echo.
  echo Wait..
  echo.
  %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% -e "update %rdb%.realmlist set address = '%address%' where id = 1;"
  echo.
  pause
)
if "%opc%" == "7" (
  echo Wait..
  echo.
  %mysql%\mysql -q -s -h %svr% --user=%user% --password=%pass% --port=%port% < drop_mysql.sql
  echo.
  pause
)
if "%opc%" == "8" goto 8_db_backup
if "%opc%" == "0" exit
goto panel

:8_db_backup
set /p pat=Where do you want to save your backup?  [backup] : 
if %pat%. == . set pat=backup
echo.
rem Get the datetime in a format that can go in a filename.
set datetime=%date%_%time%
set datetime=%datetime: =_%
set datetime=%datetime::=%
set datetime=%datetime:,=%
set datetime=%datetime:/=_%
set datetime=%datetime:.=_%
%mysqldump%\mysqldump -h %svr% --user=%user% --password=%pass% --port=%port% %wdb% > %pat%\"world_%datetime%.sql"
%mysqldump%\mysqldump -h %svr% --user=%user% --password=%pass% --port=%port% %cdb% > %pat%\"characters_%datetime%.sql"
%mysqldump%\mysqldump -h %svr% --user=%user% --password=%pass% --port=%port% %rdb% > %pat%\"auth_%datetime%.sql"
%mysqldump%\mysqldump -h %svr% --user=%user% --password=%pass% --port=%port% %sdb% > %pat%\"scripts_%datetime%.sql"
echo.
echo Backup %datetime%
echo.
pause
goto panel