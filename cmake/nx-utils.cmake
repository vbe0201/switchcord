#############
## ELF2NRO ##
#############
if (NOT ELF2NRO)
    find_program(ELF2NRO elf2nro ${DEVKITPRO}/tools/bin)
    if (ELF2NRO)
        switchcord_status_message("elf2nro: ${ELF2NRO} - found")
    else ()
        switchcord_warning("elf2nro - not found")
    endif ()
endif ()

#############
## ELF2KIP ##
#############
if (NOT ELF2KIP)
    find_program(ELF2KIP elf2kip ${DEVKITPRO}/tools/bin)
    if (ELF2KIP)
        switchcord_status_message("elf2kip: ${ELF2KIP} - found")
    else ()
        switchcord_warning("elf2kip - not found")
    endif ()
endif ()

#############
## ELF2NSO ##
#############
if (NOT ELF2NSO)
    find_program(ELF2NSO elf2nso ${DEVKITPRO}/tools/bin)
    if (ELF2NSO)
        switchcord_status_message("elf2nso: ${ELF2NSO} - found")
    else ()
        switchcord_warning("elf2nso - not found")
    endif ()
endif ()

#############
##  BIN2S  ##
#############
if (NOT BIN2S)
    find_program(BIN2S bin2s ${DEVKITPRO}/tools/bin)
    if (BIN2S)
        switchcord_status_message("bin2s: ${BIN2S} - found")
    else ()
        switchcord_warning("bin2s - not found")
    endif ()
endif ()

#############
##  RAW2C  ##
#############
if (NOT RAW2C)
    find_program(RAW2C raw2c ${DEVKITPRO}/tools/bin)
    if (RAW2C)
        switchcord_status_message("raw2c: ${RAW2C} - found")
    else ()
        switchcord_warning("raw2c - not found")
    endif ()
endif ()

##################
##  BUILD_PFS0  ##
##################
if (NOT BUILD_PFS0)
    find_program(BUILD_PFS0 build_pfs0 ${DEVKITPRO}/tools/bin)
    if (BUILD_PFS0)
        switchcord_status_message("build_pfs0: ${BUILD_PFS0} - found")
    else ()
        switchcord_warning("build_pfs0 - not found")
    endif ()
endif ()

################
##  NACPTOOL  ##
################
if (NOT NACPTOOL)
    find_program(NACPTOOL nacptool ${DEVKITPRO}/tools/bin)
    if (NACPTOOL)
        switchcord_status_message("nacptool: ${NACPTOOL} - found")
    else ()
        switchcord_warning("nacptool - not found")
    endif ()
endif ()

function(__add_nacp target APP_TITLE APP_AUTHOR APP_VERSION)
    set(__NACP_COMMAND ${NACPTOOL} --create ${APP_TITLE} ${APP_AUTHOR} ${APP_VERSION} ${CMAKE_CURRENT_BINARY_DIR}/${target})

    add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}
            COMMAND ${__NACP_COMMAND}
            WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
            VERBATIM
            )
endfunction()

function(__add_nro_target target APP_TITLE APP_AUTHOR APP_VERSION APP_ICON)
    get_filename_component(target_we ${TARGET} NAME_WE)

    if (NOT ${target_we}.nacp)
        __add_nacp(${target_we}.nacp ${APP_TITLE} ${APP_AUTHOR} ${APP_VERSION})
    endif ()

    add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/bin/${target_we}.nro
            COMMAND ${ELF2NRO} $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/bin/${target_we}.nro --nacp=${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nacp --icon=${APP_ICON}
            DEPENDS ${target} ${CMAKE_CURRENT_BINARY_DIR}/${target_we}.nacp
            VERBATIM
            )

    if (CMAKE_RUNTIME_OUTPUT_DIRECTORY)
        add_custom_target(${target_we}_nro ALL SOURCES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/bin/${target_we}.nro)
    else ()
        add_custom_target(${target_we}_nro ALL SOURCES ${CMAKE_CURRENT_BINARY_DIR}/bin/${target_we}.nro)
    endif ()
endfunction()
