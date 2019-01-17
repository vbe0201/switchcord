function(switchcord_info message)
    if (switchcord_VERBOSE)
        message("Build Info: ${message}")
    endif ()
endfunction()

function(switchcord_panic message)
    message(FATAL_ERROR message)
endfunction()