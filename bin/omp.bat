@echo off

set LLAMA_CPP_BASE_URL="http://host.docker.internal:8080/v1"
set OMP_BASE_DIR=%~dp0
set WORKSPACE_DIR=%CD%
for %%I in ("%WORKSPACE_DIR%") do set BASENAME=%%~nxI

cd %WORKSPACE_DIR%
docker run -e LLAMA_CPP_BASE_URL="%LLAMA_CPP_BASE_URL%" ^
    -v %OMP_BASE_DIR%/data:/root ^
    -v "%WORKSPACE_DIR%:/projects/%BASENAME%" -w "/projects/%BASENAME%" ^
    --rm -it omp %*
