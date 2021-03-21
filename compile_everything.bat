@echo off
set project=%1
cd %project%
if not exist sol.cpp echo [91mRequired "sol.cpp"[0m 
if not exist sol.cpp set /p ex=Continue..
if not exist sol.cpp exit
set /a comp=0
echo [95mCompiling "sol.cpp"..[0m & g++ sol.cpp -o sol.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist sol.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd generator
if not exist generator.cpp echo [91mRequired "generator.cpp"[0m 
if not exist generator.cpp set /p ex=Continue..
if not exist generator.cpp exit
set /a comp=0
echo [95mCompiling "generator.cpp"..[0m & g++ generator.cpp -o generator.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist generator.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd ..
cd correct_solution
if not exist correct_sol.cpp echo [91mRequired "correct_sol.cpp"[0m 
if not exist correct_sol.cpp set /p ex=Continue..
if not exist correct_sol.cpp exit
set /a comp=0
echo [95mCompiling "correct_sol.cpp"..[0m & g++ correct_sol.cpp -o correct_sol.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist correct_sol.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd ..
cd validator
if not exist validator.cpp echo [91mRequired "validator.cpp"[0m 
if not exist validator.cpp set /p ex=Continue..
if not exist validator.cpp exit
set /a comp=0
echo [95mCompiling "validator.cpp"..[0m & g++ validator.cpp -o validator.exe -ggdb -DDEBUG -std=c++17 -O2 -Wl,--stack=256000000 -Wall -Wextra -Wshadow -DLOCAL & set /a comp=1
if not exist validator.exe echo [91mCompilation Failed[0m & set /p ex=Continue.. & exit
cd ..
set /p ex=press any key 
