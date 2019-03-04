if (NOT DEFINED ENV{DEVKITPRO})
    switchcord_panic("Please set DEVKITPRO in your environment.")
endif ()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# devkitPro paths are broken on Windows. We need to use this macro to fix them.
macro(msys_to_cmake_path msys_path resulting_path)
    if (WIN32)
        string(
            REGEX REPLACE "^/([a-zA-Z])/" "\\1:/" ${resulting_path} ${msys_path}
        )
    else ()
        set(${resulting_path} ${msys_path})
    endif ()
endmacro()

msys_to_cmake_path($ENV{DEVKITPRO} DEVKITPRO)
set(LIBNX ${DEVKITPRO}/libnx)
set(PORTLIBS_PATH ${DEVKITPRO}/portlibs)
set(PORTLIBS ${PORTLIBS_PATH}/switch)

set(TOOLCHAIN_PREFIX ${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-)
if (WIN32)
    set(TOOLCHAIN_SUFFIX ".exe")
else ()
    set(TOOLCHAIN_SUFFIX "")
endif ()

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc${TOOLCHAIN_SUFFIX})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++${TOOLCHAIN_SUFFIX})
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}as${TOOLCHAIN_SUFFIX})

set(CMAKE_AR ${TOOLCHAIN_PREFIX}gcc-ar${TOOLCHAIN_SUFFIX} CACHE STRING "")
set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}gcc-ranlib${TOOLCHAIN_SUFFIX} CACHE STRING "")
set(CMAKE_LD "/${TOOLCHAIN_PREFIX}ld${TOOLCHAIN_SUFFIX}" CACHE INTERNAL "linker tool")
set(CMAKE_OBJCOPY "${TOOLCHAIN_PREFIX}objcopy${TOOLCHAIN_SUFFIX}" CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL "${TOOLCHAIN_PREFIX}size${TOOLCHAIN_SUFFIX}" CACHE INTERNAL "size tool")

set(CMAKE_FIND_ROOT_PATH ${DEVKITPRO}/devkitA64 ${DEVKITPRO} ${LIBNX} ${PORTLIBS})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

include_directories(${LIBNX}/include)
link_directories(${LIBNX}/lib)
include_directories(${PORTLIBS}/include)
link_directories(${PORTLIBS}/lib)

add_definitions(-D__SWITCH__)
set(ARCH "-march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -MMD -MP -g -Wall -O2 -ffunction-sections ${ARCH}")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -fno-rtti -fno-exceptions")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${ARCH} -L${LIBNX}/lib -L${PORTLIBS}/lib")

set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "Shared libs not available")
set(CMAKE_INSTALL_PREFIX ${PORTLIBS})
