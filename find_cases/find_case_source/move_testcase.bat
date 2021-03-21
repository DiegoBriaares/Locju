@echo off
set project=%1
if not exist %project%\Found\ mkdir %project%\Found\
move %cd%\ok.out %project%\Found\>nul
move %cd%\out.out %project%\Found\>nul
move %cd%\test.in %project%\Found\>nul