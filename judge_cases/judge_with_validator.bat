@echo off
set project=%1
cd %project%
if not exist sol.cpp echo [91mRequired "sol.cpp"..[0m
if not exist sol.cpp set /p ex=Continue..
if not exist sol.cpp exit
set /a comp=0
if not exist sol.exe echo [95mCompiling "sol.cpp"..[0m & g++ sol.cpp -o sol.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist sol.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
copy %cd%\sol.exe C:\Locju\judge_cases\evaluation\>nul
cd C:\Locju\judge_cases\evaluation\
validation_judge.bat 1 %project% 1