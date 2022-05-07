@ECHO off
title DSave
echo =========================
echo S - Save
echo R - Restore 
echo E - Exit
echo =========================
:a
choice /c SRE /m "Save or Restore?"
if %errorlevel%==1 goto s
if %errorlevel%==2 goto r
if %errorlevel%==3 goto end
exit/b
:s
if not exist C:\Users\%USERNAME%\Documents\DSave mkdir C:\Users\%USERNAME%\Documents\DSave
reg save HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop C:\Users\%USERNAME%\Documents\DSave\Save.reg /y
powershell Compress-Archive C:\Users\%USERNAME%\Desktop C:\Users\%USERNAME%\Documents\DSave\Save.zip -Force
goto a
:r
if not exist C:\Users\%USERNAME%\Documents\DSave\DESave mkdir C:\Users\%USERNAME%\Documents\DSave\DESave
powershell Expand-Archive C:\Users\%USERNAME%\Documents\DSave\Save.zip C:\Users\%USERNAME%\Documents\DSave\DESave
For %%F In ("C:\Users\%USERNAME%\Documents\DSave\DESave\Desktop\*.*") Do If Not Exist "C:\Users\%USERNAME%\Desktop\%%~nxF" Copy "%%F" "C:\Users\%USERNAME%\Desktop\"
rmdir /s /q C:\Users\%USERNAME%\Documents\DSave\DESave 
reg restore HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags\1\Desktop C:\Users\%USERNAME%\Documents\DSave\Save.reg
taskkill /im explorer.exe /f
start explorer.exe
goto a
:end
exit /b
