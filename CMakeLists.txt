cmake_minimum_required(VERSION 3.9)
project(switchcord CXX)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "" FORCE)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE INTERNAL "" FORCE)
set(TESTS_OUTPUT_DIR ${EXECUTABLE_OUTPUT_PATH}/tests CACHE INTERNAL "" FORCE)

if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT "Release")
endif ()

set(CMAKE_SUPPRESS_REGENERATION true)

set(switchcord_VERSION_MAJOR 1)
set(switchcord_VERSION_MINOR 0)
set(switchcord_VERSION_MICRO 0)
set(switchcord_VERSION_FULL "${switchcord_VERSION_MAJOR}.${switchcord_VERSION_MINOR}.${switchcord_VERSION_MICRO}")

include(cmake/switchcord-options.cmake)
include(cmake/switchcord-dev-tools.cmake)

if (switchcord_USE_CPP_17)
    set(CMAKE_CXX_STANDARD 17)
else ()
    set(CMAKE_CXX_STANDARD 11)
endif ()
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(cmake/clang-cxx-dev-tools.cmake)
endif ()

if (switchcord_VERBOSE)
    switchcord_info("Building switchcord version ${switchcord_VERSION_FULL}")
endif ()

include(include/CMakeLists.txt)
include(src/CMakeLists.txt)

set_target_properties(switchcord PROPERTIES LINKER_LANGUAGE CXX)