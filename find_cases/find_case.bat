@echo off
set project=%1
cd %project%
if not exist sol.cpp echo [91mRequired "sol.cpp"[0m 
if not exist sol.cpp set /p ex=Continue..
if not exist sol.cpp exit
set /a comp=0
if not exist sol.exe echo [95mCompiling "sol.cpp"..[0m & g++ sol.cpp -o sol.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist sol.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd generator
if not exist generator.cpp echo [91mRequired "generator.cpp"[0m 
if not exist generator.cpp set /p ex=Continue..
if not exist generator.cpp exit
set /a comp=0
if not exist generator.exe echo [95mCompiling "generator.cpp"..[0m & g++ generator.cpp -o generator.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist generator.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd ..
cd correct_solution
if not exist correct_sol.cpp echo [91mRequired "correct_sol.cpp"[0m 
if not exist correct_sol.cpp set /p ex=Continue..
if not exist correct_sol.cpp exit
set /a comp=0
if not exist correct_sol.exe echo [95mCompiling "correct_sol.cpp"..[0m & g++ correct_sol.cpp -o correct_sol.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist correct_sol.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd ..
set /p rep=[1mNumber of testcases to generate: [0m
if %rep% LSS 0 echo ------------------------------------------------------------------------------ & echo A Positive number & set /p ex=Try again.. & exit
copy %cd%\sol.exe C:\Locju\find_cases\find_case_source\>nul
cd C:\Locju\find_cases\find_case_source\
echo [93mLooking for cases..[0m
search_case.bat %rep% %rep% %project%


