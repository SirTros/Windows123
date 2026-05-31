@@echo off
title Windows123 Installer
color 0A
mode con: cols=70 lines=25

echo ============================
echo    Windows123 Installer
echo ============================
echo.

:: Dotaz na instalaci (Y/N)
choice /M "Chcete nainstalovat Windows123?"
if errorlevel 2 goto konec

:: Nastaveni zdroje podle mista, kde lezi tento .bat soubor
:: %~dp0 vraci cestu ke slozce se skriptem vcetne koncoveho lomitka
set zdroj=%~dp0Win123\Windows123-win32-x64
set cil=C:\Windows123-win32-x64

if not exist "%zdroj%" (
    cls
    echo ====================================================
    echo CHYBA: Instalacni slozka nebyla nalezena!
    echo Ocekavana cesta: %zdroj%
    echo ====================================================
    pause
    exit
)

cls
echo ============================
echo    Priprava instalace...
echo ============================
echo.

:: FAKE PROGRESS
for /l %%i in (1,1,100) do (
    set /p=Instalace: %%i%% %%<nul
    timeout /t 0 >nul
    echo.
)

cls
echo ============================
echo    Kopirovani souboru...
echo ============================
echo.

robocopy "%zdroj%" "%cil%" /E /R:1 /W:1

echo.
echo ============================
echo    Dokoncovani...
echo ============================
echo.

timeout /t 2 >nul

:: ZASTUPCE
set desktop=%USERPROFILE%\Desktop
set shortcut=%desktop%\Windows123.lnk

powershell -command ^
"$s=(New-Object -COM WScript.Shell).CreateShortcut('%shortcut%'); ^
$s.TargetPath='C:\Windows123-win32-x64\Windows123.exe'; ^
$s.Save()"

cls
echo ============================
echo         HOTOVO!
echo ============================
echo.
echo Instalace probehla uspesne.
echo.
echo Slozka:
echo %cil%
echo.

choice /M "Otevrit slozku?"
if errorlevel 2 goto spust

explorer "%cil%"

:spust
choice /M "Spustit Windows123?"
if errorlevel 2 goto konec

start "" "C:\Windows123-win32-x64\Windows123.exe"

:konec
echo.
echo Dekuji za instalaci!
timeout /t 3 >nul
