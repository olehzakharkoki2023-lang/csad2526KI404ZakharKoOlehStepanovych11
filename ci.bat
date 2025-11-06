@echo off

:: Exit immediately if a command fails
setlocal enabledelayedexpansion

:: --- 1. Create build directory if it doesn't exist ---
if not exist build (
    echo Creating build directory...
    mkdir build
)

:: Navigate to the build directory
cd build

:: --- 2. Configure the project ---
cmake ..
if %errorlevel% neq 0 (
    echo CMake configuration FAILED.
    exit /b 1
)
echo CMake configuration SUCCESS.

:: --- 3. Build the project ---
:: Build the project with the specified configuration (e.g., Debug)
cmake --build . --config Debug
if %errorlevel% neq 0 (
    echo Build FAILED.
    exit /b 1
)
echo Build SUCCESS.

:: --- 4. Run tests (FIXED to use Debug configuration) ---
:: We use ctest to run tests compiled in the Debug directory
ctest --test-dir . -C Debug --output-on-failure
if %errorlevel% neq 0 (
    echo Tests FAILED.
    exit /b 1
)
echo Tests SUCCESS.