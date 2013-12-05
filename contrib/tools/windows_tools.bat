@echo off
color 0b
:panel
cls
echo.
echo ================================
echo *  dbc/maps/vmaps/mmaps Tools  *
echo ================================
echo.
echo Extract dbc/maps [1]
echo Extract vmaps	 [2]
echo Generate mmaps	 [3]
echo Exit		 [0]
echo.
set /p opc=what is your option? 
cls
if "%opc%" == "1" goto 1_extract_dbc_maps
if "%opc%" == "2" goto 2_extract_vmaps
if "%opc%" == "3" goto 3_generate_mmaps
if "%opc%" == "0" goto exit
goto panel
:1_extract_dbc_maps
if exist dbc (del /S /Q dbc)
if exist maps (del /S /Q maps)
ad.exe
echo.
echo Press any key to panel . . .
pause>nul
goto panel
:2_extract_vmaps
if exist buildings (del /S /Q buildings)
vmap_extractor.exe
if exist vmaps (del /S /Q vmaps) else (md vmaps)
vmap_assembler.exe buildings vmaps
echo.
echo Press any key to panel . . .
pause>nul
goto panel
:3_generate_mmaps
if exist mmaps (cls
echo.
echo The mmaps folder already exist!
set /p opc=Do you want to delete it? [n] 
echo.) else (md mmaps)
if "%opc%" == "y" del /S /Q mmaps
echo.
MoveMapGen.exe
echo.
echo Press any key to panel . . .
pause>nul
goto panel
:exit