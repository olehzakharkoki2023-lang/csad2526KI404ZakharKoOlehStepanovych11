cmake_minimum_required(VERSION 3.10)

# Set the project name
project(csad2526KI404ZakharKoOlehStepanovych11)

# Fix LNK2038 error by forcing Dynamic Runtime Linking (Essential for MSVC in CI)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL" CACHE STRING "" FORCE)

# FINAL AGGRESSIVE FIX FOR WINDOWS LINKING (LNK2038)
# We apply necessary compiler/linker flags globally for MSVC targets
if (MSVC)
    # Use C++ standard 17 which is required by some gtest settings
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED True)

    # Force dynamic link flags globally
    add_compile_options("/MDd")
    add_link_options("/NODEFAULTLIB:libcmtd")
endif()
# END FIX

# Enable testing
enable_testing()

# Find Threads
find_package(Threads REQUIRED)

# Use FetchContent to download Google Test (Guaranteed download)
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
)
FetchContent_MakeAvailable(googletest)

# Add static library for math_operations
add_library(math_operations STATIC math_operations.cpp)

# Add executable for main application
add_executable(test_app main.cpp)
target_link_libraries(test_app PRIVATE math_operations)

# Add executable for unit tests
add_executable(unit_tests tests/unit_tests.cpp)
target_link_libraries(unit_tests PRIVATE math_operations GTest::gtest GTest::gtest_main Threads::Threads)

# Register the unit tests
add_test(NAME unit_tests COMMAND unit_tests)

# The problematic 'run_tests' custom target is removed.