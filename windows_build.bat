@echo off
cls
color 0b
echo.
echo ==========================
echo *      BlizzLikeCore     *
echo ==========================
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

rem compilers supported: VC12 VC11 VC10
for /L %%x in (12,-1,10) do (
 if exist "C:\Program Files (x86)\Microsoft Visual Studio %%x.0\VC\bin\cl.exe" (
   set xvc=%%x
   goto vcd_x86 
 )
 if exist "C:\Program Files\Microsoft Visual Studio %%x.0\VC\bin\cl.exe" (
   set xvc=%%x
   goto vcd
 )
)
goto warning2

:vcd_x86
set COMPILER_PATH="C:/Program Files (x86)/Microsoft Visual Studio %xvc%.0/VC/bin/cl.exe"
set VC_VARS="C:\\Program Files (x86)\\Microsoft Visual Studio %xvc%.0\\VC\\"
goto common

:vcd
set COMPILER_PATH="C:/Program Files/Microsoft Visual Studio %xvc%.0/VC/bin/cl.exe"
set VC_VARS="C:\\Program Files\\Microsoft Visual Studio %xvc%.0\\VC\\"
goto common

:common
set C_FLAGS="/DWIN32 /D_WINDOWS /W3 /EHsc /GR"
if %BUILD_PLATFORM%==Win64 (set COMPILER="Visual Studio %xvc% Win64") else (set COMPILER="Visual Studio %xvc%")
if %BUILD_TYPE%==Release (
  set CBUILD_TYPE="0"
  goto platform
)
if %BUILD_TYPE%==Debug (
  set CBUILD_TYPE="1"
  goto platform
)
goto help

:platform
if %BUILD_PLATFORM%==Win32 (
  set BUILD_PLATFORM=Win32
  goto begin
)
if %BUILD_PLATFORM%==Win64 (
  set BUILD_PLATFORM=x64
  goto begin
)
goto help

:begin
if not exist %INSTALL_PATH% (
  mkdir %INSTALL_PATH%
  if not exist %INSTALL_PATH% (
    echo Please, make output directory %INSTALL_PATH%
    pause
    exit
  )
)
if not exist build (
  mkdir build
  cd build
  goto cl_cmake
) else (
  echo The build folder already exist!
  set /p opc=Do you want to delete it? [n] 
)
if "%opc%" == "y" (
  rmdir /S /Q build
  mkdir build
  cd build
  goto cl_cmake
) else (
  cd build
  goto cl_vc
)

:cl_cmake
cmake -G %COMPILER% -DPCH=1 -DSCRIPTS=%SCRIPTS% -DTOOLS=%TOOLS% -DDEBUG=%CBUILD_TYPE% -DPLATFORM=%BUILD_PLATFORM% -DCMAKE_CXX_COMPILER=%COMPILER_PATH% -DCMAKE_CXX_FLAGS=%C_FLAGS% -DCMAKE_C_FLAGS=%C_FLAGS% -DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% ..
if %ERRORLEVEL% NEQ 0 goto warning
set /p opc=Do you want compile the core now? [y] 
if "%opc%" == "n" (
  cd ..
  exit
) else (goto cl_vc)

:cl_vc
call %VC_VARS%vcvarsall.bat
MSBuild INSTALL.vcxproj /m:%CORE_NUMBER% /t:Rebuild /p:Configuration=%BUILD_TYPE%;Platform=%BUILD_PLATFORM%
cd ..
pause
exit

:help
cls
color 0c
echo ============================================
echo Wrong parameters!
echo Restart and set the parameters correctly.
echo ============================================
pause
exit

:warning
cls
color 0e
echo ============================================
echo  Confirm that you have installed CMake 2.8/+
echo  When installing CMake check the box:
echo  Add CMake to the system PATH for all users.
echo ============================================
pause
exit

:warning2
cls
color 0e
echo ===============================
echo  Compilers supported not found.
echo ===============================
pause
exit