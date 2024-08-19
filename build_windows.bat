@echo off
setlocal

cl.exe /nologo HandmadeMath.c /link /DLL /OUT:HandmadeMath.dll &&^
del HandmadeMath.obj HandmadeMath.lib HandmadeMath.exp
