#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
    echo "Creating build directory..."
    mkdir build
fi

# Navigate to the build directory
cd build

# Configure the project
if cmake ..; then
    echo "CMake configuration successful."
else
    echo "CMake configuration failed." >&2
    exit 1
fi

# Build the project
if cmake --build .; then
    echo "Build successful."
else
    echo "Build failed." >&2
    exit 1
fi

# Run tests
if ctest --output-on-failure; then
    echo "All tests passed successfully."
else
    echo "Some tests failed." >&2
    exit 1
fi