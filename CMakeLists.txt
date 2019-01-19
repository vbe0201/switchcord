cmake_minimum_required(VERSION 3.9)
project(switchcord CXX)

# Check for devkitPro environment variable.
if (NOT DEFINED ENV{DEVKITPRO})
    message( FATAL_ERROR "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro")
endif ()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(SWITCH_LIBNX TRUE)

set(DEVKITPRO "$ENV{DEVKITPRO}")
set(LIBNX "${DEVKITPRO}/libnx")
set(PORTLIBS_PATH "${DEVKITPRO}/portlibs")
set(PORTLIBS "${PORTLIBS_PATH}/switch")

set(CMAKE_SUPPRESS_REGENERATION true)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "" FORCE)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE INTERNAL "" FORCE)
set(TESTS_OUTPUT_DIR ${EXECUTABLE_OUTPUT_PATH}/tests CACHE INTERNAL "" FORCE)

if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT "Release")
endif ()

# Packaging info.
set(TARGET "switchcord")

set(switchcord_VERSION_MAJOR 1)
set(switchcord_VERSION_MINOR 0)
set(switchcord_VERSION_MICRO 0)
set(switchcord_VERSION_FULL "${switchcord_VERSION_MAJOR}.${switchcord_VERSION_MINOR}.${switchcord_VERSION_MICRO}")

set(switchcord_TITLE "Switchcord")
set(switchcord_AUTHOR "Valentin B.")
set(switchcord_ICON "assets/discord-logo.png")

set(BUILD_EXEFS_SRC "exefs_src")

include(cmake/switchcord-options.cmake)
include(cmake/switchcord-dev-tools.cmake)

set(CMAKE_CXX_STANDARD 17)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(cmake/clang-cxx-dev-tools.cmake)
endif ()

if (switchcord_VERBOSE)
    switchcord_info("Building switchcord version ${switchcord_VERSION_FULL}")
endif ()

# Build packaging script with info.
configure_file(
        "${PROJECT_SOURCE_DIR}/package_switch.sh.in"
        "${PROJECT_SOURCE_DIR}/package_switch.sh"
)

set(ARCH "-march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE")
set(NX_C_COMPILE_FLAGS "-g -Wall -O2 -ffunction-sections -D__SWITCH__ ${ARCH}")
set(NX_CXX_COMPILE_FLAGS "${NX_C_COMPILE_FLAGS} -std=c++17 -fno-rtti -fno-exceptions")
set(NX_LINK_FLAGS "-specs=${LIBNX}/switch.specs -g ${ARCH} -Wl,-Map,${TARGET}.map")

# Prevent CMake from assuming we're compiling for macOS and adding platform specific flags
# that strip symbols from resulting elf files.
if (APPLE )
    string ( REPLACE "-Wl,-search_paths_first" "" CMAKE_C_LINK_FLAGS ${CMAKE_C_LINK_FLAGS} )
    string ( REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} )
    string ( REPLACE "-Wl,-headerpad_max_install_names" "" CMAKE_C_LINK_FLAGS ${CMAKE_C_LINK_FLAGS} )
    string ( REPLACE "-Wl,-headerpad_max_install_names" "" CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} )
endif ()

set(CMAKE_CXX_COMPILE_FLAGS  "${CMAKE_CXX_COMPILE_FLAGS} ${NX_CXX_COMPILE_FLAGS}")
set(CMAKE_CXX_LINK_FLAGS  "${CMAKE_CXX_LINK_FLAGS} ${NX_LINK_FLAGS}")

LIST(APPEND CMAKE_PROGRAM_PATH  "${DEVKITPRO}/tools/bin")
LIST(APPEND CMAKE_PROGRAM_PATH  "${DEVKITPRO}/devkitA64/bin")

include(include/CMakeLists.txt)
include(src/CMakeLists.txt)

include_directories("${PROJECT_BINARY_DIR}")
include_directories("${PORTLIBS}/include")
include_directories("${LIBNX}/include")

link_directories("${LIBNX}/lib")
link_directories("${PORTLIBS}/lib")

add_executable("${TARGET}-cpp.elf"
        "${switchcord_SOURCE_DIR}/main.cc")
target_link_libraries("${TARGET}-cpp.elf" nx)

set_target_properties("${TARGET}-cpp.elf" PROPERTIES LINKER_LANGUAGE CXX)