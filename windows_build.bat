@echo off
cls
color 0b
echo.
echo =====================================
echo *           BlizzLikeCore           *
echo *  Compilers supported: VC11, VC10  *
echo =====================================
echo.
set /p BUILD_TYPE=What build type use?		[Release]: 
if %BUILD_TYPE%. == . set BUILD_TYPE=Release
set /p CORE_NUMBER=What is your Core Number?	[4]: 
if %CORE_NUMBER%. == . set CORE_NUMBER=4
set /p BUILD_PLATFORM=What is your Build Platform?	[Win32]: 
if %BUILD_PLATFORM%. == . set BUILD_PLATFORM=Win32
set /p SCRIPTS=Build Scripts?			[1]: 
if %SCRIPTS%. == . set SCRIPTS=1
set /p TOOLS=Build Tools?			[0]: 
if %TOOLS%. == . set TOOLS=0
set /p INSTALL_PATH=What install path use?		["C:\\BlizzLikeCore"]: 
if %INSTALL_PATH%. == . set INSTALL_PATH="C:\\BlizzLikeCore"
echo.

if exist "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\cl.exe" (
if %BUILD_PLATFORM%==Win64 (set COMPILER="Visual Studio 11 Win64") else (set COMPILER="Visual Studio 11")
set COMPILER_PATH="C:/Program Files (x86)/Microsoft Visual Studio 11.0/VC/bin/cl.exe"
set VC_VARS="C:\\Program Files (x86)\\Microsoft Visual Studio 11.0\\VC\\"
goto common
)
if exist "C:\Program Files\Microsoft Visual Studio 11.0\VC\bin\cl.exe" (
if %BUILD_PLATFORM%==Win64 (set COMPILER="Visual Studio 11 Win64") else (set COMPILER="Visual Studio 11")
set COMPILER_PATH="C:/Program Files/Microsoft Visual Studio 11.0/VC/bin/cl.exe"
set VC_VARS="C:\\Program Files\\Microsoft Visual Studio 11.0\\VC\\"
goto common
)
if exist "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\cl.exe" (
if %BUILD_PLATFORM%==Win64 (set COMPILER="Visual Studio 10 Win64") else (set COMPILER="Visual Studio 10")
set COMPILER_PATH="C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/bin/cl.exe"
set VC_VARS="C:\\Program Files (x86)\\Microsoft Visual Studio 10.0\\VC\\"
goto common
)
if exist "C:\Program Files\Microsoft Visual Studio 10.0\VC\bin\cl.exe" (
if %BUILD_PLATFORM%==Win64 (set COMPILER="Visual Studio 10 Win64") else (set COMPILER="Visual Studio 10")
set COMPILER_PATH="C:/Program Files/Microsoft Visual Studio 10.0/VC/bin/cl.exe"
set VC_VARS="C:\\Program Files\\Microsoft Visual Studio 10.0\\VC\\"
goto common
)
goto warning2

:help
cls
color 0c
echo Wrong parameters!
echo Restart and set the parameters correctly.
echo.
pause
exit

:common
set C_FLAGS="/DWIN32 /D_WINDOWS /W3 /EHsc /GR"
if %BUILD_TYPE%==Release (
set CBUILD_TYPE="0"
goto begin
)
if %BUILD_TYPE%==Debug (
set CBUILD_TYPE="1"
goto begin
)
goto help

:begin
if not exist build (
    mkdir build
) else (
    rmdir /S /Q build
    mkdir build
)

if not exist %INSTALL_PATH% (
mkdir %INSTALL_PATH%
    if not exist %INSTALL_PATH% (
    echo Please, make output directory %INSTALL_PATH%
    pause
    exit
    )
)

if %BUILD_PLATFORM%==Win32 goto win32
if %BUILD_PLATFORM%==Win64 goto win64
goto help

:win32
cd build
cmake -G %COMPILER% -DPCH=1 -DSCRIPTS=%SCRIPTS% -DTOOLS=%TOOLS% -DDEBUG=%CBUILD_TYPE% -DCMAKE_CXX_COMPILER=%COMPILER_PATH% -DCMAKE_CXX_FLAGS=%C_FLAGS% -DCMAKE_C_FLAGS=%C_FLAGS% -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% ..
pause
if %ERRORLEVEL% NEQ 0 goto warning
call %VC_VARS%vcvarsall.bat
MSBuild INSTALL.vcxproj /m:%CORE_NUMBER% /t:Rebuild /p:Configuration=%BUILD_TYPE%;Platform=%BUILD_PLATFORM%
goto end

:win64
cd build
cmake -G %COMPILER% -DPCH=1 -DSCRIPTS=%SCRIPTS% -DTOOLS=%TOOLS% -DDEBUG=%CBUILD_TYPE% -DPLATFORM=X64 -DCMAKE_CXX_COMPILER=%COMPILER_PATH% -DCMAKE_CXX_FLAGS=%C_FLAGS% -DCMAKE_C_FLAGS=%C_FLAGS% -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% ..
pause
if %ERRORLEVEL% NEQ 0 goto warning
call %VC_VARS%vcvarsall.bat
MSBuild INSTALL.vcxproj /m:%CORE_NUMBER%  /t:Rebuild /p:Configuration=%BUILD_TYPE%;Platform=x64
goto end

:end
cd ..
pause
exit

:warning
cls
color 0e
echo ============================================
echo  Confirm that you have installed CMake 2.8/+
echo  When installing CMake check the box:
echo  Add CMake to the system PATH for all users
echo ============================================
pause
exit

:warning2
cls
color 0e
echo ============================================
echo  You need to install:
echo  Microsoft Visual Studio 11 (2012)
echo  or Microsoft Visual Studio 10 (2010)
echo ============================================
pause
exit