@echo off
:: Check if exists the current testcase.
set /a case=%1
set test_in=in%case%.in
set test_out=out%case%.out
set pat=%2\tests\
set /a status=%3
set result=[1mStatus:[0m [92mAccepted[0m
if %status%==2 set result=[1mStatus:[0m [91mRuntime Error[0m
if %status%==3 set result=[1mStatus:[0m [91mTime Limit Exceed[0m
if %status%==4 set result=[1mStatus:[0m [91mWrong Answer[0m
if not exist %pat%%test_in% echo %result%  & echo ------------------------------------------------------------------------------ & del sol.exe & set /p ex=Continue.. & exit
set verdict=[1mCase[0m #%case% : [92mOK[0m
set /p time_limit=<%pat%\time-limit\time-limit.out
set /a limit=%time_limit%
set /a stat=1
start /b sol.exe<%pat%%test_in%>%cd%\sol_out.out
timeout /t %limit% >nul
taskkill /f /t /im "sol.exe" >nul 2>&1
set /a errlv=%errorlevel%
if %errlv%==0 set verdict=[1mCase[0m #%case% : [91mTLE[0m & set /a stat=3
if %stat% neq 3 sol.exe<%pat%%test_in%>%cd%\sol_out.out 
if %errorlevel% leq -1 (set verdict=[1mCase[0m #%case% : [91mRTE[0m & set /a stat=2)
fc sol_out.out %pat%%test_out%>nul
if errorlevel 1 if %stat%==1 set verdict=[1mCase[0m #%case% : [91mWA[0m & set /a got=1 & set /a stat=4
if %stat%==2 set /a status=2
if %stat%==3 if %status% neq 2 set /a status=3
if %stat%==4 if %status%==1 set /a status=4
echo %verdict%
:: Thanks to jacob for helping in the format decision :)
if %stat%==4 echo. & echo [95mInput: [0m & type %pat%%test_in% & echo. & echo [95mOutput: [0m & type sol_out.out & echo.
del sol_out.out
set /a new_case=%case% + 1
simple_judge.bat %new_case% %2 %status%


