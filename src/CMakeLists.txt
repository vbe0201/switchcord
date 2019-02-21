set(switchcord_SOURCE_DIR "${PROJECT_SOURCE_DIR}/src")

file(GLOB switchcord_SOURCE_FILES RELATIVE "${switchcord_SOURCE_DIR}"
        "*.cc"
        "*.cpp"
        "*.h"
        "*.hpp")

if (switchcord_VERBOSE)
    list(LENGTH switchcord_SOURCE_FILES switchcord_SOURCE_FILES_LENGTH)

    switchcord_info("Loaded ${switchcord_SOURCE_FILES_LENGTH} files.")
endif ()

add_executable("${TARGET}.elf"
        ${switchcord_SOURCE_DIR}/main.cc)
