@echo off
set /a it=%1
set project=%3
echo YES>yes
cd. >verdict
if %it%==0 echo ------------------------------------------------------------------------------ & echo Verdict: [92mAccepted[0m & echo ------------------------------------------------------------------------------ & echo [95mAll tests passed[0m & set /p ex=Continue.. & del out.out & del ok.out & del test.in & del sol.exe & del yes & del verdict & exit
set /a am=%2 - %1 + 1
echo %am%/%2
del C:\Locju\utilities\validator\combine_files\combined
cd. >C:\Locju\utilities\validator\combine_files\combined
%project%\generator\generator.exe>test.in
C:\Locju\utilities\validator\combine_files\dist\combine\combine.exe<test.in
%project%\correct_solution\correct_sol.exe<test.in>%cd%\ok.out
C:\Locju\utilities\validator\combine_files\dist\combine\combine.exe<ok.out
sol.exe<test.in>out.out


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
C:\Locju\utilities\validator\combine_files\dist\combine\combine.exe<out.out
%project%\validator\validator.exe<C:\Locju\utilities\validator\combine_files\combined>verdict
del C:\Locju\utilities\validator\combine_files\combined
cd. >C:\Locju\utilities\validator\combine_files\combined
fc verdict yes>nul
if errorlevel 1 if %stat%==1 set verdict=[1mCase[0m #%case% : [91mWA[0m & set /a got=1 & set /a stat=4
del yes
del verdict
if %stat% neq 1 echo ------------------------------------------------------------------------------ & echo %verdict% & echo [96mTestcase:[0m test.in & echo [96mYour output:[0m out.out & echo [96mExpected output:[0m ok.out & echo ------------------------------------------------------------------------------ & echo [95mCheck "Found" folder[0m & set /p ex=Continue.. & del sol.exe & %cd%\move_testcase.bat %project% & exit
del C:\Locju\utilities\validator\combine_files\combined
cd. >C:\Locju\utilities\validator\combine_files\combined
set /a rep=%it% - 1
validator_search_case.bat %rep% %2 %project%
