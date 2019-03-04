set(switchcord_SOURCE_DIR ${PROJECT_SOURCE_DIR}/src)

file(GLOB switchcord_SOURCE_FILES RELATIVE ${switchcord_SOURCE_DIR}
    "*.cc"
    "*.cpp"
    "*.h"
    "*.hpp")

if (switchcord_VERBOSE)
    list(LENGTH switchcord_SOURCE_FILES switchcord_SOURCE_FILES_LENGTH)

    switchcord_info("Loaded ${switchcord_SOURCE_FILES_LENGTH}" source files.)
endif ()

add_executable(switchcord.elf
    ${switchcord_SOURCE_DIR}/main.cc
    ${switchcord_INCLUDE_HEADERS})

target_include_directories(switchcord.elf
    PUBLIC ${switchcord_INCLUDE_DIR})

if (LIBNX) # We're using the devkitPro toolchain.
    target_link_libraries(switchcord.elf nx)
    set_target_properties(switchcord.elf PROPERTIES
        LINKER_LANGUAGE CXX
        LINK_FLAGS "-specs=${LIBNX}/switch.specs -Wl,-no-as-needed -Wl,-Map,switchcord.map"
        )
endif ()
