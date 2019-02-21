cmake_minimum_required(VERSION 3.7)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/externals/cmake-modules")
include(switchcord-utils)
include(switchcord-options)

project(switchcord CXX)

set(TARGET switchcord)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(WITH_PORTLIBS ON CACHE BOOL "Use portlibs?")

# Check for the devkitPro environment variable.
# Without it, we're unable to build the project.
if (NOT DEFINED ENV{DEVKITPRO})
    switchcord_panic("Please set DEVKITPRO in your environemnt. export DEVKITPRO=/path/to/devkitpro")
endif ()

set(DEVKITPRO $ENV{DEVKITPRO})
set(LIBNX ${DEVKITPRO}/libnx)
set(PORTLIBS_PATH ${DEVKITPRO}/portlibs)
set(PORTLIBS ${PORTLIBS_PATH}/switch)

# If exists, copy pre-commit hook for the project.
if (NOT EXISTS ${PROJECT_SOURCE_DIR}/.git/hooks/pre-commit)
    switchcord_status_message("Copying pre-commit hook")
    file(COPY hooks/pre-commit
            DESTINATION ${PROJECT_SOURCE_DIR}/.git/hooks)
endif ()

set(CMAKE_SUPPRESS_REGENERATION true)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "" FORCE)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE INTERNAL "" FORCE)
set(TESTS_OUTPUT_DIR ${EXECUTABLE_OUTPUT_PATH}/tests CACHE INTERNAL "" FORCE)

if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT Release)
endif ()

set(switchcord_VERSION_MAJOR 0)
set(switchcord_VERSION_MINOR 0)
set(switchcord_VERSION_MICRO 1)
set(switchcord_FULL_VERSION
        "${switchcord_VERSION_MAJOR}.${switchcord_VERSION_MINOR}.${switchcord_VERSION_MICRO}")

# Meta information for the homebrew app.
set(switchcord_TITLE "Switchcord")
set(switchcord_AUTHOR "Valentin B.")
set(switchcord_ICON "${PROJECT_SOURCE_DIR}/assets/discord-logo.png")

set(CMAKE_C_STANDARD 11)
if (switchcord_USE_CPP_17)
    set(CMAKE_CXX_STANDARD 17)
else ()
    set(CMAKE_CXX_STANDARD 11)
endif ()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(clang-utils)
endif ()

include(nx-utils)

# libnx only compiles with some modified version of GCC
# we need to set as our compiler first.
if (WIN32)
    set(CMAKE_C_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc.exe")
    set(CMAKE_CXX_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-g++.exe")
    set(CMAKE_AR "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ar.exe" CACHE STRING "")
    set(CMAKE_RANLIB "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ranlib.exe" CACHE STRING "")
else ()
    set(CMAKE_C_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc")
    set(CMAKE_CXX_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-g++")
    set(CMAKE_AR "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ar" CACHE STRING "")
    set(CMAKE_RANLIB "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ranlib" CACHE STRING "")
endif ()

# Compile flags.
set(ARCH "-march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE")
set(NX_C_COMPILE_FLAGS "-g -Wall -O2 -ffunction-sections -D__SWITCH__ ${ARCH}")
set(NX_CXX_COMPILE_FLAGS "${NX_C_COMPILE_FLAGS} -std=c++17 -fno-rtti -fno-exceptions")
set(NX_LINK_FLAGS "-specs=${LIBNX}/switch.specs -g ${ARCH} -Wl,-Map,${TARGET}.map")

# Prevent CMake from assuming we're compiling for macOS and adding platform specific flags
# that strip symbols from resulting elf files.
if (APPLE)
    string ( REPLACE "-Wl,-search_paths_first" "" CMAKE_C_LINK_FLAGS ${CMAKE_C_LINK_FLAGS} )
    string ( REPLACE "-Wl,-search_paths_first" "" CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} )
    string ( REPLACE "-Wl,-headerpad_max_install_names" "" CMAKE_C_LINK_FLAGS ${CMAKE_C_LINK_FLAGS} )
    string ( REPLACE "-Wl,-headerpad_max_install_names" "" CMAKE_CXX_LINK_FLAGS ${CMAKE_CXX_LINK_FLAGS} )
endif ()

set(CMAKE_C_COMPILE_FLAGS "${CMAKE_C_COMPILE_FLAGS} ${NX_C_COMPILE_FLAGS}")
set(CMAKE_CXX_COMPILE_FLAGS  "${CMAKE_CXX_COMPILE_FLAGS} ${NX_CXX_COMPILE_FLAGS}")
set(CMAKE_C_LINK_FLAGS  "${CMAKE_C_LINK_FLAGS} ${NX_LINK_FLAGS}")
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} ${NX_LINK_FLAGS}")
set(CMAKE_STATIC_LINKER_FLAGS_INIT
        "-march=armv8-a -mtune=cortex-a57 -mtp=soft -L${DEVKITPRO}/libnx/lib -L${DEVKITPRO}/portlibs/switch/lib")
set(CMAKE_EXE_LINKER_FLAGS_INIT
        "-specs=${DEVKITPRO}/libnx/switch.specs -march=armv8-a -mtune=cortex-a57
        -mtp=soft -fPIE -L${DEVKITPRO}/libnx/lib -L${DEVKITPRO}/portlibs/switch/lib")

if (WITH_PORTLIBS)
    set(CMAKE_FIND_ROOT_PATH
            ${DEVKITPRO}/devkitA64 ${DEVKITPRO} ${DEVKITPRO}/libnx ${DEVKITPRO}/portlibs/switch)
else ()
    set(CMAKE_FIND_ROOT_PATH
            ${DEVKITPRO}/devkitA64 ${DEVKITPRO}/libnx ${DEVKITPRO})
endif ()

include_directories(${PROJECT_BINARY_DIR})
include_directories(${PORTLIBS}/include)
include_directories(${LIBNX}/include)

link_directories(${PORTLIBS}/lib)
link_directories(${LIBNX}/lib)

set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "Shared libs not available")
set(CMAKE_INSTALL_PREFIX ${DEVKITPRO}/portlibs/switch)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

include(include/CMakeLists.txt)
include(src/CMakeLists.txt)

switchcord_info("Building Switchcord version ${switchcord_FULL_VERSION}")

target_link_libraries("${TARGET}.elf" nx)

set_target_properties("${TARGET}.elf" PROPERTIES LINKER_LANGUAGE CXX)

# Directly builds the actual .nro binary.
__add_nro_target("${TARGET}.elf"
        ${switchcord_TITLE} ${switchcord_AUTHOR} ${switchcord_FULL_VERSION} ${switchcord_ICON})
