cmake_minimum_required(VERSION 3.20)
project(myproject C)

set(CMAKE_C_STANDARD 11)

add_executable(myproject
    src/main.c
)

# Optional: strip debug symbols for release
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    target_link_options(myproject PRIVATE -s)
endif()