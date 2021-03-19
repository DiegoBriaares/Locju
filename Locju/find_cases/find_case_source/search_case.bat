@echo off
set /a it=%1
set project=%3
if %it%==0 echo ------------------------------------------------------------------------------ & echo [1mVerdict :[0m [92mAccepted[0m & echo ------------------------------------------------------------------------------ & echo [95mAll tests passed[0m & set /p ex=Successful search & del out.out & del ok.out & del test.in & del sol.exe & exit
set /a am=%2 - %1 + 1
echo %am%/%2
%project%\generator\generator.exe>test.in

set verdict=[1mCase[0m #%case% : [92mOK[0m
set /p time_limit=<%project%\tests\time-limit\time-limit.out
set /a limit=%time_limit%
set /a stat=1
start /b sol.exe<test.in>%cd%\out.out
timeout /t %limit% >nul
taskkill /f /t /im "sol.exe" >nul 2>&1
set /a errlv=%errorlevel%
if %errlv%==0 set verdict=[1mCase[0m #%case% : [91mTLE[0m & set /a stat=3
if %stat% neq 3 sol.exe<test.in>%cd%\out.out 
if %errorlevel% leq -1 (set verdict=[1mCase[0m #%case% : [91mRTE[0m & set /a stat=2)
%project%\correct_solution\correct_sol.exe<test.in>%cd%\ok.out
fc out.out ok.out >nul
if errorlevel 1 if %stat%==1 set verdict=[1mCase[0m #%case% : [91mWA[0m & set /a got=1 & set /a stat=4

if %stat% neq 1 echo ------------------------------------------------------------------------------ & echo %verdict% & echo [96mTestcase:[0m test.in & echo [96mYour output:[0m out.out & echo [96mExpected output:[0m ok.out & echo ------------------------------------------------------------------------------ & echo [95mCheck "Found" folder[0m & set /p ex=Successful search & del sol.exe & %cd%\move_testcase.bat %project% & exit
set /a rep=%it% - 1
search_case.bat %rep% %2 %project%
