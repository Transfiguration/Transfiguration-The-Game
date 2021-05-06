@echo off
:check_if_tweego_installed
where tweego >nul
if %ERRORLEVEL% equ 0 (
  goto build
)

:install_tweego
echo Tweego was not installed, installing tweego v1.2.2
powershell -Command "Invoke-WebRequest https://github.com/ChapelR/tweego-installer/releases/download/v1.2.2/tweego-installer.exe -OutFile tweego-installer.exe"
echo Downloaded tweego installer
start /wait tweego-installer.exe
del tweego-installer.exe
:manually_check_path_to_avoid_restart
where tweego >nul
if %ERRORLEVEL% equ 0 (
  goto build
)
if exist "C:\Program Files\Tweego\tweego.exe" (
  set PATH=%PATH%;C:\Program Files\Tweego\tweego.exe
)
where tweego >nul
if %ERRORLEVEL% equ 0 (
  goto build
)
echo Restart CMD
pause
exit

:build
echo Building Transfiguration with tweego v1.2.2
tweego -o transfiguration.html Transfiguration-The-Game %*
if %ERRORLEVEL% equ 0 (
  echo Done
)
