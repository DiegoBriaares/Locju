@echo off
set /p round=[1mEnter round:[0m 
echo %round% %cd%>round_number

C:\Locju\usability\dist\get_tests\get_tests.exe<round_number
set /a err=%ERRORLEVEL%
del round_number
set /p ex=Continue..