@echo off
set project=%2
cd %project%
if not exist %cd%\validator\validator.cpp echo [91mRequired "validator.cpp"[0m
if not exist %cd%\validator\validator.cpp set /p ex=Continue..
if not exist %cd%\validator\validator.cpp exit
set /a comp=0
if not exist %cd%\validator\validator.exe echo [95mCompiling "validator.cpp"..[0m
if not exist %cd%\validator\validator.exe cd validator & g++ validator.cpp -o validator.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1 & cd ..
if not exist %cd%\validator\validator.exe echo [91mCompilation Failed[0m & del sol.exe & set /p ex=Continue.. & exit
:: Check if exists the current testcase.
set /a case=%1
cd C:\Locju\judge_cases\evaluation\
if %case%==1 echo ------------------------------------------------------------------------------
set test_in=in%case%.in
set test_out=out%case%.out
set pat=%project%\tests\
set /a status=%3
set result=[1mStatus:[0m [92mAccepted[0m
if %status%==2 set result=[1mStatus:[0m [91mRuntime Error[0m
if %status%==3 set result=[1mStatus:[0m [91mTime Limit Exceed[0m
if %status%==4 set result=[1mStatus:[0m [91mWrong Answer[0m
if not exist %pat%\%test_in% echo %result% & echo ------------------------------------------------------------------------------ & set /p ex=Continue.. & del sol.exe & exit


del C:\Locju\utilities\validator\combine_files\combined
cd. >C:\Locju\utilities\validator\combine_files\combined
C:\Locju\utilities\validator\combine_files\dist\combine\combine.exe<%pat%%test_in%
C:\Locju\utilities\validator\combine_files\dist\combine\combine.exe<%pat%%test_out%


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

C:\Locju\utilities\validator\combine_files\dist\combine\combine.exe<sol_out.out
%project%\validator\validator.exe<C:\Locju\utilities\validator\combine_files\combined>veredict
echo YES>yes
fc veredict yes>nul
if errorlevel 1 if %stat%==1 set verdict=[1mCase[0m #%case% : [91mWA[0m & set /a got=1 & set /a stat=4
if %stat%==2 set /a status=2
if %stat%==3 if %status% neq 2 set /a status=3
if %stat%==4 if %status%==1 set /a status=4
echo %verdict%
if %stat%==4 echo. & echo [95mInput: [0m & type %pat%%test_in% & echo. & echo [95mOutput: [0m & type sol_out.out & echo.
del sol_out.out
del yes
del veredict
del C:\Locju\utilities\validator\combine_files\combined
cd. >C:\Locju\utilities\validator\combine_files\combined
set /a new_case=%case% + 1
validation_judge.bat %new_case% %project% %status%

