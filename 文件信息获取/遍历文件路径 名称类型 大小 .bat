===================================

@echo off & setlocal EnableDelayedExpansion

for /f "delims=" %%i in ('"dir /a/s/b/on *.*"') do (

set file=%%~fi	%%~ni	%%~xi	%%~zi

set file=!file:/=/!

echo !file! >> Â·¾¶.txt

)

===================================
