#############
## ELF2NRO ##
#############
if (NOT ELF2NRO)
    find_program(ELF2NRO elf2nro ${DEVKITPRO}/tools/bin)
    if (ELF2NRO)
        switchcord_status("elf2nro: ${ELF2NRO} - found")
    else ()
        switchcord_warning("elf2nro - not found")
    endif ()
endif ()

################
##  NACPTOOL  ##
################
if (NOT NACPTOOL)
    find_program(NACPTOOL nacptool ${DEVKITPRO}/tools/bin)
    if (NACPTOOL)
        switchcord_status("nacptool: ${NACPTOOL} - found")
    else ()
        switchcord_warning("nacptool - not found")
    endif ()
endif ()

function(add_nacp target APP_TITLE APP_AUTHOR APP_VERSION)
    set(__NACP_COMMAND ${NACPTOOL} --create ${APP_TITLE} ${APP_AUTHOR} ${APP_VERSION} ${target})

    add_custom_command(OUTPUT ${target}
        COMMAND ${__NACP_COMMAND}
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        VERBATIM
        )
endfunction()

function(add_nro_target target APP_TITLE APP_AUTHOR APP_VERSION APP_ICON)
    get_filename_component(target_we ${target} NAME_WE)

    if (NOT ${CMAKE_BINARY_DIR}/${target_we}.nacp)
        add_nacp(${CMAKE_BINARY_DIR}/${target_we}.nacp ${APP_TITLE} ${APP_AUTHOR} ${APP_VERSION})
    endif ()

    add_custom_command(OUTPUT ${EXECUTABLE_OUTPUT_PATH}/${target_we}.nro
        COMMAND ${ELF2NRO} $<TARGET_FILE:${target}> ${EXECUTABLE_OUTPUT_PATH}/${target_we}.nro --nacp=${target_we}.nacp --icon=${APP_ICON}
        DEPENDS ${target} ${CMAKE_BINARY_DIR}/${target_we}.nacp
        VERBATIM
        )

    if (CMAKE_RUNTIME_OUTPUT_DIRECTORY)
        add_custom_target(${target_we}.nro ALL SOURCES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${target_we}.nro)
    else ()
        add_custom_target(${target_we}.nro ALL SOURCES ${EXECUTABLE_OUTPUT_PATH}/${target_we}.nro)
    endif ()
endfunction()