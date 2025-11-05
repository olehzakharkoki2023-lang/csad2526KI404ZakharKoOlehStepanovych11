@echo off

:: Exit immediately if a command fails
setlocal enabledelayedexpansion

:: Create build directory if it doesn't exist
if not exist build (
    echo Creating build directory...
    mkdir build
)

:: Navigate to the build directory
cd build

:: Configure the project
cmake ..
if %errorlevel% neq 0 (
    echo CMake configuration FAILED.
    exit /b 1
)
echo CMake configuration SUCCESS.

:: Build the project
cmake --build .
if %errorlevel% neq 0 (
    echo Build FAILED.
    exit /b 1
)
echo Build SUCCESS.

:: Run tests
ctest --output-on-failure
if %errorlevel% neq 0 (
    echo Tests FAILED.
    exit /b 1
)
echo Tests SUCCESS.