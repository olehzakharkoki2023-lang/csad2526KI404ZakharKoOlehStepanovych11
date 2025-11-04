cmake_minimum_required(VERSION 3.10)

# Set the project name
project(csad2526KI404ZakharKoOlehStepanovych11)

# Enable testing
enable_testing()

# Find Threads
find_package(Threads REQUIRED)

# Try to find Google Test
find_package(GTest CONFIG REQUIRED)
if(NOT GTest_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
    )
    FetchContent_MakeAvailable(googletest)
endif()

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

# Add custom target to run tests
add_custom_target(run_tests
    COMMAND ctest -C $<CONFIG> --output-on-failure
    DEPENDS unit_tests
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)