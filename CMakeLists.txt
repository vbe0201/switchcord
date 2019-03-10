cmake_minimum_required(VERSION 3.7)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(switchcord-options)
include(switchcord-utils)

project(switchcord)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin CACHE INTERNAL "" FORCE)
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE INTERNAL "" FORCE)
set(TESTS_OUTPUT_DIR ${EXECUTABLE_OUTPUT_PATH}/tests CACHE INTERNAL "" FORCE)

if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT Release)
endif ()

# If exists, copy pre-commit hook for the project.
if (NOT EXISTS ${PROJECT_SOURCE_DIR}/.git/hooks/pre-commit)
    switchcord_status("Copying pre-commit hook")
    file(COPY hooks/pre-commit
        DESTINATION ${PROJECT_SOURCE_DIR}/.git/hooks)
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

# Discord-specific options.
set(DISCORD_API_URL "\"https://discordapp.com/api\"")
set(DISCORD_API_VERSION "\"/v7\"")
set(DISCORD_GATEWAY_VERSION "\"?v=6\"")
set(DISCORD_VOICE_GATEWAY_VERSION "\"?v=4\"")

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

configure_file(
    "${PROJECT_SOURCE_DIR}/switchcord_meta.h.in"
    "${PROJECT_BINARY_DIR}/switchcord_meta.h"
)

include_directories(${PROJECT_BINARY_DIR})

switchcord_info("Building Switchcord version ${switchcord_FULL_VERSION}")

include(include/CMakeLists.txt)
include(src/CMakeLists.txt)

add_nro_target(switchcord.elf
    ${switchcord_TITLE} ${switchcord_AUTHOR}
    ${switchcord_FULL_VERSION} ${switchcord_ICON})
