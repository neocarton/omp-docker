@echo off

set OMP_BASE_DIR=%~dp0
set WORKSPACE_DIR=%CD%
for %%I in ("%WORKSPACE_DIR%") do set BASENAME=%%~nxI

cd %WORKSPACE_DIR%
docker run -v %OMP_BASE_DIR%/data:/root ^
    -v "%WORKSPACE_DIR%:/projects/%BASENAME%" -w "/projects/%BASENAME%" ^
    --rm
