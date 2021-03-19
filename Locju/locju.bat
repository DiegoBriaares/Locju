@echo off
set time_limit=1
if %1==start robocopy C:\Locju\templates\validator %cd%\validator>nul /E & robocopy C:\Locju\templates\generator %cd%\generator>nul /E & robocopy C:\Locju\templates\correct_solution %cd%\correct_solution>nul /E & copy C:\Locju\templates\sol.cpp %cd%>nul & if not exist %cd%\tests mkdir %cd%\tests & if not exist %cd%\tests\time-limit mkdir %cd%\tests\time-limit & if not exist %cd%\tests\time-limit\time-limit.out echo %time_limit% >%cd%\tests\time-limit\time-limit.out & echo [92mLocal Judge succesfully created[0m & set /p ex=press any key & exit
if %1==judge C:\Locju\judge_cases\judge.bat %cd%
if %1==validatorjudge C:\Locju\judge_cases\judge_with_validator.bat %cd%
if %1==find C:\Locju\find_cases\find_case.bat %cd%
if %1==validatorfind C:\Locju\find_cases\validator_find_case.bat %cd%
if %1==compile C:\Locju\compile_everything.bat %cd%
if %1==startcf C:\Locju\start_cf_round.bat
